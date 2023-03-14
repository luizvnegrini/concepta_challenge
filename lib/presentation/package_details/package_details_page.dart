import 'package:flutter/material.dart';

import '../presentation.dart';

class PackageDetailsPage extends StatefulWidget {
  const PackageDetailsPage({super.key});

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState
    extends BasePage<PackageDetailsPage, PackageDetailsController> {
  String packageName = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      packageName = ModalRoute.of(context)!.settings.arguments as String;
      controller.getPackageData(packageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final numbersTextStyle = Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontWeight: FontWeight.bold);
    final minorTextStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontSize: 10,
        );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    size: 21,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, state, _) {
                  if (state.isLoading || state.packageData == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(packageName),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.packageData?.likes ?? '',
                                  style: numbersTextStyle,
                                ),
                                Text(
                                  'LIKES',
                                  style: minorTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.packageData?.pubPoints ?? '',
                                  style: numbersTextStyle,
                                ),
                                Text(
                                  'PUB POINTS',
                                  style: minorTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.packageData?.popularity}%',
                                  style: numbersTextStyle,
                                ),
                                Text(
                                  'POPULARITY',
                                  style: minorTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 10,
                          ),
                          child: Text(
                            state.packageData?.description ?? '',
                            style: minorTextStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
