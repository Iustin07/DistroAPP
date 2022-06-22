import './employe_details_body.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsScreen extends StatefulWidget {
const  EmployeeDetailsScreen({Key? key}) : super(key: key);
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Employe details'),
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
