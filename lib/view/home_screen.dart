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
      body: ListView(
        controller: _scrollController,
        //    physics: NeverScrollableScrollPhysics(),
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Employees",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.filter_alt),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownMenu(
                      enableSearch: false,
                      label: const Text("Gender"),
                      dropdownMenuEntries:
                          ["Male", "Female","Default"].map<DropdownMenuEntry>((value) {
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
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            margin: const EdgeInsets.all(12),
            width: MediaQuery.sizeOf(context).width,
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                print(state.runtimeType);
                if (state is EmployeeLoadingState) {
                  return LoadingTable(employList: employList);
                } else if (state is EmployeeLoadedState) {
                  employList = state.employeeList;
                
                  return SingleChildScrollView(
                      // controller: _scrollController,
                      // slivers: [
                      //   SliverToBoxAdapter(
                      child: EmployeeDataTable(employeeList: employList));
                }  else {
                  return const Center(
                    child: Text("Oops!. No Data Available"),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
