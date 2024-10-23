// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checklist_app/check_list_topic_page/data/repositories/check_list_topic_repository_imp.dart'
    as _i642;
import 'package:checklist_app/check_list_topic_page/domain/repositories/check_list_topic_repository.dart'
    as _i335;
import 'package:checklist_app/check_list_topic_page/domain/use_cases/add_topic_use_case.dart'
    as _i393;
import 'package:checklist_app/check_list_topic_page/domain/use_cases/get_topics_use_case.dart'
    as _i701;
import 'package:checklist_app/check_list_topic_page/domain/use_cases/remove_topic_use_case.dart'
    as _i1014;
import 'package:checklist_app/check_list_topic_page/domain/use_cases/update_check_list_topic_use_case.dart'
    as _i1004;
import 'package:checklist_app/check_list_topic_page/presentation/manager/topics_cubit.dart'
    as _i235;
import 'package:checklist_app/checklist/data/repositories/check_list_repository_impl.dart'
    as _i780;
import 'package:checklist_app/checklist/domain/repositories/check_list_repository.dart'
    as _i956;
import 'package:checklist_app/checklist/domain/use_cases/add_%20check_list_item_use_case.dart'
    as _i1007;
import 'package:checklist_app/checklist/domain/use_cases/get_%20check_list_items_use_case.dart'
    as _i670;
import 'package:checklist_app/checklist/domain/use_cases/remove_check_list_item_use_case.dart'
    as _i518;
import 'package:checklist_app/checklist/presentation/manager/checklist_cubit.dart'
    as _i348;
import 'package:checklist_app/core/helper/injection.dart' as _i333;
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
    gh.factory<_i348.ChecklistCubit>(() => _i348.ChecklistCubit());
    gh.factory<_i235.TopicsCubit>(() => _i235.TopicsCubit());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => injectableModule.firestore);
    gh.factory<_i956.ChecklistRepository>(() => _i780.ChecklistRepositoryImpl(
        firestore: gh<_i974.FirebaseFirestore>()));
    gh.factory<_i335.CheckListTopicRepository>(() =>
        _i642.CheckListTopicRepositoryImp(
            firestore: gh<_i974.FirebaseFirestore>()));
    gh.factory<_i670.GetChecklistItemsUseCase>(
        () => _i670.GetChecklistItemsUseCase(gh<_i956.ChecklistRepository>()));
    gh.factory<_i518.RemoveChecklistItemUseCase>(() =>
        _i518.RemoveChecklistItemUseCase(gh<_i956.ChecklistRepository>()));
    gh.factory<_i1007.AddChecklistItemUseCase>(
        () => _i1007.AddChecklistItemUseCase(gh<_i956.ChecklistRepository>()));
    gh.factory<_i393.AddCheckListTopicUseCase>(() =>
        _i393.AddCheckListTopicUseCase(gh<_i335.CheckListTopicRepository>()));
    gh.factory<_i1014.RemoveCheckListTopicUseCase>(() =>
        _i1014.RemoveCheckListTopicUseCase(
            gh<_i335.CheckListTopicRepository>()));
    gh.factory<_i701.GetCheckListTopicsUseCase>(() =>
        _i701.GetCheckListTopicsUseCase(gh<_i335.CheckListTopicRepository>()));
    gh.factory<_i1004.UpdateCheckListTopicUseCase>(() =>
        _i1004.UpdateCheckListTopicUseCase(
            gh<_i335.CheckListTopicRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i333.InjectableModule {}
