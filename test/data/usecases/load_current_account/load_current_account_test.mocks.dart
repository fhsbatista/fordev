// Mocks generated by Mockito 5.1.0 from annotations
// in fordev/test/data/usecases/load_current_account/load_current_account_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;

import 'load_current_account_test.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [FetchSecureCacheStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchSecureCacheStorage extends _i1.Mock
    implements _i2.FetchSecureCacheStorage {
  MockFetchSecureCacheStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void fetchSecure(String? key) =>
      super.noSuchMethod(Invocation.method(#fetchSecure, [key]),
          returnValueForMissingStub: null);
}
