import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/range_time.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/custom_dropdown/custom_dropdown.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectDeliveryMethodViewModel extends ReactiveViewModel {
  final _newDonationService = locator<NewDonationService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  /// Indica si hubo un error al cargar los puntos de entrega.
  bool _isLoading = false;

  /// Devuelve true si se estan recuperando los puntos de entrega.
  bool get isLoading => _isLoading;

  /// Indica si hubo un error al cargar los puntos de entrega.
  bool _haveError = false;

  /// Devuelve true si hubo un error al recuperar los puntos de entrega.
  bool get haveError => _haveError;

  /// Devuelve los puntos de entrega de la ong seleccionada.
  List<ReceptionPoint> get receptionPoints =>
      _newDonationService.receptionPoints;

  /// Devuelve los horarios de retiro de la ong.
  List<PickupWeekDayRange> get pickupRange => _newDonationService.pickupRange;

  TypeDelivery get typeDeliverySelected =>
      _newDonationService.selectedTypeDelivery;

  UserAddress get userAddress => _userService.loggedUser!.address;

  /// Devuelve true si el tipo de delivery [TypeDelivery] seleccionado
  /// es a domicilio.
  bool get isHomeDelivery =>
      _newDonationService.selectedTypeDelivery == TypeDelivery.home;

  /// Actualiza el tipo de delivery de la donacion.
  void onChangeTypeDelivery(TypeDelivery type) {
    _newDonationService.updateTypeDelivery(type);
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

  List<CustomDropdownItems> get getPickupOptions {
    List<CustomDropdownItems> items = [];

    _newDonationService.pickupRange.forEach((element) {
      final times = element.timeByWeek();

      times.forEach((label) {
        items.add(
          CustomDropdownItems<RangeTime>(label: label, value: element.range[0]),
        );
      });
    });

    return [];
  }

  Future<void> loadOngData() async {
    try {
      _isLoading = true;
      _haveError = false;

      rebuildUi();

      /// Recupero los puntos de entrega de donaciones
      /// y recupero los horarios de busqueda de donaciones de la ong.
      await Future.wait([
        _newDonationService.getReceptionPoints(),
        _newDonationService.getPickupWeekdayTimeRange(),
      ]);
    } catch (e) {
      _haveError = true;
      logError('LoadOngData failed!');
    } finally {
      _isLoading = false;
      rebuildUi();
    }
  }
}
