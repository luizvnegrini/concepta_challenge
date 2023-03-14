import 'package:pub_api_client/pub_api_client.dart';

import '../../core.dart';

class PubApiClientAdapter implements IRemoteClient {
  final _client = PubClient();

  @override
  Future<List<String>> search({required String query}) async {
    final response = await _client.search(
      query,
      sort: SearchOrder.text,
    );

    return response.packages.map((e) => e.package).toList();
  }

  @override
  Future<PackageScore> getPackageScore({required String packageName}) async =>
    await _client.packageScore(packageName);

  @override
  Future<PubPackage> getPackageInfo({required String packageName}) async =>
    await _client.packageInfo(packageName);
}
