import 'package:distroapp/widgets/employee/employe_details_body.dart';

import '../../providers/users.dart';
import 'package:distroapp/model/employe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
class EmployeeDetailsScreen extends StatefulWidget {
  EmployeeDetailsScreen({Key? key}) : super(key: key);
  static const routeName = "/employee-show";
  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final employeeId=ModalRoute.of(context)!.settings.arguments;
    print('employye id from escreen ${employeeId}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: Text('Employe details'),
      ),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: BoxDecoration(
          color: Colors.blue[800],
        ),
        child:EmployeDetailsBody(employeId: employeeId,deviceHeight: deviceHeight,deviceWidth: deviceWidth,),
      ),
    );
  }

}
