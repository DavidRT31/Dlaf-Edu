import 'package:dlaf_edu_app/core/services/auth_gate.dart';
import 'package:dlaf_edu_app/firebase_options.dart';
import 'package:dlaf_edu_app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DLAF Edu',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF3EEF8),
        fontFamily: 'Montserrat',

        //? Estilo para el TextField
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),

        //? Estilo para el Botón
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA760EE),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      home: AuthGate(),
      routes: AppRoutes.routes,
    );
  }
}
