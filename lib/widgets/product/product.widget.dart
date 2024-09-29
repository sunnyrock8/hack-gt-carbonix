import 'package:carbonix/models/product.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Function onPress;
  final Product product;

  const ProductWidget({Key? key, required this.onPress, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPressed: () {
        this.onPress();
      },
      child: Container(
        width: 250.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(217, 217, 217, 0.5),
              offset: Offset(5, 13),
              blurRadius: 40.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product.image, height: 125),
            const SizedBox(height: 20.0),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 80.0,
                  child: Center(
                    child: Text(
                      '${((product.completion ?? 0.0) * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 18,
                        color: ThemeColors.darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color:
                        !product.active ? Colors.white : ThemeColors.darkGreen,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.active ? 'Remove' : 'Add',
                          style: TextStyle(
                            fontSize: 18,
                            color: product.active
                                ? Colors.white
                                : ThemeColors.darkGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Icon(
                          product.active ? Icons.remove : Icons.add,
                          size: 18,
                          color: product.active
                              ? Colors.white
                              : ThemeColors.darkGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
