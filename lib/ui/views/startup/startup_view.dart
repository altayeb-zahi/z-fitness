import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:z_fitness/ui/dumb_widgets/splash_widget.dart';
import 'package:z_fitness/ui/views/startup/startup_view_model.dart';

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  final model = StartupViewModel();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      model.runStartupLogic();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashWidget());
  }
}
