import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/ui/shared/ui_helpers.dart';
import 'package:z_fitness/ui/smart_widgets/custom_form_dialog/custom_form_dialog_view_model.dart';

import '../../../models/food_models/food_details.dart';
import '../../../models/food_models/food_details_dialog_custom_data.dart';
import '../../../models/food_models/food_details_dialog_response.dart';

class FormDialog extends StatefulWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const FormDialog({Key? key, this.request, this.completer}) : super(key: key);

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final model = CustomFormDialogViewModel();

  @override
  void initState() {
    model.initialiseValues(widget.request!.data as CustomData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _customData = widget.request!.data as CustomData;
    final TextEditingController? servingSiseController =
        TextEditingController(text: _customData.numberOfServing.toString());

    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<CustomFormDialogViewModel>(
        builder: (context, model, child) => Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: _formDialogBody(servingSiseController, _customData, model)),
      ),
    );
  }

  Widget _formDialogBody(TextEditingController? servingSiseController,
      CustomData customData, CustomFormDialogViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          Row(
            children: [
              _numberOfServings(servingSiseController),
              horizontalSpaceRegular,
              _availableMeasures(customData, model),
            ],
          ),
          verticalSpaceRegular,
          _servingUnit(model),
          verticalSpaceRegular,
          _saveAndCancelButtons(servingSiseController, model),
        ],
      ),
    );
  }

  _title() {
    return Text(widget.request!.title!,
        style: Theme.of(context).textTheme.titleMedium);
  }

  _numberOfServings(TextEditingController? servingSiseController) {
    return SizedBox(
        width: 60,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: servingSiseController,
          decoration: const InputDecoration(),
        ));
  }

  _availableMeasures(CustomData customData, CustomFormDialogViewModel model) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: DropdownButton(
          hint: const Text('Servin(s)'),
          isExpanded: true,
          items: customData.allMeasures == null
              ? []
              : customData.allMeasures!
                  .map((e) => DropdownMenuItem(
                        onTap: () {},
                        value: e,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(e.qty.toString()),
                            const SizedBox(width: 5),
                            Text(
                              '${e.measure}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
          onChanged: (dynamic value) {
            var measure = value as AltMeasure;

            model.setValues(measure);
          },
        ),
      ),
    );
  }

  _servingUnit(CustomFormDialogViewModel model) {
    return Text(model.servingQty.toString() + ' ' + model.servingUnit!);
  }

  _saveAndCancelButtons(TextEditingController? servingSiseController,
      CustomFormDialogViewModel model) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => widget.completer!(DialogResponse()),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: widget.request!.showIconInAdditionalButton!
                ? const Icon(Icons.check)
                : Text(widget.request!.additionalButtonTitle!),
            decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        horizontalSpaceSmall,
        GestureDetector(
          onTap: () => widget.completer!(DialogResponse(
              data: DialogResponseData(
                  numberOfServings: double.parse(servingSiseController!.text),
                  servingWeight: model.servingWight,
                  servingUnit: model.servingUnit.toString()))),
          child: widget.request!.showIconInMainButton!
              ? const Icon(Icons.check)
              : Text(
                  widget.request!.mainButtonTitle!,
                  style: theme.textTheme.bodyText2!
                      .copyWith(color: theme.colorScheme.primary),
                ),
        ),
      ],
    );
  }
}
