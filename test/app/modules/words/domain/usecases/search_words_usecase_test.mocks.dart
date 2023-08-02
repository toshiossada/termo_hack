// Mocks generated by Mockito 5.4.2 from annotations
// in termo/test/app/modules/words/domain/usecases/search_words_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:termo/app/modules/words/domain/repositories/word_repository_interface.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [IWordRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIWordRepository extends _i1.Mock implements _i2.IWordRepository {
  MockIWordRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<String>> getWords() => (super.noSuchMethod(
        Invocation.method(
          #getWords,
          [],
        ),
        returnValue: _i3.Future<List<String>>.value(<String>[]),
      ) as _i3.Future<List<String>>);
}
