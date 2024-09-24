import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'configs/assets/assets_path.dart';
import 'configs/routes/local_routes.dart';
import 'models/sessao/sessao_model.dart';
import 'services/service_locator.dart';
import 'view/login/login_view.dart';
import 'view/splash-screen/splash_screen_view.dart';
import 'widgets/cs_app_bar.dart';
import 'widgets/nenhuma_informacao.dart';

class RouterApp {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LocalRoutes.SPLASH_SCREEN:
        return _PageBuilder(
          child: const SplashScreenView(),
          settings: settings,
        );

      case LocalRoutes.LOGIN:
        return _PageBuilder(
          child: const LoginView(),
          settings: settings,
        );

      default:
        return _PageBuilder(
          child: const _RotaInexistenteView(),
          settings: settings,
        );
    }
  }
}

class _PageBuilder extends PageRouteBuilder {
  ///Responsável pelo efeito de 'fade transition' entre as transições de telas
  _PageBuilder({
    required this.child,
    required this.settings,
  }) : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (context, animation, secAnimation, child) {
            final data = MediaQuery.of(context);

            final sessao = getIt<SessaoModel>().configuracoes;

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Observer(
                builder: (_) {
                  return MediaQuery(
                    data: data.copyWith(
                      textScaleFactor: sessao.textFactor,
                      alwaysUse24HourFormat: true,
                    ),
                    child: child,
                  );
                },
              ),
            );
          },
          pageBuilder: (context, animation, secAnimation) => child,
        );

  final Widget child;

  @override
  final RouteSettings settings;
}

class _RotaInexistenteView extends StatelessWidget {
  const _RotaInexistenteView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CsAppBar(title: 'Ops! Ocorreu um erro'),
      body: Center(
        child: SingleChildScrollView(
          child: NenhumaInformacao(
            imagePath: AssetsPath.ERROR_404,
            message:
                'Desculpe, a página que você está procurando não foi encontrada. Relate o seu problema abrindo um chamado no botão abaixo!',
          ),
        ),
      ),
    );
  }
}