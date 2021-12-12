import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokosepatu/Widget/checkout_card.dart';
import 'package:tokosepatu/Widget/loading_button.dart';
import 'package:tokosepatu/providers/auth_provider.dart';
import 'package:tokosepatu/providers/cart_provider.dart';
import 'package:tokosepatu/providers/transaction_provider.dart';
import 'package:tokosepatu/theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (await transactionProvider.checkout(
        authProvider.user.token!,
        cartProvider.carts,
        cartProvider.totalPrice(),
      )) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }
      setState(() {
        isLoading = false;
      });
    }

    PreferredSizeWidget header() {
      return PreferredSize(
        child: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor1,
          elevation: 0,
          title: const Text('Checkout Details'),
        ),
        preferredSize: const Size.fromHeight(60),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          //NOTE: LIST ITEMS
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: cartProvider.carts
                      .map((cart) => CheckoutCard(cart: cart))
                      .toList(),
                ),
              ],
            ),
          ),

          //NOTE:: ADDRESS DETAILS
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    //NOTE: STORE LOCATION
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/icon_store_location.png',
                          width: 40,
                        ),
                        Image.asset(
                          'assets/icons/icon_line.png',
                          height: 30,
                        ),
                        Image.asset(
                          'assets/icons/icon_your_location.png',
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),

                    //NOTE : YOUR ADDRESS
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Adidas Core',
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Marsemoon',
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //NOTE: PAYMENT SUMMARY
                Container(
                  margin: EdgeInsets.only(top: defaultMargin),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundColor4,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Summary',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Quantity',
                            style: secondaryTextStyle.copyWith(fontSize: 12),
                          ),
                          Text(
                            '${cartProvider.totalItems()} Items',
                            style:
                                primaryTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Price',
                            style: secondaryTextStyle.copyWith(fontSize: 12),
                          ),
                          Text(
                            '\$${cartProvider.totalPrice()}',
                            style:
                                primaryTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style: secondaryTextStyle.copyWith(fontSize: 12),
                          ),
                          Text(
                            'Free',
                            style:
                                primaryTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xFF2e3141),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style:
                                priceTextStyle.copyWith(fontWeight: semiBold),
                          ),
                          Text(
                            '\$${cartProvider.totalPrice()}',
                            style:
                                priceTextStyle.copyWith(fontWeight: semiBold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //NOTE: CHECKOUT BUTTON
                SizedBox(
                  height: defaultMargin,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF2e3141),
                ),
                isLoading
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: const LoadingButton())
                    : Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: defaultMargin),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Checkout Now',
                            style: primaryTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: handleCheckout,
                        ),
                      )
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}
