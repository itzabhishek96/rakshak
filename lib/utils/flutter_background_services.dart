import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';



Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "Abhishek",
    "foreground service",
    "used for imp notifcation",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: "Abhishek",
        initialNotificationTitle: "foregrounf service",
        initialNotificationContent: "initializing",
        foregroundServiceNotificationId: 888,
      ));
  service.startService();
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
          print("bg location ${position.latitude}");
        })
    .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
          ShakeDetector.autoStart(
            shakeThresholdGravity: 7,
            onPhoneShake: () async{
          if (await Vibration.hasVibrator()?? false) {
            if(await Vibration.hasCustomVibrationsSupport()??false){
              Vibration.vibrate(duration: 1000);
              await Future.delayed(Duration(milliseconds: 500));
              Vibration.vibrate();
            }
          }
          });
        flutterLocalNotificationsPlugin.show(
          888,
          "Rakshakk",
          "shake feature enable",
          NotificationDetails(
              android: AndroidNotificationDetails(
            "Abhishek",
            "foregrounf service",
            "used for imp notifcation",
            icon: 'ic_bg_service_small',
            ongoing: true,
          )),
        );
      }
    }
  });
}

// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shake/shake.dart';
// import 'package:vibration/vibration.dart';
// import 'package:flutter_sms/flutter_sms.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   AndroidNotificationChannel channel = AndroidNotificationChannel(
//     "Abhishek",
//     "foreground service",
//     "used for imp notification",
//     importance: Importance.high,
//   );
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await service.configure(
//       iosConfiguration: IosConfiguration(),
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: true,
//         autoStart: true,
//         notificationChannelId: "Abhishek",
//         initialNotificationTitle: "foreground service",
//         initialNotificationContent: "initializing",
//         foregroundServiceNotificationId: 888,
//       ));
//   service.startService();
// }

// @pragma('vm-entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   Timer.periodic(Duration(seconds: 2), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         await Geolocator.getCurrentPosition(
//                 desiredAccuracy: LocationAccuracy.high,
//                 forceAndroidLocationManager: true)
//             .then((Position position) {
//           print("bg location ${position.latitude}");
//           // Send SMS with location to trusted contact on phone shake
//           ShakeDetector.autoStart(
//               shakeThresholdGravity: 7,
//               onPhoneShake: () async {
//             if (await Vibration.hasVibrator() ?? false) {
//               if (await Vibration.hasCustomVibrationsSupport() ?? false) {
//                 Vibration.vibrate(duration: 1000);
//                 await Future.delayed(Duration(milliseconds: 500));
//                 Vibration.vibrate();
//               }
//             }
//             final trustedContact = "9004048294"; // Replace with actual trusted contact number
//             final locationUrl =
//                 "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
//             final message = "I need help! My current location is: $locationUrl";
//             List<String> recipients = [trustedContact];
//             await sendSMS(message: message, recipients: recipients);
//           });
//         }).catchError((e) {
//           Fluttertoast.showToast(msg: e.toString());
//         });

//         flutterLocalNotificationsPlugin.show(
//           888,
//           "Rakshakk",
//           "shake feature enable",
//           NotificationDetails(
//               android: AndroidNotificationDetails(
//             "Abhishek",
//             "foreground service",
//             "used for imp notification",
//             icon: 'ic_bg_service_small',
//             ongoing: true,
//           )
//           ),
//         );
//       }
//     }
//   });
// }

// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shake/shake.dart';
// import 'package:vibration/vibration.dart';
// import 'package:sms_maintained/sms.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   AndroidNotificationChannel channel = AndroidNotificationChannel(
//     "Abhishek",
//     "foreground service",
//     "used for imp notification",
//     importance: Importance.high,
//   );
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await service.configure(
//       iosConfiguration: IosConfiguration(),
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: true,
//         autoStart: true,
//         notificationChannelId: "Abhishek",
//         initialNotificationTitle: "foreground service",
//         initialNotificationContent: "initializing",
//         foregroundServiceNotificationId: 888,
//       ));
//   service.startService();
// }

// @pragma('vm-entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   Timer.periodic(Duration(seconds: 2), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         await Geolocator.getCurrentPosition(
//                 desiredAccuracy: LocationAccuracy.high,
//                 forceAndroidLocationManager: true)
//             .then((Position position) {
//           print("bg location ${position.latitude}");
//           // Send SMS with location to trusted contact on phone shake
//           ShakeDetector.autoStart(
//               shakeThresholdGravity: 7,
//               onPhoneShake: () async {
//             if (await Vibration.hasVibrator() ?? false) {
//               if (await Vibration.hasCustomVibrationsSupport() ?? false) {
//                 Vibration.vibrate(duration: 1000);
//                 await Future.delayed(Duration(milliseconds: 500));
//                 Vibration.vibrate();
//               }
//             }
//             final trustedContact = "9004048294"; // Replace with actual trusted contact number
//             final locationUrl =
//                 "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
//             final message = "I need help! My current location is: $locationUrl";
//             List<String> recipients = [trustedContact];
//             print("Sending SMS to $recipients: $message");
//             try {
//               SmsSender sender = new SmsSender();
//               SmsMessage smsMessage = new SmsMessage(
//                   recipients.join(', '), message);
//               await sender.sendSms(smsMessage);
//               print("SMS sent successfully");
//             } catch (e) {
//               print("Error sending SMS: $e");
//               Fluttertoast.showToast(msg: "Error sending SMS: $e");
//             }
//           });
//         }).catchError((e) {
//           print("Error getting location: $e");
//           Fluttertoast.showToast(msg: "Error getting location: $e");
//         });

//         flutterLocalNotificationsPlugin.show(
//           888,
//           "Rakshakk",
//           "shake feature enable",
//           NotificationDetails(
//               android: AndroidNotificationDetails(
//             "Abhishek",
//             "foreground service",
//             "used for imp notification",
//             icon: 'ic_bg_service_small',
//             ongoing: true,
//           )
//           ),
//         );
//       }
//     }
//   });
// }

