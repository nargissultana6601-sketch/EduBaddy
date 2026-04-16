import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'auth_service.dart';
import 'Drawer/Doubt/doubt_service.dart';
import 'firebase_options.dart';
import 'notification_service.dart';
import 'Screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notifications
  final notificationService = NotificationService();
  await notificationService.initializeNotifications();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.bgSecondary,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(MultiProvider(
    providers: [
      Provider<NotificationService>(
        create: (_) => notificationService,
      ),
      Provider<AuthService>(
        create: (_) => AuthService(notificationService),
      ),
      Provider<DoubtService>(
        create: (context) => DoubtService(
          Provider.of<NotificationService>(context, listen: false),
        ),
      ),
    ],
    child: const EduBuddyApp(),
  ));
}

class EduBuddyApp extends StatelessWidget {
  const EduBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
