import 'package:test_app/auth/data/data_source/auth_local_db.dart';
import 'package:test_app/auth/data/models/user_model.dart';


class AuthRepo {
  final AuthLocalData local;

  AuthRepo(this.local);


  Future<UserModel?> login(String email, String password) async {
    return await local.login(email, password);
  }

  Future<void> register(UserModel user) async {
    await local.register(user);
  }


  Future<UserModel?> getUser(String email) async {
    return await local.getUser(email);
  }
}