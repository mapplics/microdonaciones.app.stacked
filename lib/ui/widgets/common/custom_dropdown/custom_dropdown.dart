import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/custom_dropdown_model.abstract.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:stacked/stacked.dart';

import 'custom_dropdown_model.dart';

class CustomDropdown<T> extends StackedView<CustomDropdownModel> {
  final OnChangeDropdownButton onchange;
  final T? initialValue;
  final List<CustomDropdownItems<T>> items;

  const CustomDropdown({
    required this.items,
    required this.onchange,
    this.initialValue,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomDropdownModel viewModel,
    Widget? child,
  ) {
    items.map((e) => logWarn(e.label));
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ), // Define el color del borde
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ), // Define el radio del borde
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          iconEnabledColor: CustomStylesTheme.tertiaryColor,
          onChanged: (T? value) => viewModel.onchangeValue(value),
          dropdownColor: Colors.white,
          menuMaxHeight: 375,
          underline: const SizedBox(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          style: CustomStylesTheme.regular14_20.copyWith(
            color: CustomStylesTheme.tertiaryColor,
          ),
          // items: viewModel.getDropdownItems,
          items: items.map<DropdownMenuItem<T>>(
            (item) {
              return DropdownMenuItem<T>(
                value: item.value,
                child: Text(
                  item.label,
                ),
              );
            },
          ).toList(),
          // selectedItemBuilder: (BuildContext ctx) {
          //   return items.map<Widget>(
          //     (item) {
          //       return DropdownMenuItem(
          //         child: Text(
          //           itemFormatter != null
          //               ? itemFormatter!(item)
          //               : item.toString(),
          //           style: CustomStylesHelper.regular14_16.copyWith(
          //             color: CustomStylesHelper.whiteColor,
          //           ),
          //           maxLines: 1,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //         value: item,
          //       );
          //     },
          //   ).toList();
          // },
        ),
      ),
      // child: DropdownButton<T>(
      //   hint: Text(
      //     'Seleccioná una opción',
      //     style: CustomStylesTheme.regular14_20.copyWith(
      //       color: CustomStylesTheme.lightGreyColor,
      //     ),
      //   ),
      //   items: viewModel.getDropdownItems as List<DropdownMenuItem<T>>,
      //   value: viewModel.selectedValue,
      //   iconEnabledColor: CustomStylesTheme.tertiaryColor,
      //   onChanged: (value) => viewModel.onchangeValue(value),
      //   dropdownColor: Colors.white,
      //   menuMaxHeight: 375,
      //   underline: const SizedBox(),
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   isExpanded: true,
      //   style: CustomStylesTheme.regular14_20.copyWith(
      //     color: CustomStylesTheme.tertiaryColor,
      //   ),
      // ),
    );
  }

  @override
  void onViewModelReady(CustomDropdownModel viewModel) {
    viewModel.loadDropdownItems(items);
    super.onViewModelReady(viewModel);
  }

  @override
  CustomDropdownModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomDropdownModel<T>(
        onchange: onchange,
        initialValue: initialValue,
      );
}
