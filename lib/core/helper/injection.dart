import 'package:checklist_app/core/helper/injection.config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final injector = GetIt.instance;
@module
abstract class InjectableModule {
   @lazySingleton
   FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
@InjectableInit()
Future<void>  configureInjection() async{
   injector.init();
}
