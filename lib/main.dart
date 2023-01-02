import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livestreamingapp/providers/user_provider.dart';
import 'package:livestreamingapp/resources/auth_method.dart';
import 'package:livestreamingapp/screens/broadcast_screen.dart';
import 'package:livestreamingapp/screens/homeScreen.dart';
import 'package:livestreamingapp/screens/login_screen.dart';
import 'package:livestreamingapp/screens/onboarding_screen.dart';
import 'package:livestreamingapp/utils/colors.dart';
import 'package:livestreamingapp/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'models/user.dart' as model;
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Streaming App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(color: primaryColor),
        ),
      ),
      routes: {
        OnboardingScreen.routeName: ((context) => const OnboardingScreen()),
        LoginScreen.routeName: ((context) => const LoginScreen()),
        SignUpScreen.routeName: ((context) => const SignUpScreen()),
        HomeScreen.routeName: ((context) => const HomeScreen()),
        '/liveScreen': (context) => const BroadCastScreen(
              channelId: "test123",
              isBroadcaster: true,
            ),
      },
      home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(FirebaseAuth.instance.currentUser != null
                  ? FirebaseAuth.instance.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false).setUser(
                model.User.fromMap(value),
              );
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }

            if (snapshot.hasData) {
              return const BroadCastScreen(
                  isBroadcaster: true, channelId: "test123");
            }
            return const OnboardingScreen();
          }),
    );
  }
}
