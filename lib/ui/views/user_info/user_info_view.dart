import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/smart_widgets/activity_level_selector/activity_level_selector_view.dart';
import 'package:z_fitness/ui/smart_widgets/birthday_selector/birthday_selector_view.dart';
import 'package:z_fitness/ui/smart_widgets/gender_selector/gender_selector_view.dart';
import 'package:z_fitness/ui/smart_widgets/height_selector/height_selector_view.dart';
import 'package:z_fitness/ui/smart_widgets/weight_selector/weight_selector_view.dart';
import 'package:z_fitness/ui/views/user_info/user_info_view_model.dart';
import '../../shared/ui_helpers.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  final model = UserInfoViewModel();

  @override
  void initState() {
    model.onModelReady();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
          body: SafeArea(
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // uper part
              SizedBox(
                height: screenHeightPercentage(context, percentage: 0.5),
                width: screenWidth(context),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: 0.7),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: GenderSelector(
                                    onMaleSelected: () =>
                                        model.setGender('male'),
                                    onFemaleSelected: () =>
                                        model.setGender('female'),
                                  )),
                                  Expanded(
                                      child: BirthdaySelector(
                                    onBirthdaySelected: (dateOfBirth) =>
                                        model.setDateOfBirth(dateOfBirth),
                                  ))
                                ],
                              )),

                          // current and desired weight
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  // current weight
                                  Expanded(
                                      child: WeightSelector(
                                    onWeightChange: (weight) =>
                                        model.setCurrentWeightValue(weight!),
                                    title: 'Current Weight',
                                    initialWeight:
                                        model.currentUser!.currentWeight,
                                  )),

                                  // desired weight
                                  Expanded(
                                      child: WeightSelector(
                                    onWeightChange: (weight) =>
                                        model.setDesiredWeightValue(weight!),
                                    title: 'Desired Weight',
                                    initialWeight:
                                        model.currentUser!.desiredWeight,
                                  ))
                                ],
                              )),
                        ],
                      ),
                    ),

                    // height
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: 0.3),
                      child: HeightSelector(
                        onHeightChange: (height) => model.setHeight(height!),
                      ),
                    ),
                  ],
                ),
              ),

              // down part
              Expanded(
                  child: Column(
                children: [
                  // Activity level
                  Expanded(
                      flex: 6,
                      child: ActivityLevelSelector(
                        onActivityLevelChange: (activityLevel) =>
                            model.setActitvityLevel(activityLevel!),
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () => model.onSaveButtonTaped(),
                          child: Consumer<UserInfoViewModel>(
                              builder: (context, model, child) =>
                                  _saveButton(model))))
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }

  Widget _saveButton(UserInfoViewModel model) => Container(
        width: double.infinity,
        height: 60,
        alignment: Alignment.center,
        color: (model.dateOfBirth != null && model.selectedGender != null)
            ? Colors.purple
            : Colors.grey,
        child: model.isBusy
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text('Save', style: TextStyle(color: Colors.white)),
      );
}
