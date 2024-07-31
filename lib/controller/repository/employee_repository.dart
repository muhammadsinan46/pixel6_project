import "dart:convert";

import "package:http/http.dart" as http;
import "package:pixel6_app/model/employee_model.dart";

String baseUrl = "https://dummyjson.com/users";

class EmployeeRepository {
  Future getEmployeeDetails() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List employees = data['users'];

    print("length is ${employees.length}");
        return employees.map((data) => Employee.fromJson(data)).toList();
      }
    } catch (e) {
      Exception(e);
    }
  }
}
