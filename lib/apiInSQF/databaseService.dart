import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ComplainList.dart';

class DatabaseHelper {
  List<Complaint> complainListModel = [];
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'complaints.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE complaints(id TEXT PRIMARY KEY, fullname TEXT, package TEXT, description TEXT, email TEXT, status TEXT, date TEXT, time TEXT)',
        );
      },
    );
  }

  Future<void> insertComplaint(Complaint complaint) async {
    final db = await database;
    await db.insert(
      'complaints',
      complaint.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Complaint>> getComplaints() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('complaints');
    return List.generate(maps.length, (i) {
      return Complaint(
        id: maps[i]['id'],
        fullname: maps[i]['fullname'],
        package: maps[i]['package'],
        description: maps[i]['description'],
        email: maps[i]['email'],
        status: maps[i]['status'],
        date: maps[i]['date'],
        time: maps[i]['time'],
      );
    });
  }

  Future<List<Complaint>> fetchComplaints() async {
    final response = await http.get(Uri.parse('https://crystalsolutions.com.pk/cablenet/admin/ComplaintList.php'));
    if (response.statusCode == 200) {
      List<Complaint> complaints = [];
      var result = jsonDecode(response.body);
      for (Map<String, dynamic> i in result) {
        complaints.add(Complaint.fromJson(i));
      }
      return complaints;
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  Future<void> storeComplaints() async {
    try {
      List<Complaint> complaints = await fetchComplaints();
      for (Complaint complaint in complaints) {
        await insertComplaint(complaint);
      }
    } catch (e) {
      print('Failed to fetch complaints: $e');
      // Handle the error, perhaps by showing a message to the user.
    }
  }
}
