import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required this.label,
      required this.amount,
      required this.percentageOfTotal})
      : super(key: key);
  final String label;
  final double amount;
  final double percentageOfTotal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          width: 50,
          child: Center(
            child: Text(
              getValueAsText(amount),
              softWrap: true,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromARGB(255, 245, 243, 243),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: percentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4,),
        Text(
          label.substring(0, 3),
        ),
      ],
    );
  }

  String getValueAsText(double givenValue) {
    if (givenValue > 1000) {
      return (givenValue / 1000).toString() + 'K';
    } else {
      if (givenValue > 1000000) {
        return (givenValue / 1000000).toString() + 'M';
      }
    }
    return givenValue.toString();
  }
}
