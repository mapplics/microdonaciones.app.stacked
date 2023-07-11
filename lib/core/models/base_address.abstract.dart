abstract class BaseAddress {
  String address;
  String? floor;
  String? apartment;
  String? latitude;
  String? longitude;

  BaseAddress({
    required this.address,
    this.floor = '',
    this.apartment = '',
    this.latitude = '',
    this.longitude = '',
  }) : assert(address.isNotEmpty, 'The address should not be empty');
}
