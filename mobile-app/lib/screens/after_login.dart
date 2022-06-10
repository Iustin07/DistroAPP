import 'package:distroapp/home_widgets/driver_home.dart';
import 'package:distroapp/home_widgets/storeman_home.dart';

import '../providers/authentification.dart';
import '../screens/auth_screen.dart';
import '../screens/manage_account_screen.dart';
import '../home_widgets/handler_home.dart';
import '../home_widgets/agent_home.dart';
import '../home_widgets/manager_home.dart';
import 'package:flutter/material.dart';
import '../home_widgets/accountant_home.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.role }) : super(key: key);
static const routeName='/home';
 final String role;
 Widget _buildChild(){
 switch(role){
   case 'accountant':
     return AccountantHome();
   case 'manager':
   return ManagerHome();
    case 'agent':
   return AgentHome();
   case 'handler':
   return HandlerHome();
   case 'driver':
   return DriverHome();
   case 'storeman':
   return StoremanHome();
   default:
   return Container(
     child: Center(child:  Text('this role does not exist')),
   );
   break;
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
           //pop until
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
         //Navigator.of(context).pushNamed(AuthScreen.routeName);  
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
