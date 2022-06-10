import '../widgets/clients/add_client.dart';

import '../screens/agent_screens/see_orders_screen.dart';

import '../screens/agent_screens/add_order_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/grid_item.dart';
class AgentHome extends StatefulWidget {
  const AgentHome({Key? key}) : super(key: key);

  @override
  State<AgentHome> createState() => _AgentHomeState();
}

class _AgentHomeState extends State<AgentHome> {
  @override
  Widget build(BuildContext context) {
    return  GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GridItem(itemTitle: 'Add Order',color:const Color.fromARGB(255,192,192,192) 
            , iconp: Icons.add_box,onTapHandler: (){
              Navigator.of(context).pushNamed(AddOrderScreen.routeName);
            }),
             GridItem(
               itemTitle: 'Require to add client',
               color:const Color.fromARGB(255,0,229,232)
            , iconp: Icons.business_center,
            onTapHandler: ()=>Navigator.of(context).pushNamed(AddClientScreen.routeName)),
  
              GridItem(
               itemTitle: 'See today orders',
               color:const Color.fromARGB(255,244,208,111),
            iconp: Icons.list_alt,
            onTapHandler: ()=>Navigator.of(context).pushNamed(SeeOrdersScreen.routeName)),
               
    
              
    
         ],
         
         );
  }
}