import '../screens/manager_screens.dart/manage_losts_manager.dart';
import '../screens/manager_screens.dart/stats_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/grid_item.dart';
import '../screens/manage_employees_screen.dart';
import '../screens/manage_clients.dart';
class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GridItem(itemTitle: 'Stats',color:const Color.fromARGB(255,192,192,192) 
            , iconp: Icons.analytics,
             onTapHandler: ()=>Navigator.of(context).pushNamed(StatsScreen.routeName)),
             GridItem(
               itemTitle: 'Manage employees',
               color:const Color.fromARGB(255,0,229,232)
            , iconp: Icons.person_search,
            onTapHandler: ()=>Navigator.of(context).pushNamed(ManageEmployeScreen.routeName)),
  
              GridItem(
               itemTitle: 'View Losts',
               color:const Color.fromARGB(255,244,208,111),
            iconp: Icons.book,
            onTapHandler: ()=>Navigator.of(context).pushNamed(ManageLostsManagerScreen.routeName),
              ),
                  GridItem(
               itemTitle: 'Manage clients',
               color:const Color.fromARGB(255,250,250,255),
            iconp: Icons.business_center,
         
            onTapHandler: ()=>Navigator.of(context).pushNamed(ManageClientsScreen.routeName),
     ),
  
    
         ],
         
         );
  }
}