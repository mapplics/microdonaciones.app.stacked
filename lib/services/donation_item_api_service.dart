// import 'package:microdonations/core/interceptor/dio.interceptor.dart';
import 'package:microdonations/core/models/donation_item.model.dart';

class DonationItemApiService {
  // final _dio = DioClient().dio;
  // final String? _apiUrl = dotenv.env['API_URL'];

  /// Devuelve la lista de items que se puede donar para una ONG
  /// TODO En algun momento este metodo debe recibir el dato de una ONG
  Future<List<DonationItem>> getDonationItems() async {
    return await Future.delayed(const Duration(milliseconds: 500), () {
      return [
        DonationItem(
          title: 'Arroz',
          pathImg: 'assets/img/img_arroz.png',
        ),
        DonationItem(
          title: 'Fideos',
          pathImg: 'assets/img/img_fideos.png',
        ),
        DonationItem(
          title: 'Leche en polvo',
          pathImg: 'assets/img/img_leche_en_polvo.png',
        ),
        DonationItem(
          title: 'Latas en conserva',
          pathImg: 'assets/img/img_latas_de_conserva.png',
        ),
      ];
    });
  }
}
