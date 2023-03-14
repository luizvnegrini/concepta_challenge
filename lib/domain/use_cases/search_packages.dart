import 'package:concepta_challenge/domain/domain.dart';

abstract class ISearchPackages {
  Future<List<String>> call({required String query});
}

class SearchPackages implements ISearchPackages {
  final IExternalPubPackagesRepository _repository;

  SearchPackages(this._repository);

  @override
  Future<List<String>> call({required String query}) async =>
      (await _repository.search(query: query)).take(5).toList();
}
