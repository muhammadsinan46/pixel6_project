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

 FutureOr<void> employeeDataLoaded(EmployeeLoadedEvent event, Emitter<EmployeeState> emit)async {

    emit(EmployeeLoadingState());

    try{

      final employeeList = await employeeRepo.getEmployeeDetails();

      emit(EmployeeLoadedState(employeeList: employeeList));
    }catch(e){


      Exception(e.toString());
    }
  }
}
