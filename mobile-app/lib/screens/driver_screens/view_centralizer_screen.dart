import '../../widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import './show_centralizer_widget.dart';
class ViewCentralizerScreen extends StatelessWidget {
  const ViewCentralizerScreen({Key? key}) : super(key: key);
static const routeName="/driver-centralizer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(
        title: 'See centralizers',
      ),
      body: ShowCentralizersWidget(),
    );
  }
}