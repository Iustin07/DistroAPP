import 'package:distroapp/widgets/clients/client_Location.dart';
import 'package:distroapp/widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/client.dart';
import'../../providers/clients.dart';
enum ChoseWidget { DEFAULT, SEARCH }
class SearchClientScreen extends StatefulWidget {
  SearchClientScreen({Key? key}) : super(key: key);
static const routeName="/searchClient";
  @override
  State<SearchClientScreen> createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> {
  List<Client> _allUsers = [];
  bool _loading = false;
  bool _isSearching = false;
  bool _init = true;
  List<Client> _foundUsers = [];
    ChoseWidget selectedWidget = ChoseWidget.DEFAULT;
  @override
  void dispose() {
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

      Provider.of<Clients>(context).fetchAndSetClients(true).then((_) {
        setState(() {
          _allUsers=List.from(Provider.of<Clients>(context,listen: false).clients);
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }
   void _searchClient(String insertedKeyword) {
    List<Client> results = [];
    if (insertedKeyword.isEmpty) {
      results = [];
    } else {
      results = _allUsers
          .where((user) =>
              user.clientName!.toLowerCase().contains(insertedKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers =List.from( results);
    }); 
  }
  @override
  Widget build(BuildContext context) {
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
            : getCustomContainerBody()
      ),
    );
  }
  Widget getCustomContainerBody() {
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
                      key: ValueKey(_foundUsers[index].id),
                      color: Colors.amberAccent,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                          leading: Text(
                            _foundUsers[index].id.toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index].clientName.toString()),
                          onTap: () {
                            print('index is $index');
                             print('client name is ${_foundUsers[index].clientName}');
                             Navigator.push(
    context,
    MaterialPageRoute(
       builder: (context) => ClientLocation(
    clientName: _foundUsers[index].clientName,
    address: _foundUsers[index].address,
    longitude: _foundUsers[index].longitude,
    latitude: _foundUsers[index].latitude,
    )),
  );
                           // _foundUsers.clear();
                            setState(() {
                              selectedWidget = ChoseWidget.DEFAULT;
                              _isSearching = false;
                            });
                          }
                          ),
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
   AppBar getSearchAppBar() {
    return AppBar(
      leading: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      title: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 18),
        onChanged: (value) => _searchClient(value),
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
  SimpleAppBar getInititalAppBar() {
    return SimpleAppBar(title:'Manage employee',
    actions: <Widget>[
       IconButton(
          icon:const  Icon(Icons.search),
          onPressed: () => setState(() {
            selectedWidget = ChoseWidget.SEARCH;
            _isSearching = true;
          }),)
    ],
    );
    
    
    
   
  }
  }
      
  

