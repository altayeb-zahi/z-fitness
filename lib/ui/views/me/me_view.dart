import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:z_fitness/ui/shared/app_colors.dart';
import 'package:z_fitness/ui/views/me/me_view_model.dart';

import '../../shared/ui_helpers.dart';

class MeView extends StatefulWidget {
  const MeView({Key? key}) : super(key: key);

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  final model = MeViewModel();
  final Color headerColor = kcPrimaryColor;

  @override
  void initState() {
    model.initialiseUserInfo();
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

          return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                   decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: kcPrimaryColor,
                offset: Offset(0, 5.0),
               
              )
            ]),
                  child: AppBar(
                    backgroundColor: kcPrimaryColor,
                    actions: [
                      TextButton(
                        onPressed: () => model.navigateToEditGoal(),
                        child: Text(
                          'Edit',
                          style: theme.textTheme.headline3!.copyWith(color: kcScafoldBackgroundColor)
                             ,
                        ),
                      ),
                      horizontalSpaceMedium
                    ],
                    centerTitle: true,
                    elevation: 0,
                  ),
                ),
              ),
              body: Container(
                color: headerColor,
                child: Column(
                  children: [
                    Container(
                        width: 110,
                        height: 110,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: kcBackgroundColor, shape: BoxShape.circle),
                        child: Icon(Icons.person,
                            size: 60, color: Colors.grey[400])),
                    Text(
                      model.currentUser.name ?? model.userNameFromGoogleSign,
                      style: theme.textTheme.headline3!.copyWith(color: kcScafoldBackgroundColor),
                    ),
                    verticalSpaceMedium,
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            color: kcBackgroundColor,
                          ),
                          Container(
                            height: 50,
                            decoration:  BoxDecoration(
                                color: headerColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(60))),
                          ),
                          Positioned(
                            top: 110,
                            child: Container(
                              color: kcBackgroundColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var info = model.info[index];
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 80,
                                    width: 200,
                                    color: kcScafoldBackgroundColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              height: 70,
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(info.subtitle,
                                                      style: theme.textTheme
                                                          .headline4),
                                                  verticalSpaceTiny,
                                                  Text(
                                                    info.title,
                                                    style: theme
                                                        .textTheme.caption,
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                            child: Container(),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Icon(info.icon,
                                                size: 30,
                                                color: kcPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 4,
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 30),
                            color: kcScafoldBackgroundColor,
                            height: 90.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(27.toString(),
                                            style: theme.textTheme.headline4!
                                               ),
                                        verticalSpaceTiny,
                                        Text(
                                          'Age',
                                          style: theme.textTheme.caption!
                                              ,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 2,
                                  color: kcSecondaryColor,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            model.currentUser.currentWeight
                                                    .toString() +
                                                ' kg',
                                            style: theme.textTheme.headline4!
                                                ),
                                        verticalSpaceTiny,
                                        Text(
                                          'Weight',
                                          style: theme.textTheme.caption
                                             ,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 2,
                                  color: kcSecondaryColor,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            model.currentUser.height
                                                    .toString() +
                                                ' cm',
                                            style: theme.textTheme.headline4!
                                                ),
                                        verticalSpaceTiny,
                                        Text(
                                          'Height',
                                          style: theme.textTheme.caption!
                                             ,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
