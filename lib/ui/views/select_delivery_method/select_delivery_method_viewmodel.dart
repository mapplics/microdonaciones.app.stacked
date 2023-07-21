import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

enum TypeDelivery {
  home,
  branch,
}

class SelectDeliveryMethodViewModel extends BaseViewModel {
  final Map<TypeDelivery, String> _children = {
    TypeDelivery.home: 'Domicilio',
    TypeDelivery.branch: 'Punto de entrega',
  };

  TypeDelivery _selectedDelivery = TypeDelivery.home;

  TypeDelivery get deliverySelected => _selectedDelivery;

  void onChangeSelected(TypeDelivery newValue) {
    _selectedDelivery = newValue;
    rebuildUi();
  }

  Map<TypeDelivery, Widget> buildSegmentedButtons() {
    Map<TypeDelivery, Widget> segmentedButtons = {};

    _children.forEach(
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
