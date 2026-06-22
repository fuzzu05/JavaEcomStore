package com.store.controller;

import com.store.entity.CartItem;
import com.store.entity.User;
import com.store.entity.Order;
import com.store.service.CartService;
import com.store.service.UserService;
import com.store.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/account")
public class AccountController {

    private final UserService userService;
    private final OrderService orderService;
    private final CartService cartService;

    private User getAuthenticatedUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return null;
        }
        return userService.findByUsername(auth.getName()).orElse(null);
    }

    private void populateHeaderInfo(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        boolean isLoggedIn = auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser");
        model.addAttribute("isLoggedIn", isLoggedIn);
        if (isLoggedIn) {
            model.addAttribute("username", auth.getName());
            User user = getAuthenticatedUser();
            if (user != null) {
                int cartCount = cartService.getCartItems(user).stream()
                        .mapToInt(CartItem::getQuantity)
                        .sum();
                model.addAttribute("cartCount", cartCount);
            }
        }
    }

    @GetMapping
    public String showAccount(Model model) {
        User user = getAuthenticatedUser();
        if (user == null) {
            return "redirect:/login";
        }

        List<Order> orders = orderService.getOrderHistory(user);

        model.addAttribute("orders", orders);
        model.addAttribute("userEmail", user.getEmail());
        model.addAttribute("userRole", user.getRole() != null ? user.getRole() : "Customer");

        populateHeaderInfo(model);
        return "account";
    }
}
