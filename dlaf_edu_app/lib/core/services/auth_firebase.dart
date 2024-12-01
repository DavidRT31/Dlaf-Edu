import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {
  // Iniciar el servicio de autenticación de Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Función para iniciar sesión
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException  catch (e) {
      throw Exception(e.code);
    }
  }

  // Función para crear una cuenta
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Función para cerrar sesión
  Future<void> signOut() async {
    return await auth .signOut();
  }
}