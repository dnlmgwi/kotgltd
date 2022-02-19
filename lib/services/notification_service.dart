// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();
//   Future selectNotification(String payload) async {
//     //Handle notification tapped logic here
//   }

//   Future<void> init() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/launch_icon');

//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//       // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS,
//             macOS: null);

//     await FlutterLocalNotificationsPlugin().initialize(
//       initializationSettings,
//     );
//   }
// }
