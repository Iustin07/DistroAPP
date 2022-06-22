import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/employee/employe_details.dart';
import '../model/custom_employe.dart';
import '../providers/users.dart';
import '../screens/add_employee_screen.dart';

enum ChoseWidget { DEFAULT, SEARCH }

class ManageEmployeScreen extends StatefulWidget {
  const ManageEmployeScreen({Key? key}) : super(key: key);
  static const routeName = '/employee';

  @override
  State<ManageEmployeScreen> createState() => _ManageEmployeScreenState();
}

class _ManageEmployeScreenState extends State<ManageEmployeScreen> {
  List<CustomEmployee> _allUsers = [];
  bool _loading = false;
  bool _isSearching = false;
  bool _init = true;
  List<CustomEmployee> _foundUsers = [];
  @override
  void initState() {
    _isSearching = false;
    _foundUsers = [];
    super.initState();
  }

  @override
  void dispose() {
    //Provider.of<Users>(context, listen: false).clear();
    _allUsers.clear();
    _foundUsers.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _loading = true;
      });

      Provider.of<Users>(context).fetchCustomEmployee().then((_) {
        setState(() {
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  void _searchEmployee(String insertedKeyword) {
    List<CustomEmployee> results = [];
    if (insertedKeyword.isEmpty) {
      results = [];
    } else {
      results = _allUsers
          .where((user) =>
              user.name!.toLowerCase().contains(insertedKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    }); 
  }

  ChoseWidget selectedWidget = ChoseWidget.DEFAULT;
  @override
  Widget build(BuildContext context) {
    _allUsers = Provider.of<Users>(context).allEmployee;
    return Scaffold(
      appBar: _isSearching ? getSearchAppBar() : getInititalAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : getCustomContainerEmploye(),
      ),
    );
  }

  Widget getCustomContainerEmploye() {
    switch (selectedWidget) {
      case ChoseWidget.DEFAULT:
        return Container();
      case ChoseWidget.SEARCH:
        return searchWidget();
    }
  }

  Widget searchWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index].employeeId),
                      color: Colors.amberAccent,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                          leading: Text(
                            _foundUsers[index].employeeId.toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index].name.toString()),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              EmployeeDetailsScreen.routeName,
                              arguments: _foundUsers[index].employeeId,
                            );
                            _foundUsers.clear();
                            setState(() {
                              selectedWidget = ChoseWidget.DEFAULT;
                              _isSearching = false;
                            });
                          }),
                    ),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }

  AppBar getInititalAppBar() {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop()),
      title: const Text('Manage employee'),
      actions: <Widget>[
        IconButton(
          icon:const  Icon(Icons.search),
          onPressed: () => setState(() {
            selectedWidget = ChoseWidget.SEARCH;
            _isSearching = true;
          }),
        ),
        IconButton(
            icon:const  Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddEmployerScreen.routeName)),
      ],
    );
  }

  AppBar getSearchAppBar() {
    return AppBar(
      leading: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      title: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 18),
        onChanged: (value) => _searchEmployee(value),
        decoration: const InputDecoration(
            labelText: 'Search', suffixIcon: Icon(Icons.search)),
      ),
      actions: <Widget>[
        IconButton(
          icon:const  Icon(Icons.close),
          onPressed: () => setState(() {
            selectedWidget = ChoseWidget.DEFAULT;
            _isSearching = false;
          }),
        ),
      ],
    );
  }
}
