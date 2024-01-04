import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:z_test/data/models/auth_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final Directory folderDokumen = await getApplicationDocumentsDirectory();
    final String lokasiDatabase = folderDokumen.path;
    final String jalurLokasiDatabase = '$lokasiDatabase/account.db';

    return await openDatabase(
      jalurLokasiDatabase,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<bool> isLoggedIn() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> accounts = await db.query('account');

    return accounts.isNotEmpty;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE account(id INTEGER PRIMARY KEY, fullName TEXT, email TEXT, password TEXT, image TEXT, score INTEGER, token INTEGER)''');
  }

  Future<Auth?> getCurrentUser() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> accounts =
        await db.query('account', where: 'token = ?', whereArgs: [1]);

    return accounts.isNotEmpty ? Auth.fromMap(accounts.first) : null;
  }

  Future<Auth?> getScoreUser() async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> accounts =
        await db.query('account', where: 'score = ?', whereArgs: [1]);

    return accounts.isNotEmpty ? Auth.fromMap(accounts.first) : null;
  }

  // Future<Auth?> getAuth(String email, String password) async {
  //   final Database db = await instance.database;

  //   final List<Map<String, dynamic>> accounts = await db.query(
  //     'account',
  //     where: 'email = ? AND password = ?',
  //     whereArgs: [email, password],
  //   );

  //   return accounts.isNotEmpty ? Auth.fromMap(accounts.first) : null;
  // }
  Future<Map<String, dynamic>> getAuth(String email, String password) async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> accounts = await db.query(
      'account',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (accounts.isEmpty) {
      // Email tidak ditemukan
      return {'error': 'email_not_found'};
    }

    final Map<String, dynamic> account = accounts.first;

    if (account['password'] != password) {
      // Password tidak sesuai
      return {'error': 'password_mismatch'};
    }

    // Auth ditemukan, kembalikan data user
    return {'auth': Auth.fromMap(account)};
  }

  Future<int> addAuth(Auth auth) async {
    final Database db = await instance.database;
    return await db.insert('account', auth.toMap());
  }

  Future<int> removeAuth(int id) async {
    final Database db = await instance.database;
    return await db.delete('account', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAuth(Auth auth) async {
    final Database db = await instance.database;

    Map<String, dynamic> updateValues = {};

    if (auth.fullName != null && auth.fullName!.isNotEmpty) {
      updateValues['fullName'] = auth.fullName;
    }

    if (auth.email != null && auth.email!.isNotEmpty) {
      updateValues['email'] = auth.email;
    }

    if (auth.password != null && auth.password!.isNotEmpty) {
      updateValues['password'] = auth.password;
    }

    if (auth.image != null && auth.image!.isNotEmpty) {
      updateValues['image'] = auth.image;
    }

    return await db.update(
      'account',
      updateValues,
      where: "id = ?",
      whereArgs: [auth.id],
    );
  }

  Future<int> updateScore(Auth auth) async {
    final Database db = await instance.database;

    Map<String, dynamic> updateValues = {};

    if (auth.score != null) {
      updateValues['score'] = auth.score;
    }

    return await db.update(
      'account',
      updateValues,
      where: "id = ?",
      whereArgs: [auth.id],
    );
  }

  Future<int> updateImgProfile(Auth auth) async {
    final Database db = await instance.database;

    Map<String, dynamic> updateValues = {};

    if (auth.image != null) {
      updateValues['image'] = auth.image;
    }

    return await db.update(
      'account',
      updateValues,
      where: "id = ?",
      whereArgs: [auth.id],
    );
  }

  Future<Auth?> getProfile(int id) async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> accounts = await db.query(
      'account',
      where: 'id = ?',
      whereArgs: [id],
    );

    return accounts.isNotEmpty ? Auth.fromMap(accounts.first) : null;
  }

  Future<int> removeAllAuth() async {
    final Database db = await instance.database;
    return await db.delete('account');
  }

  // Future<List<Auth>> getAllAccounts() async {
  //   final Database db = await instance.database;

  //   final List<Map<String, dynamic>> accountMaps = await db.query('account');

  //   List<Auth> accounts = List.generate(accountMaps.length, (i) {
  //     return Auth(
  //       id: accountMaps[i]['id'],
  //       fullName: accountMaps[i]['fullName'],
  //       email: accountMaps[i]['email'],
  //       password: accountMaps[i]['password'],
  //       score: accountMaps[i]['score'],
  //       token: accountMaps[i]['token'],
  //     );
  //   });

  //   return accounts;
  // }

  // Future<void> printAllAccounts() async {
  //   final List<Auth> allAccounts = await getAllAccounts();

  //   for (Auth account in allAccounts) {
  //     print('ID: ${account.id}');
  //     print('Full Name: ${account.fullName}');
  //     print('Email: ${account.email}');
  //     print('Password: ${account.password}');
  //     print('Score: ${account.score}');
  //     print('Token: ${account.token ?? 0}');
  //     print('------------------------');
  //   }
  // }
  
  Future<bool> isEmailAlreadyRegistered(String email) async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> accounts = await db.query(
      'account',
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email],
    );

    return accounts.isNotEmpty;
  }

  Future<void> setToken(int id, int token) async {
    final Database db = await instance.database;
    await db.rawUpdate(
      'UPDATE account SET token = ? WHERE id = ?',
      [token, id],
    );
  }

  Future<void> setScore(int id, int score) async {
    final Database db = await instance.database;
    await db.rawUpdate(
      'UPDATE account SET score = ? WHERE id = ?',
      [score, id],
    );
  }

  Future<void> setImageProfile(int id, String path) async {
    final Database db = await instance.database;
    await db.rawUpdate(
      'UPDATE account SET image = ? WHERE id = ?',
      [path, id],
    );
  }
}
