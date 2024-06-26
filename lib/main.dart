import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/services/push_notifications_service.dart';
import 'package:z_fitness/app/router.dart' as router;
import 'package:z_fitness/ui/dumb_widgets/main_button.dart';
import 'package:z_fitness/ui/shared/themes_setup.dart';
import 'app/locator.dart';
import 'app/router.dart';
import 'app/setup_bottom_sheet.dart';
import 'app/setup_dialog.dart';
import 'firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'ui/shared/ui_helpers.dart';

// to shut down emulator
// taskkill /f /im java.exe

const bool useEmulator = false;
const String ipAdress = '192.168.0.107';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (useEmulator) {
    await _connectToFirebaseEmulator();
  }

  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

Future _connectToFirebaseEmulator() async {
  FirebaseFirestore.instance.settings = const Settings(
    host: '$ipAdress:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  await FirebaseAuth.instance.useAuthEmulator(ipAdress, 9099);

  // [Storage | localhost:9199]
  await FirebaseStorage.instance.useStorageEmulator(
    ipAdress,
    9199,
  );

  FirebaseFirestore.instance.useFirestoreEmulator(ipAdress, 8080);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settings = ValueNotifier(ThemeSettings(
      sourceColor: const Color(0xff3E978B),
      themeMode: ThemeMode.system,
    ));

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => ThemeProvider(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
          settings: settings,
          child: NotificationListener<ThemeSettingChange>(
            onNotification: (notification) {
              settings.value = notification.settings;
              return true;
            },
            child: ValueListenableBuilder<ThemeSettings>(
              valueListenable: settings,
              builder: (context, value, _) {
                final theme = ThemeProvider.of(context);
                return MaterialApp(
                  navigatorKey: StackedService.navigatorKey,
                  onGenerateRoute: router.generateRoute,
                  initialRoute: Routes.startupView,
                  useInheritedMediaQuery: true,
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: theme.light(settings.value.sourceColor),
                  darkTheme: theme.dark(settings.value.sourceColor),
                  themeMode: theme.themeMode(),
                  // home: TestButtons(),
                );
              },
            ),
          )),
    );
  }
}

class TestButtons extends StatelessWidget {
  const TestButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBusy = false;
    return Center(
      child: Column(
        children: [
          verticalSpaceLarge,
          MainButton(
            onTap: () {},
            title: 'Save',
          ),
          verticalSpaceLarge,
          TextButton(
              onPressed: () {},
              child: isBusy ? CircularProgressIndicator() : const Text('Save')),
        ],
      ),
    );
  }
}

//  return ChangeNotifierProvider(
//       create: (BuildContext context) => model,
//       child: Consumer<LoginViewModel>(
//         builder: (context, model, child) => Scaffold(
//             body: Container()
//       ),
//     ));

