import 'package:microdonations/ui/views/home/home_view.dart';
import 'package:microdonations/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:microdonations/ui/views/login/login_view.dart';
import 'package:microdonations/core/services/auth_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
// @stacked-service
  ],
  bottomsheets: [
    // @stacked-bottom-sheet
  ],
  dialogs: [
    // @stacked-dialog
  ],
)
class App {}
