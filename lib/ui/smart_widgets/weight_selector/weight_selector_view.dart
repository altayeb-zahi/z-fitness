import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/shared/ui_helpers.dart';

import 'package:z_fitness/ui/smart_widgets/weight_selector/weight_selector_view_model.dart';

class WeightSelector extends StatefulWidget {
  final void Function(int? weight) onWeightChange;
  final String title;
  final int? initialWeight;

  const WeightSelector({
    Key? key,
    required this.onWeightChange,
    required this.title,
    this.initialWeight,
  }) : super(key: key);

  @override
  State<WeightSelector> createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  final model = WeightSelectorViewModel();

  @override
  void initState() {
    if (widget.initialWeight != null) {
      model.setWeightValue(widget.initialWeight!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
        create: (context) => model,
        child: Consumer<WeightSelectorViewModel>(
            builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.weight.toString() + ' kg',
                        ),
                        DropdownButton(
                            focusColor: Colors.transparent,
                            items: model.weightRange
                                .map((weight) => DropdownMenuItem(
                                      onTap: () {},
                                      value: weight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            weight.toString(),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (weight) {
                              model.setWeightValue(weight as int);
                              widget.onWeightChange(model.weight);
                            }),
                      ],
                    ),
                    verticalSpaceTiny,
                    Text(
                      widget.title,
                      style: theme.textTheme.caption,
                    )
                  ],
                )));
  }
}
