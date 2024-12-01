import 'package:dlaf_edu_app/core/services/auth_firebase.dart';
import 'package:dlaf_edu_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void register(BuildContext context) async {
    final auth = AuthFirebase();

    try {
      await auth.signUpWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada exitosamente')),
      );

      Navigator.pushNamed(context, AppRoutes.home);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 38, right: 25, left: 25),
        child: Column(
          children: [
            const _Header(),
            const SizedBox(height: 25),
            const _Title(),
            const SizedBox(height: 35),
            const _Illustration(),
            const SizedBox(height: 35),
            _InputField(
              controller: _emailController,
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
            const SizedBox(height: 25),
            _ActionButton(
              text: 'Crear Cuenta',
              onPressed: () => register(context),
            ),
            const SizedBox(height: 100),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/Edu_Logo.webp',
          height: 60,
        ),
        Container(
          width: 150,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFAE6CEF),
          ),
          child: const Text(
            'DLAF EDU',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Crea tu cuenta',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: const Color(0XFFAE6CEF),
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Image.asset('assets/images/Register3D.webp'),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _InputField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
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
    return TextField(
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
    return Text(
      message,
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ActionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleButton(
          icon: Icons.keyboard_arrow_left,
          color: Colors.black,
          onTap: () => Navigator.pushReplacementNamed(
            context,
            AppRoutes.login,
          ),
        ),
        _CircleButton(
          svgAsset: 'assets/svg/ic--round-question-mark.svg',
          color: const Color(0xFFA50976),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(
                  child: Text('Función aún no disponible'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData? icon;
  final String? svgAsset;
  final Color color;
  final VoidCallback onTap;

  const _CircleButton({
    this.icon,
    this.svgAsset,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: icon != null
            ? Icon(icon, color: Colors.white, size: 35)
            : SvgPicture.asset(svgAsset!, color: Colors.white),
      ),
    );
  }
}
