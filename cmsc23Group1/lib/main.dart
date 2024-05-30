import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:week9/screens/org/org_home_page.dart';
import 'package:week9/screens/org/org_profile_page.dart';
import 'package:week9/themedata.dart';
import 'screens/admin/admin_home.dart';
import 'screens/donors/home_page.dart';
import 'screens/donors/donate_page.dart';
import 'screens/donors/profile_page.dart';
import 'screens/donors/user_details_page.dart'; // Adjust the import to match your directory structure
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoListProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo with Auth',
      initialRoute: '/login',
      theme: appTheme,
      routes: {
        '/login': (context) => const LoginPage(),
        '/donate': (context) => DonatePage(),
        '/donor_home': (context) => HomePage(),
        '/donor_profile': (context) => ProfilePage(),
        '/org_profile': (context) => OrgProfilePage(),
        '/organization_home': (context) => OrgHomePage(),
        '/admin_home': (context) => AdminHomePage(),
      },
    );
  }
}
