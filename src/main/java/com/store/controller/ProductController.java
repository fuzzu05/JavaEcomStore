package com.store.controller;

import com.store.entity.Product;
import com.store.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @GetMapping({"/", "/index"})
    public String showCatalog(@RequestParam(value = "query", required = false) String query,
                              @RequestParam(value = "category", required = false) String category,
                              Model model) {
        
        List<Product> products = productService.searchProductsByCategory(category, query);
        
        model.addAttribute("products", products);
        model.addAttribute("searchQuery", query != null ? query : "");
        model.addAttribute("selectedCategory", category != null ? category : "");
        
        // Pass login state variables to header
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        boolean isLoggedIn = auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser");
        model.addAttribute("isLoggedIn", isLoggedIn);
        if (isLoggedIn) {
            model.addAttribute("username", auth.getName());
        }
        
        return "index";
    }

    @GetMapping("/product")
    public String showProductDetails(@RequestParam("id") Long id, Model model) {
        productService.getProductById(id).ifPresent(product -> model.addAttribute("product", product));
        
        // Pass login state variables to header
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        boolean isLoggedIn = auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser");
        model.addAttribute("isLoggedIn", isLoggedIn);
        if (isLoggedIn) {
            model.addAttribute("username", auth.getName());
        }
        
        return "product";
    }
}
