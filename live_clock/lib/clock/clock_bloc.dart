import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'clock_dependency_injection.dart';
import 'clock_model.dart';
import 'clock_repository.dart';



abstract class ClockBlocBlueprint{

  ClockModel getCurrentDateTimeClockModel();

  void dispose();
}


class ClockBloc implements ClockBlocBlueprint{


  final bool speedUpTime;


  // Streams Clock Model data
  BehaviorSubject<ClockModel> _clockModelBehaviorSubject = BehaviorSubject<ClockModel>();
  Stream<ClockModel> get getClockModelStream => _clockModelBehaviorSubject.stream;
  StreamSink<ClockModel> get _getClockModelSink => _clockModelBehaviorSubject.sink;


  //
  ClockRepository _clockRepository;


  ClockBloc({this.speedUpTime = false}){

    // Get Repository through dependency injection
    _clockRepository = ClockDependencyInjector().getClockRepository;
  }


  // Adds current datetime to stream
  void addClockModelToStream({@required ClockModel clockModel}){
    _getClockModelSink.add(clockModel);
  }


  // Gets Clock Model
  @override
  ClockModel getCurrentDateTimeClockModel() {
    return _clockRepository.getCurrentDateTimeClockModel();
  }


  // Disposes all stream controllers
  @override
  void dispose() {
    _clockModelBehaviorSubject?.close();
  }
}


