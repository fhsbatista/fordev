import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/errors/errors.dart';
import '../../ui/pages/surveys/surveys.dart';
import '../mixins/mixins.dart';

class GetxSurveysPresenter extends GetxController with GetxLoading implements SurveysPresenter {
  final LoadSurveys loadSurveys;

  final _surveys = Rx<List<SurveyViewModel>>([]);
  final _navigateTo = Rx<String?>(null);
  final _isSessionExpired = false.obs;

  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;
  Stream<String?> get navigateToStream => _navigateTo.stream;
  Stream<bool> get isSessionExpiredStream => _isSessionExpired.stream;

  GetxSurveysPresenter({required this.loadSurveys});

  @override
  Future<void> loadData() async {
    try {
      isLoading = true;
      final surveys = await loadSurveys.load();
      _surveys.value = surveys
          .map((e) => SurveyViewModel(
                id: e.id,
                question: e.question,
                date: DateFormat('dd MMM yyyy').format(e.date),
                isAnswered: e.isAnswered,
              ))
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.access_denied) {
        _isSessionExpired.value = true;
      } else {
        _surveys.addError(UIError.unexpected.description, StackTrace.empty);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  void goToSurveyResult({required String surveyId}) {
    _navigateTo.value = '/survey_result/$surveyId';
  }
}
