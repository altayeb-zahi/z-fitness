import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/smart_widgets/gender_selector/gender_selector_view_model.dart';
import '../../shared/ui_helpers.dart';

class GenderSelector extends StatefulWidget {
  final void Function()? onFemaleSelected;
  final void Function()? onMaleSelected;
  const GenderSelector({Key? key, this.onFemaleSelected, this.onMaleSelected})
      : super(key: key);

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  final model = GenderSelectorViewModel();
  @override
  void initState() {
    model.onModelReady();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (context) => model,
      child: Consumer<GenderSelectorViewModel>(
          builder: (context, value, child) => Row(
                children: [
                  // male
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          model.onMaleSelected();
                          if (widget.onMaleSelected != null) {
                            widget.onMaleSelected!();
                          }
                        },
                        child: _genderLayout(
                            title: 'Male',
                            icon: Icons.male,
                            isSelected: model.maleIsSelected)),
                  ),

                  // female
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          model.onFemaleSelected();
                          if (widget.onFemaleSelected != null) {
                            widget.onFemaleSelected!();
                          }
                        },
                        child: _genderLayout(
                            title: 'Female',
                            icon: Icons.female,
                            isSelected: model.femaleIsSelected)),
                  ),
                ],
              )),
    );
  }

  Widget _genderLayout(
      {required String title,
      required IconData icon,
      required bool isSelected}) {
    final theme = Theme.of(context);

    return Card(
        color:
            isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
        child: Container(
          width: screenWidthPercentage(context, percentage: 0.7 / 2.1),
          alignment: Alignment.center,
          // margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                size: 40,
              ),
              verticalSpaceSmall,
              Text(
                title,
                style: theme.textTheme.bodyText2!.copyWith(
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface),
              )
            ],
          ),
        ));
  }
}
