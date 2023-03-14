import 'package:concepta_challenge/data/data.dart';

import '../../domain/domain.dart';

class LocalPubPackagesRepository implements ILocalPubPackagesRepository {
  final ILocalStorageDatasource _localStorageDatasource;

  LocalPubPackagesRepository(this._localStorageDatasource);

  @override
  void addListener({
    required Function(List<String>) function,
    required List<String>? keys,
  }) {
    _localStorageDatasource.addListener(function: function, keys: keys);
  }

  @override
  Future<void> savePackage(
      {required String key, required String packageName}) async {
    List<String> listToSave;
    final packagesFromLocalStorage = await _localStorageDatasource.read(key);

    if (packagesFromLocalStorage == null) {
      listToSave = List<String>.from([packageName]);
    } else {
      listToSave = List<String>.from(packagesFromLocalStorage);

      if (listToSave.any((element) => element == packageName)) {
        return;
      }

      listToSave.add(packageName);
    }

    await _localStorageDatasource.save(
      key,
      listToSave,
    );
  }

  @override
  Future<List<String>> fetchDataFromLocalStorage({required String key}) async {
    final response = await _localStorageDatasource.read(key);
    return List.from(response ?? []);
  }
}
