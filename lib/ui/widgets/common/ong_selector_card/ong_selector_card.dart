import 'package:flutter/material.dart';
import 'package:microdonations/core/models/ong/ong.model.dart';
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
      decoration: const BoxDecoration(
        color: AppTheme.gray400,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              width: 4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                color: AppTheme.tertiaryColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  right: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        ongModel.name,
                        style: AppTheme.bold16_24.copyWith(
                          color: AppTheme.tertiaryColor,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (ongModel.description?.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Descripión: ',
                                      style: AppTheme.bold14_16.copyWith(
                                        color: AppTheme.blackColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ongModel.description,
                                      style: AppTheme.regular14_20.copyWith(
                                        color: AppTheme.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (ongModel.address?.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Dirección: ',
                                      style: AppTheme.bold14_16.copyWith(
                                        color: AppTheme.blackColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ongModel.address,
                                      style: AppTheme.regular14_20.copyWith(
                                        color: AppTheme.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    /// Botones
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: CustomOutlineButton(
                            icon: const Icon(
                              PhosphorIcons.mapPinLineLight,
                              color: AppTheme.tertiaryColor,
                            ),
                            label: 'Ver ubicacion',
                            action: () async {
                              try {
                                await LaunchUrlHelper.openUrl(
                                    ongModel.googleLink!);
                              } catch (e) {
                                MessegeHelper.showErrorSnackBar(
                                  context,
                                  'No se pudo abrir la ubicación. Volvé a intentarlo mas tarde.',
                                );
                              }
                            },
                          ),
                        ),
                        CustomFillButton(
                          label: 'Donar',
                          action: () => viewModel.goToDonate(ongModel),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  OngSelectorCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      OngSelectorCardModel();
}
