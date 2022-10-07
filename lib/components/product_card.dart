

import 'package:flutter/material.dart';

import '../features/products_showcase/model/products_response.dart';
import '../utilities/size_config.dart';
import 'cache_network_img.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Items product;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(

          top: getProportionateScreenWidth(2)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
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
                  child: Hero(
                    tag: product.thumbnail.hashCode,

                    child: imgBuilder(product.thumbnail!.url??""),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name??"",
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 product.priceRange!.maximumPrice!.finalPrice!.value.toString()??"",
                  style:   Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.teal),
                ),
              /*  InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    height: getProportionateScreenWidth(28),
                    width: getProportionateScreenWidth(28),
                    decoration: BoxDecoration(
                      color: product.isFavourite
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                          : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: product.isFavourite
                          ? Color(0xFFFF4848)
                          : Color(0xFFDBDEE4),
                    ),
                  ),
                ),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
