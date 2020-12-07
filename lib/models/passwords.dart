import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:password/helpers/variables.dart';
import 'package:sqflite/sqflite.dart';

class Password {
  final String table = "passwords";

  int id;
  String name;
  String category;
  String color;
  String website;
  String service;
  String password;

  Password(
      {this.id,
      this.name,
      this.category,
      this.color,
      this.website,
      this.service,
      this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'color': color,
      'website': website,
      'service': service,
      'password': password
    };
  }

  @override
  String toString() {
    return 'Password{id: $id, name: $name, category: $category, color: $color, website: $website, service: $service, password: $password}';
  }

  Color colorOrWhite() {
    return this.color != null
        ? Color(int.parse("0x${this.color}"))
        : Colors.white;
  }

  Color foregroundWhiteOrBlack() {
    return useWhiteForeground(this.colorOrWhite())
        ? const Color(0xffffffff)
        : const Color(0xff000000);
  }

  Future<List> categories() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Password.
    List<Map> map = await db.query(table,
        distinct: false,
        columns: ["category"],
        where: "category IS NOT NULL AND category != ''",
        groupBy: "category",
        orderBy: "category");
    return map;
  }

  Future<Password> insert() async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same password is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      table,
      this.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return this;
  }

  Future<void> delete() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Password from the Database.
    await db.delete(
      table,
      // Use a `where` clause to delete a specific password.
      where: "id = ?",
      // Pass the Password's id as a whereArg to prevent SQL injection.
      whereArgs: [this.id],
    );
  }

  Future<void> truncate() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Password from the Database.
    await db.delete(table);
  }

  Future<Password> update() async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Password.
    await db.update(
      table,
      this.toMap(),
      // Ensure that the Password has a matching id.
      where: "id = ?",
      // Pass the Password's id as a whereArg to prevent SQL injection.
      whereArgs: [this.id],
    );
    return this;
  }

  Future<List<Password>> paginate(category, offset, limit) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Password.
    List<Map<String, dynamic>> maps;
    if (category == "ALL") {
      maps = await db.query(table, offset: offset, limit: limit);
    } else {
      maps = await db.query(table,
          where: "category = '$category'", offset: offset, limit: limit);
    }

    // Convert the List<Map<String, dynamic> into a List<Password>.
    return List.generate(maps.length, (i) {
      return Password(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
        color: maps[i]['color'],
        website: maps[i]['website'],
        service: maps[i]['service'],
        password: maps[i]['password'],
      );
    });
  }

  Future<List<Password>> all() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Password.
    List<Map<String, dynamic>> maps;
    maps = await db.query(table);

    // Convert the List<Map<String, dynamic> into a List<Password>.
    return List.generate(maps.length, (i) {
      return Password(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
        color: maps[i]['color'],
        website: maps[i]['website'],
        service: maps[i]['service'],
        password: maps[i]['password'],
      );
    });
  }
}
