// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserSession {
//   // Save user session
//   static Future<void> saveUserSession(User user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('uid', user.uid);
//     // add other data as needed
//   }

//   // Retrieve user session
//   static Future<User?> retrieveUserSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? uid = prefs.getString('uid');

//     if (uid != null && uid.isNotEmpty) {
//       // Fetch the user using the uid, here you can use your own method to fetch user
//       User? user = await yourMethodToFetchUser(uid);

//       if (user != null) {
//         return user;
//       } else {
//         // If user is not found, then remove the uid from prefs
//         prefs.remove('uid');
//       }
//     }
//     return null;
//   }
// }
