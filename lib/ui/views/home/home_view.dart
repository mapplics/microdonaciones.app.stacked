import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/custom_fill_button/custom_fill_button.dart';
import '../../widgets/common/custom_tile/custom_tile.dart';
import '../../widgets/common/new_collaborator/new_collaborator.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    /// Construye la seccion historial y notificaciones.
    Widget _buildTiles() {
      return Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          children: [
            CustomTile(
              label: 'Historial de donaciones',
              action: () {},
              count: 2,
              svgPath: 'assets/icons/ic_historialdedonaciones.svg',
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 22.0),
            //   child: Divider(
            //     color: CustomStylesTheme.lightGreyColor.withOpacity(0.34),
            //   ),
            // ),
            // CustomTile(
            //   label: 'Historial de donaciones',
            //   action: () {},
            //   count: 2,
            //   svgPath: 'assets/icons/ic_notificaciones.svg',
            // ),
          ],
        ),
      );
    }

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
                  child: SvgPicture.asset(
                    'assets/logos/ic_logorosa.svg',
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 1.7),
                  child: const Text(
                    'Aporta tu microdonacion y empezamos a generar un cambio',
                    style: CustomStylesTheme.regular14_20,
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
              width: (MediaQuery.of(context).size.width / 1.5),
              child: CustomFillButton(
                label: 'QUIERO DONAR',
                textStyle: CustomStylesTheme.bold14_20.copyWith(
                  color: Colors.white,
                ),
                action: viewModel.startDonation,
              ),
            ),
          ),

          /// Seccion notificaciones y historial donaciones.
          if (viewModel.isUserLogged) _buildTiles(),
          const Spacer(),

          /// Seccion para ser colaborador logistico.
          const NewCollaborator(),
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
