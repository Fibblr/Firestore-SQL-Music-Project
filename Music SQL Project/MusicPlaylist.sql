-- Drop and recreate database
DROP DATABASE IF EXISTS music_catalog;
CREATE DATABASE music_catalog;
USE music_catalog;

-- ===============================
-- Table: Artist
-- ===============================
CREATE TABLE Artist (
    ArtistID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    ActivityStart DATE,
    INDEX idx_artist_name (Name)
);

-- ===============================
-- Table: Song
-- ===============================
CREATE TABLE Song (
    SongID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Duration INT,
    Genre VARCHAR(50),
    ReleaseDate DATE,
    ArtistID INT NOT NULL,
    CONSTRAINT fk_song_artist 
        FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    INDEX idx_song_title (Title)
);

-- ===============================
-- Table: Playlist
-- ===============================
CREATE TABLE Playlist (
    PlaylistID INT AUTO_INCREMENT PRIMARY KEY,
    PlaylistName VARCHAR(100) NOT NULL,
    Created DATE,
    Description TEXT,
    INDEX idx_playlist_name (PlaylistName)
);

-- ===============================
-- Table: PlaylistSong
-- ===============================
CREATE TABLE PlaylistSong (
    PlaylistID INT NOT NULL,
    SongID INT NOT NULL,
    SongOrder SMALLINT,
    PRIMARY KEY (PlaylistID, SongID),
    CONSTRAINT fk_playlist_song_playlist 
        FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_playlist_song_song 
        FOREIGN KEY (SongID) REFERENCES Song(SongID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ===============================
-- User and Permissions
-- ===============================
CREATE USER IF NOT EXISTS 'music_user'@'localhost' IDENTIFIED BY 'music_pass123';
GRANT SELECT, INSERT, UPDATE, DELETE ON music_catalog.* TO 'music_user'@'localhost';
FLUSH PRIVILEGES;
