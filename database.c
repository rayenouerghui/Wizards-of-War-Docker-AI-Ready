#include <sqlite3.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    sqlite3 *db;
    int rc = sqlite3_open("game.db", &db);
    if (rc) {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        return rc;
    }

    const char *sql = "CREATE TABLE IF NOT EXISTS Players (PlayerID TEXT PRIMARY KEY, Score INTEGER);";
    char *errmsg = NULL;
    rc = sqlite3_exec(db, sql, 0, 0, &errmsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", errmsg);
        sqlite3_free(errmsg);
        sqlite3_close(db);
        return rc;
    }

    const char *insert = "INSERT OR REPLACE INTO Players (PlayerID, Score) VALUES ('player1', 100);";
    rc = sqlite3_exec(db, insert, 0, 0, &errmsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", errmsg);
        sqlite3_free(errmsg);
    }

    sqlite3_close(db);
    printf("database.c: DB initialized (game.db)\n");
    return 0;
}
