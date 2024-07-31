part of 'employee_bloc.dart';

 class EmployeeState extends Equatable {
  const EmployeeState();
  
  @override
  List<Object> get props => [];
}


final class EmployeeLoadingState extends EmployeeState {}
final class EmployeeLoadedState extends EmployeeState {

  final List<Employee> employeeList;
 

   const  EmployeeLoadedState({required this.employeeList});


    @override
      List<Object> get props =>[employeeList];

  



  
}
