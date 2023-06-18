import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static Map<String, String> users = {
    'Dario': 'hiachi20',
    'jajaja': 'jajaja',
    'hhwy123': 'hhwy123',
    'gabrield': 'gabrield',
    'jorgec': 'jorgec',
    'yefersonh': 'yefersonh',
    'darios': 'darios',
  };
  String user = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    print('$user - $password');
    for (var usuario in users.keys) {
      var contrasena = users[user];
      // Realiza alguna acción con el usuario y la contraseña
      print('>$usuario - $contrasena');
      if (usuario == user && contrasena == password) {
        return formKey.currentState?.validate() ?? false;
      }
    }
    return false;
  }
}
