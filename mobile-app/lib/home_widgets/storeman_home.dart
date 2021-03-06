import 'package:flutter/material.dart';
import '../widgets/grid_item.dart';
import '../screens/storeman_screens/manage_losts_screen.dart';
import '../screens/storeman_screens/shipping_screen.dart';
import '../screens/handler_screens/see_centralizers_screen.dart';
import '../screens/manage_products.dart';
class StoremanHome extends StatelessWidget {
  const StoremanHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        GridItem(
            key: UniqueKey(),
            itemTitle: 'Manage losts',
            color: const Color.fromRGBO(155, 89, 182, 1),
            iconp: const IconData(0xf77d,
                fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            onTapHandler: () =>
                Navigator.of(context).pushNamed(ManageLostsScreen.routeName)),
        GridItem(
            itemTitle: 'Shipping',
            color: const Color.fromARGB(255, 0, 229, 232),
            iconp: Icons.local_shipping,
            onTapHandler: () =>
                Navigator.of(context).pushNamed(ShippingScreen.routeName)),
        GridItem(
          itemTitle: 'See Summary',
          color: const Color.fromARGB(255, 244, 208, 111),
          iconp: const IconData(0xf472,
              fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
          onTapHandler: ()=>Navigator.of(context).pushNamed(CentralizersScreen.routeName),
        ),
        GridItem(key: UniqueKey(),
              itemTitle: 'Manage products',color:const Color.fromARGB(255,192,192,192) 
            , iconp: Icons.inventory_2, onTapHandler: ()=>Navigator.of(context).pushNamed(ManageProductsScreen.routeName)),
      ],
    );
  }
}