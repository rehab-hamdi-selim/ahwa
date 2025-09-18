# ☕ Smart Ahwa Manager

Welcome to **Smart Ahwa Manager**, a Flutter-based mobile application designed for professional café owners in Cairo to streamline daily operations and enhance customer service. This app helps you manage orders, track popular drinks, and generate daily sales reports — all from one intuitive dashboard.


## 📦 Features

- 📝 Add new orders with customer name, drink type (e.g., shai, Turkish coffee, hibiscus tea), and special instructions (e.g., “extra mint, ya rais”).
- ✅ Mark orders as completed.
- 📋 View a dashboard of pending orders.
- 📊 Generate daily reports showing top-selling drinks and total orders served.


## 🧠 Principles Applied

This project is built using core **Object-Oriented Programming (OOP)** concepts and **SOLID principles** to ensure modularity, scalability, and maintainability:

- 🔁 **Inheritance & Polymorphism**: Used to model drink types and order behaviors.
- 🔐 **Encapsulation**: Each order maintains its own state and logic.
- 🧩 **Open/Closed Principle**: Easily extendable content types without modifying existing code.
- 🔌 **Dependency Inversion Principle**: Abstract interfaces for services like Firestore and notifications.
- 🧼 **Interface Segregation Principle**: Role-specific interfaces for widget controllers.

These principles align with *The Object-Oriented Thought Process*, promoting abstraction, modularity, and clean architecture.


## 🏗️ Architecture Overview

In this project, I applied Object-Oriented Programming (OOP) and SOLID principles to design a clean, scalable, and maintainable architecture. The Drink abstraction with multiple implementations demonstrates abstraction, encapsulation, and the Open/Closed Principle, allowing new drink types to be introduced without modifying existing code. The Order entity encapsulates both data and behavior (such as state transitions between pending and completed), ensuring a clear separation of responsibilities. Centralized state management is achieved through a Singleton OrdersStore, which enforces the Single Responsibility Principle by focusing only on order lifecycle management. Reporting is decoupled into a dedicated ReportService, which generates daily sales summaries while depending only on high-level abstractions, showcasing the Dependency Inversion Principle. This structure results in a modular system that is easy to extend, test, and adapt to future business requirements.


## 📸 Screenshots

**Dashboard**  
![Dashboard](https://github.com/user-attachments/assets/d979d8cd-3c84-495b-8ba9-8b58bdb71c90)

**Make New Order**  
![Make New Order](https://github.com/user-attachments/assets/f7d65d65-089c-4cda-a160-4ec743a909b3)

**Dashboard After Adding Orders**  
![Dashboard After Orders](https://github.com/user-attachments/assets/bdb2739a-99dc-4815-985d-74b112b800dd)

**Reports Screen**  
![Reports Screen](https://github.com/user-attachments/assets/f9e28f63-be90-4b8b-818f-7010773b7a9f)


## 🚀 Getting Started

To run the app:

```bash
flutter pub get
flutter run
