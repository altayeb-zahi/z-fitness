import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:z_fitness/services/push_notifications_service.dart';
import 'package:z_fitness/app/router.dart' as router;
import 'app/locator.dart';
import 'app/router.dart';
import 'app/setup_bottom_sheet.dart';
import 'app/setup_dialog.dart';
import 'firebase_options.dart';

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

  runApp(const MyApp());
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: Routes.startupView,
      theme: ThemeData(primarySwatch: Colors.purple,
      fontFamily: GoogleFonts.openSans().fontFamily,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      textTheme: const TextTheme(bodyText2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400
        ))
      ),
    );
  }
}
