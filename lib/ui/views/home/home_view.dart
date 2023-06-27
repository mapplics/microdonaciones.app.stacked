import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/custom_fill_button/custom_fill_button.dart';
import '../../widgets/common/custom_tile/custom_tile.dart';
import '../../widgets/common/rounded_body/rounded_body.dart';
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
    List<Widget> _buildTiles() {
      return [
        CustomTile(
          label: 'Historial de donaciones',
          action: () {},
          count: 2,
          svgPath: 'assets/icons/ic_historialdedonaciones.svg',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0),
          child: Divider(
            color: CustomStylesTheme.lightGreyColor.withOpacity(0.34),
          ),
        ),
        CustomTile(
          label: 'Historial de donaciones',
          action: () {},
          count: 2,
          svgPath: 'assets/icons/ic_historialdedonaciones.svg',
        ),
      ];
    }

    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        colors: <Color>[
          CustomStylesTheme.secondaryColor,
          CustomStylesTheme.primaryColor
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      appBar: AppBar(
        title: Text(
          'Microdonaciones',
          style: CustomStylesTheme.bold16_24.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton.filled(
            onPressed: viewModel.logout,
            color: CustomStylesTheme.primaryColor,
            icon: Icon(
              PhosphorIcons.light.signOut,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: RoundedBody(
        widgetContent: Column(
          children: [
            const SizedBox(
              height: 52,
            ),

            /// Svg y descripcion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  width: (MediaQuery.of(context).size.width / 1.6),
                  child: const Text(
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.',
                    style: CustomStylesTheme.regular14_20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),

            /// Boton quiero donar.
            SizedBox(
              width: (MediaQuery.of(context).size.width / 1.5),
              child: CustomFillButton(
                label: 'Quiero Donar',
                textStyle: CustomStylesTheme.bold14_20.copyWith(
                  color: Colors.white,
                ),
                action: () {},
              ),
            ),

            const SizedBox(
              height: 69,
            ),

            /// Seccion notificaciones y historial donaciones.
            if (viewModel.isUserLogged) ..._buildTiles()
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
