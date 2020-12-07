createPasswordTable(db) {
  db.execute("CREATE TABLE "
      "passwords ("
      "id integer PRIMARY KEY,"
      "name TEXT,"
      "category TEXT,"
      "color TEXT,"
      "website TEXT,"
      "service TEXT,"
      "password TEXT)");
}
