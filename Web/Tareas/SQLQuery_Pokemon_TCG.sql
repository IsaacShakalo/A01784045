Use Pokemon_TCG;
Select * From mano;



CREATE TABLE arena (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  name VARCHAR(255) NOT NULL,
  nation VARCHAR(255) NOT NULL
);

CREATE TABLE effect (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL
);

CREATE TABLE carta (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  name VARCHAR(255) NOT NULL,
  attack INT CHECK (attack > 0),
  health INT CHECK (health > 0),
  cost INT CHECK (cost > 0),
  effect_id INT,
  FOREIGN KEY (effect_id) REFERENCES effect(id)
);

CREATE TABLE jugador (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  wins INT DEFAULT 0,
  loses INT DEFAULT 0
);

CREATE TABLE mazo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  nation VARCHAR(255) NOT NULL
);

CREATE TABLE jugador_mazo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  player_id INT NOT NULL,
  deck_id INT NOT NULL,
  FOREIGN KEY (player_id) REFERENCES jugador(id),
  FOREIGN KEY (deck_id) REFERENCES mazo(id)
);

CREATE TABLE partida (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  duration INT NOT NULL CHECK (duration > 0),
  arena_id INT NOT NULL,
  FOREIGN KEY (arena_id) REFERENCES arena(id)
);


CREATE TABLE accion_partida (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  game_id INT NOT NULL,
  player_id INT NOT NULL,
  card_id INT NOT NULL,
  action_type VARCHAR(255) NOT NULL,
  turn_number INT NOT NULL CHECK (turn_number > 0),
  FOREIGN KEY (game_id) REFERENCES partida(id),
  FOREIGN KEY (player_id) REFERENCES jugador(id),
  FOREIGN KEY (card_id) REFERENCES carta(id)
);

CREATE TABLE mano (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  player_id INT NOT NULL,
  game_id INT NOT NULL,
  gold_coins INT NOT NULL CHECK (gold_coins > 0),
  FOREIGN KEY (player_id) REFERENCES jugador(id),
  FOREIGN KEY (game_id) REFERENCES partida(id)
);

CREATE TABLE carta_mano (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  card_id INT NOT NULL,
  hand_id INT NOT NULL,
  FOREIGN KEY (card_id) REFERENCES carta(id),
  FOREIGN KEY (hand_id) REFERENCES mano(id)
);

CREATE TABLE carta_partida (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  card_id INT NOT NULL,
  game_id INT NOT NULL,
  position INT CHECK (position BETWEEN 1 AND 3),
  FOREIGN KEY (card_id) REFERENCES carta(id),
  FOREIGN KEY (game_id) REFERENCES partida(id)
);

CREATE TABLE coleccion_cartas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME,
  updated_at DATETIME,
  player_id INT NOT NULL,
  card_id INT NOT NULL,
  cantidad INT NOT NULL CHECK (cantidad > 0),
  FOREIGN KEY (player_id) REFERENCES jugador(id),
  FOREIGN KEY (card_id) REFERENCES carta(id)
);

INSERT INTO arena (created_at, updated_at, name, nation) VALUES
(NOW(), NOW(), 'Pikachu Stadium', 'Electric Kingdom'),
(NOW(), NOW(), 'Charizard Cavern', 'Fire Nation'),
(NOW(), NOW(), 'Squirtle Shore', 'Water World'),
(NOW(), NOW(), 'Bulbasaur Garden', 'Grassland'),
(NOW(), NOW(), 'Eevee Estate', 'Evolution Valley'),
(NOW(), NOW(), 'Mewtwo Lab', 'Psychic Empire'),
(NOW(), NOW(), 'Gengar Mansion', 'Ghost Town'),
(NOW(), NOW(), 'Jigglypuff Opera', 'Fairy Land'),
(NOW(), NOW(), 'Snorlax Valley', 'Sleeping Giant'),
(NOW(), NOW(), 'Dragonite Isles', 'Dragon Domain'),
(NOW(), NOW(), 'Lugia Depths', 'Legendary Sea'),
(NOW(), NOW(), 'Ho-Oh Summit', 'Phoenix Peak'),
(NOW(), NOW(), 'Tyranitar Desert', 'Rocky Expanse'),
(NOW(), NOW(), 'Aggron Mountains', 'Steel Range'),
(NOW(), NOW(), 'Sceptile Jungle', 'Tropical Forest');

INSERT INTO effect (created_at, updated_at, name, description) VALUES
(NOW(), NOW(), 'Burn', 'Deals fire damage over time.'),
(NOW(), NOW(), 'Paralyze', 'Prevents action due to electric shock.'),
(NOW(), NOW(), 'Sleep', 'Puts opponent to sleep, preventing action.'),
(NOW(), NOW(), 'Poison', 'Inflicts damage over time with toxin.'),
(NOW(), NOW(), 'Confuse', 'Causes confusion, potentially hurting oneself.'),
(NOW(), NOW(), 'Freeze', 'Freezes opponent, preventing action.'),
(NOW(), NOW(), 'Heal', 'Restores health.'),
(NOW(), NOW(), 'Boost Attack', 'Temporarily increases attack power.'),
(NOW(), NOW(), 'Boost Defense', 'Temporarily increases defensive power.'),
(NOW(), NOW(), 'Draw Card', 'Allows player to draw extra cards.'),
(NOW(), NOW(), 'Energy Attach', 'Allows attachment of additional energy.'),
(NOW(), NOW(), 'Escape', 'Enables escape from battle.'),
(NOW(), NOW(), 'Double Strike', 'Attacks twice in one turn.'),
(NOW(), NOW(), 'Shield', 'Reduces incoming damage.'),
(NOW(), NOW(), 'Revive', 'Revives a fainted Pokémon.');

INSERT INTO carta (created_at, updated_at, name, attack, health, cost, effect_id) VALUES
(NOW(), NOW(), 'Pikachu', 40, 60, 1, 91),
(NOW(), NOW(), 'Charizard', 150, 120, 4, 92),
(NOW(), NOW(), 'Squirtle', 30, 50, 1, 93),
(NOW(), NOW(), 'Bulbasaur', 50, 60, 1, 94),
(NOW(), NOW(), 'Eevee', 35, 55, 1, 95),
(NOW(), NOW(), 'Mewtwo', 130, 110, 5, 96),
(NOW(), NOW(), 'Gengar', 70, 60, 3, 97),
(NOW(), NOW(), 'Jigglypuff', 45, 70, 1, 98),
(NOW(), NOW(), 'Snorlax', 140, 180, 5, 99),
(NOW(), NOW(), 'Dragonite', 160, 150, 6, 100),
(NOW(), NOW(), 'Lugia', 140, 130, 5, 101),
(NOW(), NOW(), 'Ho-Oh', 150, 140, 5, 102),
(NOW(), NOW(), 'Tyranitar', 160, 160, 6, 103),
(NOW(), NOW(), 'Aggron', 140, 170, 6, 104),
(NOW(), NOW(), 'Sceptile', 130, 120, 4, 105);

INSERT INTO jugador (created_at, updated_at, wins, loses) VALUES
(NOW(), NOW(), 5, 2),
(NOW(), NOW(), 10, 3),
(NOW(), NOW(), 8, 4),
(NOW(), NOW(), 2, 5),
(NOW(), NOW(), 7, 6),
(NOW(), NOW(), 3, 1),
(NOW(), NOW(), 12, 9),
(NOW(), NOW(), 6, 3),
(NOW(), NOW(), 9, 5),
(NOW(), NOW(), 4, 2),
(NOW(), NOW(), 11, 7),
(NOW(), NOW(), 8, 6),
(NOW(), NOW(), 14, 10),
(NOW(), NOW(), 3, 2),
(NOW(), NOW(), 7, 4);

INSERT INTO mazo (created_at, updated_at, name, description, nation) VALUES
(NOW(), NOW(), 'Electric Surge', 'A deck focusing on Electric-type Pokémon.', 'Electric Kingdom'),
(NOW(), NOW(), 'Fiery Wrath', 'A deck filled with Fire-type Pokémon.', 'Fire Nation'),
(NOW(), NOW(), 'Aqua Force', 'A Water-type Pokémon deck.', 'Water World'),
(NOW(), NOW(), 'Grass Whisper', 'A deck concentrating on Grass-type Pokémon.', 'Grassland'),
(NOW(), NOW(), 'Eevee Evolution', 'Features Eevee and its evolutions.', 'Evolution Valley'),
(NOW(), NOW(), 'Psychic Beam', 'A deck with Psychic-type Pokémon.', 'Psychic Empire'),
(NOW(), NOW(), 'Ghost Haunt', 'Filled with Ghost-type Pokémon.', 'Ghost Town'),
(NOW(), NOW(), 'Fairy Melody', 'A deck of Fairy-type Pokémon.', 'Fairy Land'),
(NOW(), NOW(), 'Giant Sleep', 'A deck with Snorlax and similar Pokémon.', 'Sleeping Giant'),
(NOW(), NOW(), 'Dragon Roar', 'Features Dragon-type Pokémon.', 'Dragon Domain'),
(NOW(), NOW(), 'Legendary Wing', 'A deck of Legendary Pokémon.', 'Legendary Sea'),
(NOW(), NOW(), 'Rocky Terrain', 'A deck focusing on Rock-type Pokémon.', 'Rocky Expanse'),
(NOW(), NOW(), 'Steel Fortress', 'Concentrates on Steel-type Pokémon.', 'Steel Range'),
(NOW(), NOW(), 'Tropical Storm', 'A deck with Tropical and Grass-type Pokémon.', 'Tropical Forest'),
(NOW(), NOW(), 'Volcanic Fury', 'Features Fire and Ground-type Pokémon.', 'Fire Nation');

INSERT INTO jugador_mazo (created_at, updated_at, player_id, deck_id) VALUES
(NOW(), NOW(), 51, 16),
(NOW(), NOW(), 52, 17),
(NOW(), NOW(), 53, 18),
(NOW(), NOW(), 54, 19),
(NOW(), NOW(), 55, 20),
(NOW(), NOW(), 56, 21),
(NOW(), NOW(), 57, 22),
(NOW(), NOW(), 58, 23),
(NOW(), NOW(), 59, 24),
(NOW(), NOW(), 60, 25),
(NOW(), NOW(), 61, 26),
(NOW(), NOW(), 62, 27),
(NOW(), NOW(), 63, 28),
(NOW(), NOW(), 64, 29),
(NOW(), NOW(), 65, 30);

INSERT INTO partida (created_at, updated_at, duration, arena_id)
VALUES
    (NOW(), NOW(), 30, 31),
    (NOW(), NOW(), 25, 32),
    (NOW(), NOW(), 40, 33),
    (NOW(), NOW(), 35, 34),
    (NOW(), NOW(), 45, 35),
    (NOW(), NOW(), 20, 36),
    (NOW(), NOW(), 50, 37),
    (NOW(), NOW(), 15, 38),
    (NOW(), NOW(), 55, 39),
    (NOW(), NOW(), 10, 40),
    (NOW(), NOW(), 60, 41),
    (NOW(), NOW(), 5, 42),
    (NOW(), NOW(), 70, 43),
    (NOW(), NOW(), 25, 44),
    (NOW(), NOW(), 80, 45);

INSERT INTO mano (created_at, updated_at, player_id, game_id, gold_coins)
VALUES
(NOW(), NOW(), 51, 76, 10),
(NOW(), NOW(), 52, 77, 15),
(NOW(), NOW(), 53, 78, 8),
(NOW(), NOW(), 54, 79, 12),
(NOW(), NOW(), 55, 80, 20),
(NOW(), NOW(), 56, 81, 5),
(NOW(), NOW(), 57, 82, 18),
(NOW(), NOW(), 58, 83, 13),
(NOW(), NOW(), 59, 84, 7),
(NOW(), NOW(), 60, 85, 11),
(NOW(), NOW(), 61, 86, 16),
(NOW(), NOW(), 62, 87, 9),
(NOW(), NOW(), 63, 88, 14),
(NOW(), NOW(), 64, 89, 6),
(NOW(), NOW(), 65, 90, 19);

INSERT INTO carta_mano (created_at, updated_at, card_id, hand_id)
VALUES
(NOW(), NOW(), 31, 61),
(NOW(), NOW(), 32, 62),
(NOW(), NOW(), 33, 63),
(NOW(), NOW(), 34, 64),
(NOW(), NOW(), 35, 65),
(NOW(), NOW(), 36, 66),
(NOW(), NOW(), 37, 67),
(NOW(), NOW(), 38, 68),
(NOW(), NOW(), 39, 69),
(NOW(), NOW(), 40, 70),
(NOW(), NOW(), 41, 71),
(NOW(), NOW(), 42, 72),
(NOW(), NOW(), 43, 73),
(NOW(), NOW(), 44, 74),
(NOW(), NOW(), 45, 75);

INSERT INTO coleccion_cartas (created_at, updated_at, player_id, card_id, cantidad)
VALUES
(NOW(), NOW(), 51, 31, 10),
(NOW(), NOW(), 52, 32, 5),
(NOW(), NOW(), 53, 33, 3),
(NOW(), NOW(), 54, 34, 7),
(NOW(), NOW(), 55, 35, 9),
(NOW(), NOW(), 56, 36, 12),
(NOW(), NOW(), 57, 37, 15),
(NOW(), NOW(), 58, 38, 8),
(NOW(), NOW(), 59, 39, 6),
(NOW(), NOW(), 60, 40, 11),
(NOW(), NOW(), 61, 41, 14),
(NOW(), NOW(), 62, 42, 17),
(NOW(), NOW(), 63, 43, 20),
(NOW(), NOW(), 64, 44, 4),
(NOW(), NOW(), 65, 45, 2);







