// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checklist_app/core/helper/injection.dart' as _i333;
import 'package:checklist_app/home/data/repositories/check_list_repository_impl.dart'
    as _i901;
import 'package:checklist_app/home/domain/repositories/check_list_repository.dart'
    as _i944;
import 'package:checklist_app/home/domain/use_cases/add_%20check_list_item_use_case.dart'
    as _i923;
import 'package:checklist_app/home/domain/use_cases/get_%20check_list_items_use_case.dart'
    as _i523;
import 'package:checklist_app/home/domain/use_cases/remove_check_list_item_use_case.dart'
    as _i945;
import 'package:checklist_app/home/domain/use_cases/saving_reorder_checklist_use_case.dart'
    as _i542;
import 'package:checklist_app/home/domain/use_cases/update_check_list_item_use_case.dart'
    as _i302;
import 'package:checklist_app/home/presentation/manager/checklist_cubit.dart'
    as _i987;
import 'package:checklist_app/topic_details_page.dart/data/repositories/topic_details_repository_iimp.dart'
    as _i1015;
import 'package:checklist_app/topic_details_page.dart/domain/repositories/topic_details_repository.dart'
    as _i554;
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/add_details_topic_use_case.dart'
    as _i807;
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/delete_details_topic_use_case.dart'
    as _i227;
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/get_all_details_topic_use_case.dart'
    as _i1038;
import 'package:checklist_app/topic_details_page.dart/domain/use_cases/update_details_topic_use_case.dart'
    as _i225;
import 'package:checklist_app/topic_details_page.dart/presentation/manager/topic_details_cubit.dart'
    as _i712;
import 'package:checklist_app/topic_page/data/repositories/topic_repository_imp.dart'
    as _i207;
import 'package:checklist_app/topic_page/domain/repositories/topic_repository.dart'
    as _i379;
import 'package:checklist_app/topic_page/domain/use_cases/add_topic_use_case.dart'
    as _i778;
import 'package:checklist_app/topic_page/domain/use_cases/get_topics_use_case.dart'
    as _i245;
import 'package:checklist_app/topic_page/domain/use_cases/remove_topic_use_case.dart'
    as _i990;
import 'package:checklist_app/topic_page/domain/use_cases/update_check_list_topic_use_case.dart'
    as _i480;
import 'package:checklist_app/topic_page/presentation/manager/topics_cubit.dart'
    as _i300;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i987.ChecklistCubit>(() => _i987.ChecklistCubit());
    gh.factory<_i712.TopicDetailsCubit>(() => _i712.TopicDetailsCubit());
    gh.factory<_i300.TopicsCubit>(() => _i300.TopicsCubit());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => injectableModule.firestore);
    gh.factory<_i554.TopicDetailsRepository>(
        () => _i1015.TopicDetailsRepositoryImp(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i944.ChecklistRepository>(() => _i901.ChecklistRepositoryImpl(
        firestore: gh<_i974.FirebaseFirestore>()));
    gh.factory<_i227.DeleteTopicUseCase>(
        () => _i227.DeleteTopicUseCase(gh<_i554.TopicDetailsRepository>()));
    gh.factory<_i225.UpdateTopicUseCase>(
        () => _i225.UpdateTopicUseCase(gh<_i554.TopicDetailsRepository>()));
    gh.factory<_i807.AddDetailsTopicUseCase>(
        () => _i807.AddDetailsTopicUseCase(gh<_i554.TopicDetailsRepository>()));
    gh.factory<_i542.SavingReorderChecklistUseCase>(() =>
        _i542.SavingReorderChecklistUseCase(gh<_i944.ChecklistRepository>()));
    gh.factory<_i1038.GetAllDetailsTopicUseCase>(() =>
        _i1038.GetAllDetailsTopicUseCase(gh<_i554.TopicDetailsRepository>()));
    gh.factory<_i379.TopicRepository>(() => _i207.CheckListTopicRepositoryImp(
        firestore: gh<_i974.FirebaseFirestore>()));
    gh.factory<_i302.UpdateChecklistItemUseCase>(() =>
        _i302.UpdateChecklistItemUseCase(gh<_i944.ChecklistRepository>()));
    gh.factory<_i523.GetChecklistItemsUseCase>(
        () => _i523.GetChecklistItemsUseCase(gh<_i944.ChecklistRepository>()));
    gh.factory<_i945.RemoveChecklistItemUseCase>(() =>
        _i945.RemoveChecklistItemUseCase(gh<_i944.ChecklistRepository>()));
    gh.factory<_i923.AddChecklistItemUseCase>(
        () => _i923.AddChecklistItemUseCase(gh<_i944.ChecklistRepository>()));
    gh.factory<_i778.AddCheckListTopicUseCase>(
        () => _i778.AddCheckListTopicUseCase(gh<_i379.TopicRepository>()));
    gh.factory<_i990.RemoveCheckListTopicUseCase>(
        () => _i990.RemoveCheckListTopicUseCase(gh<_i379.TopicRepository>()));
    gh.factory<_i245.GetCheckListTopicsUseCase>(
        () => _i245.GetCheckListTopicsUseCase(gh<_i379.TopicRepository>()));
    gh.factory<_i480.UpdateCheckListTopicUseCase>(
        () => _i480.UpdateCheckListTopicUseCase(gh<_i379.TopicRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i333.InjectableModule {}
