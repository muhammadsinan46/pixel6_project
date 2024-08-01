

import 'package:flutter/material.dart';
import 'package:pixel6_app/model/employee_model.dart';

import 'package:shimmer/shimmer.dart';

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
        columns:  const  [
            DataColumn(
                label: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [Text("ID "), Icon(Icons.swap_vert)],
                            )),
            DataColumn(label: Text("Image")),
            DataColumn(
                label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [Text("Full Name"), Icon(Icons.swap_vert)],
                            )),
            DataColumn(
                label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [Text("Demography"), Icon(Icons.swap_vert)],
                            )),
          ],
        rows: List.generate(employList.isEmpty?16:employList.length, (index) {
          return DataRow(cells: [
            DataCell(Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
              child: Text("${index+1}"))),
            DataCell(Shimmer.fromColors(
                       baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
              child: SizedBox(
                  width: 50, child: Image.asset('assets/images/pixel_logo.png')),
            )),
            DataCell(Shimmer.fromColors(
                       baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
              child: Text(
                  "Full name"),
            )),
            DataCell(Shimmer.fromColors(
                       baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
              child: const Text(
                          "Gender"
                  ),
            )),
    
          ]);
        }));
  }
}