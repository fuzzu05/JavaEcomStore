package com.store.service;

import com.store.entity.CartItem;
import com.store.entity.User;
import com.store.entity.Order;
import com.store.entity.OrderItem;
import com.store.repository.OrderRepository;
import com.store.repository.OrderItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final CartService cartService;

    public List<Order> getOrderHistory(User user) {
        return orderRepository.findByUserOrderByOrderDateDesc(user);
    }

    @Transactional
    public Order checkout(User user) {
        List<CartItem> cartItems = cartService.getCartItems(user);
        if (cartItems.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }

        double total = cartItems.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();

        // Round total to 2 decimal places
        total = Math.round(total * 100.0) / 100.0;

        Order order = Order.builder()
                .user(user)
                .orderDate(new Date())
                .status("Shipped") // Start with Shipped/Pending, matching Screen 3 statuses (Delivered, Shipped)
                .totalPrice(total)
                .items(new ArrayList<>())
                .build();

        // Save order first to generate ID
        Order savedOrder = orderRepository.save(order);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = OrderItem.builder()
                    .order(savedOrder)
                    .product(cartItem.getProduct())
                    .quantity(cartItem.getQuantity())
                    .price(cartItem.getProduct().getPrice())
                    .build();
            orderItems.add(orderItem);
        }

        savedOrder.setItems(orderItems);
        savedOrder = orderRepository.save(savedOrder);

        // Clear the user's shopping cart
        cartService.clearCart(user);

        return savedOrder;
    }
}
