import 'package:flutter/material.dart';
import 'package:microdonations/core/enums/order_state_type.enum.dart';
import 'package:microdonations/ui/common/app_theme.dart';

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
      case 'completed':
        return OrderStateType.completed;
      case 'cancelled':
        return OrderStateType.cancelled;
      default:
        return OrderStateType.unknow;
    }
  }

  /// Devuelve un color segun el [OrderStateType]
  Color get getStatusColor {
    switch (orderStateType.name) {
      case 'pending':
        return CustomStylesTheme.warningColor;
      case 'completed':
        return CustomStylesTheme.sucessColor;
      case 'cancelled':
        return CustomStylesTheme.errorColor;
      default:
        return CustomStylesTheme.gray400;
    }
  }
}
