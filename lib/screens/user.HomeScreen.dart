import 'package:amit_project/provider/AppProvider.dart';
import 'package:amit_project/Models/GetUser_model.dart';
import 'package:amit_project/reusable_widget/Drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consonants.dart';

class HomeScreenUser extends StatelessWidget {
  static String id = 'HomeScreen';
  String userName;
  @override
  Widget build(BuildContext context) {
    double heightMedia= MediaQuery.of(context).size.height;
    double widthMedia= MediaQuery.of(context).size.width;
    AppProvider prov= Provider.of<AppProvider>(context);

    return Scaffold(

        drawer: ProfileDrawer('me@gmail'),
        appBar: AppBar(
          title: Text('name: $userName'),
          iconTheme: IconThemeData(
              color: KButtonColor
          ),

          centerTitle: true,
          backgroundColor: KMainColor,
          elevation: 0,
        ),
        backgroundColor: KMainColor,
        bottomNavigationBar: BottomNavigationBar(
            type:BottomNavigationBarType.fixed,
            backgroundColor: KMainColor,
            selectedItemColor: KButtonColor,
            unselectedItemColor: Colors.black,
            items: prov.navList,
            onTap: (index){
              prov.ChangeIndex(index);
            },
            currentIndex:prov.currentIndex
          // AppProvider().currentIndex,
        ),
        body:prov.screens[prov.currentIndex]
    );
  }


}
