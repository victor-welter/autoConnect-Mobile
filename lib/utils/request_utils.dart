import '../configs/constants.dart';
import '../models/erros/error_model.dart';
import '../models/sessao/sessao_model.dart';
import '../services/secure_storage_service.dart';
import '../services/service_locator.dart';

///Obtém o token JWT que está salvo no SecureStorage e o retorna
Future<String> retornaJWT() async {
  final sessao = getIt<SessaoModel>();

  return await SecureStorageService.read(SharedKeys.SECURE_TOKEN,
          suffix: sessao.email) ??
      '';
}

///Invalida o token JWT do usuário
Future<void> resetJWT() async {
  final sessao = getIt<SessaoModel>();

  await SecureStorageService.save(SharedKeys.SECURE_TOKEN, '',
      suffix: sessao.email);
}

void validaResponse(Map<String, dynamic> response, [ErrorModel? custom]) {
  if (!response['success']) {
    if (response['error'] == 'Usuário não encontrado.') {
      // TODO
      // getIt<NavigationService>().navigatorKey.currentContext!.go(LocalRoutes.LOGIN);
      return;
    }

    if (response['error'] == 'Acesso negado') {
      // TODO
      // getIt<NavigationService>().navigatorKey.currentContext!.go(LocalRoutes.HOME);
      return;
    }

    if (custom == null) {
      throw ErrorModel(response['error']);
    } else {
      throw custom;
    }
  }
}
