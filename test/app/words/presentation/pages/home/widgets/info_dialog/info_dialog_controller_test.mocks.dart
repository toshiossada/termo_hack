// Mocks generated by Mockito 5.2.0 from annotations
// in termo/test/app/words/presentation/pages/home/widgets/info_dialog/info_dialog_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:termo/app/commons/adapters/custom_alerts/launch_url/launch_url_adapter.dart'
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

/// A class which mocks [LaunchUrlAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockLaunchUrlAdapter extends _i1.Mock implements _i2.LaunchUrlAdapter {
  MockLaunchUrlAdapter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> openUrl(String? url) =>
      (super.noSuchMethod(Invocation.method(#openUrl, [url]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<bool> sendEmail({String? email, String? subject}) =>
      (super.noSuchMethod(
          Invocation.method(#sendEmail, [], {#email: email, #subject: subject}),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
