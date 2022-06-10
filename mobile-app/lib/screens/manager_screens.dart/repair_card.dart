import 'package:flutter/material.dart';
class RepairCard extends StatelessWidget {
  const RepairCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child:Stack(
        
children:<Widget>[
        Container(
              alignment: Alignment.center,
              child:   Image.asset('assets/images/repair.jpeg',
                height: 150,
                //width: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ),
            Container(
              height: 150,
             // width: 200,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
              
                     
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ Text('Cars fixes'),
                        //SizedBox(height: 5,),
                        SizedBox(height: 10,),
                        Text('\$ 4000')],
                      ),
                    

                  ],),
              ),
            
           
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[Text('This year car repair cost'),
        //     Text('4000'),],
        //     ),
          ],
        )
       

      ); 
      
    
  }
}