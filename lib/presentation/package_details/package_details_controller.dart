import 'package:flutter/widgets.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

class PackageDetailsController extends ValueNotifier<PackageDetailsState> {
  final IFetchPackageData _fetchPackageData;

  PackageDetailsController({
    required IFetchPackageData fetchPackageData,
  })  : _fetchPackageData = fetchPackageData,
        super(PackageDetailsState());

  Future<void> getPackageData(String packageName) async {
    try {
      value = value.copyWith(isLoading: true);

      final packageData = await _fetchPackageData(packageName: packageName);

      value = value.copyWith(packageData: packageData);
    } catch (e) {
      ///TODO: handle here
    } finally {
      value = value.copyWith(isLoading: false);
    }
  }
}
