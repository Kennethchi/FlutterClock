import 'dart:async';
import 'package:meta/meta.dart';

import 'clock_model.dart';
import 'clock_repository.dart';


// Mock Repository
class ClockMockRepository extends ClockRepository{


  @override
  ClockModel getCurrentDateTimeClockModel() {

    return ClockModel(currentDateTime: DateTime.now());
  }
}