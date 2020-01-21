import 'dart:async';
import 'package:meta/meta.dart';

import 'clock_model.dart';


abstract class ClockRepository{

  ClockModel getCurrentDateTimeClockModel();
}

