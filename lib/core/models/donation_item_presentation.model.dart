import 'package:microdonations/ui/common/helpers/logger.helpers.dart';

class DonationItemPresentation {
  final int id;
  final String text;
  final String urlImg;

  DonationItemPresentation({
    required this.id,
    required this.text,
    required this.urlImg,
  });

  /// Crea una instancia de [DonationItemPresentation]
  static DonationItemPresentation createOne(Map<String, dynamic> data) {
    return DonationItemPresentation(
      id: data['id'],
      text: data['text'],
      urlImg: data['image'],
    );
  }

  /// Crea una lista de [DonationItemPresentation]
  static List<DonationItemPresentation> createList(List<dynamic> data) {
    List<DonationItemPresentation> items = [];

    for (var course in data) {
      try {
        items.add(DonationItemPresentation.createOne(course));
      } catch (e) {
        logError(e);
        continue;
      }
    }

    return items;
  }
}
