import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:live_clock/constants.dart';


class ClockModel{


  // Current date and timw
  DateTime currentDateTime;
  double temperatureInCelsius;
  
  // Weather Condition
  WEATHER_CONDITION weatherCondition;

  ClockModel({
    @required this.currentDateTime,
    this.weatherCondition = WEATHER_CONDITION.SUNNY,
    this.temperatureInCelsius = 24
  });

  // gets formatted current time string
  String get getCurrentTimeFormat{
    return DateFormat.jm().format(this.currentDateTime);
  }

  // gets current hour formatted
  String get getCurrentHourFormat{
    if ((currentDateTime.hour >= 10 && currentDateTime.hour <= 12)){
      return currentDateTime.hour.toString();
    }
    else if (currentDateTime.hour == 22 || currentDateTime.hour == 23){
      return (currentDateTime.hour % 12).toString();
    }
    else{
      return "0" + (currentDateTime.hour % 12).toString();
    }
  }


  // gets current minute formatted
  String get getCurrentMinuteFormat{
    if (currentDateTime.minute < 10){
      return "0" + currentDateTime.minute.toString();
    }
    else{
      return currentDateTime.minute.toString();
    }
  }

  // gets date format
  String get getCurrentDateFormat{
    return DateFormat.yMMMEd().format(this.currentDateTime).toUpperCase();
  }

  // gets time progress through out the day
  double get getDayProgressValue{

    return (currentDateTime.hour + (currentDateTime.minute / 60)) / 24;
  }


  // Gets sky color
  Color get getSkyColor{

    if (currentDateTime.hour >= 6 && currentDateTime.hour < 12){
      return Colors.lightBlueAccent.shade200;
    }
    else if (currentDateTime.hour >= 12 && currentDateTime.hour < 16){
      return Colors.lightBlueAccent;
    }
    else if (currentDateTime.hour >= 16 && currentDateTime.hour < 17){
      return Colors.yellow.shade50;
    }
    else if (currentDateTime.hour >= 17 && currentDateTime.hour < 18){
      return Colors.yellow.shade300;
    }
    /*
    else if (currentDateTime.hour >= 18 && currentDateTime.hour < 19){
      return Colors.yellow.shade400;
    }
    */
    else if (currentDateTime.hour >= 18){
      return Colors.black;
    }
    else if (currentDateTime.hour >= 0 && currentDateTime.hour < 6){
      return Colors.black;
    }
    else{
      return Colors.transparent;
    }

  }




  // gets color for the sun or moon
  Color get getLuminatedObjectColor{

    if (currentDateTime.hour >= 6 && currentDateTime.hour < 10){
      return Colors.yellow.shade100;
    }
    else if (currentDateTime.hour >= 10 && currentDateTime.hour < 12){
      return Colors.yellow.shade300;
    }
    else if (currentDateTime.hour >= 12 && currentDateTime.hour < 16){
      return Colors.yellow;
    }
    else if (currentDateTime.hour >= 16 && currentDateTime.hour < 17){
      return Colors.yellow.shade600;
    }
    else if (currentDateTime.hour >= 17 && currentDateTime.hour < 18){
      return Colors.yellow.shade700;
    }
    else if (currentDateTime.hour >= 18){
      return Colors.blue.shade50;
    }
    else if (currentDateTime.hour >= 0 && currentDateTime.hour < 6){
      return Colors.blue.shade50;
    }
    else{
      return Colors.transparent;
    }

  }


  // gets temperature Format
  String get getTemperatureFormat{

    return "${temperatureInCelsius} °C";
  }


  // Determines whether its daytime or nightime
  bool get isNightTime{

    if (currentDateTime.hour < 6 || currentDateTime.hour >= 18){
      return true;
    }
    else{
      return false;
    }
  }

  // Gets weather condition
  WEATHER_CONDITION get getWeatherCondition{
    if (this.weatherCondition != null){
      return this.weatherCondition;
    }
    else{
      return WEATHER_CONDITION.SUNNY;
    }
  }
}