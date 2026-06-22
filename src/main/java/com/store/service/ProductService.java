package com.store.service;

import com.store.entity.Product;
import com.store.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }

    public List<Product> searchProducts(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllProducts();
        }
        return productRepository.searchProducts(query);
    }

    public List<Product> searchProductsByCategory(String category, String query) {
        if (category == null || category.trim().isEmpty()) {
            return searchProducts(query);
        }
        if (query == null || query.trim().isEmpty()) {
            return getProductsByCategory(category);
        }
        return productRepository.searchProductsByCategory(category, query);
    }

    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }
}
