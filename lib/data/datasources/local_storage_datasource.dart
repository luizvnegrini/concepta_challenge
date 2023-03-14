import '../../core/core.dart';

abstract class ILocalStorageDatasource {
  Future<void> save(String key, dynamic value);
  Future<dynamic> read(String key);
  void addListener({
    required Function(List<String>) function,
    required List<String>? keys,
  });
}

class LocalStorageDatasource implements ILocalStorageDatasource {
  final ILocalStorageClient _localStorageClient;

  LocalStorageDatasource(this._localStorageClient);

  @override
  Future<void> save(String key, dynamic value) async {
    await _localStorageClient.save(key, value);
  }

  @override
  Future<dynamic> read(String key) async {
    final response = await _localStorageClient.read(key);

    return response;
  }

  @override
  void addListener({
    required Function(List<String>) function,
    required List<String>? keys,
  }) =>
      _localStorageClient.addListener(function: function, keys: keys);
}
