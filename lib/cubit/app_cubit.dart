import 'package:checklist_app/cubit/app_state.dart';
import 'package:checklist_app/core/utils/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial());

  int selectedTab = 0;

  void updateSelectedTab(int index) {
    if (selectedTab != index) {
      selectedTab = index;
      emit(state.reduce(updateSelectedTabIndex: Async.success(selectedTab)));
      print('---${state.updateSelectedTabIndex.data}');
    }
  }
}
//TabBarView(
//                       controller: _tabController,
//                       children: tabs.map(
//                         (tab) {
//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: PaddingDimensions.large,
//                                     vertical: PaddingDimensions.large,
//                                   ),
//                                   color: AppColors.mediumGrey.withOpacity(.1),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           tab.tabDescription,
//                                           style:
//                                               AppTextStyles.nunitoFont20Medium(
//                                                   context),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: PaddingDimensions.normal),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "Total Checked: ${getCheckedCount(tab)} / ${tab.checkListItems.length}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: LinearProgressIndicator(
//                                         value: _getProgressPercentage(tab),
//                                         minHeight: 10,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                         width: PaddingDimensions.large),
//                                     Text(
//                                       _getFormattedPercentage(tab),
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                                 const Gap(PaddingDimensions.large),
//                                 BuildReorderableListView(
//                                   tab: tab,
//                                   saveCheckList: _saveCheckList,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ).toList(),
//                     );