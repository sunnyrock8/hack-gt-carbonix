import 'package:carbonix/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../models/product.model.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(217, 217, 217, 0.5),
            offset: Offset(5, 13),
            blurRadius: 40.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Image.asset(product.image, height: 100),
          const SizedBox(height: 10.0),
          Text(
            product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          LinearProgressIndicator(
            value: product.completion,
            color: ThemeColors.darkGreen,
            minHeight: 10.0,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          const SizedBox(height: 5.0),
          Text(
            '${((product.completion ?? 0.0) * product.price).toStringAsFixed(2)}/${product.price.toStringAsFixed(2)} CRBX',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
