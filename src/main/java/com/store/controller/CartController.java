package com.store.controller;

import com.store.entity.CartItem;
import com.store.entity.User;
import com.store.entity.Product;
import com.store.service.CartService;
import com.store.service.UserService;
import com.store.service.ProductService;
import com.store.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;
    private final UserService userService;
    private final ProductService productService;
    private final OrderService orderService;

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
    public String showCart(Model model) {
        User user = getAuthenticatedUser();
        if (user == null) {
            return "redirect:/login";
        }

        List<CartItem> cartItems = cartService.getCartItems(user);

        double total = cartItems.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
        double cartTotal = Math.round(total * 100.0) / 100.0;

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);

        populateHeaderInfo(model);
        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("productId") Long productId,
                            @RequestParam(value = "buyNow", required = false, defaultValue = "false") boolean buyNow,
                            RedirectAttributes redirectAttributes) {
        User user = getAuthenticatedUser();
        if (user == null) {
            return "redirect:/login";
        }

        Product product = productService.getProductById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + productId));

        cartService.addToCart(user, product, 1);
        
        if (buyNow) {
            return "redirect:/cart";
        }

        redirectAttributes.addFlashAttribute("successMessage", "Added to Cart: " + product.getName());
        return "redirect:/index";
    }

    @PostMapping("/remove")
    public String removeFromCart(@RequestParam("cartItemId") Long cartItemId, RedirectAttributes redirectAttributes) {
        cartService.removeFromCart(cartItemId);
        redirectAttributes.addFlashAttribute("infoMessage", "Item removed from cart");
        return "redirect:/cart";
    }

    @PostMapping("/save-for-later")
    public String saveForLater(@RequestParam("cartItemId") Long cartItemId, RedirectAttributes redirectAttributes) {
        cartService.removeFromCart(cartItemId);
        redirectAttributes.addFlashAttribute("infoMessage", "Item saved for later!");
        return "redirect:/cart";
    }

    @PostMapping("/checkout")
    public String checkout(RedirectAttributes redirectAttributes) {
        User user = getAuthenticatedUser();
        if (user == null) {
            return "redirect:/login";
        }

        try {
            orderService.checkout(user);
            redirectAttributes.addFlashAttribute("successMessage", "Order placed successfully! 🎉");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Checkout failed: " + e.getMessage());
        }
        return "redirect:/account";
    }

    @ModelAttribute("cartCount")
    public int getCartCount() {
        User user = getAuthenticatedUser();
        if (user != null) {
            return cartService.getCartItems(user).stream()
                    .mapToInt(CartItem::getQuantity)
                    .sum();
        }
        return 0;
    }
}
