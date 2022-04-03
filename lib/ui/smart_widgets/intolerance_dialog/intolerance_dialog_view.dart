import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:z_fitness/ui/smart_widgets/intolerance_dialog/intolerance_dialog_view_model.dart';

import '../../shared/ui_helpers.dart';

class IntoleranceDialogView extends StatefulWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const IntoleranceDialogView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  State<IntoleranceDialogView> createState() => _IntoleranceDialogViewState();
}

class _IntoleranceDialogViewState extends State<IntoleranceDialogView> {
  final model = IntoleranceDialogViewModel();

  @override
  void initState() {
    model.getIntolercesSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<IntoleranceDialogViewModel>(
        builder: (context, model, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeightPercentage(context, percentage: 0.8),
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (contex, index) => CheckboxListTile(
                          title: Text(model
                              .intoleranceTypeList![index].intoleranceType!),
                          onChanged: (bool? value) => model
                              .changeValue(model.intoleranceTypeList![index]),
                          value: model.intoleranceTypeList![index].isSelected,
                        ),
                        itemCount: model.intoleranceTypeList != null
                            ? model.intoleranceTypeList!.length
                            : 0,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () => widget. completer!(DialogResponse()),
                              child: const Text('Cancel')),
                          horizontalSpaceSmall,
                          GestureDetector(
                              onTap: () => widget.completer!(DialogResponse(
                                  data: model.intoleranceTypeList)),
                              child: const Text('Save')),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
