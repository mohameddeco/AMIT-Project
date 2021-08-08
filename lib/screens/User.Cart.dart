import 'package:amit_project/Database/Db_Helper.dart';
import 'package:amit_project/Database/DbModuls.dart';
import 'package:amit_project/screens/user_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consonants.dart';

class UserCart extends StatefulWidget {
  static String id = 'cartScreen';
  @override
  _UserCartState createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  DbHelper helper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: KButtonColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        backgroundColor: KMainColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FutureBuilder<List<DbModel>>(
              future: helper.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {

                  int totalPrice=0;
                  List<DbModel>listPrice= snapshot.data;
                  for(var item in listPrice){
                    totalPrice=totalPrice+item.total;

                    print('total list price is $totalPrice');
                    print('item price is ${item.total}');
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data.length == 0) {
                        return Center(
                            child: Column(
                              children: [
                                Text('Your cart is empty !'),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            KButtonColor)),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, UserCategories.id);
                                    },
                                    child: Text('Start Shopping Now !'))
                              ],
                            ));
                      } else {
                        DbModel product = snapshot.data[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: heightMedia * .2,
                                    width: widthMedia * .28,
                                    child: Image(
                                      image: NetworkImage(product.image),
                                      fit: BoxFit.cover,
                                    )),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${product.title}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0, right: 6.0, top: 6.0),
                                        child: Text(
                                          '${product.name}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'In Stock :- ${product.inStock} ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Text(
                                                  '${(product.total).toString()} EGP',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: KButtonColor),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .indeterminate_check_box_outlined,
                                                      size: 30,
                                                      color: KButtonColor,
                                                    ),
                                                    onPressed: () {
                                                      minusAmount(product.amount);
                                                      //  prov.minusAmount(amount);
                                                      //    minusAmount();
                                                    }),
                                                Text(
                                                  '${product.amount}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.add_box_outlined,
                                                      size: 30,
                                                      color: KButtonColor,
                                                    ),
                                                    onPressed: () {
                                                      addAmount(product.amount,product.inStock);
                                                      //addAmount(product.amount,product.inStock);
                                                      //  prov.addAmount(amount);
                                                      //addAmount(product.pInStock);
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    KButtonColor)),
                                            onPressed: () {
                                              setState(() {
                                                helper.deleteProduct(product.id);
                                              });
                                            },
                                            child: Text(
                                              'Remove item',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11),
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ));
                      }
                    },
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: Column(
                        children: [
                          Text('Your cart is empty !'),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(KButtonColor)),
                              onPressed: () {
                                Navigator.pushNamed(context, UserCategories.id);
                              },
                              child: Text('Start Shopping Now !'))
                        ],
                      ));
                } else {
                  return Center(
                      child:
                      Text('Kindly, send us a screen shot with the error'));
                }
              }),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                    color: KButtonColor.withOpacity(.4),
                    width:widthMedia,
                    height: heightMedia*.04,
                    child: Text(' Total amount is : for loop to add all totals ',textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17
                      ),
                    )),
                Container(
                  width: widthMedia,
                  child: ElevatedButton(
                      style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all(KButtonColor)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            'Confirm Order',
                            style: TextStyle(color: Colors.white,fontSize: 18),
                          )
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  void minusAmount(amount) {
    if(amount==1){
      setState(() {
        amount=1;
      });
    }else{
      setState(() {
        amount--;
      });
    }
  }

  void addAmount(amount,productInStock) {
    if(amount<productInStock){
      setState(() {
        amount++;
      });
    }else{
      setState(() {
        amount=productInStock;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(' There is only $productInStock items available ,thank you for your patience ! '),
        ));
      });
    }
  }
}
/*
ListTile(
                      title: Text('${product.title}',
                      maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Container(
                          height: heightMedia*.5,
                          width: widthMedia*.25,
                          child: Image(image: NetworkImage(product.image),fit: BoxFit.cover,)),
                    ),
 */
