// Mocks generated by Mockito 5.4.2 from annotations
// in termo/test/app/modules/words/data/external/datasources/word_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:termo/app/commons/adapters/http_client/http_client_adapter.dart'
    as _i3;
import 'package:termo/app/commons/adapters/http_client/http_response.dart'
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

class _FakeHttpResponse_0 extends _i1.SmartFake implements _i2.HttpResponse {
  _FakeHttpResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IHttpClientAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockIHttpClientAdapter extends _i1.Mock
    implements _i3.IHttpClientAdapter {
  MockIHttpClientAdapter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.HttpResponse> get(
    String? path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool? cached = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
          {
            #queryParameters: queryParameters,
            #headers: headers,
            #cached: cached,
          },
        ),
        returnValue: _i4.Future<_i2.HttpResponse>.value(_FakeHttpResponse_0(
          this,
          Invocation.method(
            #get,
            [path],
            {
              #queryParameters: queryParameters,
              #headers: headers,
              #cached: cached,
            },
          ),
        )),
      ) as _i4.Future<_i2.HttpResponse>);
  @override
  _i4.Future<_i2.HttpResponse> post(
    String? path, {
    dynamic data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers,
          },
        ),
        returnValue: _i4.Future<_i2.HttpResponse>.value(_FakeHttpResponse_0(
          this,
          Invocation.method(
            #post,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #headers: headers,
            },
          ),
        )),
      ) as _i4.Future<_i2.HttpResponse>);
  @override
  _i4.Future<_i2.HttpResponse> put(
    String? path, {
    dynamic data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [path],
          {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers,
          },
        ),
        returnValue: _i4.Future<_i2.HttpResponse>.value(_FakeHttpResponse_0(
          this,
          Invocation.method(
            #put,
            [path],
            {
              #data: data,
              #queryParameters: queryParameters,
              #headers: headers,
            },
          ),
        )),
      ) as _i4.Future<_i2.HttpResponse>);
  @override
  _i4.Future<_i2.HttpResponse> delete(
    String? path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [path],
          {
            #queryParameters: queryParameters,
            #headers: headers,
          },
        ),
        returnValue: _i4.Future<_i2.HttpResponse>.value(_FakeHttpResponse_0(
          this,
          Invocation.method(
            #delete,
            [path],
            {
              #queryParameters: queryParameters,
              #headers: headers,
            },
          ),
        )),
      ) as _i4.Future<_i2.HttpResponse>);
}
