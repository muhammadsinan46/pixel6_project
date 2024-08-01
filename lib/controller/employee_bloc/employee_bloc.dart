import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel6_app/model/employee_model.dart';
import 'package:pixel6_app/controller/repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeRepository employeeRepo;
  EmployeeBloc(this.employeeRepo) : super(const EmployeeState()) {
    on<EmployeeLoadedEvent>(employeeDataLoaded);
    on<EmployeeGenderFilterEvent>(employeeGenderFilter);
    on<EmployeeSortEvent>(employeeListSort);
  }

  int limit = 16;
  int skip = 0;
  List<Employee> employeeList = [];
  bool ascending = false;

  //fetch employees details from API
  FutureOr<void> employeeDataLoaded(
      EmployeeLoadedEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());

    try {
      final List<Employee> employData =
          await employeeRepo.getEmployeeDetails(limit, skip);

      employeeList.addAll(employData);

      emit(EmployeeLoadedState(employeeList: employeeList));
      limit + 16;
      skip = skip + 16;
    } catch (e) {
      Exception(e.toString());
    }
  }

// filter the list based on the gender
  FutureOr<void> employeeGenderFilter(
      EmployeeGenderFilterEvent event, Emitter<EmployeeState> emit) {
    String genderValue = event.genderValue.toLowerCase();

    List<Employee> genderFliterList =
        employeeList.where((value) => value.gender == genderValue).toList();

    if (genderValue != "default") {
      emit(EmployeeLoadedState(employeeList: genderFliterList));
    } else {
      emit(EmployeeLoadedState(employeeList: employeeList));
    }
  }

//Sorting functionality based on Id
  FutureOr<void> employeeListSort(
      EmployeeSortEvent event, Emitter<EmployeeState> emit) {
    if (ascending == true) {
      //sort into descending order
      switch (event.sortItem) {
        case "id":
          employeeList.sort((b, a) => a.id!.compareTo(b.id!));
          ascending = false;
          break;
        case "name":
          employeeList.sort((b, a) => a.firstName!.compareTo(b.firstName!));
          ascending = false;
          break;

        case "age":
          employeeList.sort((b, a) => a.age!.compareTo(b.age!));
          ascending = false;
          break;
      }
    } else if (ascending == false) {
      //sort into ascending order
      switch (event.sortItem) {
        case "id":
          employeeList.sort((a, b) => a.id!.compareTo(b.id!));
          ascending = true;
          break;
        case "name":
          employeeList.sort((a, b) => a.firstName!.compareTo(b.firstName!));
          ascending = true;

          break;

        case "age":
          employeeList.sort((a, b) => a.age!.compareTo(b.age!));
          ascending = true;
          break;
      }
    }
    emit(EmployeeLoadingState());
    emit(EmployeeLoadedState(employeeList: employeeList));
  }
}
