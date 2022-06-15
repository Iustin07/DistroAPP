import '../screens/driver_screens/view_centralizer_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/grid_item.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        GridItem(
            key: UniqueKey(),
            itemTitle: 'See Centralizer',
            color: const Color.fromARGB(255, 192, 192, 192),
            iconp: Icons.summarize,
            onTapHandler: ()=>Navigator.of(context).pushNamed(ViewCentralizerScreen.routeName)),
        GridItem(
            itemTitle: 'Client Location',
            color: const Color.fromARGB(255, 0, 229, 232),
            iconp: Icons.location_on,
            onTapHandler: () {}),
        // GridItem(
        //   itemTitle: 'Repair car',
        //   color: const Color.fromARGB(255, 244, 208, 111),
        //   iconp: const IconData(0xf8a1,
        //       fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
        //   onTapHandler: () {},
        // ),
      ],
    );
  }
}