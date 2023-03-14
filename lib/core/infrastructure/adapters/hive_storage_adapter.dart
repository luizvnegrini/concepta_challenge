import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../core.dart';

class HiveStorageAdapter<T> implements ILocalStorageClient<T> {
  HiveStorageAdapter(String boxKey) {
    _init(boxKey);
  }

  final Completer<Box> _completer = Completer<Box>();

  Future<Box> get _box => _completer.future;

  _init(String boxKey) async {
    await Hive.initFlutter();
    _completer.complete(await Hive.openBox(boxKey));
  }

  @override
  Future<void> clear() async {
    (await _box).clear();
  }

  @override
  FutureOr<dynamic> read(String key) async => (await _box).get(key);

  @override
  Future<void> save(String key, T value) async {
    var box = await _box;
    box.put(key, value);
  }

  @override
  Future<void> addListener({
    required Function(List<String>) function,
    required List<String>? keys,
  }) async {
    final box = await _box;
    box.listenable(keys: keys).addListener(() {
      function(box.values.first);
    });
  }
}
