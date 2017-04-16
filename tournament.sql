-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP DATABASE IF EXISTS tournament;

/* Create the database tournament */
CREATE DATABASE tournament;

/* Connect to the database */
\c tournament;

-- DROP old Tables
DROP VIEW IF EXISTS standings;
DROP VIEW IF EXISTS player_wins;
DROP VIEW IF EXISTS matches_per_player;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS matches;

CREATE TABLE players (
	player_id SERIAL primary key,
	name varchar(255)
);

CREATE TABLE matches (
	id SERIAL primary key,
	player int references players(player_id),
	opponent int references players(player_id),
	result int
);

CREATE VIEW player_wins AS
	SELECT players.player_id, COUNT(matches.opponent) AS n 
	FROM players
	LEFT JOIN (SELECT * FROM matches WHERE result>0) as matches
	ON players.player_id = matches.player
	GROUP BY players.player_id;

-- Count View shows number of matches for each Player
CREATE VIEW matches_per_player AS
	SELECT players.player_id, Count(matches.opponent) AS n 
	FROM players
	LEFT JOIN matches
	ON players.player_id = matches.player
	GROUP BY players.player_id;

-- Standings View shows number of wins and matches for each Player
CREATE VIEW standings AS 
	SELECT pl.player_id,pl.name,pw.n as wins,mpp.n as matches 
	FROM players pl
	INNER JOIN matches_per_player mpp ON pl.player_id = mpp.player_id
	INNER JOIN player_wins pw ON pw.player_id = pl.player_id