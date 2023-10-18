import 'package:flutter/material.dart';
import 'package:microdonations/core/models/ong.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/launcher_url.helpers.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:microdonations/ui/widgets/common/custom_fill_button/custom_fill_button.dart';
import 'package:microdonations/ui/widgets/common/custom_outline_button/custom_outline_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'ong_selector_card_model.dart';

class OngSelectorCard extends StackedView<OngSelectorCardModel> {
  final Ong ongModel;

  const OngSelectorCard({required this.ongModel, super.key});

  @override
  Widget builder(
    BuildContext context,
    OngSelectorCardModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: const BoxDecoration(
        color: AppTheme.gray400,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ongModel.name,
                style: AppTheme.bold16_24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  ongModel.mision,
                  style: AppTheme.regular14_16,
                ),
              ),
            ],
          ),

          /// Botones
          Row(
            children: [
              CustomOutlineButton(
                icon: const Icon(
                  PhosphorIcons.mapPinLineLight,
                  color: AppTheme.tertiaryColor,
                ),
                label: 'Ver ubicacion',
                action: () async {
                  try {
                    await LaunchUrlHelper.openUrl(ongModel.googleLink!);
                  } catch (e) {
                    MessegeHelper.showErrorSnackBar(
                      context,
                      'No se pudo abrir la ubicación. Volvé a intentarlo mas tarde.',
                    );
                  }
                },
              ),
              const Spacer(),
              CustomFillButton(
                label: 'Donar',
                action: () => viewModel.goToDonate(ongModel),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  OngSelectorCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      OngSelectorCardModel();
}
