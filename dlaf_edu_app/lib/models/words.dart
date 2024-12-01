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
