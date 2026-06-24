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
                    .name("SoundWave Smart Speaker")
                    .description("Experience rich, immersive audio with our premium smart speaker. Features voice assistant support, long-lasting battery, and beautiful dynamic ambient lighting.")
                    .price(29.99)
                    .imageUrl("/images/speaker.png")
                    .category("Electronics")
                    .build();

            Product p2 = Product.builder()
                    .name("Pleated Linen Midi Skirt")
                    .description("Crafted from breathable premium linen blend. Perfect for bright sunny days, casual outings, or elegant summer evenings.")
                    .price(19.99)
                    .imageUrl("/images/skirt.png")
                    .category("Clothing")
                    .build();

            Product p3 = Product.builder()
                    .name("AromaCraft Drip Coffee Maker")
                    .description("Brew the perfect cup of coffee every morning. Modern stainless steel design, customizable strength control, and auto-shutoff safety features.")
                    .price(49.99)
                    .imageUrl("/images/coffee.png")
                    .category("Home & Kitchen")
                    .build();

            Product p4 = Product.builder()
                    .name("HydroPeak Insulated Water Bottle")
                    .description("Keep your drinks ice-cold for 24 hours or piping hot for 12. Double-walled vacuum insulated stainless steel with a leak-proof lid.")
                    .price(14.99)
                    .imageUrl("/images/bottle.png")
                    .category("Sports")
                    .build();

            productRepository.saveAll(Arrays.asList(p1, p2, p3, p4));
            System.out.println(">>> Database seeded with 4 products successfully!");
        }
    }
}
