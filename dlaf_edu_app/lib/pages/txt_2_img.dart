import 'package:dlaf_edu_app/models/words.dart';
import 'package:dlaf_edu_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextToImagePage extends StatefulWidget {
  const TextToImagePage({super.key});

  @override
  State<TextToImagePage> createState() => _TextToImagePageState();
}

class _TextToImagePageState extends State<TextToImagePage> {
  final TextEditingController _wordController = TextEditingController();
  final GifManager gifManager = GifManager();
  String? _gifPath; // Variable para guardar la ruta del GIF encontrado

  @override
  void initState() {
    super.initState();
    _uploadGifs(); // Inicializa los GIFs al iniciar
  }

  void _uploadGifs() {
    gifManager.addGif('AMOR', 'assets/videos/amor.gif');
    gifManager.addGif('AYUDA POR FAVOR', 'assets/videos/ayuda_por_favor.gif');
    gifManager.addGif('DORMIR', 'assets/videos/dormir.gif');
    gifManager.addGif('FAMILIA', 'assets/videos/familia.gif');
    gifManager.addGif('GRACIAS', 'assets/videos/gracias.gif');
    gifManager.addGif('HOLA', 'assets/videos/hola.gif');
    gifManager.addGif('LO SIENTO', 'assets/videos/lo_siento.gif');
    gifManager.addGif('NOT FOUND', 'assets/videos/not_found.gif');
  }

  void _searchGif() {
    setState(() {
      _gifPath =
          gifManager.findGifPath(_wordController.text.trim().toUpperCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildHeader(),
          const SizedBox(height: 15),
          _buildBody(),
          const SizedBox(height: 15),
          _buildFooter(context),
        ],
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
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Traducción de Texto',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          const Text(
            'Escribe el texto que desea traducir a\nlenguaje de señas 👋',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          _buildGifDisplay(),
          const SizedBox(height: 20),
          _buildSearchField(),
          const SizedBox(height: 15),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: _searchGif,
              child: const Text(
                'Traducir',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGifDisplay() {
    return Container(
      width: 350,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _gifPath != null
            ? Image.asset(
                _gifPath!,
                fit: BoxFit.cover,
              )
            : const Center(child: Text("No se ha realizado la búsqueda")),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _wordController,
      decoration: InputDecoration(
        labelText: 'Escriba la palabra a buscar',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            'assets/svg/ic--charge-animation.svg',
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
            color: const Color(0xFFBC11F0),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterButton(
            color: const Color(0xFFDF642B),
            iconPath: 'assets/svg/ic--round-home.svg',
            onTap: () => Navigator.pushNamed(context, AppRoutes.home),
          ),
          _buildFooterButton(
            color: const Color(0xFFA50976),
            iconPath: 'assets/svg/ic--round-question-mark.svg',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Función aún no disponible'),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton({
    required Color color,
    required String iconPath,
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
          width: 35,
        ),
      ),
    );
  }
}
