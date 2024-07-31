import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_app/controller/employee_bloc/employee_bloc.dart';
import 'package:pixel6_app/model/employee_model.dart';
import 'package:pixel6_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employList = [];

  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent
          
          
          ) {

            // to refresh the data table while scrollingdown to get more data from api 
             context.read<EmployeeBloc>().add(EmployeeLoadedEvent());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    context.read<EmployeeBloc>().add(EmployeeLoadedEvent());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
           controller: _scrollController,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
     
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 400,
                child: const Row(
                  children: [
                    Text("Employees"),
                    Row(
                      children: [
                        Icon(Icons.filter),
                        // DropdownButtonFormField(items: [], onChanged: (){}),
                        // DropdownButtonFormField(items: items, onChanged: onChanged),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                   height: MediaQuery.sizeOf(context).height,
              margin: const EdgeInsets.all(12),
              width: MediaQuery.sizeOf(context).width - 400,
                child: BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                
                    print(state.runtimeType);
                    if (state is EmployeeLoadingState) {
                      return LoadingTable(employList: employList);
                    } else if (state is EmployeeLoadedState) {
                      employList = state.employeeList;
                      
                      return CustomScrollView(
            
                        slivers: [
                          SliverToBoxAdapter(
                            child: DataTable(
                          showBottomBorder: false,
                            headingTextStyle:
                              const   TextStyle(fontWeight: FontWeight.bold),
                            columnSpacing: 20.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30)),
                            columns: const [
                              DataColumn(
                                  label: Row(
                                children: [Text("ID "), Icon(Icons.swap_vert)],
                              )),
                              DataColumn(label: Text("Image")),
                              DataColumn(
                                  label: Row(
                                children: [
                                  Text("Full Name "),
                                  Icon(Icons.swap_vert)
                                ],
                              )),
                              DataColumn(label: Text("Demography")),
                              DataColumn(label: Text("Designation")),
                              DataColumn(label: Text("Location")),
                            ],
                            rows: List.generate(employList.length, (index) {
                              return DataRow(cells: [
                                DataCell(Text("${employList[index].id}")),
                                DataCell(SizedBox(
                                    width: 50,
                                    child: Image.network(
                                        "${employList[index].image}"))),
                                DataCell(Text(
                                    "${employList[index].firstName} ${employList[index].maidenName}")),
                                DataCell(Text(
                                    demographyFormatter("${employList[index].gender}", employList[index].age.toString()))),
                                DataCell(
                                    Text("${employList[index].company!.title}")),
                                DataCell(Text(
                                    "${employList[index].address!.state}, ${employList[index].address!.country}")),
                              ]);
                            })
                            ),
                          )
                        ],
                  
                      );
                    } else {
                      return const Center(
                        child: Text("Oops!. No Data Available"),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingTable extends StatelessWidget {
  const LoadingTable({
    super.key,
    required this.employList,
  });

  final List<Employee> employList;

  @override
  Widget build(BuildContext context) {
    return DataTable(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30)),
        columns: const [
          DataColumn(
              label: Row(
            children: [Text("ID "), Icon(Icons.swap_vert)],
          )),
          DataColumn(label: Text("Image")),
          DataColumn(
              label: Row(
            children: [Text("Full Name "), Icon(Icons.swap_vert)],
          )),
          DataColumn(label: Text("Demography")),
          DataColumn(label: Text("Designation")),
          DataColumn(label: Text("Location")),
        ],
        rows: List.generate(employList.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text("${employList[index].id}")),
                          DataCell(SizedBox(
                              width: 50,
                              child: Image.network(
                                  "${employList[index].image}"))),
                          DataCell(Text(
                              "${employList[index].firstName} ${employList[index].maidenName}")),
                          DataCell(Text(
                              "${demographyFormatter("${employList[index].gender}", employList[index].age.toString())}")),
                          DataCell(
                              Text("${employList[index].company!.title}")),
                          DataCell(Text(
                              "${employList[index].address!.state}, ${employList[index].address!.country}")),
                        ]);
                      }));
  }
}
