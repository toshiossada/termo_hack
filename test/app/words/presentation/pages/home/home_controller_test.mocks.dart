// Mocks generated by Mockito 5.2.0 from annotations
// in termo/test/app/words/presentation/pages/home/home_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:ui' as _i10;

import 'package:flutter/widgets.dart' as _i7;
import 'package:flutter_modular/src/presenter/models/modular_navigator.dart'
    as _i8;
import 'package:flutter_modular/src/presenter/models/route.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:termo/app/commons/adapters/custom_alerts/dialog_adapter.dart'
    as _i6;
import 'package:termo/app/words/domain/entities/word_entity.dart' as _i5;
import 'package:termo/app/words/domain/usecases/filter_words_usecase.dart'
    as _i4;
import 'package:termo/app/words/domain/usecases/search_words_usecase.dart'
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

/// A class which mocks [SearchWordsUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchWordsUsecase extends _i1.Mock
    implements _i2.SearchWordsUsecase {
  MockSearchWordsUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<String>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i3.Future<List<String>>);
}

/// A class which mocks [FilterWordsUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFilterWordsUsecase extends _i1.Mock
    implements _i4.FilterWordsUsecase {
  MockFilterWordsUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<String> call(
          {List<String>? blackList,
          List<String>? whiteList,
          _i5.WordEntity? wordEntity,
          List<String>? words}) =>
      (super.noSuchMethod(
          Invocation.method(#call, [], {
            #blackList: blackList,
            #whiteList: whiteList,
            #wordEntity: wordEntity,
            #words: words
          }),
          returnValue: <String>[]) as List<String>);
}

/// A class which mocks [IDialogAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockIDialogAdapter extends _i1.Mock implements _i6.IDialogAdapter {
  MockIDialogAdapter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void showDialog(_i7.Widget? child) =>
      super.noSuchMethod(Invocation.method(#showDialog, [child]),
          returnValueForMissingStub: null);
  @override
  void alertSnackBar(String? text) =>
      super.noSuchMethod(Invocation.method(#alertSnackBar, [text]),
          returnValueForMissingStub: null);
}

/// A class which mocks [IModularNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockIModularNavigator extends _i1.Mock implements _i8.IModularNavigator {
  MockIModularNavigator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  List<_i9.ParallelRoute<dynamic>> get navigateHistory =>
      (super.noSuchMethod(Invocation.getter(#navigateHistory),
              returnValue: <_i9.ParallelRoute<dynamic>>[])
          as List<_i9.ParallelRoute<dynamic>>);
  @override
  _i3.Future<T?> push<T extends Object?>(_i7.Route<T>? route) =>
      (super.noSuchMethod(Invocation.method(#push, [route]),
          returnValue: Future<T?>.value()) as _i3.Future<T?>);
  @override
  _i3.Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments,
          bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#popAndPushNamed, [routeName],
              {#result: result, #arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value()) as _i3.Future<T?>);
  @override
  _i3.Future<T?> pushNamed<T extends Object?>(String? routeName,
          {Object? arguments, bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamed, [routeName],
              {#arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value()) as _i3.Future<T?>);
  @override
  _i3.Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
          String? newRouteName, bool Function(_i7.Route<dynamic>)? predicate,
          {Object? arguments, bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamedAndRemoveUntil, [newRouteName, predicate],
              {#arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value()) as _i3.Future<T?>);
  @override
  _i3.Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments,
          bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushReplacementNamed, [routeName],
              {#result: result, #arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value()) as _i3.Future<T?>);
  @override
  void pop<T extends Object?>([T? result]) =>
      super.noSuchMethod(Invocation.method(#pop, [result]),
          returnValueForMissingStub: null);
  @override
  bool canPop() =>
      (super.noSuchMethod(Invocation.method(#canPop, []), returnValue: false)
          as bool);
  @override
  _i3.Future<bool> maybePop<T extends Object?>([T? result]) =>
      (super.noSuchMethod(Invocation.method(#maybePop, [result]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  void popUntil(bool Function(_i7.Route<dynamic>)? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void navigate(String? path, {dynamic arguments}) => super.noSuchMethod(
      Invocation.method(#navigate, [path], {#arguments: arguments}),
      returnValueForMissingStub: null);
  @override
  void setObservers(List<_i7.NavigatorObserver>? navigatorObservers) =>
      super.noSuchMethod(Invocation.method(#setObservers, [navigatorObservers]),
          returnValueForMissingStub: null);
  @override
  void setNavigatorKey(_i7.GlobalKey<_i7.NavigatorState>? navigatorkey) =>
      super.noSuchMethod(Invocation.method(#setNavigatorKey, [navigatorkey]),
          returnValueForMissingStub: null);
  @override
  void addListener(_i10.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i10.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
}
