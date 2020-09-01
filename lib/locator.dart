import 'package:edustar/core/services/auth/auth_service.dart';
import 'package:edustar/core/services/payment/payment_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/data_sources/course_category_data_source.dart';
import 'core/services/dialog/dialog_service.dart';
import 'core/services/http/api_service.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/payment/stripe_payment_service.dart';
import 'core/services/snackbar/snackbar.dart';
import 'core/utils/file_helper.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<SnackBarService>(SnackBarService());

  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<StripePaymentService>(() => StripePaymentService());
  locator.registerLazySingleton<FileHelper>(() => FileHelper());
  locator.registerLazySingleton<HiveInterface>(() => Hive);
  locator.registerLazySingleton<CourseCategoryDataSource>(() => CourseCategoryDataSource());
}
