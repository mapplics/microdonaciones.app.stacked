import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/core/models/ong.model.dart';
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

      // await Future.delayed(
      //   const Duration(seconds: 1),
      // );

      // ongs = [
      //   Ong(
      //     id: 1,
      //     name: 'Nombre de ONG 1',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 2,
      //     name: 'Nombre de ONG 2',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 3,
      //     name: 'Nombre de ONG 3',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 3,
      //     name: 'Nombre de ONG 3',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 3,
      //     name: 'Nombre de ONG 3',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 3,
      //     name: 'Nombre de ONG 3',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 3,
      //     name: 'Nombre de ONG 3',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      //   Ong(
      //     id: 3,
      //     name: 'Nombre de ONG 3',
      //     web: '',
      //     mision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     vision:
      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae arcu libero. Orci varius natoque penatibus et magnis dis parturient.',
      //     phone: '',
      //     email: '',
      //     enabled: true,
      //     googleLink: 'https://maps.app.goo.gl/ZXrtKSdB81p4G61J9',
      //   ),
      // ];
    } catch (e) {
      haveError = true;
    } finally {
      isLoading = false;
      rebuildUi();
    }
  }
}
