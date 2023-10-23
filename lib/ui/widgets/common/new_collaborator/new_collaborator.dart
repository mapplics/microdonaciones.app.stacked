import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import '../custom_outline_button/custom_outline_button.dart';
import 'new_collaborator_model.dart';

class NewCollaborator extends StackedView<NewCollaboratorModel> {
  const NewCollaborator({super.key});

  @override
  Widget builder(
    BuildContext context,
    NewCollaboratorModel viewModel,
    Widget? child,
  ) {
    return Container(
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
                    '¿Queres la app Microdonaciones\npara tu organización?',
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
                      action: () => viewModel.navigateNewCollaborator(context),
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
    );
  }

  @override
  NewCollaboratorModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewCollaboratorModel();
}
