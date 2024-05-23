import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/screens/org/org_home_page.dart';
import 'package:week9/screens/org/org_profile_page.dart';
import 'package:week9/themedata.dart';
import 'screens/admin/admin_home.dart';
import 'screens/donors/home_page.dart';
import '../providers/todo_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/todo_page.dart';
import '../screens/user_details.dart';
import '../screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/donors/donate_page.dart';
import 'screens/donors/profile_page.dart';

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
      initialRoute: '/',
      theme: appTheme,
      routes: {
        '/': (context) => UserSelectionPage(),
        '/login': (context) => const LoginPage(),
        '/todo': (context) => const LoginPage(),
        '/user_details': (context) => const UserDetailsPage(),
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

class UserSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_home');
              },
              child: Text('Admin'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donor_home');
              },
              child: Text('Donor'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/organization_home');
              },
              child: Text('Organization'),
            ),
          ],
        ),
      ),
    );
  }
}
