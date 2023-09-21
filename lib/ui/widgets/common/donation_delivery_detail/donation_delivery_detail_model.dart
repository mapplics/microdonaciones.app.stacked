import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/services/new_donation_service.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class DonationDeliveryDetailModel extends BaseViewModel {
  final _newDonationService = locator<NewDonationService>();

  /// Devuelve la direccion del usuario.
  String get _userAddress {
    return _newDonationService.userAddres?.fullAddress ?? 'Direccion invalida';
  }

  /// Devuelve la dirreccion a donde debe llevar el donante su donacion.
  String get _receptionPointAddress {
    return '${_newDonationService.receptionPoint?.name ?? 'Direccion invalida'} | ${_newDonationService.receptionPoint?.address ?? 'Direccion invalida'}';
  }

  String get deliverDescription {
    if (_newDonationService.deliveryTypeValue == TypeDelivery.delivery) {
      return 'Vamos a retirar tu donación por';
    } else {
      return 'Elegiste llevar tu donación a';
    }
  }

  /// Devuelve la direccion en donde se retira/lleva la donacion.
  String get deliveryAddress {
    if (_newDonationService.deliveryTypeValue == TypeDelivery.delivery) {
      return _userAddress;
    } else {
      return _receptionPointAddress;
    }
  }

  String get deliveryTime {
    if (_newDonationService.deliveryTypeValue == TypeDelivery.delivery) {
      return _newDonationService.pickupPresentation!.label;
    } else {
      return _newDonationService.receptionPoint!.extraInfo;
    }
  }
}
