import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel6_app/model/employee_model.dart';
import 'package:pixel6_app/controller/repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {

 EmployeeRepository   employeeRepo ;
  EmployeeBloc(this.employeeRepo) : super(const EmployeeState()){

    
    on<EmployeeLoadedEvent>(employeeDataLoaded);
  }

  int limit =10;
  int skip =0;
List<Employee> employeeList =[];
 FutureOr<void> employeeDataLoaded(EmployeeLoadedEvent event, Emitter<EmployeeState> emit)async {



    emit(EmployeeLoadingState());

    try{

      final List<Employee> employData = await employeeRepo.getEmployeeDetails(limit, skip);
      employeeList.addAll(employData);
 
      emit(EmployeeLoadedState(employeeList: employeeList));
      limit+10;
      skip=skip+10;
    }catch(e){


      Exception(e.toString());
    }
  }
}
