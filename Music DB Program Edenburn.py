import mysql.connector

# ------------------------------
# Connect to your database
# ------------------------------
def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="music_user",
        password="pass",
        database="music_catalog"
    )


def show_overview():
    db = get_connection()
    cur = db.cursor()

    print("\n--- Artists ---")
    cur.execute("SELECT Name, Country, ActivityStart FROM Artist;")
    for row in cur.fetchall():
        print(row)

    print("\n--- Songs ---")
    cur.execute("""
        SELECT Song.Title, Song.Genre, Song.ReleaseDate, Artist.Name
        FROM Song
        JOIN Artist ON Song.ArtistID = Artist.ArtistID;
    """)
    for row in cur.fetchall():
        print(row)

    print("\n--- Playlists ---")
    cur.execute("SELECT PlaylistName, Created, Description FROM Playlist;")
    for row in cur.fetchall():
        print(row)

    db.close()


def search_songs():
    keyword = input("Enter part of a song title: ")

    db = get_connection()
    cur = db.cursor()

    cur.execute("SELECT Title, Genre, ReleaseDate FROM Song WHERE Title LIKE %s;",
                ("%" + keyword + "%",))

    print("\nSearch Results:")
    for row in cur.fetchall():
        print(row)

    db.close()


def add_artist():
    name = input("Artist name: ")
    country = input("Country: ")
    start = input("Activity Start (YYYY-MM-DD): ")

    db = get_connection()
    cur = db.cursor()

    cur.execute("INSERT INTO Artist (Name, Country, ActivityStart) VALUES (%s, %s, %s);",
                (name, country, start))

    db.commit()
    print("Artist added.")
    db.close()


def add_song():
    title = input("Song title: ")
    duration = input("Duration in seconds: ")
    genre = input("Genre: ")
    release = input("Release date (YYYY-MM-DD): ")
    artist_id = input("Artist ID (number): ")

    db = get_connection()
    cur = db.cursor()

    cur.execute("""
        INSERT INTO Song (Title, Duration, Genre, ReleaseDate, ArtistID)
        VALUES (%s, %s, %s, %s, %s);
    """, (title, duration, genre, release, artist_id))

    db.commit()
    print("Song added.")
    db.close()


def update_song():
    title = input("Enter the song title to update: ")
    new_genre = input("Enter the new genre: ")

    db = get_connection()
    cur = db.cursor()

    cur.execute("UPDATE Song SET Genre = %s WHERE Title = %s;",
                (new_genre, title))

    db.commit()
    print("Song updated.")
    db.close()

# ------------------------------
# 5. Delete data
# ------------------------------
def delete_song():
    title = input("Enter the song title to delete: ")

    db = get_connection()
    cur = db.cursor()

    cur.execute("DELETE FROM Song WHERE Title = %s;", (title,))

    db.commit()
    print("Song deleted.")
    db.close()

def main():
    while True:
        print("\n===== MUSIC DATABASE MENU =====")
        print("1. View Overview")
        print("2. Search Songs")
        print("3. Add Artist")
        print("4. Add Song")
        print("5. Update a Song")
        print("6. Delete a Song")
        print("0. Exit")

        choice = input("Choose an option: ")

        if choice == "1":
            show_overview()
        elif choice == "2":
            search_songs()
        elif choice == "3":
            add_artist()
        elif choice == "4":
            add_song()
        elif choice == "5":
            update_song()
        elif choice == "6":
            delete_song()
        elif choice == "0":
            print("Goodbye!")
            break
        else:
            print("Invalid choice.")

# ------------------------------
# Run program
# ------------------------------
if __name__ == "__main__":
    main()
