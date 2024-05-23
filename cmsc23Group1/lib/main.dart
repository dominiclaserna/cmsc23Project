import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/screens/donation_page.dart';
import 'screens/donors/home_page.dart';
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/todo_page.dart';
import '../screens/user_details.dart';
import '../screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/donors/donate_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
        ChangeNotifierProvider(create: ((context) => DonationFormProvider())),
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
      initialRoute: '/donationpage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
        '/todo': (context) => const LoginPage(),
        '/user_details': (context) => const UserDetailsPage(),
        '/donate': (context) => DonatePage(),
        '/donationpage': (context) => DonationPage(),
      },
    );
  }
}


