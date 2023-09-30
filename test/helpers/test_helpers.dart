import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:microdonations/services/user_api_service.dart';
import 'package:microdonations/services/auth_api_service.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/services/reception_api_service.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/services/new_donation_api_service.dart';
import 'package:microdonations/services/order_history_service.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AuthService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AuthApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NewDonationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DonationItemApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ReceptionApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NewDonationDataService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NewDonationApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<OrderHistoryService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterAuthService();
  getAndRegisterUserService();
  getAndRegisterUserApiService();
  getAndRegisterAuthApiService();
  getAndRegisterNewDonationService();
  getAndRegisterDonationItemApiService();
  getAndRegisterReceptionService();
  getAndRegisterReceptionApiService();
  getAndRegisterNewDonationDataService();
  getAndRegisterNewDonationApiService();
  getAndRegisterOrderService();
  getAndRegisterHistoryOrderService();
  getAndRegisterOrderHistoryService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockAuthService getAndRegisterAuthService() {
  _removeRegistrationIfExists<AuthService>();
  final service = MockAuthService();
  locator.registerSingleton<AuthService>(service);
  return service;
}

MockUserService getAndRegisterUserService() {
  _removeRegistrationIfExists<UserService>();
  final service = MockUserService();
  locator.registerSingleton<UserService>(service);
  return service;
}

MockUserApiService getAndRegisterUserApiService() {
  _removeRegistrationIfExists<UserApiService>();
  final service = MockUserApiService();
  locator.registerSingleton<UserApiService>(service);
  return service;
}

MockAuthApiService getAndRegisterAuthApiService() {
  _removeRegistrationIfExists<AuthApiService>();
  final service = MockAuthApiService();
  locator.registerSingleton<AuthApiService>(service);
  return service;
}

MockNewDonationService getAndRegisterNewDonationService() {
  _removeRegistrationIfExists<NewDonationService>();
  final service = MockNewDonationService();
  locator.registerSingleton<NewDonationService>(service);
  return service;
}

MockDonationItemApiService getAndRegisterDonationItemApiService() {
  _removeRegistrationIfExists<DonationItemApiService>();
  final service = MockDonationItemApiService();
  locator.registerSingleton<DonationItemApiService>(service);
  return service;
}

MockReceptionService getAndRegisterReceptionService() {
  _removeRegistrationIfExists<ReceptionService>();
  final service = MockReceptionService();
  locator.registerSingleton<ReceptionService>(service);
  return service;
}

MockReceptionApiService getAndRegisterReceptionApiService() {
  _removeRegistrationIfExists<ReceptionApiService>();
  final service = MockReceptionApiService();
  locator.registerSingleton<ReceptionApiService>(service);
  return service;
}

MockNewDonationDataService getAndRegisterNewDonationDataService() {
  _removeRegistrationIfExists<NewDonationDataService>();
  final service = MockNewDonationDataService();
  locator.registerSingleton<NewDonationDataService>(service);
  return service;
}

MockNewDonationApiService getAndRegisterNewDonationApiService() {
  _removeRegistrationIfExists<NewDonationApiService>();
  final service = MockNewDonationApiService();
  locator.registerSingleton<NewDonationApiService>(service);
  return service;
}

MockOrderService getAndRegisterOrderService() {
  _removeRegistrationIfExists<OrderService>();
  final service = MockOrderService();
  locator.registerSingleton<OrderService>(service);
  return service;
}

MockHistoryOrderService getAndRegisterHistoryOrderService() {
  _removeRegistrationIfExists<HistoryOrderService>();
  final service = MockHistoryOrderService();
  locator.registerSingleton<HistoryOrderService>(service);
  return service;
}

MockOrderHistoryService getAndRegisterOrderHistoryService() {
  _removeRegistrationIfExists<OrderHistoryService>();
  final service = MockOrderHistoryService();
  locator.registerSingleton<OrderHistoryService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
