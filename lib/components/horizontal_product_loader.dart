
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utilities/size_config.dart';


class HorizontalProductLoader extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     width: getProportionateScreenWidth(0),
     height: 250.0,
     child: Shimmer.fromColors(
       baseColor: Colors.grey,
       highlightColor: Colors.white,
       enabled: true,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         itemBuilder: (_, __) => Padding(
           padding: EdgeInsets.only(
               left: getProportionateScreenWidth(20),
               top: getProportionateScreenWidth(2)),
           child: SizedBox(
             width: getProportionateScreenWidth(140),
             child: GestureDetector(

               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   AspectRatio(
                     aspectRatio: 1.02,
                     child: Material(
                       elevation: 8,
                       borderRadius: BorderRadius.circular(15),
                       child: Container(
                         padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(15),
                         ),

                       ),
                     ),
                   ),
                   const SizedBox(height: 10),
                   Text(
                    "",
                     style: TextStyle(color: Colors.black),
                     maxLines: 1,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         "",
                         style: TextStyle(
                           fontSize: getProportionateScreenWidth(18),
                           fontWeight: FontWeight.w600,
                           color: Theme.of(context).colorScheme.primary,
                         ),
                       ),

                     ],
                   )
                 ],
               ),
             ),
           ),
         ),
         itemCount: 3,
       ),
     ),
   );
  }
}
