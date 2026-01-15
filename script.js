// script.js

// ============== Chargement de dotenv dans le fichier principal ============== //
import 'dotenv/config';

// ==================== GESTION DU THÈME ====================
document.addEventListener("DOMContentLoaded", function () {
  // Appliquer le thème sauvegardé sur TOUTES les pages
  const savedTheme = localStorage.getItem("theme") || "light";
  document.documentElement.setAttribute("data-theme", savedTheme);

  // Si on est sur la page de profil, créer le bouton de thème
  const settingsSection = document.getElementById("settings");
  if (settingsSection) {
    // Créer l'élément de thème dans les paramètres
    const themeItem = document.createElement("li");
    themeItem.id = "theme-setting";
    themeItem.style.display = "flex";
    themeItem.style.justifyContent = "space-between";
    themeItem.style.alignItems = "center";

    const themeLabel = document.createElement("span");
    themeLabel.textContent = "Thème";

    const themeToggle = document.createElement("button");
    themeToggle.id = "theme-toggle-btn";
    themeToggle.style.background = "var(--primary-green)";
    themeToggle.style.color = "white";
    themeToggle.style.border = "none";
    themeToggle.style.borderRadius = "8px";
    themeToggle.style.padding = "8px 16px";
    themeToggle.style.fontWeight = "700";
    themeToggle.style.cursor = "pointer";
    themeToggle.style.transition = "all 0.2s ease";

    updateThemeButtonText(themeToggle, savedTheme);

    themeItem.appendChild(themeLabel);
    themeItem.appendChild(themeToggle);

    // Ajouter en premier dans la liste des paramètres
    const settingsList = settingsSection.querySelector("ul");
    settingsList.insertBefore(themeItem, settingsList.firstChild);

    // Gérer le clic sur le bouton
    themeToggle.addEventListener("click", function (e) {
      e.stopPropagation(); // Empêcher le comportement du li
      const currentTheme = document.documentElement.getAttribute("data-theme");
      const newTheme = currentTheme === "light" ? "dark" : "light";

      document.documentElement.setAttribute("data-theme", newTheme);
      localStorage.setItem("theme", newTheme);
      updateThemeButtonText(themeToggle, newTheme);
    });

    // Empêcher le hover du li d'affecter le bouton
    themeItem.addEventListener("mouseenter", function () {
      this.style.background = "var(--bg-secondary)";
      this.style.color = "var(--text-primary)";
      this.style.transform = "none";
    });
  }
});

function updateThemeButtonText(button, theme) {
  if (button) {
    button.textContent = theme === "light" ? "🌙 Sombre" : "☀️ Clair";
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
      fleche.style.transform = "rotate(90deg)";
    }

    // Gérer le clic sur la flèche
    fleche.addEventListener("click", function () {
      if (isExpanded) {
        footer.style.height = "auto";
        progressSection.style.display = "none";
        fleche.style.transform = "rotate(90deg)";
      } else {
        footer.style.height = "300px";
        progressSection.style.display = "grid";
        fleche.style.transform = "rotate(-90deg)";
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
      // Sauvegarder le thème avant de nettoyer
      const currentTheme = localStorage.getItem("theme");

      // Nettoyer les données stockées
      localStorage.clear();

      // Restaurer le thème
      if (currentTheme) {
        localStorage.setItem("theme", currentTheme);
      }

      // Redirection vers la page de connexion
      window.location.href = "/index.html";
    });
  }
});
