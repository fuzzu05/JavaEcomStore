package com.store.controller;

import com.store.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "error", required = false) String error,
                                @RequestParam(value = "logout", required = false) String logout,
                                @RequestParam(value = "registered", required = false) String registered,
                                Model model) {
        if (error != null) {
            model.addAttribute("errorMessage", "Invalid username or password");
        }
        if (logout != null) {
            model.addAttribute("infoMessage", "Logged out successfully");
        }
        if (registered != null) {
            model.addAttribute("successMessage", "Registration successful! Please log in.");
        }
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            if (error.equals("passwords")) {
                model.addAttribute("errorMessage", "Passwords do not match!");
            } else if (error.equals("username")) {
                model.addAttribute("errorMessage", "Username already exists!");
            } else {
                model.addAttribute("errorMessage", "Registration failed!");
            }
        }
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam("username") String username,
                               @RequestParam("email") String email,
                               @RequestParam("password") String password,
                               @RequestParam("confirmPassword") String confirmPassword) {
        if (!password.equals(confirmPassword)) {
            return "redirect:/register?error=passwords";
        }
        try {
            userService.registerUser(username, email, password);
            return "redirect:/login?registered=true";
        } catch (IllegalArgumentException e) {
            return "redirect:/register?error=username";
        } catch (Exception e) {
            return "redirect:/register?error=failed";
        }
    }
}
