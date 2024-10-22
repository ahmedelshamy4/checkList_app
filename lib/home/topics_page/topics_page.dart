import 'package:checklist_app/core/custom_widgets/app_text_field_input.dart';
import 'package:checklist_app/core/custom_widgets/main_button.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/home/topics_page/widgets/custom_expansion_tile.dart';
import 'package:checklist_app/model/check_list_item.dart';
import 'package:checklist_app/model/package_item.dart';
import 'package:checklist_app/model/tab_data_model.dart';
import 'package:checklist_app/utils/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage(
      {super.key, required this.sharedPrefsManager, required this.topic});

  final SharedPreferencesManager sharedPrefsManager;
  final String topic;

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> with TickerProviderStateMixin {
  List<TabDataModel> tabs = [];
  TabController? _tabController;
  final _tabNameController = TextEditingController();
  final _tabDescriptionController = TextEditingController();
  final _checkListItemTitleController = TextEditingController();
  final _checkListItemDesController = TextEditingController();
  final _checkListItemPackageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTabs();
  }

  @override
  void dispose() {
    super.dispose();
    _tabNameController.dispose();
    _tabDescriptionController.dispose();
    _checkListItemTitleController.dispose();
    _checkListItemDesController.dispose();
    _checkListItemPackageController.dispose();
  }

  void _loadTabs() {
    setState(() {
      tabs = widget.sharedPrefsManager.getTabs();
      if (tabs.isNotEmpty) {
        for (var tab in tabs) {
          tab.checkListItems =
              widget.sharedPrefsManager.getCheckList(tab.tabName);
        }
        _tabController = TabController(length: tabs.length, vsync: this);
      }
    });
  }

  void _showAddTabDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add New Tab",
            style: AppTextStyles.nunitoFont24Regular(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: _tabNameController,
                hintText: "Tab Name",
              ),
              const Gap(PaddingDimensions.large),
              AppTextField(
                controller: _tabDescriptionController,
                hintText: "Tab Description",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addNewTab();
                Navigator.of(context).pop();
              },
              child: const Text("Add tab"),
            ),
          ],
        );
      },
    );
  }

  void _addNewTab() {
    if (_tabNameController.text.isNotEmpty &&
        _tabDescriptionController.text.isNotEmpty) {
      setState(() {
        var newTab = TabDataModel(
          tabName: _tabNameController.text,
          tabDescription: _tabDescriptionController.text,
        );
        tabs.add(newTab);
        _tabNameController.clear();
        _tabDescriptionController.clear();

        _tabController?.dispose();
        _tabController = TabController(length: tabs.length, vsync: this);

        newTab.checkListItems = [];

        _saveTabs();
      });
    }
  }

  void _saveTabs() {
    widget.sharedPrefsManager.saveTabs(tabs);
  }

  void _addChecklistItem(TabDataModel tab, List<PackageItem> packageList) {
    if (_checkListItemTitleController.text.isNotEmpty &&
        _checkListItemDesController.text.isNotEmpty &&
        packageList.isNotEmpty) {
      tab.checkListItems.add(
        CheckListItem(
          text: _checkListItemTitleController.text,
          description: _checkListItemDesController.text,
          packageList: packageList,
        ),
      );
      _checkListItemTitleController.clear();
      _checkListItemDesController.clear();
      _checkListItemPackageController.clear();
      _saveCheckList(tab);

      setState(() {});
    }
  }

  void _deleteTab(int index) {
    setState(() {
      tabs.removeAt(index);

      _tabController?.dispose();
      if (tabs.isNotEmpty) {
        _tabController = TabController(length: tabs.length, vsync: this);
      } else {
        _tabController = null;
      }

      _saveTabs();
    });
  }

  void _saveCheckList(TabDataModel tab) {
    widget.sharedPrefsManager.saveCheckList(tab.tabName, tab.checkListItems);
  }

  void _showCheckListItemAddedAlertDialog(TabDataModel tab) {
    List<PackageItem> packageList = [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Add checklist item",
                style: AppTextStyles.nunitoFont24Regular(context),
              ),
              content: SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: _checkListItemTitleController,
                        hintText: "Checklist Item Name",
                      ),
                      const Gap(PaddingDimensions.large),
                      AppTextField(
                        controller: _checkListItemDesController,
                        hintText: "Checklist Item Description",
                      ),
                      const Gap(PaddingDimensions.large),
                      // Field for adding a new package name
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: _checkListItemPackageController,
                              hintText: "Package Name",
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              if (_checkListItemPackageController
                                  .text.isNotEmpty) {
                                setState(() {
                                  packageList.add(
                                    PackageItem(
                                      packageName:
                                          _checkListItemPackageController.text,
                                      isChecked: false,
                                    ),
                                  );
                                  _checkListItemPackageController.clear();
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const Gap(PaddingDimensions.large),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: packageList
                            .map((e) => Text(
                                  "💡${e.packageName}",
                                  style: AppTextStyles.ralewayFont20SemiBold(
                                      context),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                MainButton(
                  textColor: AppColors.white,
                  onPressed: () {
                    _addChecklistItem(tab, packageList);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add Item"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editCheckListItem(CheckListItem item) {
    final editTitleController = TextEditingController(text: item.text);
    final editDesController = TextEditingController(text: item.description);
    List<PackageItem> originalPackageList = List.from(item.packageList);
    List<PackageItem> newPackageList = [];
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Edit Item"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      controller: editTitleController,
                      hintText: "Edit Item Text",
                    ),
                    const Gap(PaddingDimensions.large),
                    AppTextField(
                      controller: editDesController,
                      hintText: "Edit Item Description",
                    ),
                    const Gap(PaddingDimensions.large),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _checkListItemPackageController,
                            hintText: "Package Name",
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (_checkListItemPackageController
                                .text.isNotEmpty) {
                              setStateDialog(() {
                                newPackageList.add(
                                  PackageItem(
                                    packageName:
                                        _checkListItemPackageController.text,
                                    isChecked: false,
                                  ),
                                );
                                _checkListItemPackageController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const Gap(PaddingDimensions.large),
                    if (originalPackageList.isNotEmpty)
                      const Text("Existing Packages:"),
                    Column(
                      children:
                          originalPackageList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final package = entry.value;
                        return Row(
                          children: [
                            Expanded(
                              child: Text(package.packageName),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                originalPackageList.removeAt(index);
                                setStateDialog(() {});
                              },
                            )
                          ],
                        );
                      }).toList(),
                    ),
                    if (newPackageList.isNotEmpty) const Text("New Packages:"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: newPackageList
                          .map((newPackage) => Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "💡${newPackage.packageName}",
                                      style:
                                          AppTextStyles.ralewayFont20SemiBold(
                                              context),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Colors.red),
                                    onPressed: () {
                                      newPackageList.remove(newPackage);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    item.packageList = List.from(originalPackageList)
                      ..addAll(newPackageList);
                    item.text = editTitleController.text;
                    item.description = editDesController.text;
                    _saveCheckList(tabs[_tabController!.index]);
                    print("Total packages: ${item.packageList.length}");
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save Edit"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateProgress(TabDataModel tab) {
    int totalPackages = 0;
    int checkedPackages = 0;

    for (var checkListItem in tab.checkListItems) {
      for (var package in checkListItem.packageList) {
        totalPackages++;
        if (package.isChecked) {
          checkedPackages++;
        }
      }
    }

    double progress =
        totalPackages > 0 ? (checkedPackages / totalPackages) * 100 : 0;
    setState(() {
      tab.progress = progress;
    });
  }

  int getCheckedCount(TabDataModel tab) {
    return tab.checkListItems
        .where((item) => item.packageList.every((package) => package.isChecked))
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (tabs.isNotEmpty)
            IconButton(
              onPressed: () => _showCheckListItemAddedAlertDialog(
                  tabs[_tabController!.index]),
              icon: const Icon(Icons.add_box_rounded),
            ),
          IconButton(
            onPressed: _showAddTabDialog,
            icon: const Icon(Icons.add),
          ),
        ],
        title: Text(
          " ${widget.topic}",
          style: AppTextStyles.playfairFont24Bold(context),
        ),
        bottom: tabs.isNotEmpty
            ? TabBar(
                controller: _tabController,
                tabs: tabs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tab = entry.value;
                  return Tab(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                tab.tabName,
                                style:
                                    AppTextStyles.nunitoFont16Regular(context),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            color: Colors.red,
                            icon: const Icon(
                              Icons.clear_outlined,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete Tab"),
                                    content: const Text(
                                        "Are you sure you want to delete this tab?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _deleteTab(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            : null,
      ),
      body: (tabs.isEmpty)
          ? Center(
              child: Text(
                "No tabs added. Press + to add a new tab.",
                style: AppTextStyles.nunitoFont20Medium(context),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  fillOverscroll: true,
                  hasScrollBody: true,
                  child: TabBarView(
                    controller: _tabController,
                    children: tabs.map((tab) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PaddingDimensions.normal,
                            vertical: PaddingDimensions.large),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: tab.progress / 100,
                                    minHeight: 10,
                                  ),
                                ),
                                const SizedBox(width: PaddingDimensions.large),
                                Text(
                                  "${(tab.progress).toStringAsFixed(0)}%",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Gap(PaddingDimensions.large),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: PaddingDimensions.large,
                                  horizontal: PaddingDimensions.large),
                              color: AppColors.mediumGrey.withOpacity(.1),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "🚀 ${tab.tabDescription}",
                                      style: AppTextStyles.nunitoFont20Medium(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: PaddingDimensions.normal),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Total Checked: ${getCheckedCount(tab)} / ${tab.checkListItems.length}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(PaddingDimensions.large),
                            Expanded(
                              child: ReorderableListView(
                                physics: const BouncingScrollPhysics(),
                                onReorder: (int oldIndex, int newIndex) {
                                  setState(() {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final movedItem =
                                        tab.checkListItems.removeAt(oldIndex);
                                    tab.checkListItems
                                        .insert(newIndex, movedItem);

                                    _saveCheckList(tab);
                                  });
                                },
                                children: [
                                  for (int index = 0;
                                      index < tab.checkListItems.length;
                                      index++)
                                    Dismissible(
                                      key: ValueKey(tab.checkListItems[index]),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        final removedItem =
                                            tab.checkListItems[index];
                                        tab.checkListItems.removeAt(index);
                                        _saveCheckList(tab);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "${removedItem.text} deleted"),
                                            duration:
                                                const Duration(seconds: 3),
                                          ),
                                        );
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      child: GestureDetector(
                                        onDoubleTap: () {
                                          _editCheckListItem(
                                              tab.checkListItems[index]);
                                        },
                                        child: CustomTopExpansionTile(
                                          key: ValueKey(
                                              tab.checkListItems[index]),
                                          headerBuilder: (context, isExpanded) {
                                            return ContentWidgetHeader(
                                              isExpanded: isExpanded,
                                              title:
                                                  "✅ ${tab.checkListItems[index].text}",
                                              trailing: Checkbox(
                                                value: tab.checkListItems[index]
                                                    .packageList
                                                    .every((package) =>
                                                        package.isChecked),
                                                onChanged: tab
                                                        .checkListItems[index]
                                                        .packageList
                                                        .every((package) =>
                                                            package.isChecked)
                                                    ? (bool? value) {
                                                        setState(() {
                                                          final isChecked =
                                                              value ?? false;
                                                          for (var package in tab
                                                              .checkListItems[
                                                                  index]
                                                              .packageList) {
                                                            package.isChecked =
                                                                isChecked;
                                                          }
                                                          _updateProgress(tab);
                                                        });
                                                      }
                                                    : null,
                                              ),
                                            );
                                          },
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          PaddingDimensions
                                                              .large),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    " 👉${tab.checkListItems[index].description}",
                                                    style: AppTextStyles
                                                        .ralewayFont18Medium(
                                                            context),
                                                  ),
                                                  Text(
                                                    "Common Package:",
                                                    style: AppTextStyles
                                                        .nunitoFont16Bold(
                                                            context),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: tab
                                                        .checkListItems[index]
                                                        .packageList
                                                        .map((package) {
                                                      return CheckboxListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: Text(
                                                          "💡${package.packageName}",
                                                          style: AppTextStyles
                                                              .nunitoFont20Regular(
                                                                  context),
                                                        ),
                                                        value:
                                                            package.isChecked,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            package.isChecked =
                                                                value ?? false;
                                                            final allChecked = tab
                                                                .checkListItems[
                                                                    index]
                                                                .packageList
                                                                .every((p) => p
                                                                    .isChecked);
                                                            final noneChecked = tab
                                                                .checkListItems[
                                                                    index]
                                                                .packageList
                                                                .any((p) => !p
                                                                    .isChecked);

                                                            _saveCheckList(tab);
                                                            if (allChecked ||
                                                                noneChecked) {
                                                              _updateProgress(
                                                                  tab);
                                                            }
                                                          });
                                                        },
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Gap(PaddingDimensions.xxLarge)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
    );
  }
}

class ContentWidgetHeader extends StatelessWidget {
  const ContentWidgetHeader({
    super.key,
    required this.isExpanded,
    required this.title,
    required this.trailing,
  });

  final bool isExpanded;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Row(
            children: [
              Icon(!isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  size: IconDimensions.xSmall),
              const SizedBox(
                width: 6,
              ),
              Text(
                isExpanded ? 'Hide' : title,
                style: AppTextStyles.nunitoFont20Bold(context),
              ),
            ],
          ),
          const Spacer(),
          if (!isExpanded) trailing
        ],
      ),
    );
  }
}
