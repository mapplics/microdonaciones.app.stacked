import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/views/home/home_view.dart';
import 'package:microdonations/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:microdonations/ui/views/login/login_view.dart';
import 'package:microdonations/ui/views/onboarding/onboarding_view.dart';
import 'package:microdonations/ui/views/personal_information/personal_information_view.dart';
import 'package:microdonations/ui/bottom_sheets/test_alert/test_alert_sheet.dart';
import 'package:microdonations/ui/dialogs/test_dialog/test_dialog_dialog.dart';
import 'package:microdonations/ui/views/create_account/create_account_view.dart';
import 'package:microdonations/services/user_api_service.dart';

import '../services/auth_service.dart';
import 'package:microdonations/services/auth_api_service.dart';
import 'package:microdonations/ui/views/make_a_donation/make_a_donation_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: PersonalInformationView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: MakeADonationView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: UserApiService),
    LazySingleton(classType: AuthApiService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: TestAlertSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: TestDialogDialog),
// @stacked-dialog
  ],
)
class App {}
