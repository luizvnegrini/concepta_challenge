import '../../domain/domain.dart';

class PackageDetailsState {
  PackageDetailsState({
    this.isLoading = false,
    this.packageData,
  });

  bool isLoading;
  PackageData? packageData;

  PackageDetailsState copyWith({
    bool? isLoading,
    PackageData? packageData,
  }) =>
      PackageDetailsState(
        isLoading: isLoading ?? this.isLoading,
        packageData: packageData ?? this.packageData,
      );
}
