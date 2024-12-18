import 'package:flutter/material.dart';

import '../../configs/assets/assets_path.dart';
import '../../configs/constants.dart';
import '../../configs/routes/local_routes.dart';
import '../../services/navigator_service.dart';
import '../../services/service_locator.dart';
import '../../widgets/animations/fade_widget.dart';
import '../../widgets/animations/slide_widget.dart';
import '../../widgets/cs_circular_progress_indicador.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  initState() {
    super.initState();

    _navigateLogin();
  }

  Future<void> _navigateLogin() async {
    Future.delayed(const Duration(seconds: 2), () {
      getIt<NavigationService>().pushNamedAndRemoveUntil(LocalRoutes.LOGIN);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeWidget(
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Image.asset(
                AssetsPath.LOGO,
                fit: BoxFit.scaleDown,
                height: 350,
                width: 350,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SlideWidget(
              child: Center(
            child: Column(
              children: [
                Text(
                  App.NAME,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 25),
                CsCircularProgressIndicador.dark(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
