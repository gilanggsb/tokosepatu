import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokosepatu/models/product_model.dart';
import 'package:tokosepatu/providers/wishlist_provider.dart';
import 'package:tokosepatu/theme.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({Key? key, required this.product}) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.galleries![0].url.toString(),
              width: 60,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.toString(),
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text('\$${product.price}', style: priceTextStyle),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishListProvider.setProduct(product);
            },
            child: Image.asset(
              'assets/buttons/button_wishlist_blue.png',
              width: 34,
            ),
          )
        ],
      ),
    );
  }
}
