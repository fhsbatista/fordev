// Mocks generated by Mockito 5.1.0 from annotations
// in fordev/test/presentation/presenters/getx_survey_result_presenter_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:fordev/domain/entities/entities.dart' as _i2;
import 'package:fordev/domain/usecases/load_survey_result.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSurveyResultEntity_0 extends _i1.Fake
    implements _i2.SurveyResultEntity {}

/// A class which mocks [LoadSurveyResult].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadSurveyResult extends _i1.Mock implements _i3.LoadSurveyResult {
  MockLoadSurveyResult() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SurveyResultEntity> loadBySurvey(String? surveyId) =>
      (super.noSuchMethod(Invocation.method(#loadBySurvey, [surveyId]),
              returnValue: Future<_i2.SurveyResultEntity>.value(
                  _FakeSurveyResultEntity_0()))
          as _i4.Future<_i2.SurveyResultEntity>);
}
