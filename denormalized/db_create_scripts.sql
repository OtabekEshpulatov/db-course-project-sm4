-- Create schema for denormalized model
CREATE SCHEMA IF NOT EXISTS denormalized_model;

-- Create fact table: tracks
CREATE TABLE IF NOT EXISTS denormalized_model.tracks
(
    track_id         VARCHAR(255) PRIMARY KEY,
    track_name       VARCHAR(255),
    track_popularity INTEGER,
    album_id         VARCHAR(255),
    artist_id        VARCHAR(255),
    playlist_id      VARCHAR(255),
    duration_ms      INTEGER,
    time_signature   INTEGER,
    danceability     DOUBLE PRECISION,
    energy           DOUBLE PRECISION,
    key_             INTEGER,
    loudness         DOUBLE PRECISION,
    mode_            INTEGER,
    speechiness      DOUBLE PRECISION,
    acousticness     DOUBLE PRECISION,
    instrumentalness DOUBLE PRECISION,
    liveness         DOUBLE PRECISION,
    valence          DOUBLE PRECISION,
    tempo            DOUBLE precision
);


-- Create dimension table: artists
CREATE TABLE IF NOT EXISTS denormalized_model.artists
(
    artist_id         VARCHAR(255) PRIMARY KEY,
    artist_name       VARCHAR(255),
    genre_id VARCHAR(255),
    artist_popularity INTEGER
    
);

-- Create dimension table: playlists
CREATE TABLE IF NOT EXISTS denormalized_model.playlists
(
    playlist_id  VARCHAR(255) PRIMARY KEY,
    playlist_url VARCHAR(255),
    year_        INTEGER
);

-- Create dimension table: albums
CREATE TABLE IF NOT EXISTS denormalized_model.albums
(
    album_id   VARCHAR(255) PRIMARY KEY,
    album_name VARCHAR(255)
);

-- Create dimension table: genres
CREATE TABLE IF NOT EXISTS denormalized_model.genres
(
    genre_id   VARCHAR(255) PRIMARY KEY,
    genre_name VARCHAR(255)
);



ALTER TABLE denormalized_model.tracks
    DROP CONSTRAINT IF EXISTS track_album_fk;
ALTER TABLE denormalized_model.tracks
    ADD CONSTRAINT track_album_fk FOREIGN KEY (album_id)
        REFERENCES denormalized_model.albums (album_id);

ALTER TABLE denormalized_model.tracks
    DROP CONSTRAINT IF EXISTS track_artist_fk;
ALTER TABLE denormalized_model.tracks
    ADD CONSTRAINT track_artist_fk FOREIGN KEY (artist_id)
        REFERENCES denormalized_model.artists (artist_id);

ALTER TABLE denormalized_model.tracks
    DROP CONSTRAINT IF EXISTS track_playlist_fk;
ALTER TABLE denormalized_model.tracks
    ADD CONSTRAINT track_playlist_fk FOREIGN KEY (playlist_id)
        REFERENCES denormalized_model.playlists (playlist_id);

ALTER TABLE denormalized_model.artists
	DROP CONSTRAINT IF EXISTS artist_genre_fk;
ALTER TABLE denormalized_model.artists
	ADD CONSTRAINT artist_genre_fk FOREIGN KEY (genre_id)
		REFERENCES denormalized_model.genres (genre_id);