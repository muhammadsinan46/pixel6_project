

import 'package:flutter/material.dart';
import 'package:pixel6_app/model/employee_model.dart';
import 'package:pixel6_app/utils/utils.dart';

class LoadingTable extends StatelessWidget {
  const LoadingTable({
    super.key,
    required this.employList,
  });

  final List<Employee> employList;

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columnSpacing: 10.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30)),
        columns: const [
          DataColumn(
              label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("ID "), Icon(Icons.swap_vert)],
          )),
          DataColumn(label: Text("Image")),
          DataColumn(
              label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Full Name "), Icon(Icons.swap_vert)],
          )),
          DataColumn(label: Text("Demography")),
          // DataColumn(label: Text("Designation")),
          // DataColumn(label: Text("Location")),
        ],
        rows: List.generate(employList.length, (index) {
          return DataRow(cells: [
            DataCell(Text("${employList[index].id}")),
            DataCell(SizedBox(
                width: 50, child: Image.network("${employList[index].image}"))),
            DataCell(Text(
                "${employList[index].firstName} ${employList[index].maidenName}")),
            DataCell(Text(
                "${demographyFormatter("${employList[index].gender}", employList[index].age.toString())}")),
            // DataCell(Text("${employList[index].company!.title}")),
            // DataCell(Text(
            //     "${employList[index].address!.state}, ${employList[index].address!.country}")),
          ]);
        }));
  }
}