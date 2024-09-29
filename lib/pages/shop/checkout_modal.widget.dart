import 'package:carbonix/crypto/crypto_service.dart';
import 'package:carbonix/pages/shop/product.widget.dart';
import 'package:carbonix/provider/cart.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckoutModalWidget extends StatefulWidget {
  final CartModel cart;

  CheckoutModalWidget({super.key, required this.cart});

  @override
  State<CheckoutModalWidget> createState() => _CheckoutModalWidgetState();
}

class _CheckoutModalWidgetState extends State<CheckoutModalWidget> {
  final CryptoService _cryptoService = CryptoService();
  Future<void>? _walletConnection;
  bool _transferringCrypto = false;

  @override
  void initState() {
    super.initState();
    _walletConnection = _connectToWallet();
  }

  Future<void> _connectToWallet() {
    return _cryptoService.setAgent();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.cart.getTotal()} CBRX',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.75,
                  child: Text(
                    'Are you ready to check out?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.cart.products.length,
                    itemBuilder: (_, int index) =>
                        ProductWidget(product: widget.cart.products[index]),
                  ),
                ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: _transferringCrypto ? 0.7 : 1.0,
                      child: Pressable(
                        disabled: _transferringCrypto,
                        onPressed: () async {
                          setState(() {
                            _transferringCrypto = true;
                          });
                          try {
                            await _walletConnection;
                            dynamic result = await _cryptoService.transfer(
                              '0ebebf70-4402-4b68-b853-1c2d61a5b4b0',
                              '647c54b7-0478-4fab-9211-b5881d26db91',
                              widget.cart.getTotal().toInt(),
                            );
                            print(result);

                            await showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Payment successful'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            '${widget.cart.getTotal()} CBRX were transferrred successfully and your order is confirmed.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Okay'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        widget.cart.removeAll();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            print(e);
                          } finally {
                            setState(() {
                              _transferringCrypto = false;
                            });
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
                            child: Text(
                              _transferringCrypto
                                  ? 'Paying...'
                                  : 'Pay ${widget.cart.getTotal()} CBRX securely',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
