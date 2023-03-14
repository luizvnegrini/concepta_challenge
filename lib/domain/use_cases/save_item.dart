import 'package:concepta_challenge/domain/domain.dart';

abstract class ISaveItem {
  Future<void> call({
    required String key,
    required String packageName,
  });
}

class SaveItem implements ISaveItem {
  final ILocalPubPackagesRepository _repository;

  SaveItem(this._repository);

  @override
  Future<void> call({
    required String key,
    required String packageName,
  }) async =>
      await _repository.savePackage(key: key, packageName: packageName);
}
