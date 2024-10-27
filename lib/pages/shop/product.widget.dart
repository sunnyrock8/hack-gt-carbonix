import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/pages/shop/product_modal.widget.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPressed: () {
        showCupertinoModalBottomSheet(
            context: context,
            builder: (_) => ProductModalWidget(product: product));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(product.image, height: 100.0)),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 175.0,
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '${product.price} CCTS' +
                  (product.quantity != null && product.quantity! > 0
                      ? ' x ${product.quantity}'
                      : ''),
              style: TextStyle(
                color: ThemeColors.darkGreen,
              ),
            )
          ],
        ),
      ),
    );
  }
}
