import 'package:flutter/material.dart';
import '../../model/review.dart';
import './details_review.dart';
class HeroReviewWidget extends StatelessWidget {
   HeroReviewWidget({Key? key,
  required this.review,
  required this.transportId
  }) : super(key: key);
  Review review;
  int? transportId;
  @override
  Widget build(BuildContext context) {
    return Hero(
                tag: "Review",
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsReview(
                            review:review );
                      }));
                    },
                    child: Card(
                      color:const  Color.fromRGBO(169,169,169, 0.8),
                      child: Column(
                        children: [
                          Text(
                              'Review for transport T${transportId}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              fontWeight: FontWeight.w600
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rating: ${review.rating}',
                                style:const  TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              fontWeight: FontWeight.w500
                              )),
                              
                             const Icon(Icons.text_snippet_sharp,size: 40,color: Colors.white70,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}