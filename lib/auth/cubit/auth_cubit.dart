
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/auth/data/models/user_model.dart';
import 'package:test_app/auth/data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitial());

  /// LOGIN
  String? currentEmail;
  UserModel? currentUser;


  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final user = await repo.login(email, password);
    print(user?.email);

    if (user != null) {

      // emit(LoginSuccess());
      currentUser = user; //
      currentEmail= user.email;

      emit(UserLoaded(user)); //

    } else {
      emit(LoginError("Invalid email or password"));
    }
  }

  /// REGISTER

  Future<void> register(UserModel user) async {
    emit(RegisterLoading());

    try {
      await repo.register(user);

      emit(RegisterSuccess());

    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Map<String, dynamic>? user;

  Future<void> loadUser() async {
    emit(AuthInitial());
    print(currentEmail);

    try {
      final user = await repo.getUser(currentEmail!);

      if (user != null) {
        emit(UserLoaded(user)); //
      } else {
        emit(LoginError("No user found"));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  String get userName {
    return user?['name'] ?? 'Guest';
  }


  Future<void> logout() async {
    if (isClosed) return;

    currentUser = null;
    currentEmail = null;

    if (!isClosed) {
      emit(AuthInitial());
    }
  }

}