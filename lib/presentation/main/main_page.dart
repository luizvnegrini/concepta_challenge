import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../presentation.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BasePage<MainPage, MainController>
    with SingleTickerProviderStateMixin {
  late Duration defaultDuration = const Duration(milliseconds: 250);
  late double boxInitialValue = MediaQuery.of(context).size.width * 0.13;
  final focus = FocusNode();
  late AnimationController inputAnimationController =
      inputAnimationController = AnimationController(
    vsync: this,
    duration: defaultDuration,
  );
  late Animation<double> sizeAnimation = Tween<double>(
    begin: boxInitialValue,
    end: MediaQuery.of(context).size.width,
  ).animate(
    CurvedAnimation(
      curve: Curves.slowMiddle,
      parent: inputAnimationController,
    ),
  );
  late ValueNotifier<bool> showResultContainer;
  final minLengthRequiredToSearch = 2;

  @override
  void initState() {
    super.initState();

    focus.addListener(() {
      if (!focus.hasFocus) {
        inputAnimationController.reverse();
      }
    });
    inputAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.reverse) {
        focus.unfocus();
        showResultContainer.value = false;
      }

      if (status == AnimationStatus.completed) {
        showResultContainer.value = true;
      }
    });
    showResultContainer = ValueNotifier(false);
  }

  @override
  void dispose() {
    focus.dispose();
    inputAnimationController.dispose();
    showResultContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) => Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: sizeAnimation,
                        builder: (context, value, child) => SizedBox(
                          width: sizeAnimation.value,
                          height: 50,
                          child: TextFormField(
                            focusNode: focus,
                            onChanged: (value) {
                              if (value.length >= minLengthRequiredToSearch) {
                                controller.searchPackages(value);
                              }
                
                              controller.clearResults();
                            },
                            onTap: () => inputAnimationController.forward(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 0,
                              ),
                              prefixIcon: inputAnimationController.status ==
                                      AnimationStatus.dismissed
                                  ? const Align(
                                      child: Icon(Icons.search),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueListenableBuilder(
                        valueListenable: showResultContainer,
                        builder: (context, showResults, _) {
                          if (!showResults) {
                            return const SizedBox.shrink();
                          }
                
                          if (state.isLoading) {
                            return const CircularProgressIndicator();
                          }
                
                          if (state.packagesResult.isNotEmpty) {
                            return AutoCompleteList(
                              items: state.packagesResult,
                              controller: controller,
                            );
                          }
                
                          if (state.valuesOnStorage.isNotEmpty) {
                            return RecentSearchesWidget(controller: controller);
                          }
                
                          return const NoRecentSearchesWidget();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class RecentSearchesWidget extends StatelessWidget {
  const RecentSearchesWidget({
    required this.controller,
    super.key,
  });

  final MainController controller;
  double get defaultSpace => 8;

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [
            SizedBox(height: defaultSpace),
            const Text('Recent Searches'),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(bottom: defaultSpace),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.value.valuesOnStorage.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.packageDetails,
                      arguments: controller.value.valuesOnStorage[index],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(controller.value.valuesOnStorage[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class AutoCompleteList extends StatelessWidget {
  const AutoCompleteList({
    required this.controller,
    required this.items,
    super.key,
  });

  final MainController controller;
  final List<String> items;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.saveItem(item);
                  Navigator.pushNamed(
                    context,
                    Routes.packageDetails,
                    arguments: item,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(item),
                ),
              );
            },
          ),
        ),
      );
}

class NoRecentSearchesWidget extends StatelessWidget {
  const NoRecentSearchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColor,
          )),
      child: const Text('No Recent Searches'),
    );
  }
}
