# Proyecto DLAF EDU (En curso)

*El proyecto está siendo en desarrollo para el aprendizaje y traducción del lenguaje de señas*

Para poder acceder al proyecto y proporcionar un desarrollo de manera personal, acceda a la carpeta 'dlaf_edu_app'; en su respectivo README.md, se encuentran las indicaciones pertinentes.

### Dependencias del proyecto 'pubspec.yaml':
  
~~~
  flutter_svg: ^2.0.15  ->  Para el uso de archivos .svg
  firebase_core: ^3.7.0  ->  Base para el uso de Firebase en la aplicación
  firebase_auth: ^5.3.3  ->  Servicio de Autenticación de Firebase
  cloud_firestore: ^5.5.0  ->  Servicio de almacenamiento (nube) de Firebase
  syncfusion_flutter_pdfviewer: ^27.2.4  ->  Para la visualización de un PDF
~~~

### Uso de Firebase en la App

~~~
  firebase login  ->  Inicio de sesión en una cuenta registrada en Firebase
  dart pub global activate flutterfire_cli  ->  Creación de los elementos relacionados con la configuración de Firebase
  flutterfire configure  ->  Configuración del proyecto (plataformas, id, etc) referente a Firebase, para luego dar generación a un .json
~~~

Ejemplo de código de Firebase.json

~~~
    "android": {
                    "default": {
                        "projectId": "dlaf-edu",
                        "appId":    "1:148866572482:android:53887b73fcd4efeafbdb5b",
                        "fileOutput": "android/app/google-services.json"
                    }
                },
~~~

Creación (manual) de los servicios de autenticación:

~~~
  // Función para iniciar sesión
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException  catch (e) {
        throw Exception(e.code);
      }
    }
~~~

~~~
  // Función para crear una cuenta
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
~~~

### Ruteo de Página de la aplicación:
Se hace creación de una carpeta **/routes** dentro de **/lib** para añadir un archivo: **/app_routes.dart**

~~~
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
~~~

Esto, permite obtener las rutas correspondientes a cada pantalla dentro de la aplicación.

### Página de Create_Account.dart
Aquí el usuario crea su cuenta. en base a un correo y contraseña usando un método que se encuentra relacionado al servicio de autenticación de Firebase.

~~~
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
~~~

Luego de darle al botón de **'Crear Cuenta'**, se loguea correctamente y pasa a la pantalla principal de la aplicación: **home.dart**

### Página de Inicio de Sesión:
Aquí el usuario con una cuenta previamente creada, procede a Iniciar Sesión

Es sencillo de entender la verdad.

### Página Principal 'home.dart':
Es donde tenemos las diversas opciones como:
- Traductor en Tiempo Real
- Traducción por Texto a Imagen (en este caso un .gif)
- Apartado de Aprendizaje (Se muestra un PDF proporcionado por el **MINEDU** sobre el LSP)
- Feedback (Donde el usuario nos proporcionará sus comentarios con respecto a la aplicación)

### Página para Feedback:
Acá hacemos uso de un servicio creado por nosotros, en donde hacemos uso de una colección de Firebase (Se puede entender como una tabla de SQL Server o MySQL, con sus respectivos campos o atributos)

**Parte del código del servicio del feedback:**
~~~
Future<void> saveFeedback(String comment,int rating) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "test";

    try {
      await _firestore.collection('feedback').add({
        'userId': userId,
        'comment': comment,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // print('Feedback enviado correctamente');
    } catch (e) {
      // print('Error al enviar el feedback: $e');
      rethrow;
    }
  }
~~~

Primero recuperamos el id (identificador) del usuario actualmente logeado en la aplicación (en pocas palabras, que haya iniciado sesión en este momento), para luego también obtener los valores de la caja de comentarios y el rating (calificación) que le da a nuestra app.

### Página para la visualización del PDF
En esta página se hizo el uso de la dependencia de **syncfusion_flutter_pdfviewer** para poder visualizar el pdf (que se encuentra subido en línea, en este caso **Google Drive**)

No hay mucho que explicar la verdad, es como un visualizador de PDF común.

### Página para la 'Traducción' de texto a Imagen (.gif)
Aquí, se hace la creación de un modelo llamado 'words.dart', donde será la base para el 'almacenamiento de palabras' previamente registradas.

~~~
class WordModel {
  String word;
  String gifPath;

  WordModel({
    required this.word,
    required this.gifPath,
  });
}

class GifManager {
  final List<WordModel> _gifDatabase = [];

  void addGif(String word, String gifPath) {
    if (word.isEmpty || gifPath.isEmpty) {
      throw Exception('El nombre y la ruta del GIF no pueden estar vacíos');
    }

    _gifDatabase.add(WordModel(word: word, gifPath: gifPath));
    // print('GIF agregado: $word -> $gifPath');
  }

  String? findGifPath(String word) {
    for (var gif in _gifDatabase) {
      if (gif.word == word) {
        // print('GIF encontrado: ${gif.word} -> ${gif.gifPath}');
        return gif.gifPath;
      }
    }
    return null;
  }
}

~~~

Se hace uso de un método creado para la recuperación de, en este caso, el gif relacionado a la palabra. Un ejemplo: Palabra -> 'Hola'; Ruta del Gif -> './assets/gifs/HOLA.gif'

Luego aplicamos un método para cargar todas las palabras y la ruta de sus .gifs correspondientes dentro de la aplicación, para que luego, usando un TextField (Cuadro de texto), podamos **buscar** dicha palabra guardada.

### Página de Traducción en Tiempo Real:
Aquí la verdad, se quería hacer uso de TensorFlow Lite (Pequeña red neuronal) para el reconocimiento del lenguaje en base a las manos; mas no fue posible debido a varios fallos por incompatibilidad de dependencias y bugs (fallos) constantes al momento de la ejecución de la aplicación. **Así que en este punto se buscará seguir trabajando**