import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_outline_button/custom_outline_button.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/custom_fill_button/custom_fill_button.dart';
import '../../widgets/common/custom_tile/custom_tile.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      appbar: const CustomAppbar(title: 'Microdonaciones'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 52.0,
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                  ),
                  child: Image.asset(
                    'assets/icons/Icono_app-05.png',
                    scale: 4.5,
                  ),
                ),
                const Flexible(
                  child: Text(
                    'Aportá tu microdonación y empezamos a generar un cambio',
                    style: AppTheme.regular14_20,
                    overflow: TextOverflow.visible,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),

          /// Boton quiero donar.
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              bottom: 69,
              left: 30,
              right: 30,
            ),
            child: SizedBox(
              width: double.infinity,
              child: CustomFillButton(
                label: 'QUIERO DONAR',
                textStyle: AppTheme.bold14_20.copyWith(
                  color: Colors.white,
                ),
                action: viewModel.startDonation,
              ),
            ),
          ),

          /// Seccion historial donaciones.
          if (viewModel.isUserLogged)
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  CustomTile(
                    label: 'Historial de donaciones',
                    svgPath: PhosphorIcons.listChecks,
                    action: viewModel.goToDonationHistory,
                  ),
                ],
              ),
            ),
          const Spacer(),

          /// Seccion para navegar al about.
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppTheme.tertiaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Conocé más de nuestra\nAsociación Civil',
                          style: AppTheme.bold16_24.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CustomOutlineButton(
                            label: 'MÁS INFORMACIÓN',
                            action: viewModel.navigateToAbout,
                            mainColor: Colors.white,
                            textStyle: AppTheme.regular14_16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
