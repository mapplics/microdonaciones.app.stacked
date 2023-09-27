import 'package:microdonations/core/enums/order_state_type.enum.dart';

/// Representa el estado de una donación.

class OrderState {
  final int id;
  final OrderStateType orderStateType;
  final String name;

  OrderState({
    required this.id,
    required this.orderStateType,
    required this.name,
  });

  static OrderState createOne(Map<String, dynamic> data) {
    return OrderState(
      id: data['id'],
      orderStateType: _parseOrderStateType(data['tag']),
      name: data['name'],
    );
  }

  static OrderStateType _parseOrderStateType(String state) {
    switch (state) {
      case 'pending':
        return OrderStateType.pending;
      case 'delivered':
        return OrderStateType.delivered;
      default:
        return OrderStateType.unknow;
    }
  }
}
