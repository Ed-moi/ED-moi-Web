-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 13, 2024
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `learning_platform`
--
CREATE DATABASE IF NOT EXISTS `learning_platform` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `learning_platform`;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','professeur','etudiant') NOT NULL DEFAULT 'etudiant',
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role`, `creation_date`) VALUES
(1, 'MasterChef87', 'sophie.cuisine@learning.fr', '$2y$10$YourHashedPasswordHere1', 'admin', '2024-01-15 10:00:00'),
(2, 'BricoleurPro', 'marc.bricolage@learning.fr', '$2y$10$YourHashedPasswordHere2', 'professeur', '2024-01-20 09:30:00'),
(3, 'FinanceGuru', 'julie.finance@learning.fr', '$2y$10$YourHashedPasswordHere3', 'professeur', '2024-02-01 14:20:00'),
(4, 'TechWizard', 'alex.tech@learning.fr', '$2y$10$YourHashedPasswordHere4', 'professeur', '2024-02-10 11:15:00'),
(5, 'CookieLover', 'alice.bernard@email.fr', '$2y$10$YourHashedPasswordHere5', 'etudiant', '2024-02-15 16:45:00'),
(6, 'MecanoFan', 'thomas.petit@email.fr', '$2y$10$YourHashedPasswordHere6', 'etudiant', '2024-02-20 08:30:00'),
(7, 'BudgetMaster', 'emma.robert@email.fr', '$2y$10$YourHashedPasswordHere7', 'etudiant', '2024-03-01 13:20:00'),
(8, 'CodeNinja42', 'lucas.richard@email.fr', '$2y$10$YourHashedPasswordHere8', 'etudiant', '2024-03-05 10:00:00'),
(9, 'DogWhisperer', 'lea.moreau@email.fr', '$2y$10$YourHashedPasswordHere9', 'etudiant', '2024-03-10 15:30:00'),
(10, 'PlumberKing', 'hugo.simon@email.fr', '$2y$10$YourHashedPasswordHere10', 'etudiant', '2024-03-15 09:45:00'),
(11, 'ElectroSpark', 'marine.dubois@email.fr', '$2y$10$YourHashedPasswordHere11', 'professeur', '2024-03-18 11:20:00'),
(12, 'JobHunter88', 'paul.martin@email.fr', '$2y$10$YourHashedPasswordHere12', 'etudiant', '2024-03-20 14:30:00'),
(13, 'AdminPro2024', 'claire.admin@learning.fr', '$2y$10$YourHashedPasswordHere13', 'professeur', '2024-03-22 09:15:00'),
(14, 'PetCareLover', 'sarah.laurent@email.fr', '$2y$10$YourHashedPasswordHere14', 'etudiant', '2024-03-25 16:00:00'),
(15, 'LifeHacker', 'antoine.rousseau@email.fr', '$2y$10$YourHashedPasswordHere15', 'etudiant', '2024-03-28 10:45:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Cuisine'),
(2, 'Mécanique'),
(3, 'Finances'),
(4, 'Administratif'),
(5, 'Informatique'),
(6, 'Recherche d\'emploi'),
(7, 'Animaux de compagnie'),
(8, 'Quotidien'),
(9, 'Plomberie'),
(10, 'Électricité');

-- --------------------------------------------------------

--
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE `cours` (
  `cours_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('approuve','en_attente','refuse') NOT NULL DEFAULT 'en_attente',
  `level` enum('debutant','intermediaire','avance') NOT NULL DEFAULT 'debutant',
  PRIMARY KEY (`cours_id`),
  KEY `category_id` (`category_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `cours_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `cours_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cours`
--

INSERT INTO `cours` (`cours_id`, `title`, `description`, `category_id`, `created_by`, `creation_date`, `status`, `level`) VALUES
(1, 'Les Bases de la Cuisine Française', 'Découvrez les techniques fondamentales de la cuisine française : sauces, cuisson des viandes, préparation des légumes. Apprenez à réaliser des plats traditionnels comme le bœuf bourguignon et la quiche lorraine.', 1, 1, '2024-03-01 10:00:00', 'approuve', 'debutant'),
(2, 'Entretien Auto pour Débutants', 'Apprenez à entretenir votre véhicule : vidange, changement de pneus, vérification des niveaux, remplacement des filtres. Économisez de l\'argent en réalisant vous-même l\'entretien basique.', 2, 2, '2024-03-05 14:30:00', 'approuve', 'debutant'),
(3, 'Gérer son Budget Personnel', 'Maîtrisez vos finances personnelles : créer un budget, épargner efficacement, réduire vos dépenses, planifier vos investissements. Outils et méthodes pratiques inclus.', 3, 3, '2024-03-10 09:15:00', 'approuve', 'debutant'),
(4, 'Démarches Administratives Simplifiées', 'Comprendre et réaliser vos démarches administratives : déclaration d\'impôts, demande de documents officiels, droits et obligations, utilisation des services en ligne.', 4, 13, '2024-03-12 16:00:00', 'approuve', 'debutant'),
(5, 'Programmation Python pour Tous', 'Introduction à la programmation avec Python. Apprenez les variables, boucles, fonctions et créez vos premiers programmes. Aucune expérience requise.', 5, 4, '2024-03-15 11:30:00', 'approuve', 'debutant'),
(6, 'Réussir sa Recherche d\'Emploi', 'Techniques de recherche d\'emploi efficaces : CV percutant, lettre de motivation, préparation aux entretiens, utilisation de LinkedIn, négociation salariale.', 6, 13, '2024-03-18 13:45:00', 'approuve', 'intermediaire'),
(7, 'Éduquer son Chien - Méthodes Positives', 'Apprenez à éduquer votre chien avec des méthodes basées sur le renforcement positif. Ordres de base, propreté, sociabilisation et résolution de problèmes comportementaux.', 7, 2, '2024-03-20 10:20:00', 'approuve', 'debutant'),
(8, 'Organisation et Productivité au Quotidien', 'Optimisez votre temps et votre organisation : techniques de gestion du temps, désencombrement, routine efficace, équilibre vie pro/perso.', 8, 1, '2024-03-22 15:00:00', 'approuve', 'intermediaire'),
(9, 'Plomberie : Réparer les Fuites', 'Identifiez et réparez les fuites d\'eau courantes : robinets, chasse d\'eau, tuyauterie. Matériel nécessaire et techniques pas à pas.', 9, 2, '2024-03-25 09:00:00', 'approuve', 'intermediaire'),
(10, 'Électricité Domestique Sécurisée', 'Bases de l\'électricité domestique : comprendre votre tableau électrique, remplacer une prise, installer un interrupteur. Sécurité et normes.', 10, 11, '2024-03-28 14:15:00', 'approuve', 'intermediaire'),
(11, 'Pâtisserie Française Avancée', 'Maîtrisez les grands classiques de la pâtisserie : macarons, éclairs, opéra, fraisier. Techniques professionnelles et tours de main.', 1, 1, '2024-04-01 10:30:00', 'approuve', 'avance'),
(12, 'Diagnostic Panne Auto', 'Apprenez à diagnostiquer les pannes courantes de votre véhicule : bruits anormaux, voyants allumés, problèmes de démarrage. Utilisation d\'outils de diagnostic.', 2, 2, '2024-04-05 11:20:00', 'en_attente', 'avance'),
(13, 'Investir en Bourse pour Débutants', 'Introduction aux marchés financiers : actions, ETF, diversification de portefeuille, analyse fondamentale et technique. Stratégies d\'investissement long terme.', 3, 3, '2024-04-08 09:45:00', 'approuve', 'intermediaire'),
(14, 'Créer son Site Web Sans Code', 'Créez votre site web professionnel sans programmation : WordPress, design, référencement SEO, hébergement. Projet pratique inclus.', 5, 4, '2024-04-10 14:30:00', 'approuve', 'debutant'),
(15, 'Soins des Chats d\'Appartement', 'Tout savoir sur les soins des chats : alimentation, santé, comportement, enrichissement de l\'environnement, prévention des maladies courantes.', 7, 2, '2024-04-12 16:00:00', 'approuve', 'debutant');

-- --------------------------------------------------------

--
-- Table structure for table `cours_proposals`
--

DROP TABLE IF EXISTS `cours_proposals`;
CREATE TABLE `cours_proposals` (
  `proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `category_id` int(11) NOT NULL,
  `proposed_by` int(11) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('en_attente','accepte','rejete') NOT NULL DEFAULT 'en_attente',
  `vote_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`proposal_id`),
  KEY `category_id` (`category_id`),
  KEY `proposed_by` (`proposed_by`),
  CONSTRAINT `cours_proposals_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `cours_proposals_ibfk_2` FOREIGN KEY (`proposed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cours_proposals`
--

INSERT INTO `cours_proposals` (`proposal_id`, `title`, `description`, `category_id`, `proposed_by`, `creation_date`, `status`, `vote_count`) VALUES
(1, 'Cuisine Végétarienne et Équilibrée', 'Découvrez comment préparer des repas végétariens délicieux et nutritifs. Recettes variées, conseils nutritionnels et alternatives protéinées.', 1, 5, '2024-04-15 10:30:00', 'en_attente', 28),
(2, 'Réparer sa Moto Soi-Même', 'Entretien et réparation basique de motos : chaîne, freins, vidange, réglages. Spécificités par rapport aux voitures.', 2, 6, '2024-04-17 14:20:00', 'en_attente', 19),
(3, 'Optimiser ses Impôts Légalement', 'Stratégies légales pour réduire sa fiscalité : déductions, crédits d\'impôts, choix du régime fiscal, investissements défiscalisants.', 3, 7, '2024-04-20 09:45:00', 'accepte', 42),
(4, 'Installer un Système Domotique', 'Guide complet pour automatiser sa maison : éclairage, chauffage, sécurité. Comparatif des solutions et installation pas à pas.', 10, 8, '2024-04-22 16:15:00', 'en_attente', 35),
(5, 'Aquariophilie pour Débutants', 'Créer et entretenir son premier aquarium : choix des poissons, équipement, cycle de l\'azote, maintenance et prévention des maladies.', 7, 9, '2024-04-25 11:00:00', 'en_attente', 23),
(6, 'Jardinage sur Balcon', 'Cultiver fruits, légumes et plantes aromatiques sur un balcon. Choix des contenants, entretien et récolte en espace réduit.', 8, 15, '2024-04-28 13:30:00', 'en_attente', 31),
(7, 'Rénovation de Salle de Bain', 'Projet complet de rénovation : plomberie, carrelage, étanchéité, ventilation. Planning et budget à prévoir.', 9, 10, '2024-05-01 15:20:00', 'rejete', 12),
(8, 'Reconversion Professionnelle Réussie', 'Guide complet pour changer de carrière : bilan de compétences, formation, financement, réseau professionnel, gestion de la transition.', 6, 12, '2024-05-03 10:45:00', 'accepte', 38);

-- --------------------------------------------------------

--
-- Table structure for table `cours_votes`
--

DROP TABLE IF EXISTS `cours_votes`;
CREATE TABLE `cours_votes` (
  `vote_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `vote_type` enum('positif','negatif') NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`vote_id`),
  UNIQUE KEY `unique_vote` (`user_id`,`proposal_id`),
  KEY `proposal_id` (`proposal_id`),
  CONSTRAINT `cours_votes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `cours_votes_ibfk_2` FOREIGN KEY (`proposal_id`) REFERENCES `cours_proposals` (`proposal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cours_votes`
--

INSERT INTO `cours_votes` (`vote_id`, `user_id`, `proposal_id`, `vote_type`, `creation_date`) VALUES
(1, 5, 1, 'positif', '2024-04-15 11:00:00'),
(2, 6, 1, 'positif', '2024-04-15 12:30:00'),
(3, 7, 1, 'positif', '2024-04-15 14:15:00'),
(4, 8, 1, 'positif', '2024-04-15 15:45:00'),
(5, 9, 1, 'positif', '2024-04-15 16:30:00'),
(6, 6, 2, 'positif', '2024-04-17 15:00:00'),
(7, 10, 2, 'positif', '2024-04-17 16:20:00'),
(8, 8, 2, 'negatif', '2024-04-17 17:30:00'),
(9, 5, 3, 'positif', '2024-04-20 10:30:00'),
(10, 6, 3, 'positif', '2024-04-20 11:45:00'),
(11, 7, 3, 'positif', '2024-04-20 13:00:00'),
(12, 8, 3, 'positif', '2024-04-20 14:30:00'),
(13, 9, 3, 'positif', '2024-04-20 16:00:00'),
(14, 10, 3, 'positif', '2024-04-20 17:20:00'),
(15, 12, 3, 'positif', '2024-04-20 18:15:00'),
(16, 8, 4, 'positif', '2024-04-22 17:00:00'),
(17, 10, 4, 'positif', '2024-04-22 18:30:00'),
(18, 11, 4, 'positif', '2024-04-22 19:15:00'),
(19, 9, 5, 'positif', '2024-04-25 12:00:00'),
(20, 14, 5, 'positif', '2024-04-25 13:30:00'),
(21, 5, 5, 'positif', '2024-04-25 14:45:00'),
(22, 15, 6, 'positif', '2024-04-28 14:20:00'),
(23, 5, 6, 'positif', '2024-04-28 15:30:00'),
(24, 9, 6, 'positif', '2024-04-28 16:45:00'),
(25, 10, 7, 'negatif', '2024-05-01 16:00:00'),
(26, 11, 7, 'positif', '2024-05-01 16:30:00'),
(27, 12, 8, 'positif', '2024-05-03 11:30:00'),
(28, 6, 8, 'positif', '2024-05-03 12:45:00'),
(29, 7, 8, 'positif', '2024-05-03 14:00:00'),
(30, 15, 8, 'positif', '2024-05-03 15:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `cours_content`
--

DROP TABLE IF EXISTS `cours_content`;
CREATE TABLE `cours_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `cours_id` int(11) NOT NULL,
  `content_type` enum('video','texte','quiz','exercice') NOT NULL,
  `content_data` text NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`content_id`),
  KEY `cours_id` (`cours_id`),
  CONSTRAINT `cours_content_ibfk_1` FOREIGN KEY (`cours_id`) REFERENCES `cours` (`cours_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cours_content`
--

INSERT INTO `cours_content` (`content_id`, `cours_id`, `content_type`, `content_data`, `order`) VALUES
(1, 1, 'video', 'Introduction à la Cuisine Française (URL: /videos/cuisine_intro.mp4)', 1),
(2, 1, 'texte', 'La cuisine française repose sur des techniques ancestrales et des produits de qualité. Les cinq sauces mères sont la base de nombreuses préparations...', 2),
(3, 1, 'video', 'Réaliser une Sauce Béchamel Parfaite (URL: /videos/bechamel.mp4)', 3),
(4, 1, 'exercice', 'Exercice : Préparez un bœuf bourguignon en suivant la recette fournie', 4),
(5, 1, 'quiz', 'Quiz : Quelle est la température idéale pour cuire un rôti de bœuf ?', 5),
(6, 2, 'video', 'Faire sa Vidange Soi-Même (URL: /videos/vidange_auto.mp4)', 1),
(7, 2, 'texte', 'L\'entretien régulier de votre véhicule prolonge sa durée de vie et évite les pannes coûteuses. La vidange doit être effectuée tous les 10 000 à 15 000 km...', 2),
(8, 2, 'exercice', 'Exercice : Identifiez les différents niveaux à vérifier sous le capot', 3),
(9, 2, 'video', 'Changer ses Pneus : Tutoriel Complet (URL: /videos/pneus.mp4)', 4),
(10, 3, 'video', 'Créer son Budget Mensuel (URL: /videos/budget.mp4)', 1),
(11, 3, 'texte', 'Un budget efficace suit la règle 50/30/20 : 50% pour les besoins essentiels, 30% pour les envies, 20% pour l\'épargne...', 2),
(12, 3, 'exercice', 'Exercice : Analysez vos relevés bancaires et créez votre premier budget', 3),
(13, 4, 'video', 'Comprendre sa Déclaration d\'Impôts (URL: /videos/impots.mp4)', 1),
(14, 4, 'texte', 'La déclaration d\'impôts peut sembler complexe, mais en suivant les étapes méthodiquement, elle devient accessible...', 2),
(15, 5, 'video', 'Python : Vos Premiers Pas (URL: /videos/python_intro.mp4)', 1),
(16, 5, 'texte', 'Python est un langage de programmation simple et puissant, idéal pour débuter. Commençons par les variables...', 2),
(17, 5, 'exercice', 'Exercice : Écrivez un programme qui calcule la moyenne de trois notes', 3),
(18, 6, 'video', 'Créer un CV qui Marque les Esprits (URL: /videos/cv_percutant.mp4)', 1),
(19, 6, 'texte', 'Un bon CV doit être clair, concis et adapté au poste visé. Utilisez des verbes d\'action et quantifiez vos réussites...', 2),
(20, 7, 'video', 'Les Ordres de Base pour Chien (URL: /videos/education_chien.mp4)', 1),
(21, 7, 'texte', 'L\'éducation positive renforce le lien avec votre chien. Récompensez les bons comportements plutôt que punir les mauvais...', 2),
(22, 8, 'video', 'Méthode GTD : Getting Things Done (URL: /videos/gtd.mp4)', 1),
(23, 8, 'exercice', 'Exercice : Listez toutes vos tâches et organisez-les par priorité', 2),
(24, 9, 'video', 'Réparer un Robinet qui Fuit (URL: /videos/robinet_fuite.mp4)', 1),
(25, 9, 'texte', 'Une fuite de robinet provient souvent d\'un joint usé. Voici comment le remplacer en 5 étapes simples...', 2),
(26, 10, 'video', 'Sécurité Électrique : Les Bases (URL: /videos/securite_elec.mp4)', 1),
(27, 10, 'texte', 'Avant toute intervention électrique, coupez le disjoncteur général. Vérifiez toujours l\'absence de tension avec un testeur...', 2),
(28, 10, 'quiz', 'Quiz : Quelle section de câble utiliser pour un circuit de prises 16A ?', 3);

-- --------------------------------------------------------

--
-- Table structure for table `cours_comments`
--

DROP TABLE IF EXISTS `cours_comments`;
CREATE TABLE `cours_comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment_text` text NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`comment_id`),
  KEY `course_id` (`course_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cours_comments_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `cours` (`cours_id`),
  CONSTRAINT `cours_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cours_comments`
--

INSERT INTO `cours_comments` (`comment_id`, `course_id`, `user_id`, `comment_text`, `creation_date`) VALUES
(1, 1, 5, 'Super cours ! J\'ai enfin réussi mon bœuf bourguignon grâce aux explications claires 👨‍🍳', '2024-03-15 14:30:00'),
(2, 1, 7, 'Les techniques de base sont très bien expliquées. Je recommande !', '2024-03-16 10:45:00'),
(3, 2, 6, 'J\'ai économisé 80€ en faisant ma vidange moi-même. Merci pour ce tuto !', '2024-03-17 16:20:00'),
(4, 2, 10, 'Vidéos très détaillées, même pour un débutant comme moi c\'est accessible', '2024-03-18 11:15:00'),
(5, 3, 7, 'Depuis que j\'applique ces méthodes, j\'arrive enfin à mettre de l\'argent de côté 💰', '2024-03-22 15:40:00'),
(6, 3, 15, 'La règle 50/30/20 a changé ma vie financière !', '2024-03-23 09:30:00'),
(7, 5, 8, 'Python semblait compliqué mais ce cours rend tout simple. Excellent pédagogue !', '2024-03-25 13:50:00'),
(8, 5, 12, 'J\'ai créé mon premier programme en une semaine. Addictif !', '2024-03-26 16:20:00'),
(9, 6, 12, 'Grâce à ce cours, j\'ai décroché 3 entretiens en 2 semaines. Le CV fait toute la différence', '2024-03-27 10:20:00'),
(10, 6, 15, 'Les conseils pour LinkedIn sont en or. J\'ai doublé mon nombre de contacts qualifiés', '2024-03-28 14:15:00'),
(11, 7, 9, 'Mon chien maîtrise maintenant le assis, couché et pas bouger. Méthode vraiment efficace 🐕', '2024-04-01 11:00:00'),
(12, 7, 14, 'Les techniques positives fonctionnent bien mieux que les anciennes méthodes', '2024-04-02 09:30:00'),
(13, 8, 5, 'Ma productivité a explosé ! Je gagne au moins 2h par jour', '2024-04-05 16:45:00'),
(14, 9, 10, 'J\'ai réparé la fuite de mon évier en 30 minutes. Économie de 150€ de plombier !', '2024-04-08 11:20:00'),
(15, 10, 11, 'Explications sur la sécurité très importantes. On ne plaisante pas avec l\'électricité', '2024-04-10 14:30:00'),
(16, 10, 8, 'J\'ai installé mes prises moi-même en respectant toutes les normes. Fier de moi !', '2024-04-11 09:15:00'),
(17, 11, 5, 'Niveau expert ! Les macarons sont difficiles mais les conseils sont précieux', '2024-04-15 16:00:00'),
(18, 13, 7, 'J\'ai ouvert mon premier compte titres grâce à ce cours. Investissements diversifiés !', '2024-04-20 10:30:00'),
(19, 14, 15, 'Site créé en une semaine sans une ligne de code. WordPress est génial', '2024-04-25 13:45:00'),
(20, 15, 9, 'Ma chatte va beaucoup mieux depuis que j\'applique ces conseils de santé 🐱', '2024-04-28 15:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_progress`
--

DROP TABLE IF EXISTS `user_progress`;
CREATE TABLE `user_progress` (
  `progress_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `progress_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `last_accessed` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`progress_id`),
  UNIQUE KEY `unique_user_course` (`user_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `user_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_progress_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `cours` (`cours_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_progress`
--

INSERT INTO `user_progress` (`progress_id`, `user_id`, `course_id`, `progress_percentage`, `last_accessed`) VALUES
(1, 5, 1, 100.00, '2024-03-20 16:45:00'),
(2, 5, 8, 85.00, '2024-04-10 10:30:00'),
(3, 5, 11, 45.50, '2024-04-20 14:20:00'),
(4, 6, 2, 100.00, '2024-03-25 14:20:00'),
(5, 6, 12, 30.00, '2024-04-15 09:15:00'),
(6, 7, 3, 95.00, '2024-03-28 11:30:00'),
(7, 7, 13, 60.00, '2024-04-25 13:20:00'),
(8, 8, 5, 78.00, '2024-04-05 16:50:00'),
(9, 8, 14, 55.00, '2024-04-28 10:00:00'),
(10, 9, 7, 100.00, '2024-04-07 14:15:00'),
(11, 9, 15, 88.00, '2024-05-02 09:45:00'),
(12, 10, 2, 65.00, '2024-03-30 12:30:00'),
(13, 10, 9, 100.00, '2024-04-12 08:20:00'),
(14, 11, 10, 92.00, '2024-04-18 15:40:00'),
(15, 12, 6, 100.00, '2024-04-08 11:15:00'),
(16, 12, 5, 40.00, '2024-04-22 14:50:00'),
(17, 14, 7, 70.00, '2024-04-16 10:25:00'),
(18, 14, 15, 55.00, '2024-05-01 13:30:00'),
(19, 15, 8, 82.00, '2024-04-14 16:10:00'),
(20, 15, 14, 100.00, '2024-04-30 09:00:00');

--
-- AUTO_INCREMENT for dumped tables
--

ALTER TABLE `users` MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
ALTER TABLE `categories` MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
ALTER TABLE `cours` MODIFY `cours_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
ALTER TABLE `cours_proposals` MODIFY `proposal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `cours_votes` MODIFY `vote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
ALTER TABLE `cours_content` MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
ALTER TABLE `cours_comments` MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
ALTER TABLE `user_progress` MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;