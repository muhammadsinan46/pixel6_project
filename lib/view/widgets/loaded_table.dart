

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_app/controller/employee_bloc/employee_bloc.dart';
import 'package:pixel6_app/model/employee_model.dart';
import 'package:pixel6_app/utils/utils.dart';

class EmployeeDataTable extends StatelessWidget {
  EmployeeDataTable({super.key, required this.employeeList});

  List<Employee> employeeList;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: DataTable(
      
          headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          columnSpacing: 20.2,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30)),
          columns:  [
            DataColumn(
                label: GestureDetector(

                  onTap: () {
                    context.read<EmployeeBloc>().add(const EmployeeSortEvent(sortItem: "id"));
                  },
                  child:const  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [Text("ID "), Icon(Icons.swap_vert)],
                              ),
                )),
            const DataColumn(label: Text("Image")),
            DataColumn(
                label: GestureDetector(
                    onTap: () {
                    context.read<EmployeeBloc>().add(const EmployeeSortEvent(sortItem: "name"));
                  },
                  child:const  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text("Full Name"), Icon(Icons.swap_vert)],
                              ),
                )),
            DataColumn(
                label: GestureDetector(

                    onTap: () {
                    context.read<EmployeeBloc>().add(const EmployeeSortEvent(sortItem: "age"));
                  },
                  child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text("Demography"), Icon(Icons.swap_vert)],
                              ),
                )),
          ],
          rows: List.generate(employeeList.length, (index) {
            return DataRow(cells: [
              DataCell(Text("${employeeList[index].id}")),
              DataCell(SizedBox(
                  width: 50,
                  child: Image.network("${employeeList[index].image}"))),
              DataCell(Text(
                  "${employeeList[index].firstName} ${employeeList[index].maidenName}")),
              DataCell(Text(demographyFormatter("${employeeList[index].gender}",
                  employeeList[index].age.toString()))),
            ]);
          })),
    );
  }
}