import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/features/onboarding/onboarding_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/onboarding/welcome.dart';
import 'firebase_options.dart';
import 'provider/navigation_provider.dart';
import 'navigation/routes.dart';
import 'provider/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => NavigationProvider()),
        Provider<FirestoreProvider>(
          create: (_) => FirestoreProvider(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
            prefs: prefs,
          ),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            firestoreProvider: Provider.of<FirestoreProvider>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<StorageProvider>(
          create: (_) => StorageProvider(firebaseStorage: FirebaseStorage.instance),
        ),
        ChangeNotifierProvider<AuthProviders>(
          create: (context) => AuthProviders(
            firebaseAuth: FirebaseAuth.instance,
            userProvider: Provider.of<UserProvider>(context, listen: false),
            storageProvider: Provider.of<StorageProvider>(context, listen: false),
            prefs: prefs,
          ),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(
            firestoreProvider: Provider.of<FirestoreProvider>(context, listen: false),
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        ChangeNotifierProvider<AppointmentProvider>(
          create: (context) => AppointmentProvider(
            firestoreProvider: Provider.of<FirestoreProvider>(context, listen: false),
          ),
        ),
      ],
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigatorService, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: navigatorService.navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            fontFamily: 'Poppins',
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              titleMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              titleSmall: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              bodyMedium: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              bodySmall: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelSmall: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            useMaterial3: true,
          ),
          home: prefs.getBool('onboarding') == true ? const WelcomePage() : const OnboardingView(),
        );
      },
    );
  }
}

