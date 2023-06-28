import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          svgPath: 'assets/icons/ic_notificaciones.svg',
        ),
      ];
    }

    return CustomScaffold(
      padding: const EdgeInsets.all(0),
      appbar: CustomAppbar(
        title: 'Microdonaciones',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Column(
              children: [
                /// Svg y descripcion
                Padding(
                  padding: const EdgeInsets.only(top: 52.0),
                  child: Row(
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
                ),

                /// Boton quiero donar.
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 69),
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
                if (!viewModel.isUserLogged) ..._buildTiles(),
              ],
            ),
          ),
          const Spacer(),
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

class NewCollaborator extends StatelessWidget {
  const NewCollaborator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: CustomStylesTheme.tertiaryColor,
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
                    '¿Te interesaría colaborar\ncon la logística del proyecto?',
                    style: CustomStylesTheme.bold16_24.copyWith(
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
                      action: () {},
                      mainColor: Colors.white,
                      textStyle: CustomStylesTheme.regular14_16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).size.height / 25),
                  ),
                  child: Text(
                    'Laborum sunt laborum commodo enim. Mollit est amet commodo tempor minim.',
                    style: CustomStylesTheme.regular14_16.copyWith(
                      color: Colors.white.withOpacity(0.52),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
