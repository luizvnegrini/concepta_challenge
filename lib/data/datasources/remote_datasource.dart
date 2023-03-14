import 'package:concepta_challenge/core/core.dart';
import 'package:pub_api_client/pub_api_client.dart';

abstract class IRemoteDatasource {
  Future<List<String>> search({required String query});
  Future<PackageScore> getPackageScore({required String packageName});
  Future<PubPackage> getPubPackage({required String packageName});
}

class RemoteDatasource implements IRemoteDatasource {
  final IRemoteClient _remoteClient;

  RemoteDatasource(this._remoteClient);

  @override
  Future<List<String>> search({required String query}) async =>
      await _remoteClient.search(query: query);

  @override
  Future<PackageScore> getPackageScore({required String packageName}) async =>
      await _remoteClient.getPackageScore(packageName: packageName);

  @override
  Future<PubPackage> getPubPackage({required String packageName}) async =>
      await _remoteClient.getPackageInfo(packageName: packageName);
}
