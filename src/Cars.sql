create DATABASE fastapi;

use fastapi;

CREATE USER 'fast_user'@'%' IDENTIFIED BY 'secret_pass1234';
GRANT ALL PRIVILEGES ON * . * TO 'fast_user'@'%';
flush privileges;

CREATE TABLE IF NOT EXISTS brand (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    street_cred VARCHAR(255) NOT NULL
);

insert into brand (title, street_cred) values ('Renault', 'Tu es un bon patriote, mais probablement malgré toi.');

insert into brand (title, street_cred) values ('Bugatti', 'Tu es le capitalisme, crédibilité maximale.');

insert into brand (title, street_cred) values ('FIAT', 'Tu conduis la voiture de ta femme, honte sur ton âme.');

insert into brand (title, street_cred) values ('Mercedes', 'Tu possèdes tous les attributs pour être défini comme sénile.');

insert into brand (title, street_cred) values ('Lotus', 'Tu es un pilote Harry.');

insert into brand (title, street_cred) values ('BMW', 'Tu achètes du bas de gamme pour avoir le porte clé. Bravo à toi.');

insert into brand (title, street_cred) values ('Dacia', 'Basé ou précarité, telle est la question');

insert into brand (title, street_cred) values ('Volkswagen', 'Tu sait reconnaître l\'efficacité de l\'ingénierie allemande.');

insert into brand (title, street_cred) values ('Volvo', 'Ta masse musculaire pèse probablement plus lourd que ta voiture.');