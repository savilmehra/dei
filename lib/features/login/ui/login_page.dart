import 'package:clean_framework/clean_framework.dart';
import 'package:dei/features/login/ui/sign_form.dart';
import 'package:flutter/material.dart';

import '../../../utilities/size_config.dart';

class LofinPage extends StatefulWidget {

  static String routeName = '/login';




  @override
  LofinPageState createState() =>LofinPageState();
}


class LofinPageState extends State<LofinPage>
{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:

     Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("lib/assets/images/bg_2.png"),
             fit: BoxFit.cover,
           ),
         ),
         child:Padding(
           padding: const EdgeInsets.all(20.0),
           child: Center(

             child: Column(
               children: [

                 SizedBox(height: SizeConfig.screenHeight! * 0.04),
                 SizedBox(
                   height: 70,
                   child: Image(

                     image:AssetImage("lib/assets/images/logo.png"),
                   ),
                 ),


                 Text.rich(
                     TextSpan(
                         text: 'Sign In ',
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: getProportionateScreenWidth(28),
                           fontWeight: FontWeight.bold,
                         ),
                         children: <InlineSpan>[
                           TextSpan(
                             text: 'With',
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: getProportionateScreenWidth(18),
                               fontWeight: FontWeight.normal,
                             ),
                           )
                         ]
                     )
                 ),

                 Text(
                   "Your Credentials",
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: getProportionateScreenWidth(18),
                     fontWeight: FontWeight.normal,
                   ),
                 ),
                 SizedBox(height: SizeConfig.screenHeight! * 0.08),
                 SignForm(
                   isLoading:false,
                   onTapForgotPassword: (){},
                   signInFormCallback: (username, password) {
                     print("sing in button pressed1");

                   },
                 ),
                 SizedBox(height: SizeConfig.screenHeight! * 0.08),
               ],
             ),


           ),
         )
     ),
  /*   Stack(
       children: [
         Container(
           decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage("lib/assets/images/bg_2.png"),
               fit: BoxFit.cover,
             ),
           ),
           child:Container(
             child: SingleChildScrollView(

               child: Column(

             children: [    Text("uidywdf80")],
               ),
             ),



           )
         ),
       *//*  Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage("lib/assets/images/bg_1.png"),
                 fit: BoxFit.fitHeight,
               ),
             ),
             child:  Padding(
               padding: EdgeInsets.symmetric(
                   horizontal: getProportionateScreenWidth(20)),
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     SizedBox(height: SizeConfig.screenHeight! * 0.04),
                     Image(

                       image:AssetImage("lib/assets/images/ff.png"),
                     ),


                     Text(
                       "Sign In",
                       style: TextStyle(
                         color: Theme.of(context).colorScheme.primary,
                         fontSize: getProportionateScreenWidth(28),
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Text(
                       "With Your Credentials",
                       textAlign: TextAlign.center,
                     ),
                     SizedBox(height: SizeConfig.screenHeight! * 0.08),
                     SignForm(
                       isLoading:false,
                       onTapForgotPassword: (){},
                       signInFormCallback: (username, password) {
                         print("sing in button pressed1");

                       },
                     ),
                     SizedBox(height: SizeConfig.screenHeight! * 0.08),
                     *//**//* Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         SocialCard(
                           icon: "assets/icons/google-icon.svg",
                           press: () {},
                         ),
                         SocialCard(
                           icon: "assets/icons/facebook-2.svg",
                           press: () {},
                         ),
                         SocialCard(
                           icon: "assets/icons/twitter.svg",
                           press: () {},
                         ),
                       ],
                     ),*//**//*
                     SizedBox(height: getProportionateScreenHeight(20)),

                   ],
                 ),
               ),
             )
         ),*//*
       ],
     ),*/




   );
  }
}