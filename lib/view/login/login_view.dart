// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../configs/assets/assets_path.dart';
import '../../models/sessao/login_model.dart';
import '../../widgets/animations/fade_widget.dart';
import '../../widgets/cards/card_error_login.dart';
import '../../widgets/cs_circular_progress_indicador.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_icon_button.dart';
import '../../widgets/cs_text_form_field.dart';
import 'login_state.dart';
import 'login_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final login = LoginModel();
  final stateView = LoginState();

  ///[Controllers]
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  ///Form Validation
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  IconData _iconObscureText() {
    if (stateView.obscurePassword) {
      return Icons.visibility_outlined;
    }

    return Icons.visibility_off_outlined;
  }

  String _tooltipPassword() {
    if (stateView.obscurePassword) {
      return 'Mostrar senha';
    }

    return 'Esconder senha';
  }

  void _login() async {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ListView(
        children: [
          FadeWidget(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Image.asset(
                AssetsPath.LOGO,
                fit: BoxFit.scaleDown,
                height: 400,
                width: 400,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Campo de E-mail
                      CsTextFormField(
                        hintText: 'Informe seu e-mail',
                        label: 'E-mail',
                        controller: emailController,
                        validator: LoginValidator.validateEmail,
                        onChanged: (email) {
                          login.email = email;
                        },
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        prefixIcon: CsIconButton.light(
                          icon: const CsIcon(
                            icon: Icons.person_outline_rounded,
                          ),
                        ),
                      ),

                      // Campo de senha
                      Observer(
                        builder: (_) {
                          return CsTextFormField(
                            hintText: 'Informe sua senha',
                            label: 'Senha',
                            controller: senhaController,
                            validator: LoginValidator.validateSenha,
                            onChanged: (senha) {
                              login.senha = senha;
                            },
                            obscureText: stateView.obscurePassword,
                            autocorrect: false,
                            enableSuggestions: false,
                            prefixIcon: CsIconButton.light(
                              icon: const CsIcon(
                                icon: Icons.lock_outline_rounded,
                              ),
                            ),
                            suffixIcon: CsIconButton.light(
                              tooltip: _tooltipPassword(),
                              onPressed: stateView.changeObscurePassword,
                              icon: CsIcon(icon: _iconObscureText()),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

                      Observer(
                        builder: (_) {
                          return Visibility(
                            visible: stateView.errorMessage.isNotEmpty,
                            child:
                                CardErrorLogin(message: stateView.errorMessage),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

                      Observer(
                        builder: (_) {
                          return AnimatedSwitcher(
                            duration: const Duration(seconds: 1),
                            child: stateView.loggingIn
                                ? const CsCircularProgressIndicador.light()
                                : CsElevatedButton(
                                    label: 'Entrar',
                                    onPressed: () => _login(),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}