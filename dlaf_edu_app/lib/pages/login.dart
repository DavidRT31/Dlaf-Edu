import 'package:dlaf_edu_app/core/services/auth_firebase.dart';
import 'package:dlaf_edu_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _mensajeError;
  bool _isPasswordVisible = false;

  Future<void> _login(BuildContext context) async {
    final authService = AuthFirebase();

    try {
      await authService.signInWithEmailPassword(
        _usuarioController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.pushNamed(context, AppRoutes.home);
    } catch (e) {
      setState(() {
        _mensajeError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Logo(),
              const SizedBox(height: 20),
              const _WelcomeText(),
              const SizedBox(height: 15),
              _InputField(
                controller: _usuarioController,
                label: 'Correo electrónico',
              ),
              const SizedBox(height: 15),
              _PasswordField(
                controller: _passwordController,
                isPasswordVisible: _isPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              if (_mensajeError != null) _ErrorMessage(message: _mensajeError!),
              const SizedBox(height: 15),
              _LoginButton(onPressed: () => _login(context)),
              const SizedBox(height: 15),
              _SignUpLink(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: const BoxDecoration(
        color: Color(0xFFFCDF78),
        shape: BoxShape.circle,
      ),
      child: Image.asset('assets/images/PersonLanguage3D.webp'),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenid@ a\nDLAF EDU!',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 32,
        color: Color(0xFF9B0DEE),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _InputField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback onVisibilityToggle;

  const _PasswordField({
    required this.controller,
    required this.isPasswordVisible,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: IconButton(
          icon: SvgPicture.asset(
            isPasswordVisible
                ? 'assets/svg/ic--round-visibility-off.svg'
                : 'assets/svg/ic--round-visibility.svg',
            color: const Color(0XFFAE6CEF),
          ),
          onPressed: onVisibilityToggle,
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'Iniciar Sesión',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SignUpLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.createAccount);
      },
      child: const Text(
        '¿No tienes cuenta? Regístrate ahora',
        style: TextStyle(
          color: Color(0XFFAE6CEF),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
