import 'dart:async';
import 'package:google_mao/features/auth/presentacion/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mao/features/shared/shared.dart';
import 'package:provider/provider.dart';

import 'home_screems.dart';

class LoginScreen extends StatelessWidget {
  static const name = "login-screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SizedBox.expand(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Icon Banner
            const Icon(
              Icons.local_taxi_outlined,
              color: Colors.black,
              size: 200,
            ),
            // const SizedBox(height: 10),
            Container(
              height: size.height - 260, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _LoginForm(),
            ),
          ],
        ),
      ))),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final login_provider = context.read<LoginFormProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: login_provider.formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Iniciar Sesión', style: textStyles.titleLarge),
            const SizedBox(height: 50),
            CustomTextFormField(
              label: 'Usuario',
              keyboardType: TextInputType.text,
              onChanged: (valor) {
                login_provider.user = valor;
              },
              validator: (value) {
                if (login_provider.user.isEmpty) {
                  return "Ingrese nombre de usaurio";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Contraseña',
              obscureText: true,
              onChanged: (valor) => login_provider.password = valor,
              validator: (value) {
                if (login_provider.password.isEmpty) {
                  return "Ingrese la contraseña";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Ingresar',
                  buttonColor: Colors.black,
                  onPressed: () {
                    if (login_provider.isValidForm()) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            Timer(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                              );
                            });
                            return AlertDialog(
                              title: const Text('Usuario Validado'),
                              icon: const Icon(
                                Icons.check_circle_outline_sharp,
                                color: Colors.green,
                                size: 70,
                              ),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            Timer(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                            });
                            return AlertDialog(
                              title: const Text('El usuario no existe'),
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                                size: 70,
                              ),
                            );
                          });
                    }
                  },
                )),
            const Spacer(flex: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No tienes cuenta?'),
                TextButton(
                    onPressed: () => context.push('/register'),
                    child: const Text('Crea una aquí'))
              ],
            ),
            const Spacer(flex: 10),
          ],
        ),
      ),
    );
  }
}
