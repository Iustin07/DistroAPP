import '../screens/handler_screens/see_centralizers_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/grid_item.dart';
class HandlerHome extends StatefulWidget {
  const HandlerHome({Key? key}) : super(key: key);

  @override
  State<HandlerHome> createState() => _HandlerHomeState();
}

class _HandlerHomeState extends State<HandlerHome> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GridItem(itemTitle: 'Centralizers',color:const Color.fromARGB(255,192,192,192) 
            , iconp: Icons.add_box,onTapHandler: ()=>Navigator.of(context).pushNamed(CentralizersScreen.routeName)),
         ],
         
         );
  }
}
