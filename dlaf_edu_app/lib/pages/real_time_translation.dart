import 'package:flutter/material.dart';

class RealTimeTranslationPage extends StatefulWidget {
  const RealTimeTranslationPage({super.key});

  @override
  _RealTimeTranslationState createState() => _RealTimeTranslationState();
}

class _RealTimeTranslationState extends State<RealTimeTranslationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aquí debería ir'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Se intentó profe, disculpe',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset(
                'assets/videos/tenor.gif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
