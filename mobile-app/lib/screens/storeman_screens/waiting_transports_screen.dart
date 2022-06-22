import 'package:flutter/material.dart';
import './transports_main_widget.dart';
import '../../widgets/simple_app_bat.dart';

class WaitingTransportsScreen extends StatelessWidget {
  const WaitingTransportsScreen({Key? key}) : super(key: key);
static const routeName="/waiting-transports";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Arriving transports'),
body: TransportsMainWidget(isWainting: true),
    );

}
}