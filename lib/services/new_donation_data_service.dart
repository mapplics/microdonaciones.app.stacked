import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/core/models/ong/ong_pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/ong/ong_product.model.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/services/donation_item_api_service.dart';
import 'package:microdonations/services/reception_api_service.dart';

import '../app/app.locator.dart';

class NewDonationDataService {
  final _donationItemApi = locator<DonationItemApiService>();
  final _receptionApi = locator<ReceptionApiService>();

  /// La ONG que eligio el usuario para hacer una donacion.
  Ong? _ongSelected;

  /// Setea la ONG [_ongSelected]
  set setOng(Ong ong) => _ongSelected = ong;

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<OngProduct> _products = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<OngProduct> get productsOptions => _products;

  /// Contiene los items que recibe la ONG como donacion
  /// y la persona puede elegir.
  List<OngReceptionPoint> _receptionPoints = [];

  /// Devuelve las opciones que el usuario puede elegir para donar.
  List<OngReceptionPoint> get receptionPoints => _receptionPoints;

  /// Contiene el rango de horarios que puede pasar a buscar las donaciones
  /// la ong [_ongSelected].
  List<OngPickupWeekDayRange> _pickupRange = [];

  /// Devuelve el rango de horarios que puede pasar a buscar las donaciones
  /// la ong [_ongSelected].
  List<OngPickupWeekDayRange> get pickupRange => _pickupRange;

  /// Recupera la lista de items que se pueden seleccionar para donar.
  Future<void> getOngDonationsItems() async {
    try {
      /// Chequeo si tengo que recuperar los items para donar.
      if (_products.isEmpty) {
        _products.addAll(
          await _donationItemApi.getProductsByOng(_ongSelected!),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Recupera la lista de puntos de entrega de la ong seleccionada [_ongSelected]
  Future<void> getReceptionPoints() async {
    try {
      _receptionPoints = await _receptionApi.getReceptionPoints(_ongSelected!);
    } catch (e) {
      rethrow;
    }
  }

  /// Devuelve las opciones de horarios para que le retiren
  /// la donacion al usuario
  Future<void> getPickupWeekdayTimeRange() async {
    try {
      _pickupRange = await _receptionApi.getWeekdayRangeTime(_ongSelected!);
    } catch (e) {
      rethrow;
    }
  }

  /// Resetea todos todos los campos del servicio a su valor inicial.
  void resetNewDonationData() {
    _products = [];
    _receptionPoints = [];
    _pickupRange = [];
    _ongSelected = null;
  }
}
