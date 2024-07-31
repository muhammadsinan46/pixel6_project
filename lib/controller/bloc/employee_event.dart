part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}


class EmployeeLoadingEvent extends EmployeeEvent{}
class EmployeeLoadedEvent extends EmployeeEvent{}