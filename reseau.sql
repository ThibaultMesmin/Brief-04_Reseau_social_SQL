BEGIN;

-- Création Table Utilisateur
DROP TABLE IF EXISTS "users" CASCADE;
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    mail VARCHAR(255) NOT NULL,
    pass VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    firstname VARCHAR(250) NULL,
    lastname VARCHAR(250) NULL,
    profilPicture VARCHAR(250) NULL
);

-- TEST insertion faux utilisateur
-- source: https://www.fakenamegenerator.com/
INSERT INTO users (mail, pass, username, firstname, lastname)
VALUES
    ('DominicRicher@armyspy.com','fe6Ke4pae','Consequall','Dominic','Richer'),
    ('CaresseLacharite@superrito.com','Poh4ohGhe2','Moterieved','Caresse','Lacharité'),
    ('ArnoCoulombe@teleworm.us','aiBa1Bi3ahw','Mandew','Arno','Coulombe'),
    ('MelusinaLamare@teleworm.us','bu9oShai','Seconied','Melusina','Lamare'),
    ('VeroniqueChicoine@fleckens.hu','iec3IeGae','Tepen1991','Véronique','Chicoine'),
    ('IvenMoise@rhyta.com','IePahl5wee','Whandricits','Iven','Moïse'),
    ('CrescentSacre@teleworm.us','AeK7ahngee','Doody1963','Crescent','Sacré'),
    ('MorganaCasgrain@superrito.com','Jawei4Pho','Beirdniance','Morgana','Casgrain'),
    ('ZoePitre@teleworm.us','phahz5Dae','Kning1958','Zoé','Pitre'),
    ('MercerQuessy@dayrep.com','za0ooWeing1','Thativess','Mercer','Quessy'),
    ('GauthierFournier@dayrep.com','ahPh0eech','Behinscathe','Gauthier','Fournier'),
    ('MarcelleDubois@fleckens.hu','gi5uata8L','Obelf1979','Marcelle','Dubois'),
    ('ElodieChatigny@jourrapide.com','Hai1einia6','Poetild','Élodie','Chatigny'),
    ('CelineLegault@gustr.com','Uu2Josh3chee','Dworter','Céline','Legault'),
    ('BayardBosse@superrito.com','iGiequi3oox','Dill1990','Bayard','Bossé'),
    ('ChristianGrandpre@gustr.com','Diey6teoyo','Blat1972','Christian','Grandpré'),
    ('ValiantTheberge@gustr.com','XaecoaCu7ah','Thartat','Valiant','Théberge'),
    ('NamoMailloux@teleworm.us','aiPeenooy9','Thumbeth','Namo','Mailloux'),
    ('PascalSevier@armyspy.com','uGhoozo9ech','Dowelacte69','Pascal','Sevier'),
    ('MaryseCharlebois@einrot.com','ooPhu2Hiu','Whoreat','Maryse','Charlebois')
;
-- Création Table Like
DROP TABLE IF EXISTS "like" CASCADE;
CREATE TABLE "like" (
    id SERIAL PRIMARY KEY,
    users_id INT NOT NULL,
    posts_id INT NOT NULL,
    CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Création Table Publication
DROP TABLE IF EXISTS posts CASCADE;
CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    users_id INT NOT NULL,
    parents_id INT,
    -- pictures VARCHAR (255),
    title VARCHAR(255),
    body VARCHAR(255) NULL,
    "date" DATE NOT NULL,
    "time" TIME NOT NULL,
    CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_parents FOREIGN KEY (parents_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Création de la table Followers
DROP TABLE IF EXISTS followers CASCADE;
CREATE TABLE IF NOT EXISTS followers (
    id SERIAL PRIMARY KEY,
    following_id INT, 
    followed_id INT,
    CONSTRAINT fk_following FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_followed FOREIGN KEY (followed_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insertion Table Followers
INSERT INTO followers (following_id, followed_id)
VALUES 
(1, 2),
(2, 1),
(2, 3),
(3, 4),
(4, 1),
(4, 2),
(5, 1),
(1, 5);

-- Compte les followers
DROP VIEW IF EXISTS view_followers;
CREATE VIEW view_followers AS
SELECT f.followed_id AS user_id, COUNT(DISTINCT f.following_id) AS followed_count
FROM followers f
GROUP BY f.followed_id;

-- TEST FOREIGN KEY
INSERT INTO posts (users_id, title, body, "date", "time")
VALUES 
(1, 'Photo plage vacances', 'photo_plage.png', '2023-03-12', '13:59'),
(2, 'Photo France vacances', 'photo_france.png', '2023-04-13', '11:34'),
(3, 'Photo Italie vacances', 'photo_italie.png', '2023-05-13', '11:48'),
(4, 'Photo Espagne vacances', 'photo_espagne.png', '2023-04-13', '11:53'),
(5, 'Photo USA vacances', 'photo_usa.png', '2023-06-13', '11:48');

-- Insertion Table Like
INSERT INTO "like" (users_id, posts_id)
VALUES 
(1, 2),
(2, 1),
(2, 3),
(3, 4),
(4, 1),
(4, 2),
(5, 1),
(1, 5);

-- Ajout liaison Like 
ALTER TABLE "like" ADD CONSTRAINT fk_posts FOREIGN KEY (posts_id) REFERENCES posts (id) ON DELETE CASCADE;

-- Création Table Rôle 
DROP TABLE IF EXISTS "role" CASCADE;
CREATE TABLE IF NOT EXISTS "role" (
    id SERIAL PRIMARY KEY,
    "Super Utilisateur" VARCHAR(255) NOT NULL,
    "Admin" VARCHAR(255) NOT NULL,
    "Modérateur" VARCHAR (255) NOT NULL,
    "Editeur" VARCHAR (255) NOT NULL, 
    "Visiteur" VARCHAR (255) NOT NULL, 
    users_id INT NOT NULL,
    CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Création Table Groupe
DROP TABLE IF EXISTS groups CASCADE;
CREATE TABLE IF NOT EXISTS groups (
    id SERIAL PRIMARY KEY,
    groupName VARCHAR(255) NOT NULL,
    users_id INT NOT NULl,
    role_id INT,
    posts_id INT,
    CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES "role"(id) ON DELETE CASCADE,
    CONSTRAINT fk_posts FOREIGN KEY (posts_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Création Table Partage
DROP TABLE IF EXISTS "share" CASCADE;
CREATE TABLE share (
    id SERIAL PRIMARY KEY,
    users_id INT NOT NULL,
    posts_id INT NULL,
    groups_id INT NOT NULL,
    CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_posts FOREIGN KEY (posts_id) REFERENCES posts(id) ON DELETE CASCADE,
    CONSTRAINT fk_groups FOREIGN KEY (groups_id) REFERENCES groups(id) ON DELETE CASCADE
);

-- Compte les likes et partages 
DROP VIEW IF EXISTS view_posts;
CREATE VIEW view_posts AS                -- Création d'une view des posts avec leurs nombre de like.
SELECT DISTINCT p.*, COUNT(l.users_id) AS "like", (SELECT count(s.id) FROM share s WHERE s.posts_id = p.id) AS share
FROM "like" l
RIGHT JOIN posts p ON p.id = l.posts_id
GROUP BY p.id
ORDER BY p."date" DESC;

-- Création de la table intermédiaire entre users et groups
DROP TABLE IF EXISTS users_groups CASCADE;
CREATE TABLE IF NOT EXISTS users_groups (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    CONSTRAINT fk_users_groups_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_users_groups_group FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE
);

-- Affichage TABLE
SELECT * FROM posts;
SELECT * FROM "like";


COMMIT;
