// // import 'dart:io';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:rakshakk/child/child_login_screen.dart';
// // import 'package:rakshakk/utils/constants.dart';
// // import 'package:uuid/uuid.dart';


// // import '../../components/PrimaryButton.dart';
// // import '../../components/custom_textfield.dart';

// // class ProfilePage extends StatelessWidget {
// //   const ProfilePage({super.key});


// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   TextEditingController nameC = TextEditingController();
// //   final key = GlobalKey<FormState>();
// //   String? id;
// //   String? profilePic;
// //   String? downloadUrl;
// //   bool isSaving = false;
// //   getDate() async {
// //     await FirebaseFirestore.instance
// //         .collection('users')
// //         .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
// //         .get()
// //         .then((value) {
// //       setState(() {
// //         nameC.text = value.docs.first['name'];
// //         id = value.docs.first.id;
// //         profilePic = value.docs.first['profilePic'];
// //       });
// //     });
// //   }

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     getDate();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: TextButton(
// //           onPressed: () async{
// //             try {
// //               await FirebaseAuth.instance.signOut();
// //               goTo(context, LoginScreen());
// //             } on FirebaseAuthException catch (e) {
// //               dialogueBox(context, e.toString());
// //             }
// //           },
// //           child: Text(
// //             "sign out",
// //           )
// //         )
// //         ),
// //     );
// //   }
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: isSaving == true
// //           ? Center(
// //               child: CircularProgressIndicator(
// //               backgroundColor: Colors.pink,
// //             ))
// //           : SafeArea(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(18.0),
// //                 child: Center(
// //                   child: Form(
// //                       key: key,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: [
// //                           Text(
// //                             "UPDATE YOUR PROFILE",
// //                             style: TextStyle(fontSize: 25),
// //                           ),
// //                           SizedBox(height: 15),
// //                           GestureDetector(
// //                             onTap: () async {
// //                               final XFile? pickImage = await ImagePicker()
// //                                   .pickImage(
// //                                       source: ImageSource.gallery,
// //                                       imageQuality: 50);
// //                               if (pickImage != null) {
// //                                 setState(() {
// //                                   profilePic = pickImage.path;
// //                                 });
// //                               }
// //                             },
// //                             child: Container(
// //                               child: profilePic == null
// //                                   ? CircleAvatar(
// //                                       backgroundColor: Colors.deepPurple,
// //                                       radius: 80,
// //                                       child: Center(
// //                                           child: Image.asset(
// //                                         'assets/add_pic.png',
// //                                         height: 80,
// //                                         width: 80,
// //                                       )),
// //                                     )
// //                                   : profilePic!.contains('http')
// //                                       ? CircleAvatar(
// //                                           backgroundColor: Colors.deepPurple,
// //                                           radius: 80,
// //                                           backgroundImage:
// //                                               NetworkImage(profilePic!),
// //                                         )
// //                                       : CircleAvatar(
// //                                           backgroundColor: Colors.deepPurple,
// //                                           radius: 80,
// //                                           backgroundImage:
// //                                               FileImage(File(profilePic!))),
// //                             ),
// //                           ),
// //                           CustomTextField(
// //                             controller: nameC,
// //                             hintText: nameC.text,
// //                             validate: (v) {
// //                               if (v!.isEmpty) {
// //                                 return 'please enter your updated name';
// //                               }
// //                               return null;
// //                             },
// //                           ),
// //                           SizedBox(height: 25),
// //                           PrimaryButton(
// //                               title: "UPDATE",
// //                               onPressed: () async {
// //                                 if (key.currentState!.validate()) {
// //                                   SystemChannels.textInput
// //                                       .invokeMethod('TextInput.hide');


// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rakshakk/child/child_login_screen.dart';
// import 'package:rakshakk/utils/constants.dart';
// import 'package:uuid/uuid.dart';

// import '../../components/PrimaryButton.dart';
// import '../../components/custom_textfield.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   TextEditingController nameC = TextEditingController();
//   final key = GlobalKey<FormState>();
//   String? id;
//   String? profilePic;
//   String? downloadUrl;
//   bool isSaving = false;

//   getDate() async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get()
//         .then((value) {
//       setState(() {
//         nameC.text = value.docs.first['name'];
//         id = value.docs.first.id;
//         profilePic = value.docs.first['profilePic'];
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getDate();
//   }

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isSaving == true
//           ? Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.pink,
//               ),
//             )
//           : SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Center(
//                   child: Form(
//                     key: key,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           "UPDATE YOUR PROFILE",
//                           style: TextStyle(fontSize: 25),
//                         ),
//                         SizedBox(height: 15),
//                         GestureDetector(
//                           onTap: () async {
//                             final XFile? pickImage = await ImagePicker()
//                                 .pickImage(
//                               source: ImageSource.gallery,
//                               imageQuality: 50,
//                             );
//                             if (pickImage != null) {
//                               setState(() {
//                                 profilePic = pickImage.path;
//                               });
//                             }
//                           },
                          
//                           child: Container(
//                             child: profilePic == null
//                                 ? CircleAvatar(
//                                     backgroundColor: Colors.deepPurple,
//                                     radius: 80,
//                                     child: Center(
//                                       child: Image.asset(
//                                         'assets/add_pic.png',
//                                         height: 80,
//                                         width: 80,
//                                       ),
//                                     ),
//                                   )
//                                 : profilePic!.contains('http')
//                                     ? CircleAvatar(
//                                         backgroundColor: Colors.deepPurple,
//                                         radius: 80,
//                                         backgroundImage:
//                                             NetworkImage(profilePic!),
//                                       )
//                                     : CircleAvatar(
//                                         backgroundColor: Colors.deepPurple,
//                                         radius: 80,
//                                         backgroundImage:
//                                             FileImage(File(profilePic!))),
//                           ),
//                         ),
//                         CustomTextField(
//                           controller: nameC,
//                           hintText: nameC.text,
//                           validate: (v) {
//                             if (v!.isEmpty) {
//                               return 'please enter your updated name';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 25),
//                         PrimaryButton(
//                           title: "UPDATE",
//                           onPressed: () async {
//                             if (key.currentState!.validate()) {
//                               SystemChannels.textInput
//                                   .invokeMethod('TextInput.hide');

//                               profilePic == null
//                                   ? Fluttertoast.showToast(
//                                       msg: 'please select profile picture')
//                                   : update();
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton(
//                 onPressed: () async{
//             try {
//               await FirebaseAuth.instance.signOut();
//               goTo(context, LoginScreen());
//             } on FirebaseAuthException catch (e) {
//               dialogueBox(context, e.toString());
//             }
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Color(0xff03416a)), // change background color
//             padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 32)), // add padding
//             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))), // add rounded corners
//           ),
//           child: Text(
//             "Sign Out",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//               )
//               )
//             ],
//         ),
//       ),
//       )
//     );
//   }
//   Future<String?> uploadImage(String filePath) async {
//     try {
//       final filenName = Uuid().v4();
//       final Reference fbStorage =
//           FirebaseStorage.instance.ref('profile').child(filenName);
//       final UploadTask uploadTask = fbStorage.putFile(File(filePath));
//       await uploadTask.then((p0) async {
//         downloadUrl = await fbStorage.getDownloadURL();
//       });
//       return downloadUrl;
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   update() async {
//     setState(() {
//       isSaving = true;
//     });
//     uploadImage(profilePic!).then((value) {
//       Map<String, dynamic> data = {
//         'name': nameC.text,
//         'profilePic': downloadUrl,
//       };
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update(data);
//       setState(() {
//         isSaving = false;
//       });
//     });
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rakshakk/child/child_login_screen.dart';
import 'package:rakshakk/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../../components/PrimaryButton.dart';
import '../../components/custom_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameC = TextEditingController();
  final key = GlobalKey<FormState>();
  String? id;
  String? profilePic;
  String? downloadUrl;
  bool isSaving = false;

  getDate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        nameC.text = value.docs.first['name'];
        id = value.docs.first.id;
        profilePic = value.docs.first['profilePic'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
  actions: [
    Container(
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 232, 11, 11),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut();
            goTo(context, LoginScreen());
          } on FirebaseAuthException catch (e) {
            dialogueBox(context, e.toString());
          }
        },
        icon: Icon(
          Icons.logout,
          color: Color.fromARGB(255, 255, 254, 253), // add this line to make the icon red
        ),
      ),
    ),
  ],
    title: Text('Update Profile'),
  ),
      body: isSaving == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final XFile? pickImage = await ImagePicker()
                                .pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 50,
                            );
                            if (pickImage != null) {
                              setState(() {
                                profilePic = pickImage.path;
                              });
                            }
                          },
                          child: Container(
                            child: profilePic == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.deepPurple,
                                    radius: 80,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/add_pic.png',
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                  )
                                : profilePic!.contains('http')
                                    ? CircleAvatar(
                                        backgroundColor: Colors.deepPurple,
                                        radius: 80,
                                        backgroundImage:
                                            NetworkImage(profilePic!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.deepPurple,
                                        radius: 80,
                                        backgroundImage:
                                            FileImage(File(profilePic!))),
                          ),
                        ),
                        CustomTextField(
                          controller: nameC,
                          hintText: nameC.text,
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'please enter your name';
}
return null;
},
),
PrimaryButton(
title: 'Update',
onPressed: () async {
if (key.currentState!.validate()) {
setState(() {
isSaving = true;
});
try {
if (profilePic != null &&
!profilePic!.contains('http')) {
final Reference firebaseStorageRef =
FirebaseStorage.instance.ref().child(
'profilePics/${Uuid().v4()}');
final UploadTask task =
firebaseStorageRef.putFile(
File(profilePic!));
TaskSnapshot snapshot =
await task.whenComplete(() => null);
downloadUrl =
await snapshot.ref.getDownloadURL();
}
await FirebaseFirestore.instance
.collection('users')
.doc(id)
.update({
'name': nameC.text.trim(),
'profilePic': downloadUrl == null
? profilePic
: downloadUrl
});
setState(() {
isSaving = false;
});
Fluttertoast.showToast(
msg: 'Profile Updated Successfully');
} on FirebaseException catch (e) {
dialogueBox(context, e.toString());
}
}
},
),
],
),
),
),
),
),
);
}
}

void dialogueBox(BuildContext context, String e) {
showDialog(
context: context,
builder: (context) {
return AlertDialog(
title: Text('Error'),
content: Text(e),
actions: [
ElevatedButton(
onPressed: () {
Navigator.pop(context);
},
child: Text('ok')),
],
);
});
}