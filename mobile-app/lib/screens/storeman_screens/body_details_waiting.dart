import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../model/review.dart';
import '../../model/transport.dart';
import '../../model/transport_item.dart';
import '../../providers/transport_cart.dart';
import './hero_review_widget.dart';
import '../../providers/products.dart';
import '../../model/product.dart';
class BodyTransportDetailsWaiting extends StatefulWidget {
  BodyTransportDetailsWaiting({Key? key, required this.transport})
      : super(key: key);
  Transport transport;
  @override
  State<BodyTransportDetailsWaiting> createState() =>
      _BodyTransportDetailsState();
}

class _BodyTransportDetailsState extends State<BodyTransportDetailsWaiting> {
  bool? _isWaiting;
  bool _loading = false;
  TransportCart? transportCart;
  List<TransportItem>? cartItems;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      transportCart = Provider.of<TransportCart>(context);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(children: <Widget>[
        GridView.count(
            primary: true,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 30,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: [
                  Image.asset('assets/images/box-512.png',height: 100,),
                  ElevatedButton(
                      child: const Text('ADD PRODUCT'),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddDialog();
                          })),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/images/rating2.png',height: 100,),
                  ElevatedButton(
                     
                      child:const  Text('ADD REVIEW'),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddReviewDialog();
                          })),
                ],
              ),
            ]),
        transportCart!.review == null
            ? const Text('no reviews')
            : HeroReviewWidget(review:transportCart?.review as Review, transportId: widget.transport.idTrasnport),
        transportCart!.transportItems.isEmpty
            ? const Text('no products yet')
            : Expanded(
                child: ListView.builder(
                  itemCount: transportCart!.transportItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          tileColor: Theme.of(context).backgroundColor,
                          leading: Image.asset('assets/images/prod_search.png'),
                          title: Text(
                              '${transportCart!.transportItems[index].productName}'),
                          subtitle: Row(
                            children: <Widget>[
                              Text(
                                  '${transportCart!.transportItems[index].productQuantity} ${transportCart!.transportItems[index].unityMeasure}'),
                              const SizedBox(width: 15, ),
                              Text(
                                  '${transportCart!.transportItems[index].productValue} RON'),
                            ],
                          )),
                    );
                  },
                ),
              ),
      ]),
    );
  }
}

class DetailsReview extends StatelessWidget {
  DetailsReview({Key? key, required this.review}) : super(key: key);
  Review review;
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
                color: Colors.amber,
                height: 300,
                width: 200,
                child: Column(
                  children: [
                    const Text('Reason'),
                    Text(
                      softWrap: true,
                      review.textReview as String,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Text('Rating'),
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
                        onRatingUpdate: (value) {}),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

/* #region Add product */
class AddDialog extends StatefulWidget {
 const  AddDialog({Key? key}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  bool _init = true;
  bool _loading = false;
  TransportCart? cart;
  List<Product> _products = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _loading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts();
      setState(() {
        cart = Provider.of<TransportCart>(context);
         _products = Provider.of<Products>(context).products;
        _loading = false;
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  final _formLost = GlobalKey<FormState>();
  Product? dropdownValue;
  double? quantity;
  String unit = 'Buc';
  double? price;
  final _formTransportProduct = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Add product'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formTransportProduct,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Text('Choose product'),
                  const SizedBox(
                    width: 10,
                  ),
                  
                      _loading
                      ?const  CircularProgressIndicator(): DropdownButton<Product>(
                          menuMaxHeight: 300,
                          hint: const Text('product'),
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: _products
                              .map<DropdownMenuItem<Product>>(
                            (Product product) {
                              return DropdownMenuItem<Product>(
                                value: product,
                                child:
                                    SizedBox(width: 100, child: Text(product.productName)),
                              );
                            },
                          ).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                        ),
                ],
              ),
              Row(
                children: [
                  const Text('Measure unit'),
                  const SizedBox(  width: 10, ),
                  DropdownButton<String>(
                    hint: const Text('unit measure'),
                    value: unit,
                    icon: const Icon(Icons.category),
                    items: ['Buc', 'Box', 'Pal'].map<DropdownMenuItem<String>>(
                      (String measure) {
                        return DropdownMenuItem<String>(
                          value: measure,
                          child: SizedBox(width: 100, child: Text(measure)),
                        );
                      },
                    ).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        unit = newValue as String;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'quantity',
                  icon: Icon(Icons.add_moderator),
                ),
                onSaved: (value) {
                  quantity = double.parse(value as String);
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'value',
                  icon: Icon(Icons.attach_money),
                ),
                onSaved: (value) {
                  price = double.parse(value as String);
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            child:const Text("Add"),
            onPressed: () {
              _saveProduct();
            })
      ],
    );
  }

  void _saveProduct() {
    _formTransportProduct.currentState!.save();
    Navigator.of(context).pop();
    if(dropdownValue!=null){
    cart!.addProduct(TransportItem.cart(
      productId: dropdownValue!.productId,
      productName: dropdownValue!.productName,
      productQuantity: quantity,
      unityMeasure: unit,
      productValue: price,
    ));}
  }
}

/* #endregion*/
/////review
class AddReviewDialog extends StatefulWidget {
 const AddReviewDialog({Key? key}) : super(key: key);

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  bool _init = true;
  bool _loading = false;
  TransportCart? cart;
  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _loading = true;
      });
      setState(() {
        cart = Provider.of<TransportCart>(context);
        _loading = false;
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  String? _description;
  double? _ratingValue;
  final _formReview = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Add review'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formReview,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 6,
                decoration:const  InputDecoration(
                  labelText: 'Description',
                  icon: Icon(
                    Icons.text_snippet_sharp,
                    size: 50,
                  ),
                ),
                onSaved: (value) {
                  _description = value as String;
                },
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox( height: 20,),              
              //cod preluat de pe https://www.kindacode.com/article/how-to-implement-star-rating-in-flutter/
              const Text(
                'Give a rate',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 25),
              // implement the rating bar
              RatingBar(
                  initialRating: 0,
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
                    setState(() {
                      _ratingValue = value;
                    });
                  }),
              const SizedBox(height: 25),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.blue, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            child: const Text("Add"),
            onPressed: () {
              _saveReview();
            })
      ],
    );
  }

  void _saveReview() {
    _formReview.currentState!.save();
    Navigator.of(context).pop();
    cart!.addReview(
        Review.custom(textReview: _description, rating: _ratingValue));
  }
}
