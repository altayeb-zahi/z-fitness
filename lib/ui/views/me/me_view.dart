import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

import 'package:z_fitness/ui/views/me/me_view_model.dart';

import '../../shared/ui_helpers.dart';

class MeView extends StatefulWidget {
  const MeView({Key? key}) : super(key: key);

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  final model = MeViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<DocumentSnapshot>(
        stream: model.getCurrentUSerStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeightPercentage(context, percentage: 0.4),
                  width: double.infinity,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 40,
                        child: Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: () => model.logout(),
                              child: Icon(
                                Icons.more_vert,
                                color: theme.colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle),
                          child: Icon(Icons.person,
                              size: 40, color: theme.colorScheme.onPrimary)),
                      verticalSpaceTiny,
                      Text(
                          snapshot.data!['name'] ??
                              model.userNameFromGoogleSign,
                          style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary)),
                      verticalSpaceSmall,
                      GestureDetector(
                        onTap: () => model.navigateToEditGoal(),
                        child: Text('Edit',
                            style: theme.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurfaceVariant)),
                      ),
                      verticalSpaceMedium,
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        model.getAge(
                                            snapshot.data!['dateOfBirth']),
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                                fontWeight: FontWeight.bold)),
                                    verticalSpaceSmall,
                                    Text('Age',
                                        style: theme.textTheme.caption!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: theme.colorScheme.onSurfaceVariant
                                  .withOpacity(0.5),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        snapshot.data!['currentWeight']
                                                .toString() +
                                            ' kg',
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                                fontWeight: FontWeight.bold)),
                                    verticalSpaceTiny,
                                    Text('Weight',
                                        style: theme.textTheme.caption!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: theme.colorScheme.onSurfaceVariant
                                  .withOpacity(0.3),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        snapshot.data!['height'].toString() +
                                            ' cm',
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                                fontWeight: FontWeight.bold)),
                                    verticalSpaceTiny,
                                    Text('Height',
                                        style: theme.textTheme.caption!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ###################################################################

                verticalSpaceRegular,

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Row(
                    children: [
                      Text('Overview',
                          style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),
                          style: theme.textTheme.titleSmall!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                verticalSpaceRegular,

                // ###################################################################

                Column(
                  children: [
                    _OverviewItem(
                        title: snapshot.data!['desiredWeight'].toString(),
                        subtitle: 'Desired weight',
                        iconData: UniconsLine.weight),
                    _OverviewItem(
                        title: snapshot.data!['activityLevel'],
                        subtitle: 'Activity level',
                        iconData: Icons.directions_run_outlined),
                    _OverviewItem(
                        title: snapshot.data!['dailyCaloriesGoal']
                            .round()
                            .toString(),
                        subtitle: 'Daily Calories needed',
                        iconData: Icons.dining_outlined),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class _OverviewItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  const _OverviewItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalViewPading),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold)),
                      verticalSpaceTiny,
                      Text(
                        subtitle,
                        style: theme.textTheme.caption!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  )),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child:
                    Icon(iconData, size: 30, color: theme.colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
