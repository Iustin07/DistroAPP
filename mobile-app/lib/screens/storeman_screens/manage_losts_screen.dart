import 'package:flutter/material.dart';

class ManageLostsScreen extends StatelessWidget {
  const ManageLostsScreen({Key? key}) : super(key: key);

  static const routeName = '/losts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Manage losts'),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/waiting.png',
                  color: Colors.white)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.add))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}