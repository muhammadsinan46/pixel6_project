import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_app/controller/employee_bloc/employee_bloc.dart';
import 'package:pixel6_app/model/employee_model.dart';
import 'package:pixel6_app/view/widgets/loaded_table.dart';
import 'package:pixel6_app/view/widgets/loading_table.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employList = [];

  final _scrollController = ScrollController();

  String genderValue = "";

  @override
  void initState() {
    context.read<EmployeeBloc>().add(EmployeeLoadedEvent());
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // to refresh the data table while scrollingdown to get more data from api
        context.read<EmployeeBloc>().add(EmployeeLoadedEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/pixel_logo.png',
            ),
          ),
          forceMaterialTransparency: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
              ),
            )
          ]),
      body:
      
       NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                surfaceTintColor: Colors.white,
                title: const Text("Employees"),
                titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                actions: [
                  const Icon(Icons.filter_alt, color: Color.fromARGB(255, 167, 18, 7),),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownMenu(
                    enableSearch: false,
                    label: const Text("Gender"),
                    dropdownMenuEntries: ["Male", "Female", "Default"]
                        .map<DropdownMenuEntry>((value) {
                      return DropdownMenuEntry(value: value, label: value);
                    }).toList(),
                    onSelected: (value) {
                      setState(() {
                        genderValue = value;
                        context.read<EmployeeBloc>().add(
                            EmployeeGenderFilterEvent(
                                genderValue: genderValue));
                      });
                    },
                  )
                ],
                pinned: true,
              )
            ];
          },
          body:
          
           Container(
            height: MediaQuery.sizeOf(context).height,
            margin: const EdgeInsets.only(top:20, left: 12, right: 12, ),
            width: MediaQuery.sizeOf(context).width,
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
        
                if (state is EmployeeLoadingState) {
                  //loading data table enables skelton view while loading the data
                  return LoadingTable(employList: employList);
                } else if (state is EmployeeLoadedState) {
                  employList = state.employeeList;

                  //employeedatatable enables fetch the data and infite scrolling
                  return EmployeeDataTable(employeeList: employList);
                } else {
                  return const Center(
                    child: Text("Oops!. No Data Available"),
                  );
                }
              },
            ),
          )),
    );
  }
}
