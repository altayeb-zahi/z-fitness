import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../shared/ui_helpers.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Center(
        child: Column(
      children: [
        verticalSpaceLarge,
        Container(
          alignment: Alignment.center,
          height: screenHeightPercentage(context, percentage: 0.6),
          child: SizedBox(
            height: 220,
            width: 220,
            child: isDarkMode
                ? Lottie.asset(
                    'assets/lottie/splash_dark.json',
                  )
                : Lottie.asset('assets/lottie/splash_light.json'),
          ),
        ),
        Text('Z-fitness',
            style: theme.textTheme.headline3!
                .copyWith(color: theme.colorScheme.secondary)),
        verticalSpaceSmall,
        Text(
          'Please wait..',
          style: theme.textTheme.caption,
        ),
        verticalSpaceLarge
      ],
    ));
  }
}
