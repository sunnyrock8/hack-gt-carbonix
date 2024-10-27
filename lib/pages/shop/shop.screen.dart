import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/pages/shop/checkout_modal.widget.dart';
import 'package:carbonix/pages/shop/product.widget.dart';
import 'package:carbonix/provider/cart.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  TextEditingController _searchController = TextEditingController();

  final Map<String, List<Product>> _categorisedProducts = {
    'tickets': [
      Product(
        name: 'NFL Tickets',
        image: 'images/footballticket.png',
        completion: 0.56,
        tags: ['Tickets', 'Football'],
        price: 378.0,
        vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0',
      ),
      Product(
        name: 'Concert Tickets',
        image: 'images/concert.png',
        completion: 0.56,
        tags: ['Music', 'Concert'],
        price: 130.0,
        vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0',
      ),
      Product(
        name: 'Six Flags Gold Pass',
        image: 'images/six_flags_gold_pass_480x480.png',
        completion: 0.56,
        tags: ['Pass', 'Theme Park'],
        price: 80.0,
        vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0',
      ),
    ],
    'subscriptions': [
      Product(
          name: 'Apple Music Subscription',
          image: 'images/applemusic.png',
          completion: 0.56,
          tags: ['Music'],
          price: 11.0,
          vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0'),
      Product(
          name: 'Spotify Premium Subscription',
          image: 'images/spotify.png',
          completion: 0.56,
          tags: ['Music'],
          price: 10.0,
          vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0'),
      Product(
          name: 'DashPass Subscription',
          image: 'images/dashpass.png',
          completion: 0.56,
          tags: ['Food'],
          price: 10.0,
          vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0'),
      Product(
          name: 'Instacart+ Subscription',
          image: 'images/instacartplus.png',
          completion: 0.56,
          tags: ['Food', 'Grocery', 'Delivery'],
          price: 10.0,
          vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0'),
    ],
    'clothing': [
      Product(
          name: 'Avatar: The Last Airbender T-Shirt',
          image: 'images/t-shirt.png',
          completion: 0.56,
          tags: ['T-Shirt', 'Black'],
          price: 25.0,
          vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0'),
    ],
    'other': [
      Product(
          name: 'Utility Bill Credits',
          image: 'images/utilitybill.png',
          completion: 0.56,
          tags: ['T-Shirt', 'Black'],
          price: 15.0,
          vendorWallet: '0ebebf70-4402-4b68-b853-1c2d61a5b4b0'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ThemeColors.blue,
      // appBar: toolbarWidget(showBack: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimSearchBar(
                      width: screenWidth - 40,
                      textController: _searchController,
                      onSuffixTap: () {},
                      onSubmitted: (_) {},
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Tickets',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categorisedProducts['tickets']!.length,
                        itemBuilder: (_, int index) => ProductWidget(
                            product: _categorisedProducts['tickets']![index]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Subscriptions',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _categorisedProducts['subscriptions']!.length,
                        itemBuilder: (_, int index) => ProductWidget(
                            product:
                                _categorisedProducts['subscriptions']![index]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Clothing',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categorisedProducts['clothing']!.length,
                        itemBuilder: (_, int index) => ProductWidget(
                            product: _categorisedProducts['clothing']![index]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Other',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categorisedProducts['other']!.length,
                        itemBuilder: (_, int index) => ProductWidget(
                            product: _categorisedProducts['other']![index]),
                      ),
                    ),
                  ],
                ),
                Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return cart.products.length > 0
                        ? Positioned(
                            top: screenHeight - 240.0,
                            left: 0,
                            child: Pressable(
                              onPressed: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (_) => CheckoutModalWidget(
                                    cart: cart,
                                  ),
                                );
                              },
                              child: Container(
                                width: screenWidth - 40,
                                decoration: BoxDecoration(
                                  color: ThemeColors.text,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${cart.products.length} item${cart.products.length > 1 ? "s" : ""} in cart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.shopping_cart_checkout,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
