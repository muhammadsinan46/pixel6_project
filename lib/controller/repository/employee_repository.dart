import "dart:convert";

import "package:http/http.dart" as http;
import "package:pixel6_app/model/employee_model.dart";

String baseUrl = "https://dummyjson.com/users/";

class EmployeeRepository {
   
  Future<List<Employee>> getEmployeeDetails(int limit, int skip) async {
    final url = Uri.parse('$baseUrl?limit=$limit&skip=$skip');
    final response = await http.get(url);

    try {


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List employees = data['users'];
      
   
          List<Employee> employeeList = employees.map((data) => Employee.fromJson(data)).toList();

        return employeeList;
      }
    } catch (e) {
   throw Exception("erro is $e.toString()");
    }
   throw Exception("error of getting data");
  }







}
