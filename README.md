# Projet SQL

Ce projet SQL consiste à créer et gérer une base de données pour une application de réseau social. Il inclut la création de tables pour les utilisateurs,
les publications, les likes, les followers, les rôles, les groupes et les partages, ainsi que des vues pour compter les followers et les interactions sur les publications.

## Structure de la base de données

### Tables

- users : Contient les informations des utilisateurs.
- like : Gère les likes sur les publications.
- posts : Contient les publications des utilisateurs.
- followers : Gère les relations de suivi entre les utilisateurs.
- role : Définit les rôles des utilisateurs.
- groups : Gère les groupes d’utilisateurs.
- share : Gère les partages de publications entre les groupes.
- users_groups : Table intermédiaire pour les relations entre utilisateurs et groupes.

### Vues

- view_followers : Compte le nombre de followers pour chaque utilisateur.
- view_posts : Compte le nombre de likes et de partages pour chaque publication.

### Instructions
- Création des tables : Les tables sont créées avec des contraintes de clé étrangère pour assurer l’intégrité référentielle.
- Insertion de données : Des données fictives sont insérées dans les tables users, followers, posts, et like pour tester les fonctionnalités.
- Création des vues : Les vues view_followers et view_posts sont créées pour faciliter l’analyse des données.
