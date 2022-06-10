import 'package:flutter/material.dart';
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
   SimpleAppBar({Key? key, this.title,this.actions}) : super(key: key);
  final String? title;
 final  List<Widget>? actions;
 @override
    final Size preferredSize=Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title:  Text(title as String),
        actions: actions,
      );
  }
}