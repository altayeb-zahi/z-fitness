import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/locator.dart';
import '../app/logger.dart';
import 'local_notifications_service.dart';
// import 'navigation_service.dart';

///Receives the message when app is in background ( its a solution for on message which work only in forground )
///this function need to be top level (not inside class or something)
/// i am useing FirebaseMessaging.onBackgroundMessage(backgroundHandler) in main function
Future<void> backgroundHandler(RemoteMessage message) async {
  log.i('backgroundHandler');

  log.d(message.data.toString());
  log.d(message.notification!.title);
}

class PushNotificationService {
  final _navigationService = locator<NavigationService>();
  final _localNotifcationService = locator<LocalNotificationService>();

  final messaging = FirebaseMessaging.instance;

  Future initialise() async {
    if (Platform.isIOS) {
      _requestNotificationPermissions();
    }

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    /// for example when i want to open screen when user tap on the notifcation i will use onMessageOpenedApp if
    /// the app in the background and not terminated but if it is terminated then i need to use this one
    messaging.getInitialMessage().then((message) {
      log.i('getInitialMessage');

      if (message != null) {
        final routeFromMessage = message.data["route"];

        _navigationService.navigateTo(routeFromMessage);
      }
    });

    /// only work while the app in forground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log.i('onMessage');
        log.d(message.notification!.title);
        log.d(message.notification!.body);
      }

      // use this one if u need to display the notifcation while
      // the app in forground
      _localNotifcationService.display(message);
    });

    /// work only when u tap on the notifcation and app in the
    /// background and not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // in firebase send data that includes the route as key map value
      // then use that route name to navigate to the page u want
      // as simple as that

      log.i('onMessageOpenedApp');

      final _routeFromMessage = message.data['route'];

      _navigationService.navigateTo(_routeFromMessage);
    });
  }

  Future _requestNotificationPermissions() async {
    log.i('_requestNotificationPermissions');

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log.v('User granted permission: ${settings.authorizationStatus}');
  }
}
