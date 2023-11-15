import 'package:flutter/material.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/ui/widgets/common/custom_outline_button/custom_outline_button.dart';
import 'package:microdonations/ui/widgets/forms/custom_checkbox/custom_checkbox.dart';
import 'package:stacked/stacked.dart';
import 'new_donation_shipping_method_model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/new_donation/pickup_appointment_form/pickup_appointment_form.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
import 'package:microdonations/ui/widgets/common/reception_point_list/reception_point_list.dart';

class NewDonationShippingMethod
    extends StackedView<DonationShippingMethodModel> {
  const NewDonationShippingMethod({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationShippingMethodModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      controller: viewModel.scrollController,
      child: Column(
        children: [
          /// Descripcion
          const Padding(
            padding: EdgeInsets.only(bottom: 19.0),
            child: Text(
              'Seleccioná el metodo de entrega que quieras utilizar para tu donación',
              style: AppTheme.regular14_16,
              textAlign: TextAlign.center,
            ),
          ),

          /// Segmented Buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              width: double.infinity,
              child: ShippingSegmentedButtons(
                initialValue: viewModel.typeDeliverySelected,
                onChangeTypeDelivery: viewModel.onChangeTypeDelivery,
                showReceptionPoint: viewModel.receptionPoints.isNotEmpty,
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!viewModel.isDelivery)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Retiramos la donación por tu domicilio',
                          style: AppTheme.bold16_20.copyWith(
                            color: AppTheme.blackColor,
                          ),
                        ),
                      ),
                      Text(
                        'En esta primera etapa solo podremos retirar tu donación si estás dentro de la siguiente zona.',
                        style: AppTheme.regular14_20.copyWith(
                          color: AppTheme.blackColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset(
                          'assets/img/pickup_map.png',
                          scale: 0.1,
                        ),
                      ),
                      CustomCheckbox(
                        label: 'Confirmo que estoy dentro de la zona de retiro',
                        onchange: viewModel.toggleAreaConfirm,
                        initialValue: viewModel.areaConfirm,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: PickupAppointmentForm(
                          onchange: viewModel.updatePickUpAppointmentForm,
                          form: viewModel.pickupAppointmentForm,
                          onFocusChangeAclaraciones:
                              viewModel.onFocusAclaracionesChange,
                        ),
                      ),

                      /// Instrucciones para retiro por domicilio
                      if (viewModel.pickupAppointmentFormValid &&
                          viewModel.isUserLogged)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vamos a retirar tu donación',
                              style: AppTheme.bold16_20.copyWith(
                                color: AppTheme.blackColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 2.0),
                              child: Text(
                                viewModel.deliveryDetail,
                                style: AppTheme.regular14_20.copyWith(
                                  color: AppTheme.blackColor,
                                ),
                              ),
                            ),
                            Text(
                              'Por la dirección ${viewModel.userAddress.fullAddress.capitalize()}',
                              style: AppTheme.regular14_20.copyWith(
                                color: AppTheme.blackColor,
                              ),
                            ),
                            LinkButton(
                              label: 'Cambiar dirección',
                              action: viewModel.navigateToPersonalInformation,
                              buttonStyle: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                  EdgeInsets.all(0),
                                ),
                              ),
                              textStyle: AppTheme.regular14_20.copyWith(
                                color: AppTheme.tertiaryColor,
                              ),
                            ),
                          ],
                        ),

                      if (!viewModel.isUserLogged)
                        Column(
                          children: [
                            Text(
                              'Para poder utilizar este metodo de entrega es necesario que estes logueado',
                              style: AppTheme.regular14_20.copyWith(
                                color: AppTheme.blackColor,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: CustomOutlineButton(
                                label: 'Iniciar Sesion',
                                action: viewModel.navigateToLogin,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 165,
                      ),
                    ],
                  ),
                if (viewModel.isDelivery)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Puntos de entrega para dejar tu donación',
                        style: AppTheme.bold16_20.copyWith(
                          color: AppTheme.blackColor,
                        ),
                      ),
                      ReceptionPointList(
                        receptionPoints: viewModel.receptionPoints,
                        onchange: <ReceptionPoint>(newValue) =>
                            viewModel.updateReceptionPoint(newValue),
                        initialValue: viewModel.receptionPointSelected,
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void onViewModelReady(DonationShippingMethodModel viewModel) {
    viewModel.initUserAddress();
    super.onViewModelReady(viewModel);
  }

  @override
  DonationShippingMethodModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationShippingMethodModel();
}
