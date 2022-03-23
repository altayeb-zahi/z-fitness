import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/smart_widgets/activity_level_selector/activity_level_selector_view_model.dart';

import '../../shared/ui_helpers.dart';

class ActivityLevelSelector extends StatelessWidget {
  final void Function(String? activityLevel) onActivityLevelChange;

  const ActivityLevelSelector({Key? key, required this.onActivityLevelChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ActivityLevelSelectorViewModel();

    return ChangeNotifierProvider(
        create: (context) => model,
        child: Consumer<ActivityLevelSelectorViewModel>(
            builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text('Activity Level'),
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: model.activityLevels
                                .map((level) => RadioListTile<String>(
                                    dense: true,
                                    title: Text(
                                      level,
                                    ),
                                    value: level,
                                    groupValue: model.activityLevel,
                                    onChanged: (activityLevel) {
                                      model.setActitvityLevel(activityLevel!);
                                      onActivityLevelChange(
                                          model.activityLevel);
                                    }))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                )));
  }
}