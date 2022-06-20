import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/big_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.shopping_cart)
        ],
        title: Center(child: BigText(text: "Cart History",)),
      ),
      body:Column(
        children: [

        ],
      ),
    );
  }
}
