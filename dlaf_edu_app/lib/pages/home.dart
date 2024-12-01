import 'package:dlaf_edu_app/core/services/auth_firebase.dart';
import 'package:dlaf_edu_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dlaf_edu_app/models/options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<OptionModel> options;

  @override
  void initState() {
    super.initState();
    _initializeOptions();
  }

  void _initializeOptions() {
    options = [
      OptionModel(
        name: 'Traducción en Tiempo Real',
        imagePath: 'assets/images/StreamCamera3D.webp',
        boxColor: const Color(0xFFF92A80),
        action: () => Navigator.pushNamed(context, AppRoutes.realTimeTranslation),
      ),
      OptionModel(
        name: 'Traducción de Texto',
        imagePath: 'assets/images/SearchBook3D.webp',
        boxColor: const Color(0xFF6CDA39),
        action: () => Navigator.pushNamed(context, AppRoutes.textToImage),
      ),
      OptionModel(
        name: 'Traducción por Voz',
        imagePath: 'assets/images/VoiceToImage3D.webp',
        boxColor: const Color(0xFFF8945B),
        action: () => _showFeatureUnavailable(),
      ),
      OptionModel(
        name: '¿Quieres aprender?',
        imagePath: 'assets/images/EducationBook3D.webp',
        boxColor: const Color(0xFF4BAEFF),
        action: () => Navigator.pushNamed(context, AppRoutes.learningPdf),
      ),
    ];
  }

  void _showFeatureUnavailable() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función aún no disponible')),
    );
  }

  void logout(){
    // Obtención del servicio
    final auth = AuthFirebase();

    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    '¿Qué deseas hacer?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Color.fromARGB(255, 183, 58, 221),
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(103, 149, 47, 196),
                          blurRadius: 10,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  CardOptions(options: options),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
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
              color: const Color(0xFFAE6CEF),
            ),
            child: const Text(
              'DLAF EDU',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterButton(
            iconPath: 'assets/svg/ic--round-log-out.svg',
            color: Colors.black,
            onTap: () => logout(),
          ),
          _buildFooterButton(
            iconPath: 'assets/svg/ic--round-star-border.svg',
            color: const Color(0xFFDFB52B),
            onTap: () => Navigator.pushNamed(context, AppRoutes.feedback),
          ),
          _buildFooterButton(
            iconPath: 'assets/svg/ic--round-question-mark.svg',
            color: const Color(0xFFA50976),
            onTap: _showFeatureUnavailable,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton({
    required String iconPath,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          iconPath,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CardOptions extends StatelessWidget {
  const CardOptions({
    super.key,
    required this.options,
  });

  final List<OptionModel> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemCount: options.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, __) => const SizedBox(width: 25),
        itemBuilder: (context, index) {
          final option = options[index];
          return GestureDetector(
            onTap: option.action,
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: option.boxColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(option.imagePath),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    option.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
