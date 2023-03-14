import 'core/core.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

class ServiceLocator {
  factory ServiceLocator() {
    return _singleton;
  }

  ServiceLocator._internal();

  static final ServiceLocator _singleton = ServiceLocator._internal();
  static final injections = <Type, dynamic>{};

  static void register() {
    // Adapters
    injections.addAll({
      ILocalStorageClient: HiveStorageAdapter('success_results'),
      IRemoteClient: PubApiClientAdapter(),
    });

    // Datasources
    injections.addAll({
      ILocalStorageDatasource:
          LocalStorageDatasource(injections[ILocalStorageClient]),
      IRemoteDatasource: RemoteDatasource(injections[IRemoteClient]),
    });

    // Repositories
    injections.addAll({
      IExternalPubPackagesRepository:
          ExternalPubPackagesRepository(injections[IRemoteDatasource]),
      ILocalPubPackagesRepository:
          LocalPubPackagesRepository(injections[ILocalStorageDatasource]),
    });

    // UseCases
    injections.addAll({
      ISearchPackages:
          SearchPackages(injections[IExternalPubPackagesRepository]),
      IListenLocalStorageChanges:
          ListenLocalStorageChanges(injections[ILocalPubPackagesRepository]),
      ISaveItem: SaveItem(injections[ILocalPubPackagesRepository]),
      IFetchDataFromLocalStorage:
          FetchDataFromLocalStorage(injections[ILocalPubPackagesRepository]),
      IFetchPackageData:
          FetchPackageData(injections[IExternalPubPackagesRepository]),
    });

    // Controllers
    injections.addAll({
      MainController: MainController(
        searchPackages: injections[ISearchPackages],
        listenLocalStorageChanges: injections[IListenLocalStorageChanges],
        saveItem: injections[ISaveItem],
        fetchDataFromLocalStorage: injections[IFetchDataFromLocalStorage],
      ),
      PackageDetailsController: PackageDetailsController(
          fetchPackageData: injections[IFetchPackageData]),
    });
  }

  static T getInstance<T>() {
    if (injections.entries.any((element) => element.value is T)) {
      return injections[T] as T;
    }

    throw UnimplementedError('Should register dependency for $T');
  }
}
