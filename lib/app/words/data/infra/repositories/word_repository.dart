import '../../../domain/repositories/word_repository_interface.dart';
import '../datasources/word_datasource_interface.dart';

class WordRepository implements IWordRepository {
  final IWordDataSource _wordDataSource;

  WordRepository({
    required IWordDataSource wordDataSource,
  }) : _wordDataSource = wordDataSource;

  @override
  Future<List<String>> getWords() async {
    final result = await _wordDataSource.getWords();

    return result.toSet().toList();
  }
}
