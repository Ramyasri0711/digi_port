import 'package:digiport/home_page.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBekjOh9KtUYnD_ziOP1tS8fbpJoXSgL9U",
          authDomain: "digiport-3ff13.firebaseapp.com",
          projectId: "digiport-3ff13",
          storageBucket: "digiport-3ff13.appspot.com",
          messagingSenderId: "386673841903",
          appId: "1:386673841903:web:3dc23f03072941fc872d1a",
          measurementId: "G-WYXS7CDRDR"));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:Login(),);
  }
}

