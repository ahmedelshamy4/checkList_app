import 'package:checklist_app/check_list_topic_page/presentation/pages/checkList_topic_page.dart';
import 'package:checklist_app/checklist/domain/entities/check_list_item.dart';
import 'package:checklist_app/checklist/presentation/manager/checklist_cubit.dart';
import 'package:checklist_app/checklist/presentation/manager/checklist_state.dart';
import 'package:checklist_app/core/custom_widgets/app_text_field_input.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChecklistApp extends StatelessWidget {
  const ChecklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChecklistCubit()..loadItems(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checklist App'),
        ),
        body: const ChecklistAppBody(),
      ),
    );
  }
}

class ChecklistAppBody extends StatefulWidget {
  const ChecklistAppBody({super.key});

  @override
  State<ChecklistAppBody> createState() => _ChecklistAppBodyState();
}

class _ChecklistAppBodyState extends State<ChecklistAppBody> {
  final TextEditingController _addChecklistTopicController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onSuffixIconPressed() {
    if (_addChecklistTopicController.text.isNotEmpty) {
      context.read<ChecklistCubit>().addChecklistNewItem(
            ChecklistItem(
              id: DateTime.now().toString(),
              name: _addChecklistTopicController.text,
            ),
          );
      _addChecklistTopicController.clear();
    }
  }

  void _onRemoveChecklistTopic(String id) {
    context.read<ChecklistCubit>().removeChecklistItem(id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                controller: _addChecklistTopicController,
                hintText: "Add new checklist topic",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _onSuffixIconPressed,
                ),
              ),
              Expanded(
                child: BlocBuilder<ChecklistCubit, ChecklistState>(
                  builder: (context, state) {
                    if (state.getChecklistItemsState.isFailure) {
                      return Center(
                        child: Text(
                          state.getChecklistItemsState.failure?.errorMessage ??
                              '',
                          style: AppTextStyles.playfairFont24Bold(context),
                        ),
                      );
                    } else if (state.getChecklistItemsState.isSuccess) {
                      final checklist = state.getChecklistItemsState.data;
                      if (checklist != null) {
                        return checklist.isNotEmpty
                            ? ListView.builder(
                                itemCount: checklist.length,
                                itemBuilder: (context, index) {
                                  final checklistItem = checklist[index];
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckListTopicPage(
                                                  checklistItem: checklistItem),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      checklistItem.name,
                                      style: AppTextStyles.playfairFont24Bold(
                                          context),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _onRemoveChecklistTopic(
                                          checklistItem.id),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "No Checklist Items",
                                  style:
                                      AppTextStyles.playfairFont24Bold(context),
                                ),
                              );
                      }
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<ChecklistCubit, ChecklistState>(
          builder: (context, state) {
            if (state.addChecklistItemState.isLoading ||
                state.getChecklistItemsState.isLoading ||
                state.deleteChecklistItemState.isLoading) {
              return Center(
                child: CustomLoader(),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
