package com.store.util;

import com.store.entity.Product;
import com.store.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
@RequiredArgsConstructor
public class DatabaseSeeder implements CommandLineRunner {

    private final ProductRepository productRepository;

    @Override
    public void run(String... args) {
        if (productRepository.count() == 0) {
            Product p1 = Product.builder()
                    .name("Product 1")
                    .description("Short description of product 1 that highlights its key features and benefits. Experience maximum utility and premium design crafted for your everyday needs.")
                    .price(29.99)
                    .imageUrl("electronics")
                    .category("Electronics")
                    .build();

            Product p2 = Product.builder()
                    .name("Product 2")
                    .description("Short description of product 2 that highlights its key features and benefits. Crafted from ultra-soft cotton blend. Perfect for breezy evenings.")
                    .price(19.99)
                    .imageUrl("clothing")
                    .category("Clothing")
                    .build();

            Product p3 = Product.builder()
                    .name("Product 3")
                    .description("Short description of product 3 that highlights its key features and benefits. Detailed description of the product, including its features, specifications, and any other relevant information that can help the customer make an informed decision.")
                    .price(49.99)
                    .imageUrl("home")
                    .category("Home & Kitchen")
                    .build();

            Product p4 = Product.builder()
                    .name("Product 4")
                    .description("Short description of product 4 that highlights its key features and benefits. Double-walled vacuum insulated stainless steel water bottle.")
                    .price(14.99)
                    .imageUrl("sports")
                    .category("Sports")
                    .build();

            productRepository.saveAll(Arrays.asList(p1, p2, p3, p4));
            System.out.println(">>> Database seeded with 4 products successfully!");
        }
    }
}
