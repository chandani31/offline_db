import 'package:flutter/material.dart';

import 'Database/sqflite.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key,});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
{
  List<Map<String,dynamic>> addNotebookDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      addNotebookDataList = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView.builder(
          itemCount: addNotebookDataList.length,
          itemBuilder: (BuildContext context, index)
          {
            return ListTile(
              title: Text(addNotebookDataList[index]["firstName"]),
              subtitle: Column(
                children: [
                  Text("lastName"),
                  Text("dob"),
                  Text("address"),
                  Text("city"),
                  Text("email"),
                  Text("password"),
                  Text("confirmPassword"),
                ],
              ),
            );
          }),
    );
  }
}
