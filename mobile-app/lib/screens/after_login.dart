import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../home_widgets/driver_home.dart';
import '../home_widgets/storeman_home.dart';
import '../providers/authentification.dart';
import '../screens/manage_account_screen.dart';
import '../home_widgets/handler_home.dart';
import '../home_widgets/agent_home.dart';
import '../home_widgets/manager_home.dart';
import '../home_widgets/accountant_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.role }) : super(key: key);
static const routeName='/home';
 final String role;
 Widget _buildChild(){
 switch(role){
   case 'accountant':
     return const AccountantHome();
   case 'manager':
   return const ManagerHome();
    case 'agent':
   return const AgentHome();
   case 'handler':
   return const  HandlerHome();
   case 'driver':
   return const DriverHome();
   case 'storeman':
   return const StoremanHome();
   default:
   return 
   const Center(child:  Text('this role does not exist'));
 

 }
 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:const  Text('Home'),
       actions: <Widget>[
         IconButton(onPressed: ()=>Navigator.of(context).pushNamed(ManageAccountScreen.routeName),
         icon: const Icon(Icons.manage_accounts)),
         IconButton(onPressed: (){
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
         Provider.of<Authentication>(context,listen:false).logout();},
         icon: const Icon(Icons.logout)),
       ],),
      body:   Container(
        decoration: BoxDecoration(
    color: Colors.blue[800],
  ),
        child:_buildChild(),

        )
    );
  }
}
