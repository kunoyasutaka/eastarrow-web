import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/admin_app.dart';

Future main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  // ユーザのログイン状態が確定するまで待つ
  await Firebase.initializeApp();
  //await firebase.auth(firebase.app()).onAuthStateChanged.first;

  runApp(AdminApp());
}
