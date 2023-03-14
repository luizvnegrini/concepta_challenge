import 'dart:async';

abstract class ILocalStorageClient<T> {
  FutureOr<void> save(String key, T value);
  FutureOr<dynamic> read(String key);
  FutureOr<void> clear();
  Future<void> addListener({
    required Function(List<String>) function,
    required List<String>? keys,
  });
}
