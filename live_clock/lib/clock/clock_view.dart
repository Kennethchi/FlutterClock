import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:live_clock/custom_widgets/objects_widgets/bird.dart';
import 'package:live_clock/custom_widgets/objects_widgets/fish.dart';
import 'clock_bloc.dart';
import 'clock_bloc_provider.dart';
import 'clock_view_widgets.dart';




// Clock Main View
class ClockView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return SafeArea(
      child: Center(
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: Stack(
            children: <Widget>[

              ClockSkyBackgroundColorWidget(),

              GroupStarsWidget(),

              LuminatedLightObjectWidget(),

              WeatherConditionWidget(),

              Positioned(
                  child: Center(child: RainBowWidget())
              ),

              Positioned(
                  bottom: 0.0,
                  child: SwimmingFishesWidget()
              ),

              Positioned(
                top: 0.0,
                child: FlyingBirdsWidget(),
              ),

              TimeProgressLiquidWidget(),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TemperatureWidget(),
                    TimeTextWidget(),
                    DateTextWidget()
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
