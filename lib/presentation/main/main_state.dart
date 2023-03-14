
class MainState {
  MainState({
    this.isLoading = false,
    List<String>? packagesResult,
    List<String>? valuesOnStorage,
  }) : packagesResult = packagesResult ?? [],
  valuesOnStorage = valuesOnStorage ?? [];

  bool isLoading;
  List<String> packagesResult;
  List<String> valuesOnStorage;

  MainState copyWith({
    bool? isLoading,
    List<String>? packagesResult,
    List<String>? valuesOnStorage,
  }) =>
      MainState(
        isLoading: isLoading ?? this.isLoading,
        packagesResult: packagesResult ?? this.packagesResult,
        valuesOnStorage: valuesOnStorage ?? this.valuesOnStorage,
      );
}
