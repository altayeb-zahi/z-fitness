import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/locator.dart';
import '../app/logger.dart';
// import 'navigation_service.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _navigationService = locator<NavigationService>();


   Future initialize()async {
    const InitializationSettings initializationSettings = 
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async{
      if(route != null){
        _navigationService.navigateTo(route);
      }
    });
  }

   void display(RemoteMessage message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "zahiCode",
          "zahiCode channel",
          importance: Importance.max,
          priority: Priority.high,
        )
      );


      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      log.e(e);
    }
  }
}