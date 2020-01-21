import 'package:meta/meta.dart';
import 'package:live_clock/constants.dart';

import 'clock_mock_repository.dart';
import 'clock_production_repository.dart';
import 'clock_repository.dart';




class ClockDependencyInjector{

  ClockDependencyInjector._internal();

  static final ClockDependencyInjector _singleton = ClockDependencyInjector._internal();

  factory ClockDependencyInjector(){
    return _singleton;
  }

  static REPOSITORY_DEPENDENCY _repositoryDependency;

  static void confgure({@required REPOSITORY_DEPENDENCY repository_dependency}){
    _repositoryDependency = repository_dependency;
  }


  ClockRepository get getClockRepository{

    switch (_repositoryDependency){
      case REPOSITORY_DEPENDENCY.MOCK:
        return ClockMockRepository();
      case REPOSITORY_DEPENDENCY.PRODUCTION:
        return ClockProductionRepository();
    }
  }




}