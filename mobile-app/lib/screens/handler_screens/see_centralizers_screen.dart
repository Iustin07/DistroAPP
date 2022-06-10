import './centralizers_list.dart';
import './centralzier_card.dart';
import '../../widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';

class CentralizersScreen extends StatelessWidget {
  const CentralizersScreen({Key? key}) : super(key: key);
static const routeName="/centralizers";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:SimpleAppBar(title:'Centralizers'),
      body:const CentralizersList(),
  );


  }
}