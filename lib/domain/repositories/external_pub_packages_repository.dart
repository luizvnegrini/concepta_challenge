import '../entities/entities.dart';

abstract class IExternalPubPackagesRepository {
  Future<List<String>> search({required String query});
  Future<PackageData> getPackageData({required String packageName});
}
