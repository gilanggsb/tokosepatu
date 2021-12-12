import 'package:flutter/cupertino.dart';
import 'package:tokosepatu/models/user_model.dart';
import 'package:tokosepatu/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      UserModel user = await AuthService().register(
          name: name, username: username, email: email, password: password);
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    required String password,
    required String email,
  }) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
