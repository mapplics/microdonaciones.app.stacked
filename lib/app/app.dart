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
import 'package:microdonations/ui/views/new_donation/new_donation_view.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/services/reception_api_service.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/services/new_donation_api_service.dart';
import 'package:microdonations/ui/views/new_donation_confirmed/new_donation_confirmed_view.dart';
import 'package:microdonations/ui/views/orders_history/orders_history_view.dart';
import 'package:microdonations/services/order_history_service.dart';
import 'package:microdonations/ui/views/order_history_detail/order_history_detail_view.dart';
import 'package:microdonations/services/ong_service.dart';
import 'package:microdonations/ui/views/ong_selector/ong_selector_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: PersonalInformationView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: NewDonationView),
    MaterialRoute(page: NewDonationConfirmedView),
    MaterialRoute(page: OrdersHistoryView),
    MaterialRoute(page: OrderHistoryDetailView),
    MaterialRoute(page: OngSelectorView),
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
    LazySingleton(classType: NewDonationService),
    LazySingleton(classType: DonationItemApiService),
    LazySingleton(classType: ReceptionApiService),
    LazySingleton(classType: NewDonationDataService),
    LazySingleton(classType: NewDonationApiService),
    LazySingleton(classType: OrderHistoryService),
    LazySingleton(classType: OngService),
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
