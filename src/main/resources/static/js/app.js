/**
 * Theme & UI interactions
 */
document.addEventListener("DOMContentLoaded", () => {
    // 1. Theme Toggling Logic
    const htmlElement = document.documentElement;
    const themeToggleBtn = document.getElementById("themeToggle");

    // Initialize theme from localStorage
    const savedTheme = localStorage.getItem("theme");
    if (savedTheme === "light") {
        htmlElement.classList.add("light");
    } else {
        htmlElement.classList.remove("light");
    }

    if (themeToggleBtn) {
        themeToggleBtn.addEventListener("click", () => {
            if (htmlElement.classList.contains("light")) {
                htmlElement.classList.remove("light");
                localStorage.setItem("theme", "dark");
            } else {
                htmlElement.classList.add("light");
                localStorage.setItem("theme", "light");
            }
        });
    }

    // 2. Automatically hide notifications/alerts after 4 seconds
    const setupToastDismissal = () => {
        const messages = document.querySelectorAll(".faces-messages li");
        messages.forEach(msg => {
            setTimeout(() => {
                msg.style.transition = "opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1), transform 0.6s cubic-bezier(0.4, 0, 0.2, 1)";
                msg.style.opacity = "0";
                msg.style.transform = "translateX(100px)";
                setTimeout(() => msg.remove(), 600);
            }, 4000);
        });
    };

    setupToastDismissal();
});
