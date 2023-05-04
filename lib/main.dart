import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakshakk/child/bottom_page.dart';
import 'package:rakshakk/child/child_login_screen.dart';
import 'package:rakshakk/db/share_pref.dart';
import 'package:rakshakk/parent/parent_home_screen.dart';
import 'package:rakshakk/utils/constants.dart';
import 'package:rakshakk/utils/flutter_background_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorkey = GlobalKey<ScaffoldMessengerState>();

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPrefference.init();
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme, 
        ),
        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder(
        future: MySharedPrefference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == "") {
            return LoginScreen();
          }
          if (snapshot.data == "child") {
            return BottomPage();
          }
          if (snapshot.data == "parent") {
            return ParentHomeScreen();
          }

          return progressIndicator(context);
        },
      ),
    );
  }
}

// class CheckAuth extends StatelessWidget {
//   //const CheckAuth({Key? key}): super(key: key);

//   checkData(){
//     if (MySharedPrefference.getUserType()=='parent') {

      
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//     );
//   }
// }