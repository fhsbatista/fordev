import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fordev/data/cache/cache.dart';
import 'package:fordev/data/http/http.dart';
import 'package:fordev/main/decorators/auth_http_client_decorator.dart';

import 'auth_http_client_decorator_test.mocks.dart';

@GenerateMocks([FetchSecureCacheStorage, HttpClient])
void main() {
  late AuthHttpClientDecorator sut;
  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late MockHttpClient httpClient;
  late String url;
  late String method;
  late String token;
  late String decorateeResponse;

  PostExpectation whenTokenCall() {
    return when(fetchSecureCacheStorage.fetchSecure(any));
  }

  void mockToken() {
    token = faker.guid.guid();
    whenTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() {
    whenTokenCall().thenThrow(Exception());
  }

  void mockDecoratee() {
    decorateeResponse = faker.randomGenerator.string(50);
    when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => decorateeResponse);
  }

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    httpClient = MockHttpClient();
    sut = AuthHttpClientDecorator(fetchSecureCacheStorage, httpClient);
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    mockToken();
    mockDecoratee();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should call decoratee with token on header', () async {
    await sut.request(url: url, method: method);

    verify(httpClient.request(
        url: url,
        method: method,
        headers: {'x-access-token': token},
        body: {})).called(1);
  });

  test(
    'Should call decoratee with token on header without modifying original headers',
    () async {
      await sut.request(
        url: url,
        method: method,
        headers: {'header1': 'header1-value'},
      );

      verify(httpClient.request(
        url: url,
        method: method,
        headers: {
          'x-access-token': token,
          'header1': 'header1-value',
        },
        body: {},
      )).called(1);
    },
  );

  test('Should return same result as decoratee', () async {
    final response = await sut.request(
      url: url,
      method: method,
      headers: {'header1': 'header1-value'},
    );

    expect(response, decorateeResponse);
  });

  test(
    'Should throw Forbidden error if FetchSecureCacheStorage throws',
    () async {
      mockTokenError();
      
      final future = sut.request(
        url: url,
        method: method,
        headers: {'header1': 'header1-value'},
      );

      expect(future, throwsA(HttpError.forbidden));
    },
  );
}
