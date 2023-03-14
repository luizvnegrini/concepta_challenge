import 'package:concepta_challenge/domain/domain.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ILocalPubPackagesRepositoryMock extends Mock
    implements ILocalPubPackagesRepository {}

void main() {
  late IFetchDataFromLocalStorage sut;
  late ILocalPubPackagesRepositoryMock spy;

  setUp(() {
    spy = ILocalPubPackagesRepositoryMock();
    sut = FetchDataFromLocalStorage(spy);
  });

  test('should call repository method using key and return correct response',
      () async {
    final key = faker.randomGenerator.string(10);
    final fakeResult = [
      faker.randomGenerator.string(10),
      faker.randomGenerator.string(10),
      faker.randomGenerator.string(10),
    ];

    when(() => spy.fetchDataFromLocalStorage(key: key)).thenAnswer(
      (invocation) async => fakeResult,
    );

    final response = await sut(key: key);

    verify(() => spy.fetchDataFromLocalStorage(key: key));
    expect(fakeResult, response);
  });
}
