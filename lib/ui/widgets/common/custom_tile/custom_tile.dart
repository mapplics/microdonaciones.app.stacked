import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'custom_tile_model.dart';

class CustomTile extends StackedView<CustomTileModel> {
  final Function action;
  final String label;
  final String svgPath;
  final int count;

  const CustomTile({
    required this.action,
    required this.label,
    required this.svgPath,
    required this.count,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomTileModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => action(),
      splashColor: CustomStylesTheme.primaryColor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 37,
                  width: 37,
                  child: SvgPicture.asset(
                    svgPath,
                  ),
                ),
                (count > 0)
                    ? Positioned(
                        right: -12,
                        top: -8,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: CustomStylesTheme.primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            count.toString(),
                            textAlign: TextAlign.center,
                            style: CustomStylesTheme.regular12_20
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          Text(
            label,
            style: CustomStylesTheme.regular14_20,
          ),
          const Spacer(),
          Icon(
            PhosphorIcons.bold.caretRight,
            size: 14,
          )
        ],
      ),
    );
  }

  @override
  CustomTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTileModel();
}
