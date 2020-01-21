import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:live_clock/custom_widgets/objects_widgets/bird.dart';
import 'package:live_clock/custom_widgets/objects_widgets/fish.dart';
import 'package:live_clock/custom_widgets/liquid_progress/liquid_progress.dart';
import 'package:live_clock/custom_widgets/objects_widgets/star.dart';
import 'package:live_clock/custom_widgets/weather_effects/cloudy_effect.dart';
import 'package:live_clock/custom_widgets/weather_effects/foggy_effect.dart';
import 'package:live_clock/custom_widgets/weather_effects/rainbow_effect.dart';
import 'package:live_clock/custom_widgets/weather_effects/rainy_effect.dart';
import 'package:live_clock/custom_widgets/weather_effects/snowy_effect.dart';
import 'package:live_clock/custom_widgets/weather_effects/thunderstorm_effect.dart';
import '../constants.dart';
import 'clock_bloc.dart';
import 'clock_bloc_provider.dart';
import 'clock_model.dart';
import 'dart:math' as math;



/// Widget contains the time text formatted
class TimeTextWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return RichText(
              text: TextSpan(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 150.0,
                    fontWeight: FontWeight.w900,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: snapshot.data.getCurrentHourFormat
                  ),
                  TextSpan(
                      text: ":"
                  ),
                  TextSpan(
                      text: snapshot.data.getCurrentMinuteFormat
                  ),

                ]
              ),
            );

          }
          else {
            return Container();
          }
        }
    );
  }
}




/// Widget contains formatted date text
class DateTextWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.getCurrentDateFormat,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.headline.fontSize,
                  fontWeight: FontWeight.w900
              ),
            );
          }
          else {
            return Container();
          }
        }
    );

  }
}




/// Widget Contains temperature
class TemperatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                ConstrainedBox(

                  constraints: BoxConstraints(
                    maxWidth: 40.0,
                    maxHeight: 40.0
                  ),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        left: -8.0,
                          top: -8.0,
                          child: Transform.rotate(
                            angle: math.pi / 4,
                            child: Container(
                              child: Icon(!snapshot.data.isNightTime
                                  ? Icons.wb_sunny
                                  : Icons.brightness_3,
                                color: snapshot.data.getLuminatedObjectColor, size: 40.0,),
                            ),
                          )
                      ),
                      Positioned(
                        right: 0.0,
                          bottom: 0.0,
                          child: Icon(Icons.cloud, color: Colors.white, size: 40.0,)
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.0,),

                Text(snapshot.data.getTemperatureFormat,
                  style: TextStyle(
                      color: snapshot.data.currentDateTime.hour >= 16 && snapshot.data.currentDateTime.hour < 17? Colors.yellow: Colors.white,
                      fontSize: Theme.of(context).textTheme.headline.fontSize,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ],
            );
          }
          else {
            return Container();
          }
        }
    );
  }
}





/// This Widget Represents the sun or the moon depending on whether it is daytime or night time
class LuminatedLightObjectWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<ClockModel>(
      stream: _bloc.getClockModelStream,
      builder: (context, snapshot) {

        if (snapshot.hasData){


          return AnimatedPositioned(
            duration: Duration(seconds: 2),
            top: -20.0,
            left: !snapshot.data.isNightTime
                ? -20.0 + ((snapshot.data.currentDateTime.hour / 24) * screenWidth)
                : -20.0,
            child: Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: snapshot.data.getLuminatedObjectColor,
                      blurRadius: 40.0, // has the effect of softening the shadow
                      spreadRadius: 20.0, // has the effect of extending the shadow
                    )
                  ],

                  gradient: LinearGradient(
                    colors: [snapshot.data.getLuminatedObjectColor.withOpacity(0.1), snapshot.data.getLuminatedObjectColor],
                    stops: [0.1, 0.5],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )
              ),
            ),
          );
        }
        else{
          return Container(
            color: Colors.transparent,
          );
        }

      }
    );
  }
}




/// Widget is a rising progress liquid that progresses according to the time already elasped throughout the day (24 hour)
/// from 00:00 am to 23:59 pm
class TimeProgressLiquidWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return StreamBuilder<ClockModel>(
      stream: _bloc.getClockModelStream,
      builder: (context, snapshot) {

        if (snapshot.hasData){
          return LiquidLinearProgressIndicator(
            value: snapshot.hasData? snapshot.data.getDayProgressValue: 0.0,
            valueColor: AlwaysStoppedAnimation(snapshot.data.getLuminatedObjectColor.withOpacity(0.4)),
            backgroundColor: Colors.transparent,
            direction: Axis.vertical
          );
        }
        else{
          return Container();
        }

      }
    );
    ;
  }
}






/// This Widget is the background that represennts the sky which is clear during the day and dark at night
class ClockSkyBackgroundColorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<ClockModel>(
      stream: _bloc.getClockModelStream,
      builder: (context, snapshot) {

        if (snapshot.hasData){
          return AnimatedContainer(
            duration: _provider.animatedColorDuration,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [snapshot.data.getSkyColor, snapshot.data.getSkyColor.withOpacity(0.2)],
                  stops: [0.4, 0.7],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
            )
          );
        }
        else{
          return Container();
        }

      }
    );
  }
}




/// Group of swimming fishes widget
class SwimmingFishesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double scaleFactor = 0.125;

    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {

          if (snapshot.hasData){

            return Container(
              height: screenHeight * 0.75 * snapshot.data.getDayProgressValue,
                width: screenWidth,
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Column(
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for (int count = 1; count <= 2; ++count )
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Fish(
                                    size: 100.0,
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for (int count = 1; count <= 3; ++count )
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Fish(
                                    size: 100.0,
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for (int count = 1; count <= 2; ++count )
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Fish(
                                    size: 100.0,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      )

                    ],
                  ),
                ),
            );
          }
          else{
            return Container();
          }

        }
    );
  }
}





/// Group of flying birds widget
class FlyingBirdsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {

          if (snapshot.hasData && (!snapshot.data.isNightTime)){

            return Container(
              padding: EdgeInsets.only(top: 20.0),
              height: screenHeight * 0.25,
              width: screenWidth,
              child: FittedBox(
                child: Column(
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for (int count = 1; count <= 2; ++count )
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Bird(
                              size: 75.0,
                            ),
                          ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for (int count = 1; count <= 3; ++count )
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Bird(
                              size: 75.0,
                            ),
                          ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for (int count = 1; count <= 2; ++count )
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Bird(
                              size: 75.0,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );

          }
          else{
            return Container();
          }

        }
    );
  }
}






/// Widget contains stars that blinks and shine at night
class GroupStarsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {

          if (snapshot.hasData && (snapshot.data.currentDateTime.hour < 6 || snapshot.data.currentDateTime.hour >= 18 )){

            return Container(
              padding: EdgeInsets.only(top: 10.0),
              height: screenHeight * 0.25,
              width: screenWidth,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        for (int count = 1; count <= 6; ++count)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Star(
                              starSize: Size(15.0, 15.0),
                            ),
                          )

                      ],
                    ),
                    SizedBox(height: 50.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        for (int count = 1; count <= 7; ++count)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Star(
                              starSize: Size(20.0, 20.0),
                            ),
                          )

                      ],
                    ),
                    SizedBox(height: 50.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        for (int count = 1; count <= 6; ++count)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Star(
                              starSize: Size(15.0, 15.0),
                            ),
                          )

                      ],
                    ),
                    SizedBox(height: 50.0,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        for (int count = 1; count <= 7; ++count)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Star(
                              starSize: Size(20.0, 20.0),
                            ),
                          )

                      ],
                    ),
                    SizedBox(height: 50.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        for (int count = 1; count <= 6; ++count)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100.0),
                            child: Star(
                              starSize: Size(15.0, 15.0),
                            ),
                          )

                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            return Container();
          }

        }
    );
  }
}






/// Widget contains a rainbow that appears in the early morning
class RainBowWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {

          if (snapshot.hasData && (snapshot.data.currentDateTime.hour >= 6 && snapshot.data.currentDateTime.hour < 9)){

            return RainbowEffect(
              width: screenWidth,
              height: screenHeight,
              strokethickness: 5.0,
              opacity: 0.3,
            );
          }
          else{
            return Container();
          }

        }
    );
  }
}




/// This widget contains weather effects that take effect based on the weather conditions
class WeatherConditionWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ClockBlocProvider _provider = ClockBlocProvider.of(context);
    ClockBloc _bloc = ClockBlocProvider.of(context).bloc;
    ThemeData _themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<ClockModel>(
        stream: _bloc.getClockModelStream,
        builder: (context, snapshot) {

          if (snapshot.hasData){

            switch(snapshot.data.weatherCondition){
              case WEATHER_CONDITION.CLOUDY:

                if (!snapshot.data.isNightTime){
                  return CloudyEffect();
                }
                else{
                  return Container();
                }
                break;
              case WEATHER_CONDITION.RAINY:
                return RainyEffect();
              case WEATHER_CONDITION.SNOWY:
                return SnowyEffect();
              case WEATHER_CONDITION.FOGGY:
                return FoggyEffect();
              case WEATHER_CONDITION.SUNNY:
                return Container();
              case WEATHER_CONDITION.THUNDERSTORM:
                return FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: <Widget>[

                      for (int count = 1; count<= 3; ++count)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: ThunderstormEffect(),
                        ),
                    ],
                  ),
                );
              default:
                return Container();
            }

          }
          else{
            return Container();
          }

        }
    );
  }
}





