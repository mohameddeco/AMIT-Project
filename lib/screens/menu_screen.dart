import 'package:amit_project/screens/login_screen.dart';
import 'package:amit_project/bloc/bloc_control.dart';
import 'package:amit_project/bloc/bloc_event.dart';
import 'package:amit_project/models/getUser_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../consonants.dart';

class MenuScreen extends StatelessWidget {


  String userName;
  @override
  Widget build(BuildContext context) {
    print('KToken in constants is $KToken');
    GetUserDetails(KToken);
    BlocControl counter=BlocProvider.of<BlocControl>(context);
    counter.add(BlocEvents.lastValue);
    int count = 7;
    return Scaffold(

      appBar: AppBar(title: Text('name :$userName '),),
      body: Center(

        child: Column(
          children: [
            Row(
              children: [
                IconButton(icon: Icon(Icons.minimize_outlined), onPressed: () {
                  minusAmountTry(context);
                  //counter.add(BlocEvents.decrement);
                }),
                BlocBuilder<BlocControl,int>(
                  builder:(context, state) =>  Text(
                    '$state',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: () {
                  addAmountTry(count,context);
                })
              ],
            ),
            Text('Number in Stock = $count')
          ],
        ),
      ),

    );
  }


  void minusAmountTry(context) {
    BlocControl counter= BlocProvider.of<BlocControl>(context);
    if(counter.state==1){
      counter.add(BlocEvents.lastValue);
    }else{
      counter.add(BlocEvents.decrement);
    }
  }
  void addAmountTry(productInStock,context) {

    BlocControl counter= BlocProvider.of<BlocControl>(context);
    if(counter.state<productInStock){
      counter.add(BlocEvents.increment);
    }else{
      num number= counter.state;
      number=productInStock;
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // content: Text(' There is only $productInStock items available ,thank you for your patience ! '),
      //));

    }
  }

  Future<GetUserModel> GetUserDetails(KToken)async{
    var response = await Dio().get('https://retail.amit-learning.com/api/user',options: Options(headers: {'Authorization': '$KToken'}));
    var data= response.data['user'];
    print(data);
    GetUserModel model=GetUserModel.fromJson(data);
    print('model is $model');
    return model;
  }
}
