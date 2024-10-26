import 'package:auto_connect_mobile/view/seleciona-registro/selecionar_registro_state.dart';
import 'package:flutter/material.dart';

import '../../configs/constants.dart';
import '../../widgets/cs_app_bar.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_icon_button.dart';

class SelecionaRegistroView extends StatefulWidget {
  const SelecionaRegistroView({super.key});

  @override
  State<SelecionaRegistroView> createState() => _SelecionaRegistroViewState();
}

class _SelecionaRegistroViewState extends State<SelecionaRegistroView> {
  final stateView = SelecionarRegistroState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CsAppBar(
        title: "Tela seleciona registro",
      ),
    );
  }
}
