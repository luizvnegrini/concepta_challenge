import '../../domain/domain.dart';
import '../data.dart';

class ExternalPubPackagesRepository implements IExternalPubPackagesRepository {
  final IRemoteDatasource _remoteDatasource;

  ExternalPubPackagesRepository(this._remoteDatasource);

  @override
  Future<List<String>> search({required query}) async {
    try {
      return await _remoteDatasource.search(query: query);
    } catch (e) {
      ///TODO: handle error
      throw UnimplementedError();
    }
  }

  @override
  Future<PackageData> getPackageData({required String packageName}) async {
    final score =
        await _remoteDatasource.getPackageScore(packageName: packageName);
    final info =
        await _remoteDatasource.getPubPackage(packageName: packageName);

    final popularity =
        score.popularityScore != null ? score.popularityScore! * 100 : 0;

    return PackageData(
      likes: score.likeCount.toString(),
      pubPoints: score.grantedPoints?.toString() ?? '0',
      popularity: popularity.round().toString(),
      description: info.description,
    );
  }
}
