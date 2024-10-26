import 'package:flutter/material.dart';

import 'cadastro_usuario_state.dart';

class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({super.key});

  @override
  State<CadastroUsuarioView> createState() => _CadastroUsuarioViewState();
}

class _CadastroUsuarioViewState extends State<CadastroUsuarioView> {
  final stateView = CadastroUsuarioState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold();
  }
}
