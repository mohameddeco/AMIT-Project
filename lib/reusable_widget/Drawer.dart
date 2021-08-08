import 'package:amit_project/screens/login_screen.dart';
import 'package:amit_project/consonants.dart';
import 'package:amit_project/models/getUser_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileDrawer extends StatelessWidget {
  ProfileDrawer(this.emailDrawer){}

  String emailDrawer;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetUserModel>(
      future: GetUserDetails(KToken),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Container(

            width: 180,
            child: Drawer(

              child: Container(
                color: Colors.black87,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ListTile(
                            title: Text('@UserName',style: TextStyle(fontSize: 15,color: Colors.white),),
                            subtitle:Text('${ emailDrawer!=null?emailDrawer:'Email is Bugged'}',style: TextStyle(fontSize: 10,color: Colors.white)),
                            leading: CircleAvatar(
                                backgroundImage: null
                              //AssetImage('assets/images/profileavatar.jpg'),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Home',style: TextStyle(fontSize: 10,color: Colors.white)),
                        leading: Icon(Icons.home,color: Colors.indigo,),
                      ),
                      ListTile(
                        title: Text('Explore',style: TextStyle(fontSize: 10,color: Colors.white)),
                        leading: Icon(Icons.explore,color: Colors.indigo,),
                        onTap: (){
                          Navigator.pushNamed(context, 'TabBarPages');
                        },
                      ),
                      Center(
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(right: 20,top: 380),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  RemoveKeepLoggedin(context);
                                },
                                child: ListTile(
                                  title: Text('Sign Out',style: TextStyle(fontSize: 10,color: Colors.white)),
                                  leading: IconButton(icon:Icon(Icons.home,color: Colors.indigo),
                                    onPressed: (){

                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(icon: SvgPicture.asset('assets/images/fb.svg',color: Colors.indigo,width: 15,),onPressed: (){},),
                                  IconButton(icon: SvgPicture.asset('assets/images/insta.svg',color: Colors.indigo,width: 24,),onPressed: (){}),
                                  IconButton(icon: SvgPicture.asset('assets/images/twit.svg',color: Colors.indigo,width: 24,),onPressed: (){}),


                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else if(snapshot.hasData){
          GetUserModel modelUser=snapshot.data;
          return Container(

            width: 180,
            child: Drawer(

              child: Container(
                color: Colors.black87,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ListTile(
                            title: Text('${modelUser.name}',style: TextStyle(fontSize: 15,color: Colors.white),),
                            subtitle:Text('${ emailDrawer!=null?modelUser.email:'Email is Bugged'}',style: TextStyle(fontSize: 10,color: Colors.white)),
                            leading: CircleAvatar(
                                backgroundImage: null
                              //AssetImage('assets/images/profileavatar.jpg'),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Home',style: TextStyle(fontSize: 10,color: Colors.white)),
                        leading: Icon(Icons.home,color: Colors.indigo,),
                      ),
                      ListTile(
                        title: Text('Explore',style: TextStyle(fontSize: 10,color: Colors.white)),
                        leading: Icon(Icons.explore,color: Colors.indigo,),
                        onTap: (){
                          Navigator.pushNamed(context, 'TabBarPages');
                        },
                      ),
                      Center(
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(right: 20,top: 380),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  RemoveKeepLoggedin(context);
                                },
                                child: ListTile(
                                  title: Text('Sign Out',style: TextStyle(fontSize: 10,color: Colors.white)),
                                  leading: IconButton(icon:Icon(Icons.home,color: Colors.indigo),
                                    onPressed: (){

                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(icon: SvgPicture.asset('assets/images/fb.svg',color: Colors.indigo,width: 15,),onPressed: (){},),
                                  IconButton(icon: SvgPicture.asset('assets/images/insta.svg',color: Colors.indigo,width: 24,),onPressed: (){}),
                                  IconButton(icon: SvgPicture.asset('assets/images/twit.svg',color: Colors.indigo,width: 24,),onPressed: (){}),


                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        }else{
          return null;
        }
      },
    );
  }

  void RemoveKeepLoggedin(context) async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.remove(KeepMeLoggedIn);
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
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
/*
Container(

      width: 180,
      child: Drawer(

        child: Container(
          color: Colors.black87,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      title: Text('@UserName',style: TextStyle(fontSize: 15,color: Colors.white),),
                      subtitle:Text('${ emailDrawer!=null?emailDrawer:'Email is Bugged'}',style: TextStyle(fontSize: 10,color: Colors.white)),
                      leading: CircleAvatar(
                        backgroundImage: null
                        //AssetImage('assets/images/profileavatar.jpg'),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home',style: TextStyle(fontSize: 10,color: Colors.white)),
                  leading: Icon(Icons.home,color: Colors.indigo,),
                ),
                ListTile(
                  title: Text('Explore',style: TextStyle(fontSize: 10,color: Colors.white)),
                  leading: Icon(Icons.explore,color: Colors.indigo,),
                  onTap: (){
                    Navigator.pushNamed(context, 'TabBarPages');
                  },
                ),
                Center(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(right: 20,top: 380),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            RemoveKeepLoggedin(context);
                          },
                          child: ListTile(
                            title: Text('Sign Out',style: TextStyle(fontSize: 10,color: Colors.white)),
                            leading: IconButton(icon:Icon(Icons.home,color: Colors.indigo),
                            onPressed: (){

                            },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(icon: SvgPicture.asset('assets/images/fb.svg',color: Colors.indigo,width: 15,),onPressed: (){},),
                            IconButton(icon: SvgPicture.asset('assets/images/insta.svg',color: Colors.indigo,width: 24,),onPressed: (){}),
                            IconButton(icon: SvgPicture.asset('assets/images/twit.svg',color: Colors.indigo,width: 24,),onPressed: (){}),


                          ],

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
*/