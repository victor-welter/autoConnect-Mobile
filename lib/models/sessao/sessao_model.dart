// ignore_for_file: unused_element, prefer_final_fields, library_private_types_in_public_api

import 'package:auto_connect_mobile/models/sessao/configuracoes_model.dart';
import 'package:mobx/mobx.dart';

part 'sessao_model.g.dart';

class SessaoModel = _SessaoModel with _$SessaoModel;

abstract class _SessaoModel with Store {
  _SessaoModel();
  
  _SessaoModel.fromMap(Map<String, dynamic> data) {
    idUsuario = data['id_usuario'];
    email = data['email'];
    nome = data['nome'];
  }

  // Dados do usuário
  late int idUsuario = 0;
  late String email = '';
  String? nome;
  ConfiguracoesModel configuracoes = ConfiguracoesModel(); //Configurações do usuário
}
