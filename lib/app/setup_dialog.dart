import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../enums/dialog_type.dart';
import '../ui/smart_widgets/custom_form_dialog/custom_form_dialog_view.dart';
import '../ui/smart_widgets/intolerance_dialog/intolerance_dialog_view.dart';
import '../ui/smart_widgets/meal_type_dialog/meal_type_dialog_view.dart';


void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.form: (context, sheetRequest, completer) =>
        FormDialog(request: sheetRequest, completer: completer),
    DialogType.intolerance: (context, sheetRequest, completer) =>
        IntoleranceDialogView(request: sheetRequest, completer: completer),
    DialogType.recipeMealType: (context, sheetRequest, completer) =>
        MealTypeDialogView(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _BasicDialog({Key? key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container());
  }
}