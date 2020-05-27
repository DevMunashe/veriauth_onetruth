import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veriauth_onetruth/providers/app_provider.dart';
import 'package:veriauth_onetruth/src/checkin.dart';
import 'package:veriauth_onetruth/src/register.dart';
import 'package:veriauth_onetruth/src/welcome_screen.dart';
import 'package:veriauth_onetruth/utils/consts.dart';

void main() {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.getInstance().then((prefs) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {//lock app in portatrait by waiting for orientation Future

          runApp(
            MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AppProvider()),
              // ChangeNotifierProvider(create: (_) => HomeProvider()),
              // ChangeNotifierProvider(create: (_) => DetailsProvider()),
              // ChangeNotifierProvider(create: (_) => FavoritesProvider()),
            ],
              child: MyApp(prefs: prefs)
            ),
          ); 
    });
      
     
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({this.prefs});
   

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
    return MaterialApp(
       key: appProvider.key,
          debugShowCheckedModeBanner: false,
      //      localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // locale: Locale('en', 'US'),
      // supportedLocales: [
      //   const Locale('en', 'US'), // English
      //   //const Locale('th', 'TH'), // Thai
      // ],
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
      theme: appProvider.theme,
     
      routes: <String, WidgetBuilder>{
      //  '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
       // '/root': (BuildContext context) => new RootScreen(),
        '/checkin': (BuildContext context) => new Checkin(),
        '/welcome': (BuildContext context) => new WelcomeScreen(),
      //  '/register': (BuildContext context) => new Register(),
      },

      home: _displayCurrentScreen(),
    );
  },
  );
  }

  Widget _displayCurrentScreen() {

    bool seen = (prefs.getBool('seen') ?? false);

     if (seen) return new Checkin();
     else return new WelcomeScreen();
  }
}