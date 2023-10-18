import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MessegeHelper {
  ///  permite mostrar un alert de información
  ///
  /// recibe un [message] que es texto a mostrar, un [title] por defecto muestro 'Error'
  /// y un texto para el botton [textBtn]
  static showMessegeDialog(BuildContext context, String message,
      {String title = 'Error',
      String textBtnConfirm = 'Aceptar',
      VoidCallback? functionBtn}) async {
    await showDialog(
      barrierDismissible: false,
      barrierColor: AppTheme.blackColor.withOpacity(0.8),
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 0.0,
        backgroundColor: AppTheme.gray400,
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: AppTheme.bold16_24.copyWith(
            color: Colors.white,
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.start,
          style: AppTheme.regular14_24.copyWith(
            color: AppTheme.gray100,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.primaryColor)),
                    onPressed: functionBtn ?? () => Navigator.of(context).pop(),
                    child: Text(
                      textBtnConfirm,
                      style: const TextStyle(
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Future<void> showMessegeConfirmDialog(
    BuildContext context,
    String message, {
    String title = 'Error',
    String? textBtnConfirm,
    String? textBtnCancel,
    required VoidCallback confirmFunction,
    VoidCallback? cancelFunction,
  }) async {
    await showDialog(
      barrierColor: AppTheme.blackColor.withOpacity(0.8),
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        elevation: 0.0,
        backgroundColor: AppTheme.gray400,
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: AppTheme.bold16_24.copyWith(
            color: Colors.white,
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.start,
          style: AppTheme.regular14_24.copyWith(
            color: AppTheme.gray100,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.gray200,
                      ),
                    ),
                    onPressed: cancelFunction ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: Text(
                      textBtnCancel ?? 'Cancelar',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.primaryColor,
                      ),
                    ),
                    onPressed: () => confirmFunction(),
                    child: Text(
                      textBtnConfirm ?? 'Confirmar',
                      style: const TextStyle(
                          color: AppTheme.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// snackbar
  ///
  /// muestra un [message] con un determinado [backgroundColor]
  static void showSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData? icon, {
    double marginBottom = 16.0,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(vertical: 0),
        content: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: backgroundColor,
                  width: 4,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: backgroundColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      message,
                      style: AppTheme.regular12_20.copyWith(
                        color: AppTheme.blackColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: const Icon(
                      PhosphorIcons.xLight, //,
                      color: AppTheme.gray100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: marginBottom, left: 16, right: 16),
        backgroundColor: AppTheme.gray400, // backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        duration: const Duration(milliseconds: 2800),
      ),
    );
  }

  /// Toast de error que muestra un [message]
  static void showErrorSnackBar(
    BuildContext context,
    String message, {
    double marginBottom = 16.0,
  }) {
    showSnackBar(
      context,
      message,
      AppTheme.errorColor,
      PhosphorIcons.warningOctagonBold,
      marginBottom: marginBottom,
    );
  }

  /// Toast de error que muestra un [message]
  static void showInfoSnackBar(
    BuildContext context,
    String message, {
    double marginBottom = 16.0,
  }) {
    showSnackBar(
      context,
      message,
      AppTheme.secondaryColor,
      PhosphorIcons.infoBold,
      marginBottom: marginBottom,
    );
  }

  /// Toast de exito que muestra un [message]
  static void showSuccessSnackBar(
    BuildContext context,
    String message, {
    double marginBottom = 16.0,
  }) {
    showSnackBar(
      context,
      message,
      AppTheme.sucessColor,
      PhosphorIcons.checkCircleBold,
      marginBottom: marginBottom,
    );
  }
}
