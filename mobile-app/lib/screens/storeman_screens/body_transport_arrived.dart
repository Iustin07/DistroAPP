import 'package:flutter/material.dart';
import '../../model/transport.dart';
import 'package:provider/provider.dart';
import './hero_review_widget.dart';
import '../../model/review.dart';
class BodyTransportArived extends StatefulWidget {
  BodyTransportArived({Key? key, required this.transport}) : super(key: key);
  Transport transport;
  @override
  State<BodyTransportArived> createState() => _BodyTransportArivedState();
}

class _BodyTransportArivedState extends State<BodyTransportArived> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Column(
        children: [
          Icon(
            Icons.local_shipping_outlined,
            size: 100,
          ),
          //reviews
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.amber,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${widget.transport.producer}'),
                      Text('${widget.transport.dateArrive}'),
                      Text('${widget.transport.valueOfProducts}'),
                    ]),
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.red,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${widget.transport.truckRegistraionNumber}'),
                      Text('${widget.transport.driverName}'),
                      Text('${widget.transport.driverPhoneNumber}'),
                    ]),
              )
            ],
          ),
           widget.transport.review == null
            ? Text('no reviews')
            : HeroReviewWidget(review:widget.transport.review as Review, transportId: widget.transport.idTrasnport),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                  itemCount: widget.transport.transportItems!.length,
                  itemBuilder: (ctx, index) => Card(
                          child: ListTile(
                        leading: Image.asset('assets/images/debox.png'),
                        title: Text(
                          '${widget.transport.transportItems![index].product!.productName}',
                        ),
                        subtitle: Text(
                            '${widget.transport.transportItems![index].productQuantity} ${widget.transport.transportItems![index].unityMeasure}'),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}