import 'package:url_launcher/url_launcher.dart';

class LaunchUrlHelper {
  /// Abre en el navegador la [url] recibida. Devuelve true si pudo abrirla false si hubo un error.
  /// Usamos la bandera de [isWspLink] para poder enviar una descripcion distinta.
  static Future<void> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      rethrow;
    }
  }
}
