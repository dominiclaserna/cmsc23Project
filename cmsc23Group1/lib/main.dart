import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:week9/screens/org/org_home_page.dart';
import 'package:week9/screens/org/org_profile_page.dart';
import 'package:week9/themedata.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/screens/donation_page.dart';
import 'package:week9/screens/donors/donor_profile.dart';
import 'screens/donors/home_page.dart';
import 'screens/donors/donations_page.dart';
import 'screens/org/donation_drive_page.dart';
import 'screens/org/donations_page.dart';
import 'screens/donors/profile_page.dart';
import '../providers/auth_provider.dart';
import '../screens/login.dart';
import 'firebase_options.dart';
import 'package:week9/screens/admin/admin_home.dart';
import 'package:week9/screens/admin/admin_donations.dart';
import 'package:week9/screens/admin/admin_drive.dart';
import 'package:week9/screens/admin/admin_donors.dart';
import 'package:week9/screens/admin/admin_organizations.dart';
import 'package:week9/screens/admin/admin_approve.dart';
import 'package:week9/screens/donors/donor_drive.dart';
import 'package:week9/screens/donation_page_drive.dart';
import 'package:week9/screens/donors/drive_details_page.dart' as DriveDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
        ChangeNotifierProvider(create: ((context) => DonationFormProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo with Auth',
      initialRoute: '/login',
      theme: appTheme,
      routes: {
        '/login': (context) => const LoginPage(),
        '/donate': (context) {
          final String receiverEmail =
              ModalRoute.of(context)!.settings.arguments as String;
          return DonationPage(receiverEmail: receiverEmail);
        },
        '/donationPageDrive': (context) {
          final String driveName =
              ModalRoute.of(context)!.settings.arguments as String;
          return DonationPageDrive(driveName: driveName);
        },
        '/drive_details': (context) {
          final String driveName =
              ModalRoute.of(context)!.settings.arguments as String;
          return DriveDetails.DriveDetailsPage(driveName: driveName);
        },
        '/donation': (context) => DonationDetailsPage(),
        '/donationDrive': (context) => DonationDrivePage(),
        '/donor_home': (context) => HomePage(),
        '/org_profile': (context) => OrgProfilePage(),
        '/organization_home': (context) => OrgHomePage(),
        '/donor_profile': (context) => ProfilePage(),
        '/donated': (context) => DonationSentPage(),
        '/donor_drive': (context) => DonationDrivesPage(),
        '/user_profile': (context) => UserProfilePage(),
        '/admin_home': (context) => AdminHomePage(),
        '/admin_donations': (context) => AdminAllDonationsPage(),
        '/admin_donors': (context) => AdminAllDonorsPage(),
        '/admin_orgs': (context) => adminallorganizationPage(),
        '/admin_approve': (context) => AdminApproverPage(),
        '/admin_drives': (context) => AllDonationDrivesPage(),
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Set the background color to white
      title: Text('CMSC23 Project'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
