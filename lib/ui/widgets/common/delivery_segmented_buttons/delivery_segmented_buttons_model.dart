import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

enum TypeDelivery {
  home,
  branch,
}

class DeliverySegmentedButtonsModel extends BaseViewModel {
  final OnChangeTypeDelivery onChangeTypeDelivery;
  final TypeDelivery initialValue;

  DeliverySegmentedButtonsModel(this.initialValue, this.onChangeTypeDelivery) {
    _selectedDelivery = initialValue;
  }

  late TypeDelivery _selectedDelivery;

  final Map<TypeDelivery, String> _buttonsOptions = {
    TypeDelivery.home: 'Domicilio',
    TypeDelivery.branch: 'Punto de entrega',
  };

  /// Devuelve el tipo de delivery seleccionado [_selectedDelivery]
  TypeDelivery get deliverySelected => _selectedDelivery;

  /// Recibe un [TypeDelivery] y actualiza el tipo de delivery de la donacion.
  void onChangeSelected(TypeDelivery newValue) {
    _selectedDelivery = newValue;
    onChangeTypeDelivery(_selectedDelivery);
    rebuildUi();
  }

  Map<TypeDelivery, Widget> buildSegmentedButtons() {
    Map<TypeDelivery, Widget> segmentedButtons = {};

    _buttonsOptions.forEach(
      (key, value) {
        segmentedButtons.putIfAbsent(
          key,
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (TypeDelivery.home == key)
                    ? PhosphorIcons.bold.houseLine
                    : PhosphorIcons.bold.mapPinLine,
                size: 18,
                color: (key == _selectedDelivery)
                    ? Colors.white
                    : CustomStylesTheme.blackColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                value,
                style: CustomStylesTheme.bold14_20.copyWith(
                  color: (key == _selectedDelivery)
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
