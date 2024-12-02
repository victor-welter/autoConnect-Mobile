import 'dart:convert';

import '../../configs/routes/web_routes.dart';
import '../../models/sessao/login_model.dart';
import '../../models/sessao/novo_usuario_model.dart';
import '../../services/http_service.dart';

class UsuarioRepository {
  static Future<Map<String, dynamic>> login(LoginModel login) async {
    Map params = {
      'email': login.email,
      'senha': login.senha,
    };

    final response = await HttpService.post(
      rota: WebRoutes.LOGIN,
      params: params,
    );

    return response;
  }

  static Future<Map<String, dynamic>> registrar(NovoUsuarioModel novoUsuario) async {
    Map jsonData = {
      'nome': novoUsuario.nome,
      'email': novoUsuario.email,
      'senha': novoUsuario.senha,
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_USUARIO,
      body: jsonEncode(jsonData),
    );
  }
}
