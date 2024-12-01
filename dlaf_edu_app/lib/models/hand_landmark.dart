/*import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HandLandmark extends StatefulWidget {
  const HandLandmark({super.key});

  @override
  _HandLandmarkState createState() => _HandLandmarkState();
}

class _HandLandmarkState extends State<HandLandmark> {
  String answer = 'Loading...';
  CameraController? _cameraController;
  Interpreter? _interpreter;

  @override
  void initState() {
    super.initState();
    _initializeInterpreter();
    _initializeCamera();
  }

  // Inicializar el intérprete del modelo
  Future<void> _initializeInterpreter() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('models/hand_landmarker.tflite');
    } catch (e) {
      debugPrint('Error al cargar el modelo: $e');
    }
  }

  // Inicializar la cámara
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();
      _cameraController!.startImageStream((image) {
        if (mounted) {
          _processCameraImage(image);
        }
      });
    } catch (e) {
      debugPrint('Error al inicializar la cámara: $e');
    }
  }

  // Procesar las imágenes de la cámara
  Future<void> _processCameraImage(CameraImage image) async {
    if (_interpreter == null) return;

    try {
      // Convertir CameraImage a Float32List
      final input = _convertCameraImageToInput(image);

      // Crear un buffer para la salida del modelo
      final output = List.filled(63, 0.0).reshape([1, 63]);

      // Ejecutar el modelo
      _interpreter!.run(input, output);

      // Convertir la salida a List<List<double>>
      final processedOutput = (output)
          .map((e) => (e as List<dynamic>).map((v) => v as double).toList())
          .toList();

      // Actualizar los resultados
      _updateResults(processedOutput);
    } catch (e) {
      debugPrint('Error al procesar la imagen: $e');
    }
  }

  // Convertir CameraImage a Float32List
  Float32List _convertCameraImageToInput(CameraImage image) {
    final bytes = image.planes[0].bytes; // Solo el plano Y para blanco y negro
    return Float32List.fromList(
      bytes.map((byte) => byte.toDouble() / 255.0).toList(), // Normalización
    );
  }

  // Actualizar resultados en la pantalla
  void _updateResults(List<List<double>> output) {
    setState(() {
      answer = output.first.map((e) => e.toStringAsFixed(2)).join(', ');
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _cameraController != null &&
                _cameraController!.value.isInitialized
            ? Stack(
                children: [
                  CameraPreview(_cameraController!),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black87,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        answer,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class HandLandmarkModel {
  late Interpreter _interpreter;

  // Constructor privado
  HandLandmarkModel._privateConstructor();

  static final HandLandmarkModel _instance = HandLandmarkModel._privateConstructor();

  // Instancia estática para acceso global
  static HandLandmarkModel get instance => _instance;

  // Cargar el modelo
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/hand_landmarker.tflite');
      print('Modelo cargado correctamente.');
    } catch (e) {
      print('Error al cargar el modelo: $e');
    }
  }

  // Ejecutar el modelo con la imagen procesada
  List<dynamic> runModel(Uint8List input) {
    // Crear un buffer para la salida de landmarks (63 es el número de valores esperados)
    final output = List.filled(63, 0).reshape([1, 21, 3]);

    try {
      // Ejecutar el modelo con el tensor de entrada y obtener la salida
      _interpreter.run(input, output);
    } catch (e) {
      print("Error al ejecutar el modelo: $e");
    }

    // Retornar los resultados del modelo (landmarks)
    return output;
  }
}
*/
