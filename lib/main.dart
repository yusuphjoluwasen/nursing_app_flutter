import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/features/onboarding/onboarding_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'features/onboarding/onboarding_view.dart';
import 'navigation/navigation_service.dart';
import 'navigation/routes.dart';
import 'provider/providers.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NavigationService navigationService = NavigationService();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(navigationService: navigationService, prefs: prefs));
}

class MyApp extends StatelessWidget {

  MyApp({super.key, required this.navigationService, required this.prefs});
  final NavigationService navigationService;
  final SharedPreferences prefs;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirestoreProvider>(
            create: (_) => FirestoreProvider(
              firebaseFirestore: _firebaseFirestore,
              firebaseAuth: _firebaseAuth,
              prefs: prefs,
            ),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(
              firestoreProvider: Provider.of<FirestoreProvider>(context, listen: false),
            ),
          ),
          ChangeNotifierProvider<StorageProvider>(
            create: (_) => StorageProvider(firebaseStorage: _firebaseStorage),
          ),
          ChangeNotifierProvider<AuthProviders>(
            create: (context) => AuthProviders(
              firebaseAuth: _firebaseAuth,
              userProvider: Provider.of<UserProvider>(context, listen: false),
              storageProvider: Provider.of<StorageProvider>(context, listen: false),
              prefs: prefs,
            ),
          ),
          ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider(
              firestoreProvider: Provider.of<FirestoreProvider>(context, listen: false),
              firebaseStorage: _firebaseStorage,
            ),
          ),
          ChangeNotifierProvider<AppointmentProvider>(
            create: (context) => AppointmentProvider(
              firestoreProvider: Provider.of<FirestoreProvider>(context, listen: false),
            ),
          ),
        ],
      child: MaterialApp(
      title: 'Flutter Demoo',
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Poppins',
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
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
      home: const OnboardingView(),
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text("kkkkkk",style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
