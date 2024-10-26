// ignore_for_file: constant_identifier_names

///Armazena dados constantes
class App {
  static const NAME = 'Auto Connect';

  static const VERSION = '1.0.1';

  static const ANDROID_ID = 'br.com.flutter.monitoramento_energia_mobile';

  static const DATA_ATUALIZACAO = '21/08/2023';

  static const DESENVOLVEDOR = 'Víctor Vinícius Welter';
}

enum ErrorType {
  generic,
  internet,
  login,
  login_offline,
  cadastro,
  http_request,
  session,
  sync,
  expired_token,
}

enum DialogAction { ok, sim_nao, none }

class SharedKeys {
  static const SECURE_TOKEN = 'secure_token';

  static const DADOS_USER = 'dados_user';
}

class CadOptions {
  static const SIM = 1;

  static const NAO = 0;

  static const MANUTENCAO_PREVENTIVA = 0;

  static const MANUTENCAO_CORRETIVA = 1;
}

class NormalizeDate {
  ///dd/MM/yyyy
  static const BR_FORMAT = 1;

  static const JUST_HOUR = 2;

  //yyyy-mm-dd
  static const US_FORMAT = 3;
}

class SearchOffset {
  static const MONITORAMENTOS = 20;
}

class ValidationPattern {
  static const PATTERN =
      "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.,]).{8,}\$";

  static const LENGTH_SENHA = ".{8,}";

  static const MAIUSCULA = "(?=.*[A-Z])";

  static const MINUSCULA = "(?=.*[a-z])";

  static const NUMEROS = "(?=.*?[0-9])";

  static const CARACTERE_ESPECIAL = "(?=.*?[!@#\$&*~.,])";
}
