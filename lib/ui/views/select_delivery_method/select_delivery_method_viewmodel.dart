import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/models/pickup_dropdown_value.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/new_donation_data_service.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectDeliveryMethodViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _newDonationDataService = locator<NewDonationDataService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  /// Devuelve los puntos de entrega de la ong seleccionada.
  List<ReceptionPoint> get receptionPoints =>
      _newDonationDataService.receptionPoints;

  /// Devuelve los horarios de retiro de la ong.
  List<PickupWeekDayRange> get pickupRange =>
      _newDonationDataService.pickupRange;

  TypeDelivery get typeDeliverySelected =>
      _newDonationService.selectedTypeDelivery;

  UserAddress get userAddress => _userService.loggedUser!.address;

  /// Devuelve true si el tipo de delivery [TypeDelivery] seleccionado
  /// es a domicilio.
  bool get isHomeDelivery =>
      _newDonationService.selectedTypeDelivery == TypeDelivery.delivery;

  /// Actualiza el tipo de delivery de la donacion.
  void onChangeTypeDelivery(TypeDelivery type) {
    _newDonationService.updateTypeDelivery(type);

    if (TypeDelivery.delivery == type) {
      _newDonationService.resetReceptionPoint();
      _newDonationService.updateUserAddres(_userService.loggedUser!.address);
    } else {
      _newDonationService.resetPickupValue();
      _newDonationService.resetUserAddres();
      _newDonationService.updateReceptionPoint(
        _newDonationDataService.receptionPoints.first,
      );
    }

    rebuildUi();
  }

  /// Navega a la pantalla para editar los datos del usuario.
  void navigateToPersonalInformation() {
    _navigationService.navigateToPersonalInformationView(
      viewParameters: UserInformationFormParameters(
        user: _userService.loggedUser!,
      ),
    );
  }

  List<CustomDropdownItems<PickupDropdownValue>> get getPickupOptions {
    List<CustomDropdownItems<PickupDropdownValue>> items = [];

    _newDonationDataService.pickupRange.forEach((element) {
      items.addAll(element.prepareForDropdown());
    });

    return items;
  }

  ///
  void setPickupRange<T>(T value) {
    final pickupValue = value as PickupDropdownValue;
    _newDonationService.updatePickupValue(pickupValue);
  }

  PickupDropdownValue? getPickupValue() {
    return _newDonationService.pickupValue;
  }
}
