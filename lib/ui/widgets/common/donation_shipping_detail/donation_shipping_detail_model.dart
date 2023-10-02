import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/pickup_weekday_range_presentation.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/ui/widgets/new_donation/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

class DonationShippingDetailModel extends BaseViewModel {
  final String? userAddress;
  final ReceptionPoint? receptionPoint;
  final ShippingMethod type;
  final PickupWeekDayRangePresentation? pickupPresentation;

  DonationShippingDetailModel({
    required this.userAddress,
    required this.receptionPoint,
    required this.type,
    required this.pickupPresentation,
  });

  /// Devuelve la dirreccion a donde debe llevar el donante su donacion.
  String get _receptionPointAddress {
    return '${receptionPoint?.name.capitalize() ?? 'Direccion invalida'} | ${receptionPoint?.address.capitalize() ?? 'Direccion invalida'}';
  }

  String get deliverDescription {
    if (type == ShippingMethod.pickup) {
      return 'Vamos a retirar tu donación por';
    } else {
      return 'Elegiste llevar tu donación a';
    }
  }

  /// Devuelve la direccion en donde se retira/lleva la donacion.
  String get deliveryAddress {
    if (type == ShippingMethod.pickup) {
      return userAddress?.capitalize() ?? 'Direccion invalida';
    } else {
      return _receptionPointAddress;
    }
  }

  String get deliveryTime {
    if (type == ShippingMethod.pickup) {
      return pickupPresentation!.label.capitalize();
    } else {
      return receptionPoint!.extraInfo.capitalize();
    }
  }
}
