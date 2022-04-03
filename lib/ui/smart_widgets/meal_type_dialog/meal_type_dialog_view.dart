import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:z_fitness/enums/meal_type.dart';
import 'package:z_fitness/ui/smart_widgets/meal_type_dialog/meal_type_dialog_view_model.dart';

class MealTypeDialogView extends StatefulWidget {
   final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const MealTypeDialogView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  State<MealTypeDialogView> createState() => _MealTypeDialogViewState();
}

class _MealTypeDialogViewState extends State<MealTypeDialogView> {
  final model = MealTypeDialogViewModel();
  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<MealTypeDialogViewModel>(
        builder: (context, model, child) => 
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () => widget. completer!(DialogResponse(
                            data:
                                mealTypeToString[model.mealTypeList[index]])),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(mealTypeToString[model.mealTypeList[index]]!),
                            ],
                          ),
                        )),
                    itemCount: 4,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}