
/// LENOVO LIVE CLOCK
///
/// This is a clock that simulates your environment from when the sun rises till when sets
///
/// You also have a progress liquid that rises to the top depending on the time already elapsed of the day.
/// This can give users the feel to be more concious about their time
///
/// In the background you can have effects that simulate the weather depending on the weather condition
///
/// You will also observe stars at night that blink, birds in the air, fishes in the rising liquid progress
/// and also a beautiful rainbow that appears in the early morning
/// ALl this helps add more liveliness to the environment
///
///




import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home.dart';
import 'package:live_clock/clock/clock_dependency_injection.dart';
import 'constants.dart';
import 'package:flutter/services.dart';




void main(){

  WidgetsFlutterBinding.ensureInitialized();

  // Sets Device Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  // Configure Clock Repository using dependency injection
  ClockDependencyInjector.confgure(repository_dependency: REPOSITORY_DEPENDENCY.MOCK);

  runApp(ClockApp());
}


/// This Widget is the main application widget.
class ClockApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Live Clock",
      debugShowCheckedModeBanner: false,

      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: Home(),
    );
  }
}
