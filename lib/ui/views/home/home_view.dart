import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:z_fitness/ui/views/diary/diary_view.dart';
import 'package:z_fitness/ui/views/me/me_view.dart';
import 'package:z_fitness/ui/views/recipes/recipes_view.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final model = HomeViewModel();

  final screens = [const DiaryView(), const RecipesView(), const MeView()];

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      model.onModelReady();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (
        BuildContext context,
      ) =>
          model,
      child: Consumer<HomeViewModel>(
          builder: (context, model, child) => Scaffold(
                body: IndexedStack(
                  index: model.currentIndex,
                  children: screens,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: model.setIndex,
                  currentIndex: model.currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.restaurant), label: 'Diary'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.restaurant_menu), label: 'Recipes'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Me'),
                  ],
                ),
              )),
    );
  }
}
