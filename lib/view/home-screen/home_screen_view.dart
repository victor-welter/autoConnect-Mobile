import 'package:auto_connect_mobile/configs/routes/local_routes.dart';
import 'package:auto_connect_mobile/services/navigator_service.dart';
import 'package:auto_connect_mobile/widgets/cs_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../configs/constants.dart';
import '../../services/dialog_service.dart';
import '../../services/service_locator.dart';
import '../../utils/functions_utils.dart';
import '../../widgets/cs_app_bar.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_icon_button.dart';
import '../../widgets/menu/cs_menu.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
    @override
  initState() {
    super.initState();

    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CsAppBar(
        title: App.NAME,
        leading: CsIconButton.dark(
          icon: const CsIcon(
            icon: Icons.menu_rounded,
            color: Colors.white,
          ),
          tooltip: 'Menu',
          onPressed: () => openModal(content: const CsMenu()),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CsElevatedButton(
              label: 'Consultar Combustível',
              onPressed: () => getIt<NavigationService>()
                  .pushNamed(LocalRoutes.CONECTA_BLUETOOTH),
            ),
          ),
        ],
      ),
    );
  }
}
