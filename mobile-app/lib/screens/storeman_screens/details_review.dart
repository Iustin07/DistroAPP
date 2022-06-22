import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/review.dart';
class DetailsReview extends StatelessWidget {
 const DetailsReview({Key? key,
  required this.review}) : super(key: key);
final Review review;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Container(
              decoration:const  BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
                 color: Color.fromARGB(179, 226, 226, 226),
              ),
              
              height: 400,
              width: 300,
              child: Column(
                children: [
                  const Text('Reason',style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              fontWeight: FontWeight.w500
                              )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      softWrap: true,
                      review.textReview as String,
                    style: const TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w400),
                    ),
                  ),
              const Text('Rating',style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              fontWeight: FontWeight.w500
                              )),
 RatingBar(
                    initialRating: review.rating as double,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                    }),
                  ],)
                
              ),
            ),
            ),
          ),
        );
      
  }
}