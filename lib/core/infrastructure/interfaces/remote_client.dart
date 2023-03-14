import 'dart:async';

import 'package:pub_api_client/pub_api_client.dart';

abstract class IRemoteClient {
  Future<List<String>> search({required String query});
  Future<PackageScore> getPackageScore({required String packageName});
  Future<PubPackage> getPackageInfo({required String packageName});
}
