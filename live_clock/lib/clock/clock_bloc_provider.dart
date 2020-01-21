import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'clock_bloc.dart';



class ClockBlocProvider extends InheritedWidget{

  final ClockBloc bloc;
  final Key key;
  final Widget child;

  Duration animatedColorDuration;

  ClockBlocProvider({@required this.bloc, this.key, this.child}): super(key: key, child: child){
    animatedColorDuration = Duration(seconds: 2);
  }


  static ClockBlocProvider of(BuildContext context) => (context.inheritFromWidgetOfExactType(ClockBlocProvider) as ClockBlocProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}