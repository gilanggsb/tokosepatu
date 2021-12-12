import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokosepatu/pages/cart_page.dart';
import 'package:tokosepatu/pages/checkout_page.dart';
import 'package:tokosepatu/pages/home/detail_chat_page.dart';
import 'package:tokosepatu/pages/home/edit_profile_page.dart';
import 'package:tokosepatu/pages/sign_in_page.dart';
import 'package:tokosepatu/pages/sign_up_page.dart';
import 'package:tokosepatu/pages/splash_page.dart';
import 'package:tokosepatu/providers/auth_provider.dart';
import 'package:tokosepatu/providers/page_provider.dart';
import 'package:tokosepatu/providers/product_providers.dart';
import 'package:tokosepatu/providers/transaction_provider.dart';
import 'package:tokosepatu/providers/wishlist_provider.dart';

import 'pages/checkout_success_page.dart';
import 'pages/home/main_page.dart';
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => const MainPage(),
          // '/detail-chat': (context) => const DetailChatPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/checkout-success': (context) => const CheckoutSuccessPage(),
        },
      ),
    );
  }
}
