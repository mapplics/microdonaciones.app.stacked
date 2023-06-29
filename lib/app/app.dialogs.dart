// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/test_dialog/test_dialog_dialog.dart';

enum DialogType {
  testDialog,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.testDialog: (context, request, completer) =>
        TestDialogDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
