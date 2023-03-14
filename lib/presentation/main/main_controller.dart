import 'package:concepta_challenge/domain/domain.dart';
import 'package:flutter/widgets.dart';

import 'main_state.dart';

class MainController extends ValueNotifier<MainState> {
  final ISearchPackages _searchPackages;
  final IListenLocalStorageChanges _listenLocalStorageChanges;
  final ISaveItem _saveItem;
  final IFetchDataFromLocalStorage _fetchDataFromLocalStorage;

  String get defaultKey => 'success_results';

  MainController({
    required ISearchPackages searchPackages,
    required IListenLocalStorageChanges listenLocalStorageChanges,
    required ISaveItem saveItem,
    required IFetchDataFromLocalStorage fetchDataFromLocalStorage,
  })  : _searchPackages = searchPackages,
        _listenLocalStorageChanges = listenLocalStorageChanges,
        _saveItem = saveItem,
        _fetchDataFromLocalStorage = fetchDataFromLocalStorage,
        super(MainState()) {
    _fetchPackagesOnLocalStorage();
    _addListenerToLocalChangesStorage();
  }

  void _addListenerToLocalChangesStorage() {
    _listenLocalStorageChanges(
        function: (items) {
          value = value.copyWith(valuesOnStorage: items);
        },
        keys: [defaultKey]);
  }

  Future<void> saveItem(String item) async {
    try {
      value = value.copyWith(isLoading: true);

      await _saveItem(
        key: defaultKey,
        packageName: item,
      );
    } catch (e) {
      ///TODO: handle here
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchPackagesOnLocalStorage() async {
    try {
      value = value.copyWith(isLoading: true);

      final response = await _fetchDataFromLocalStorage(
        key: defaultKey,
      );

      value = value.copyWith(valuesOnStorage: response);
    } catch (e) {
      ///TODO: handle here
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }

  Future<void> searchPackages(String query) async {
    try {
      value = value.copyWith(isLoading: true);

      final packages = await _searchPackages(query: query);

      value = value.copyWith(
        isLoading: false,
        packagesResult: packages,
      );
    } catch (e) {
      ///TODO: handle here
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }

  void clearResults() => value = value.copyWith(packagesResult: List.empty());
}
