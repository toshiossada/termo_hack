import 'package:diacritic/diacritic.dart';

class BuildPluralWord {
  List<String> call({
    required String word,
  }) {
    final wordResult = removeDiacritics(word.toUpperCase()).trim();

    final result = <String>[];

    if (wordResult.endsWith('R') ||
        wordResult.endsWith('S') ||
        wordResult.endsWith('Z')) {
      result.add('${wordResult}ES'); // Hello.
    } else if (wordResult.endsWith('AL') ||
        wordResult.endsWith('EL') ||
        wordResult.endsWith('OL') ||
        wordResult.endsWith('UL')) {
      result.add('${wordResult.substring(0, wordResult.length - 1)}IS');
    } else if (wordResult.endsWith('IL')) {
      result.add('${wordResult.substring(0, wordResult.length - 2)}IS');
      result.add('${wordResult.substring(0, wordResult.length - 2)}EIS');
    } else if (wordResult.endsWith('M')) {
      result.add('${wordResult.substring(0, wordResult.length - 1)}NS');
    } else if (wordResult.endsWith('AO')) {
      result.add('${wordResult}S');
      result.add('${wordResult.substring(0, wordResult.length - 2)}OES');
    } else {
      result.add('${wordResult}S');
    }

    return result.toList();
  }
}
