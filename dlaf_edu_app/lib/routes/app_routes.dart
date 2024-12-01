import 'package:dlaf_edu_app/pages/create_account.dart';
import 'package:dlaf_edu_app/pages/feedback.dart';
import 'package:dlaf_edu_app/pages/home.dart';
import 'package:dlaf_edu_app/pages/learning_pdf.dart';
import 'package:dlaf_edu_app/pages/login.dart';
import 'package:dlaf_edu_app/pages/real_time_translation.dart';
import 'package:dlaf_edu_app/pages/txt_2_img.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String createAccount = '/createAccount';
  static const String home = '/home';
  static const String feedback = '/feedback';
  static const String textToImage = '/textToImage';
  static const String realTimeTranslation = '/realTimeTranslation';
  static const String learningPdf = '/learningPdf';

  static final Map<String, WidgetBuilder>  routes = {
    login: (context) => LoginPage(),
    createAccount: (context) => CreateAccount(),
    home: (context) => HomePage(),
    feedback: (context) => FeedbackPage(),
    textToImage: (context) => TextToImagePage(),
    realTimeTranslation: (context) => RealTimeTranslationPage(),
    learningPdf: (context) => LearningPdfPage(),
  };
}