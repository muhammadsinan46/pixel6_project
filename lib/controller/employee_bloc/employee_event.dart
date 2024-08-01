part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}


class EmployeeLoadingEvent extends EmployeeEvent{}
class EmployeeLoadedEvent extends EmployeeEvent{}

class EmployeeGenderFilterEvent extends EmployeeEvent{

  final String  genderValue;

 const  EmployeeGenderFilterEvent({required this.genderValue});

 @override
  List<Object> get props =>[genderValue];

}

 class EmployeeSortEvent extends EmployeeEvent{
  final String sortItem;

  const EmployeeSortEvent({required this.sortItem});

  @override
  List<Object> get props =>[sortItem];

 }
