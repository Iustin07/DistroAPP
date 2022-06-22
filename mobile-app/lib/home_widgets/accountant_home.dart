import '../screens/accountant_screens.dart/manage_centralizers_screen.dart';
import '../screens/accountant_screens.dart/manage_orders.dart';
import '../screens/manage_clients.dart';
import '../screens/manage_employees_screen.dart';
import '../screens/manage_products.dart';
import'package:flutter/material.dart';
import '../widgets/grid_item.dart';
import '../screens/storeman_screens/shipping_screen.dart';
class AccountantHome extends StatefulWidget {
 const  AccountantHome({Key? key}) : super(key: key);

  @override
  State<AccountantHome> createState() => _AccountantHomeState();
}

class _AccountantHomeState extends State<AccountantHome> {
  @override
  Widget build(BuildContext context) {
    return 
   GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GridItem(key: UniqueKey(),
              itemTitle: 'Manage products',color:const Color.fromARGB(255,192,192,192) 
            , iconp: Icons.inventory_2, onTapHandler: ()=>Navigator.of(context).pushNamed(ManageProductsScreen.routeName)),
             GridItem(
               itemTitle: 'Manage employees',
               color:const Color.fromARGB(255,0,229,232)
            , iconp: Icons.person_search,
            onTapHandler:()=>Navigator.of(context).pushNamed(ManageEmployeScreen.routeName)
    ),
  
              GridItem(
               itemTitle: 'Manage orders',
               color:const Color.fromARGB(255,244,208,111),
            iconp: Icons.list_alt,
            onTapHandler: ()=>Navigator.of(context).pushNamed(ManageOrdersScreen.routeName),
              ),
    
              GridItem(
               itemTitle: 'Centralize orders',
               color:const Color.fromARGB(255,214,104,83),
            iconp: Icons.summarize,
            onTapHandler: ()=>Navigator.of(context).pushNamed(ManageCentralizerScreen.routeName)),
            GridItem(
               itemTitle: 'Shipping',
               color:const Color.fromARGB(255,179,233,199),
            iconp: Icons.local_shipping,
            onTapHandler: ()=>Navigator.of(context).pushNamed(ShippingScreen.routeName)),
     GridItem(
               itemTitle: 'Manage clients',
               color:const Color.fromARGB(255,250,250,255),
            iconp: Icons.business_center,
         
            onTapHandler: ()=>
            Navigator.of(context).pushNamed(ManageClientsScreen.routeName),
     ),
         ],
         
         );
      
  }
}