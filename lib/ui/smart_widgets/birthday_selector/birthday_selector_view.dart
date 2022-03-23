import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/smart_widgets/birthday_selector/birthday_selector_view_model.dart';
import '../../shared/ui_helpers.dart';

class BirthdaySelector extends StatelessWidget {
  final void Function(String? dateOfBirth) onBirthdaySelected;

  const BirthdaySelector({Key? key, required this.onBirthdaySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = BirthdaySelectorViewModel();

    return ChangeNotifierProvider(
        create: (context) => model,
        child: Consumer<BirthdaySelectorViewModel>(
            builder: (context, value, child) => SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      await model.pickDate(context);
                      onBirthdaySelected(model.dateOfBirth);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cake_outlined,
                          size: 60,
                          color: Colors.pink,
                        ),
                        verticalSpaceRegular,
                        Text(
                          model.dateOfBirth ?? 'pick your birthday',
                        )
                      ],
                    ),
                  ),
                )));
  }
}
