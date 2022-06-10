import 'package:flutter/material.dart';
class GridItem extends StatelessWidget {
  final VoidCallback onTapHandler;
  final String itemTitle;
  final Color color;
  final IconData iconp;
  const GridItem({Key? key,
  required this.itemTitle,
  required this.iconp,
  required this.color,
  required this.onTapHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
             child:InkWell(
               splashColor: color.withAlpha(30),
               onTap:(){//print('on tapped was called');
               onTapHandler();
               },
               child: Card(
                 margin: const EdgeInsets.all(10),
                 elevation: 10,
                 
                 shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                 ), 
               color: color,
               child: Column(
                 crossAxisAlignment:CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(iconp,size: 50,),
                   Center(
                    
                         child: Text(itemTitle,style: const TextStyle(fontSize: 18),),),
                 ],
               )
               
                        ),
             ) ,);
  }
}
