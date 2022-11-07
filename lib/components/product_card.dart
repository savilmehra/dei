import 'package:flutter/material.dart';
import '../features/products_showcase/models/fielSpinResponse.dart';
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
  final FileSpinFiles product;

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

                    child: imgBuilder(product.thumbnail!??""),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name??"",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: getProportionateScreenWidth(20),fontWeight: FontWeight.bold),
              maxLines: 1,
            ),

          ],
        ),
      ),
    );
  }
}
