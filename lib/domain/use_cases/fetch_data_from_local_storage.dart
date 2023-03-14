import 'package:concepta_challenge/domain/domain.dart';

abstract class IFetchDataFromLocalStorage {
  Future<List<String>> call({    
    required String key,
  });
}

class FetchDataFromLocalStorage implements IFetchDataFromLocalStorage {
  final ILocalPubPackagesRepository _repository;

  FetchDataFromLocalStorage(this._repository);

  @override
  Future<List<String>> call({
    required String key,
  }) async =>
      await _repository.fetchDataFromLocalStorage(key: key);
}
