import 'package:microdonations/ui/views/home/home_view.dart';
import 'package:microdonations/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:microdonations/ui/views/login/login_view.dart';
import 'package:microdonations/core/services/auth_service.dart';
import 'package:microdonations/ui/views/onboarding/onboarding_view.dart';
import 'package:microdonations/ui/views/personal_information/personal_information_view.dart';
import 'package:microdonations/ui/bottom_sheets/test_alert/test_alert_sheet.dart';
import 'package:microdonations/ui/dialogs/test_dialog/test_dialog_dialog.dart';
import 'package:microdonations/ui/views/create_account/create_account_view.dart';
import 'package:microdonations/core/services/user_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: PersonalInformationView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: CreateAccountView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: UserService),
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
