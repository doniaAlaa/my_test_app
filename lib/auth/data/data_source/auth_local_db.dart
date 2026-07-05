import 'package:test_app/auth/data/models/user_model.dart';
import 'package:test_app/db_helper/login_db_helper.dart';


class AuthLocalData {


  Future<void> register(UserModel user) async {
    await DBHelper.insertUser(user);
  }

  Future<UserModel?> login(String email, String password) async {
    return await DBHelper.login(email, password);
  }



   Future<UserModel?> getUser() async {
      final db = await DBHelper.database; //

    final result = await db.query('users');

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null;
  }
  }