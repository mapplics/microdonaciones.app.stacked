import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
import 'package:microdonations/services/ong_service.dart';
import 'package:stacked/stacked.dart';

class OngSelectorViewModel extends BaseViewModel {
  final _ongService = locator<OngService>();

  bool isLoading = false;

  bool haveError = false;

  List<Ong> ongs = [];

  /// Recupera las ongs disponibles
  Future<void> getOngs() async {
    try {
      isLoading = true;
      haveError = false;

      rebuildUi();

      ongs = await _ongService.getOngs();
    } catch (e) {
      haveError = true;
    } finally {
      isLoading = false;
      rebuildUi();
    }
  }
}
