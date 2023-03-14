import 'package:concepta_challenge/domain/domain.dart';

abstract class IFetchPackageData {
  Future<PackageData> call({    
    required String packageName,
  });
}

class FetchPackageData implements IFetchPackageData {
  final IExternalPubPackagesRepository _repository;

  FetchPackageData(this._repository);

  @override
  Future<PackageData> call({    
    required String packageName,
  }) async =>
      await _repository.getPackageData(packageName: packageName);
}
