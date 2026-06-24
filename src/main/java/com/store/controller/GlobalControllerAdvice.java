package com.store.controller;

import com.store.entity.User;
import com.store.entity.CartItem;
import com.store.service.CartService;
import com.store.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {

    private final UserService userService;
    private final CartService cartService;

    private User getAuthenticatedUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return null;
        }
        return userService.findByUsername(auth.getName()).orElse(null);
    }

    @ModelAttribute("isLoggedIn")
    public boolean isLoggedIn() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser");
    }

    @ModelAttribute("username")
    public String username() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser")) {
            return auth.getName();
        }
        return null;
    }

    @ModelAttribute("cartCount")
    public int cartCount() {
        User user = getAuthenticatedUser();
        if (user != null) {
            return cartService.getCartItems(user).stream()
                    .mapToInt(CartItem::getQuantity)
                    .sum();
        }
        return 0;
    }
}
