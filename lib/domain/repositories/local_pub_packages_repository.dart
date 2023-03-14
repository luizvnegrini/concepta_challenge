abstract class ILocalPubPackagesRepository {
  void addListener({
    required Function(List<String>) function,
    required List<String>? keys,
  });
  Future<void> savePackage({
    required String key,
    required String packageName,
  });
  Future<List<String>> fetchDataFromLocalStorage({required String key});
}
