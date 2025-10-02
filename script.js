// script.js

// ==================== GESTION DU THÈME ====================
document.addEventListener("DOMContentLoaded", function () {
  // Créer le bouton de thème s'il n'existe pas déjà
  if (!document.getElementById("theme-toggle")) {
    const themeToggle = document.createElement("button");
    themeToggle.id = "theme-toggle";
    themeToggle.setAttribute("aria-label", "Changer de thème");
    document.body.appendChild(themeToggle);

    // Récupérer le thème sauvegardé ou utiliser 'light' par défaut
    const savedTheme = localStorage.getItem("theme") || "light";
    document.documentElement.setAttribute("data-theme", savedTheme);
    updateThemeIcon(savedTheme);

    // Gérer le clic sur le bouton
    themeToggle.addEventListener("click", function () {
      const currentTheme = document.documentElement.getAttribute("data-theme");
      const newTheme = currentTheme === "light" ? "dark" : "light";

      document.documentElement.setAttribute("data-theme", newTheme);
      localStorage.setItem("theme", newTheme);
      updateThemeIcon(newTheme);
    });
  }
});

function updateThemeIcon(theme) {
  const themeToggle = document.getElementById("theme-toggle");
  if (themeToggle) {
    themeToggle.textContent = theme === "light" ? "🌙" : "☀️";
  }
}

// ==================== CALENDRIER DE STREAK ====================
document.addEventListener("DOMContentLoaded", function () {
  const days = document.querySelectorAll(".day");

  if (days.length > 0) {
    let today = new Date().getDay(); // Retourne 0 (Dimanche) à 6 (Samedi)

    //let today = 6; // faire croire au programme que l'on est sur un autre jour

    if (today === 0) today = 7; // Convertir Dimanche (0) en 7 pour correspondre à tes données

    days.forEach((day, index) => {
      const dayNumber = index + 1; // Associer 1 = Lundi, ..., 7 = Dimanche

      if (dayNumber < today) {
        day.querySelector(".circle").classList.add("filled"); // Jour passé
      } else if (dayNumber === today) {
        day.querySelector(".circle").classList.add("current"); // Jour actuel
      }
    });
  }
});

// ==================== GESTION DU FOOTER DE PROGRESSION ====================
document.addEventListener("DOMContentLoaded", function () {
  const footer = document.getElementById("progression-footer");
  const fleche = document.getElementById("fleche-formation");
  const progressSection = document.querySelector(".progress-section");

  if (footer && fleche && progressSection) {
    // Récupérer l'état précédent depuis le localStorage
    let isExpanded = localStorage.getItem("footerState") === "true";

    // Appliquer l'état sauvegardé
    if (isExpanded) {
      footer.style.height = "300px";
      progressSection.style.display = "grid";
      fleche.style.transform = "rotate(0deg)";
    } else {
      footer.style.height = "auto";
      progressSection.style.display = "none";
      fleche.style.transform = "rotate(-180deg)";
    }

    // Gérer le clic sur la flèche
    fleche.addEventListener("click", function () {
      if (isExpanded) {
        footer.style.height = "auto";
        progressSection.style.display = "none";
        fleche.style.transform = "rotate(-180deg)";
      } else {
        footer.style.height = "300px";
        progressSection.style.display = "grid";
        fleche.style.transform = "rotate(0deg)";
      }

      // Mettre à jour l'état
      isExpanded = !isExpanded;

      // Sauvegarder l'état dans le localStorage
      localStorage.setItem("footerState", isExpanded);
    });
  }
});

// ==================== GESTION DE LA DÉCONNEXION ====================
document.addEventListener("DOMContentLoaded", function () {
  const logoutButton = document.getElementById("logout");

  if (logoutButton) {
    logoutButton.addEventListener("click", function () {
      // Nettoyer les données stockées
      localStorage.clear();

      // Redirection vers la page de connexion
      window.location.href = "/index.html";
    });
  }
});
