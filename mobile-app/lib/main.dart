/* #region */

import 'package:distroapp/screens/accountant_screens.dart/generate_centralizers_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/transport_cart.dart';
import './providers/transports.dart';
import './screens/accountant_screens.dart/add_transport.dart';
import './screens/driver_screens/centralizerdetailscreen.dart';
import './screens/driver_screens/search_client.dart';
import './screens/driver_screens/view_centralizer_screen.dart';
import './screens/manager_screens.dart/manage_losts_manager.dart';
import './screens/storeman_screens/detailing_transport.dart';
import './screens/storeman_screens/waiting_transports_screen.dart';
import './widgets/clients/modify_client_screen.dart';

import './screens/storeman_screens/manage_losts_screen.dart';
import './screens/storeman_screens/shipping_screen.dart';
import './widgets/clients/waiting_clients.dart';
import './widgets/clients/client_Location.dart';
import './model/custom_centralizer.dart';
import './widgets/clients/add_client.dart';
import './screens/accountant_screens.dart/manage_centralizers_screen.dart';
import './screens/handler_screens/centralizer_details.screen.dart';
import './screens/handler_screens/see_centralizers_screen.dart';
import './providers/centralizers_provider.dart';
import './screens/accountant_screens.dart/manage_orders.dart';
import './screens/manager_screens.dart/stats_screen.dart';
import './screens/agent_screens/order_details_products_screen.dart';
import './screens/agent_screens/see_orders_screen.dart';
import './widgets/employee/employe_details.dart';
import './screens/add_employee_screen.dart';
import './screens/manage_clients.dart';
import './screens/cart_screen.dart';
import './screens/agent_screens/add_order_screen.dart';
import './screens/manage_account_screen.dart';
import './screens/manage_employees_screen.dart';
import './widgets/manage_products_widgets/add_product.dart';
import './widgets/manage_products_widgets/modify_widget.dart';
import './screens/manage_products.dart';
import './screens/auth_screen.dart';
import './providers/authentification.dart';
import './screens/after_login.dart';
import './model/cart.dart';
import './providers/products.dart';
import './providers/clients.dart';
import './providers/users.dart';
import './providers/orders_provider.dart';
import './providers/stats_provider.dart';
import './providers/losts.dart';
/* #endregion */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName = "/";
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProvider.value(value: Cart(),),
        ChangeNotifierProxyProvider<Authentication, Products>(
          create: (ctx) => Products(
              Provider.of<Authentication>(ctx, listen: false).token, []),
          update: (ctx, auth, products) =>
              Products(auth.token, products == null ? [] : products.products),
        ),
        ChangeNotifierProxyProvider<Authentication,Clients>(
          create:(ctx)=>Clients(Provider.of<Authentication>(ctx,listen:false ).token),
          update: (ctx,auth,previous)=>Clients(auth.token),
        ),
        ChangeNotifierProxyProvider<Authentication, Users>(
          create: (ctx) =>
              Users(Provider.of<Authentication>(ctx, listen: false).token),
          update: (ctx, auth, previous) => Users(auth.token),
        ),
           ChangeNotifierProxyProvider<Authentication, Orders>(
          create: (ctx) =>
              Orders(Provider.of<Authentication>(ctx, listen: false).token,),
          update: (ctx, auth, previous) => Orders(auth.token),
        ),
         ChangeNotifierProxyProvider<Authentication, Losts>(
          create: (ctx) =>
              Losts(Provider.of<Authentication>(ctx, listen: false).token),
          update: (ctx, auth, previous) => Losts(auth.token),
        ),
        ChangeNotifierProxyProvider<Authentication, Stats>(
          create: (ctx) =>
              Stats(Provider.of<Authentication>(ctx, listen: false).token),
          update: (ctx, auth, previous) => Stats(auth.token),
        ),
                 ChangeNotifierProxyProvider<Authentication, Centralizers>(
          create: (ctx) =>
              Centralizers(Provider.of<Authentication>(ctx, listen: false).token,),
          update: (ctx, auth, previous) => Centralizers(auth.token),
        ),
 ChangeNotifierProxyProvider<Authentication,Transports>(
          create: (ctx) =>
              Transports(Provider.of<Authentication>(ctx, listen: false).token,),
          update: (ctx, auth, previous) =>Transports(auth.token),
        ),
        ChangeNotifierProvider.value(
          value: CustomCentralizer(),
        ),
        
         ChangeNotifierProvider.value(value: TransportCart()),
      ],
      child: Consumer<Authentication>(
        builder: (ctx, authenticate, _) => MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          title: 'Distro App',
          theme: ThemeData(
            errorColor: Colors.red,
            primaryColor: Colors.blue[800],
           textTheme: const TextTheme(titleSmall: TextStyle(color: Colors.white)) 
          ),
            home:authenticate.isAuth? HomeScreen(role: authenticate.getRole):
            const AuthScreen(),
          //home:const HomeScreen(role:'handler'),
          routes: {
            AuthScreen.routeName: (ctx) => const AuthScreen(),
            HomeScreen.routeName: (ctx) =>HomeScreen(role: authenticate.getRole),
            ManageProductsScreen.routeName: (ctx) =>const ManageProductsScreen(),
            ManageEmployeScreen.routeName: (ctx) => const ManageEmployeScreen(),
            ManageAccountScreen.routeName: (ctx) => const ManageAccountScreen(),
            ProductModifyScreen.routeName: (ctx) => const ProductModifyScreen(),
            AddProductScreen.routeName: (ctx) =>const AddProductScreen(),
            AddOrderScreen.routeName: (ctx) => const AddOrderScreen(),
            AddClientScreen.routeName: (ctx) => const AddClientScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            ManageClientsScreen.routeName: (ctx) => const ManageClientsScreen(),
            AddEmployerScreen.routeName: (ctx) => const AddEmployerScreen(),
            EmployeeDetailsScreen.routeName: (ctx) =>const EmployeeDetailsScreen(),
            SeeOrdersScreen.routeName: (ctx) =>const  SeeOrdersScreen(),
            OrderDetailsProducts.routeName: (ctx) =>const OrderDetailsProducts(),
            StatsScreen.routeName: (ctx) => const StatsScreen(),
            ManageOrdersScreen.routeName: (ctx) =>const  ManageOrdersScreen(),
            CentralizersScreen.routeName: (ctx) => const CentralizersScreen(),
            CentralizerDetails.routeName: (ctx) => CentralizerDetails(),
            ManageCentralizerScreen.routeName: (ctx) =>const ManageCentralizerScreen(),
            ClientLocation.routeName:(ctx)=>const ClientLocation(),
            WaitingClientsScreen.routeName:(ctx)=>const WaitingClientsScreen(),
            ManageLostsScreen.routeName:(ctx)=>const ManageLostsScreen(),
            ShippingScreen.routeName:(ctx) => const ShippingScreen(),  
            ViewCentralizerScreen.routeName:(ctx)=>const ViewCentralizerScreen() , 
            CentralizerDetailsScreen.routeName:(ctx)=>const CentralizerDetailsScreen(),
            ManageLostsManagerScreen.routeName:(ctx)=>const ManageLostsManagerScreen(),
            ModifyClient.routeName:(ctx)=>const ModifyClient(),
            WaitingTransportsScreen.routeName:(ctx)=>const WaitingTransportsScreen(),
            TransportDetails.routeName:(ctx)=>const TransportDetails(),
            AddTransportScreen.routeName:(ctx)=>const AddTransportScreen(),
            SearchClientScreen.routeName:(ctx)=>SearchClientScreen(),
            GenerateCentralizersScreen.routeName:(ctx)=>const GenerateCentralizersScreen(),
          },
        ),
      ),
    );
  }
}
