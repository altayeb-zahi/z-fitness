import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../enums/bottom_sheet_type.dart';
import '../enums/dialog_type.dart';
import '../ui/smart_widgets/custom_form_dialog/custom_form_dialog_view.dart';
import '../ui/smart_widgets/recipes_filters_bottom_sheet/recipes_filters_bottom_sheet_view.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.recipeFilters: (context, sheetRequest, completer) =>
        RecipeBottomSheet(request: sheetRequest, completer: completer),
    DialogType.form: (context, sheetRequest, completer) =>
        FormDialog(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}