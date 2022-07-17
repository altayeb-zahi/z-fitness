import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/smart_widgets/height_selector/height_selector_view_model.dart';

class HeightSelector extends StatelessWidget {
  final void Function(int? height) onHeightChange;

  const HeightSelector({Key? key, required this.onHeightChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = HeightSelectorViewModel();
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
        create: (context) => model,
        child: Consumer<HeightSelectorViewModel>(
            builder: (context, value, child) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.height.round().toString(),
                            ),
                            Text(
                              ' cm',
                              style: theme.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            activeColor: theme.colorScheme.primary,
                            inactiveColor: theme.colorScheme.surfaceVariant,
                            value: model.height.toDouble(),
                            onChanged: (height) {
                              model.setHeight(height);
                              onHeightChange(model.height.toInt());
                            },
                            max: 250,
                            min: 60,
                          )),
                    ),
                    Text(
                      'Height ',
                      style: theme.textTheme.caption,
                    ),
                  ],
                )));
  }
}
