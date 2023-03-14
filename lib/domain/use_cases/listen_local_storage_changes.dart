import 'package:concepta_challenge/domain/domain.dart';

abstract class IListenLocalStorageChanges {
  void call({
    required Function(List<String>) function,
    required List<String>? keys,
  });
}

class ListenLocalStorageChanges implements IListenLocalStorageChanges {
  final ILocalPubPackagesRepository _repository;

  ListenLocalStorageChanges(this._repository);

  @override
  void call({
    required Function(List<String>) function,
    required List<String>? keys,
  }) =>
      _repository.addListener(function: function, keys: keys);
}
