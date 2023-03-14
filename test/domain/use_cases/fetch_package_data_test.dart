import 'package:concepta_challenge/domain/domain.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class IExternalPubPackagesRepositoryMock extends Mock
    implements IExternalPubPackagesRepository {}

void main() {
  late IFetchPackageData sut;
  late IExternalPubPackagesRepositoryMock spy;

  setUp(() {
    spy = IExternalPubPackagesRepositoryMock();
    sut = FetchPackageData(spy);
  });

  test(
      'should call getPackageData repository method using key and return correct response',
      () async {
    final packageName = faker.randomGenerator.string(10);
    final fakeResult = PackageData(
      likes: faker.randomGenerator.string(2),
      pubPoints: faker.randomGenerator.string(3),
      popularity: faker.randomGenerator.string(4),
      description: faker.randomGenerator.string(20),
    );

    when(() => spy.getPackageData(packageName: packageName)).thenAnswer(
      (invocation) async => fakeResult,
    );

    final response = await sut(packageName: packageName);

    verify(() => spy.getPackageData(packageName: packageName));
    expect(fakeResult, response);
  });
}
