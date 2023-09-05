// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/auth_api_service.dart';
import '../services/auth_service.dart';
import '../services/donation_item_api_service.dart';
import '../services/new_donation_api_service.dart';
import '../services/new_donation_data_service.dart';
import '../services/new_donation_service.dart';
import '../services/reception_api_service.dart';
import '../services/user_api_service.dart';
import '../services/user_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => UserApiService());
  locator.registerLazySingleton(() => AuthApiService());
  locator.registerLazySingleton(() => NewDonationService());
  locator.registerLazySingleton(() => DonationItemApiService());
  locator.registerLazySingleton(() => ReceptionApiService());
  locator.registerLazySingleton(() => NewDonationDataService());
  locator.registerLazySingleton(() => NewDonationApiService());
}
