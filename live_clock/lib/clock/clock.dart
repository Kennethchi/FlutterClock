import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'clock_model.dart';
import 'clock_view.dart';
import 'clock_bloc.dart';
import 'clock_bloc_provider.dart';



class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {


  ClockBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initialises the bloc
    _bloc = ClockBloc(speedUpTime: false);


    if (_bloc.speedUpTime){

      // Speeds up time
      Timer.periodic(Duration(milliseconds: 1), (Timer timer){
        int milliseconds = timer.tick % (24 * 60 * 60 * 1000);
        ClockModel currentDateTimeclockModel =  ClockModel(

            currentDateTime: DateTime.now().add(Duration(milliseconds: milliseconds * 1000 * 6))
        );
        _bloc.addClockModelToStream(clockModel: currentDateTimeclockModel);
      });
    }
    else{

      // Time runs normally
      // Gets current date and time clock model and adds it to stream every second
      Timer.periodic(Duration(seconds: 1), (Timer timer){
        ClockModel currentDateTimeclockModel =  _bloc.getCurrentDateTimeClockModel();
        _bloc.addClockModelToStream(clockModel: currentDateTimeclockModel);
      });
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose

    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClockBlocProvider(
        bloc: _bloc,
        child: ClockView()
    );
  }
}
