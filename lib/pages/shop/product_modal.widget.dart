import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/provider/cart.model.dart';
import 'package:carbonix/provider/user_details.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductModalWidget extends StatelessWidget {
  final Product product;

  const ProductModalWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: Container(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(product.image, width: screenWidth - 60),
                SizedBox(height: 20.0),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                product.description != null
                    ? SizedBox(
                        width: screenWidth * 0.75,
                        child: Text(
                          product.description ?? '',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                      )
                    : SizedBox(),
                Row(
                  children: [
                    ...(product.tags ?? []).map(
                      (tag) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: ThemeColors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    Expanded(child: SizedBox()),
                    Consumer<UserDetailsModel>(
                      builder: (context, userDetails, child) {
                        bool inWishlist = userDetails.wishlist
                            .where((el) => el.id == product.id)
                            .isNotEmpty;
                        return Pressable(
                          onPressed: () {
                            inWishlist
                                ? userDetails.removeFromWishlist(product.id)
                                : userDetails.addToWishlist(product);
                          },
                          child: Icon(
                            inWishlist
                                ? Icons.star
                                : Icons.star_border_outlined,
                            size: 30.0,
                            color:
                                inWishlist ? Colors.yellow : ThemeColors.text,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 5.0),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Consumer<CartModel>(
                  builder: (context, cart, child) {
                    bool isAdded = cart.products
                        .where((el) => el.id == product.id)
                        .isNotEmpty;
                    return Row(
                      mainAxisAlignment: isAdded
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isAdded
                            ? Pressable(
                                onPressed: () {
                                  cart.reducePiece(product.id);
                                },
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  margin: const EdgeInsets.only(right: 20.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        30.0,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Pressable(
                          onPressed: () {
                            if (isAdded) {
                              cart.addPiece(product.id);
                            } else {
                              cart.add(product);
                            }
                          },
                          child: Container(
                            width: screenWidth * 0.7,
                            padding: const EdgeInsets.all(20.0),
                            decoration: const BoxDecoration(
                              color: ThemeColors.text,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    isAdded
                                        ? 'Added (${cart.products.firstWhere((el) => el.id == product.id).quantity})'
                                        : 'Add to cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
