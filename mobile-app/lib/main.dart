/* #region */
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
import './widgets/auxiliary_widgets/manage_products_widgets/add_product.dart';
import './widgets/auxiliary_widgets/manage_products_widgets/modify_widget.dart';
import './screens/manage_products.dart';
import './screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/authentification.dart';
import './screens/after_login.dart';
import './model/cart.dart';
import './providers/products.dart';
import './providers/clients.dart';
import './providers/users.dart';
import './providers/orders_provider.dart';
import './providers/stats_provider.dart';
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
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        //ChangeNotifierProvider.value(value: Products(),),
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
     
        ChangeNotifierProvider.value(
          value: Stats(),
        ),
                 ChangeNotifierProxyProvider<Authentication, Centralizers>(
          create: (ctx) =>
              Centralizers(Provider.of<Authentication>(ctx, listen: false).token,),
          update: (ctx, auth, previous) => Centralizers(auth.token),
        ),

        ChangeNotifierProvider.value(
          value: CustomCentralizer(),
        ),
      ],
      child: Consumer<Authentication>(
        builder: (ctx, authenticate, _) => MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          title: 'Distro App',
          theme: ThemeData(
            primaryColor: Colors.blue[800],
           textTheme: const TextTheme(titleSmall: TextStyle(color: Colors.white)) 
          ),
          home:authenticate.isAuth? HomeScreen(role: authenticate.getRole):
          const AuthScreen(),
         // home: HomeScreen(role: 'accountant'),

          routes: {
            AuthScreen.routeName: (ctx) => const AuthScreen(),
            HomeScreen.routeName: (ctx) =>HomeScreen(role: authenticate.getRole),
            ManageProductsScreen.routeName: (ctx) =>const ManageProductsScreen(),
            ManageEmployeScreen.routeName: (ctx) => const ManageEmployeScreen(),
            ManageAccountScreen.routeName: (ctx) => const ManageAccountScreen(),
            ProductModifyScreen.routeName: (ctx) => ProductModifyScreen(),
            AddProductScreen.routeName: (ctx) => AddProductScreen(),
            AddOrderScreen.routeName: (ctx) => const AddOrderScreen(),
            AddClientScreen.routeName: (ctx) => const AddClientScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            ManageClientsScreen.routeName: (ctx) => const ManageClientsScreen(),
            AddEmployerScreen.routeName: (ctx) => AddEmployerScreen(),
            EmployeeDetailsScreen.routeName: (ctx) => EmployeeDetailsScreen(),
            SeeOrdersScreen.routeName: (ctx) =>const  SeeOrdersScreen(),
            OrderDetailsProducts.routeName: (ctx) =>const OrderDetailsProducts(),
            StatsScreen.routeName: (ctx) => const StatsScreen(),
            ManageOrdersScreen.routeName: (ctx) =>const  ManageOrdersScreen(),
            CentralizersScreen.routeName: (ctx) => const CentralizersScreen(),
            CentralizerDetails.routeName: (ctx) => CentralizerDetails(),
            ManageCentralizerScreen.routeName: (ctx) =>const ManageCentralizerScreen(),
            ClientLocation.routeName:(ctx)=>ClientLocation(),
            WaitingClientsScreen.routeName:(ctx)=>WaitingClientsScreen(),
            ManageLostsScreen.routeName:(ctx)=>ManageLostsScreen(),
            ShippingScreen.routeName:(ctx) => ShippingScreen(),    
          },
        ),
      ),
    );
  }
}
