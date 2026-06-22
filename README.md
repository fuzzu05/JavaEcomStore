# 🛒 Online Store — Java Full-Stack E-Commerce Application

A complete, full-stack e-commerce web application built with **Java**, **Spring Boot**, **Spring Security**, **Spring Data JPA**, **H2 Database**, and **JSP (Jakarta Server Pages)**.

---

## ✨ Features

- **User Authentication** — Register & login with encrypted passwords (BCrypt)
- **Product Catalog** — Browse products with search and category filtering
- **Product Detail Page** — View detailed product info, description & highlights
- **Shopping Cart** — Add/remove items, view total, proceed to checkout
- **Order History** — View past orders with status tracking
- **My Account** — View account details and order history
- **Light/Dark Theme** — Toggle between light and dark mode (persisted via localStorage)
- **Responsive Design** — Works on desktop and mobile screens

---

## 🛠️ Tech Stack

| Layer         | Technology                                  |
|---------------|---------------------------------------------|
| **Language**  | Java 17                                     |
| **Framework** | Spring Boot 3.3.1                           |
| **Security**  | Spring Security 6 (Form Login + BCrypt)     |
| **ORM**       | Spring Data JPA + Hibernate                 |
| **Database**  | H2 (File-based, persists between restarts)  |
| **Views**     | JSP + JSTL (Jakarta Server Pages)           |
| **Styling**   | Vanilla CSS (Custom design system)          |
| **Build**     | Maven                                       |
| **Server**    | Embedded Apache Tomcat                      |

---

## 📁 Project Structure

```
online-store/
├── pom.xml                          # Maven build configuration
├── .gitignore
├── README.md
│
├── src/main/java/com/store/
│   ├── OnlineStoreApplication.java  # Spring Boot entry point
│   │
│   ├── config/
│   │   └── SecurityConfig.java      # Spring Security (routes, BCrypt, form login)
│   │
│   ├── controller/
│   │   ├── AuthController.java      # Login & Registration endpoints
│   │   ├── ProductController.java   # Home catalog & product detail page
│   │   ├── CartController.java      # Shopping cart & checkout
│   │   └── AccountController.java   # Account details & order history
│   │
│   ├── entity/
│   │   ├── User.java                # User entity (id, username, email, password, role)
│   │   ├── Product.java             # Product entity (id, name, description, price, category)
│   │   ├── CartItem.java            # Cart item (links user ↔ product with quantity)
│   │   ├── Order.java               # Order entity (user, total, date, status)
│   │   └── OrderItem.java           # Order line item (product snapshot at purchase time)
│   │
│   ├── repository/
│   │   ├── UserRepository.java      # User CRUD + findByUsername
│   │   ├── ProductRepository.java   # Product CRUD + search + category filter
│   │   ├── CartItemRepository.java  # Cart CRUD + findByUser
│   │   ├── OrderRepository.java     # Order CRUD + findByUser (sorted by date)
│   │   └── OrderItemRepository.java # Order items CRUD
│   │
│   ├── service/
│   │   ├── UserService.java         # User lookup + Spring Security UserDetailsService
│   │   ├── ProductService.java      # Product search, filter, and retrieval
│   │   ├── CartService.java         # Add/remove cart items
│   │   └── OrderService.java        # Checkout logic (cart → order conversion)
│   │
│   └── util/
│       └── DatabaseSeeder.java      # Seeds 4 default products on first run
│
├── src/main/resources/
│   ├── application.properties       # Server, DB, JPA, and JSP view config
│   └── static/
│       ├── css/style.css            # Full design system (dark/light mode, glassmorphism)
│       └── js/app.js                # Theme toggle persistence + toast auto-dismiss
│
└── src/main/webapp/WEB-INF/jsp/
    ├── header.jsp                   # Shared header (nav, theme toggle, auth state)
    ├── footer.jsp                   # Shared footer
    ├── login.jsp                    # Login form
    ├── register.jsp                 # Registration form
    ├── index.jsp                    # Home page (search, categories, product grid)
    ├── product.jsp                  # Product detail page (image, info, description)
    ├── cart.jsp                     # Shopping cart (items, total, checkout)
    └── account.jsp                  # Account details + order history
```

---

## 🚀 How to Run

### Prerequisites
- **Java 17+** installed
- **Maven** installed (or use `./mvnw`)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/online-store-java.git
cd online-store-java

# 2. Run the application
mvn spring-boot:run

# 3. Open in browser
# Navigate to: http://localhost:8080
```

The app seeds 4 demo products on first run automatically.

### Default Accounts
No default accounts — register a new user at `/register`.

### H2 Database Console
Available at: `http://localhost:8080/h2-console`
- **JDBC URL**: `jdbc:h2:file:./data/storedb`
- **Username**: `sa`
- **Password**: *(empty)*

---

## 📸 Pages Overview

| Page              | URL                | Description                                  |
|-------------------|--------------------|----------------------------------------------|
| Home / Catalog    | `/index`           | Browse all products, search, filter by category |
| Product Detail    | `/product?id=1`    | Full product info with Add to Cart / Buy Now |
| Login             | `/login`           | User login form                              |
| Register          | `/register`        | New user registration                        |
| Shopping Cart     | `/cart`             | View cart items, remove, checkout            |
| My Account        | `/account`          | Account details + order history              |

---

## 🎨 Design Features

- **Royal Violet** accent color scheme
- **Dark/Light mode** toggle with localStorage persistence
- **Glassmorphism** card styling with backdrop blur
- **Smooth animations** — hover effects, toast slide-ins, button transitions
- **Responsive layout** — adapts to mobile and desktop viewports
- **Google Fonts** — Outfit typeface for modern typography

---

## 📝 License

This project is built for educational/hackathon purposes.
