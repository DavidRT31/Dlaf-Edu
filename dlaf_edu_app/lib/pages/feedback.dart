import 'package:dlaf_edu_app/core/services/feedback_service.dart';
import 'package:dlaf_edu_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _commentController = TextEditingController();

  int _rating = 3;
  final FeedbackService _feedbackService = FeedbackService();

  void _submitFeedback() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty || _rating < 1 || _rating > 5) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Por favor, ingrese correctamente su comentario y la calificación.')));
      return;
    }
    try {
      await _feedbackService.saveFeedback(
        comment,
        _rating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback enviado correctamente')),
      );
      _commentController.clear();
      setState(() {
        _rating = 3;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar el feedback.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EEF8),
      body: SafeArea(
        child: Column(
          children: [
            // Header de la página
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
                children: [
                  _buildTitleSection(),
                  const SizedBox(height: 15),
                  _buildCommentSection(),
                  const SizedBox(height: 20),
                  _buildRatingSection(),
                  const SizedBox(height: 20),
                  _buildSubmitButton(),
                ],
              ),
            ),
            _buildFooterNavigation(context),
          ],
        ),
      ),
    );
  }

  // Widget para el encabezado
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

  // Widget para la sección de título y descripción
  Widget _buildTitleSection() {
    return Column(
      children: const [
        Text(
          'FeedBack',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Envíanos tus comentarios sobre DLAF EDU,\npara poder seguir mejorando 😁',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget para la sección de comentarios
  Widget _buildCommentSection() {
    return TextField(
      controller: _commentController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Escribe tu comentario aquí...',
      ),
      maxLines: 5,
    );
  }

  // Widget para la sección de calificación
  Widget _buildRatingSection() {
    return Column(
      children: [
        const Text(
          'Calificación',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        const Text(
          '¿Cómo calificarías tu experiencia\nusando DLAF EDU?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              child: SvgPicture.asset(
                _rating > index
                    ? 'assets/svg/ic--round-star.svg'
                    : 'assets/svg/ic--round-star-border.svg',
                height: 40,
                color: const Color(0xFFDFA0FC),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('←— Mala', style: TextStyle(fontWeight: FontWeight.w600)),
            Text('Excelente —→', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  // Widget para el botón de enviar comentario
  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: 220,
        child: ElevatedButton(
          onPressed: _submitFeedback,
          child: const Text(
            'Enviar Comentario',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  // Widget para la navegación inferior
  Widget _buildFooterNavigation(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavigationIcon(
            context,
            'assets/svg/ic--round-home.svg',
            const Color(0xFFDF642B),
            () => Navigator.pushNamed(context, AppRoutes.home),
          ),
          _buildNavigationIcon(
            context,
            'assets/svg/ic--round-question-mark.svg',
            const Color(0xFFA50976),
            () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Función aún no disponible'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper para los íconos de navegación
  Widget _buildNavigationIcon(
      BuildContext context, String assetPath, Color color, VoidCallback onTap) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          assetPath,
          color: Colors.white,
          width: 35,
        ),
      ),
    );
  }
}
