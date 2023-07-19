class Ong {
  final int id;
  final String name;
  final String web;
  final String mision;
  final String vision;
  final String phone;
  final String email;
  final bool enabled;

  Ong({
    required this.id,
    required this.name,
    required this.web,
    required this.mision,
    required this.vision,
    required this.phone,
    required this.email,
    required this.enabled,
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
      enabled: (data['enabled'] == 1) ? true : false,
    );
  }
}
