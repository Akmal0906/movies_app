import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/view/main/combain_screen.dart';
import 'package:movies_app/presentation/view/main_screen.dart';
import 'package:movies_app/presentation/view/register/introduction_screen.dart';
import 'package:movies_app/presentation/view/register/main_page.dart';
import 'package:movies_app/presentation/view/register/sign_in_screen.dart';
import 'package:movies_app/presentation/view/register/sign_up_screen.dart';
import 'package:movies_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: 'AIzaSyD9SOHa6p0UWbUopkkSwqGLs0Zfq3QccQE', appId: "1:514288857046:android:dc871a65c5331e0edffe77", messagingSenderId: "514288857046", projectId: "movies-app-1de78")
  ): await Firebase.initializeApp();  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'SplashScreen',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'introduce',
          name: 'introduce',
          builder: (BuildContext context, GoRouterState state) {
            return const IntroductionScreen();
          },
        ),
        GoRoute(
          path: 'signup',
          name: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: 'signin',
          name: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
        ),
        GoRoute(
          path: 'main',
          name: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
        ),
        GoRoute(
          path: 'mainpage',
          name: 'mainpage',
          builder: (BuildContext context, GoRouterState state) {
            return const MainPage();
          },
        ),
        GoRoute(
          path: 'combain',
          name: 'combain',
          builder: (BuildContext context, GoRouterState state) {
            return const CombainScreen();
          },
        ),
      ],
    ),
  ],
);
