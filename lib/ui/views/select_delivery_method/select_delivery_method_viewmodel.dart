import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/models/user_address.model.dart';
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
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
  bool _loadingReceptionPoints = false;

  /// Devuelve true si se estan recuperando los puntos de entrega.
  bool get loadingReceptionPoints => _loadingReceptionPoints;

  /// Indica si hubo un error al cargar los puntos de entrega.
  bool _errorReceptionPoints = false;

  /// Devuelve true si hubo un error al recuperar los puntos de entrega.
  bool get errorReceptionPoints => _errorReceptionPoints;

  /// Devuelve los puntos de entrega de la ong seleccionada.
  List<ReceptionPoint> get receptionPoints =>
      _newDonationService.receptionPoints;

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

  /// Carga los puntos de entrega de la ong seleccionada.
  Future<void> loadReceptionPoints() async {
    try {
      logWarn('Cargando puntos');
      _loadingReceptionPoints = true;
      _errorReceptionPoints = false;

      rebuildUi();

      await _newDonationService.getReceptionPoints();
    } catch (e) {
      _errorReceptionPoints = true;
    } finally {
      _loadingReceptionPoints = false;
      rebuildUi();
    }
  }
}
