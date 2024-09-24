import 'package:auto_connect_mobile/utils/functions_utils.dart';

class LoginValidator {
  static String? validateEmail(String? email) {
    if(isNullOrEmpty(email)) {
      return 'Informe o seu e-mail';
    }

    return null;
  }

  static String? validateSenha(String? senha) {
    if(isNullOrEmpty(senha)) {
      return 'Informe uma senha';
    }

    if (senha!.length < 6) {
      return 'Senha deve ter no mínimo 6 dígitos';
    }

    return null;
  }
}
