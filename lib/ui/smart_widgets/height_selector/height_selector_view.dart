import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/smart_widgets/height_selector/height_selector_view_model.dart';

import '../../shared/ui_helpers.dart';

class HeightSelector extends StatelessWidget {
  final void Function(int? height) onHeightChange;

  const HeightSelector({Key? key, required this.onHeightChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = HeightSelectorViewModel();

    return ChangeNotifierProvider(
        create: (context) => model,
        child: Consumer<HeightSelectorViewModel>(
            builder: (context, value, child) => Card(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Height'),
                            horizontalSpaceSmall,
                            Text(
                              model.height.round().toString(),
                            ),
                            const Text(' cm'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              activeColor: Colors.pink,
                              inactiveColor: Colors.grey,
                              value: model.height.toDouble(),
                              onChanged: (height) {
                                model.setHeight(height);
                                onHeightChange(model.height.toInt());
                              },
                              max: 250,
                              min: 60,
                            )),
                      )
                    ],
                  ),
                )));
  }
}
