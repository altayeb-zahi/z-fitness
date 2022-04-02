import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
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
            child: _formDialogBody(servingSiseController, _customData, model)),
      ),
    );
  }

  Widget _formDialogBody(TextEditingController? servingSiseController,
      CustomData customData, CustomFormDialogViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          _title(),
          Row(
            children: [
              _numberOfServings(servingSiseController),
              const SizedBox(
                width: 20,
              ),
              _availableMeasures(customData, model),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _servingUnit(model),
          const SizedBox(
            height: 20,
          ),
          _saveAndCancelButtons(servingSiseController, model),
        ],
      ),
    );
  }

  _title() {
    return Text(widget.request!.title!);
  }

  _numberOfServings(TextEditingController? servingSiseController) {
    return SizedBox(
        width: 150,
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
          focusColor: Colors.red,
          hint: const Text('show all measures '),
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
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () => widget.completer!(DialogResponse(
              data: DialogResponseData(
                  numberOfServings: double.parse(servingSiseController!.text),
                  servingWeight: model.servingWight,
                  servingUnit: model.servingUnit.toString()))),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: widget.request!.showIconInMainButton!
                ? const Icon(Icons.check)
                : Text(widget.request!.mainButtonTitle!),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
