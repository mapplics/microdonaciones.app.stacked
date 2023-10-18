import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

enum ShippingMethod {
  delivery,
  pickup,
  unknow,
}

class ShippingSegmentedButtonsModel extends BaseViewModel {
  final OnChangeTypeDelivery onChangeTypeDelivery;
  final ShippingMethod initialValue;
  final bool showReceptionPoint;

  ShippingSegmentedButtonsModel({
    required this.initialValue,
    required this.onChangeTypeDelivery,
    required this.showReceptionPoint,
  }) {
    selectedDelivery = initialValue;

    if (showReceptionPoint) {
      _buttonsOptions.putIfAbsent(
        ShippingMethod.delivery,
        () => 'Punto de entrega',
      );
    }
  }

  late ShippingMethod selectedDelivery;

  final Map<ShippingMethod, String> _buttonsOptions = {
    ShippingMethod.pickup: 'Domicilio',
  };

  /// Recibe un [ShippingMethod] y actualiza el tipo de delivery de la donacion.
  void onChangeSelected(ShippingMethod newValue) {
    selectedDelivery = newValue;
    onChangeTypeDelivery(selectedDelivery);
    rebuildUi();
  }

  Map<ShippingMethod, Widget> buildSegmentedButtons() {
    Map<ShippingMethod, Widget> segmentedButtons = {};

    _buttonsOptions.forEach(
      (shippingType, label) {
        segmentedButtons.putIfAbsent(
          shippingType,
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (ShippingMethod.delivery == shippingType)
                    ? PhosphorIcons.mapPinLineBold
                    : PhosphorIcons.houseLineBold,
                size: 18,
                color: (shippingType == selectedDelivery)
                    ? Colors.white
                    : CustomStylesTheme.blackColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                label,
                style: CustomStylesTheme.bold14_20.copyWith(
                  color: (shippingType == selectedDelivery)
                      ? Colors.white
                      : CustomStylesTheme.blackColor,
                ),
              ),
            ],
          ),
        );
      },
    );

    return segmentedButtons;
  }
}