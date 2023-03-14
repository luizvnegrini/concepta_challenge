import '../entities/entities.dart';

abstract class IExternalPubPackagesRepository {
  Future<List<String>> search({required query});
  Future<PackageData> getPackageData({required String packageName});
}
