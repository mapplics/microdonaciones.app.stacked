/// Representa una ONG a la que se le puede donar.
class Ong {
  final int id;
  final String name;
  final String web;
  final String mision;
  final String vision;
  final String phone;
  final String email;
  final String? description;
  final String? googleLink;
  final bool enabled;

  Ong({
    required this.id,
    required this.name,
    required this.web,
    required this.mision,
    required this.vision,
    required this.phone,
    required this.email,
    required this.description,
    required this.enabled,
    this.googleLink,
  });

  /// Crea una instancia de [Ong]
  static Ong createOne(Map<String, dynamic> data) {
    return Ong(
      id: data['id'],
      name: data['name'],
      web: data['web'],
      mision: data['mision'],
      vision: data['vision'],
      phone: data['phone'],
      email: data['email'],
      description: data['description'],
      googleLink: data['googleLink'],
      enabled: (data['enabled'] == 1) ? true : false,
    );
  }

  /// Devuelve una lista de ongs
  static List<Ong> createArray(List<dynamic> data) {
    final List<Ong> items = [];

    for (var item in data) {
      try {
        items.add(
          Ong.createOne(item),
        );
      } catch (e) {
        continue;
      }
    }

    return items;
  }
}
