import 'package:flutter/material.dart';
import 'package:product_app/products.dart';

class CartPage extends StatelessWidget {
  final List<Product> cart; // List to store products in the cart.
  final Function(Product)
      removeFromCart; // Function to remove a product from the cart.
  final Function() clearCart; // Function to clear all items from the cart.
  final Function() generateReceipt; // Function to generate a receipt.

  CartPage({
    required this.cart, // Constructor parameter for the cart.
    required this.removeFromCart, // Constructor parameter for the removeFromCart function.
    required this.clearCart, // Constructor parameter for the clearCart function.
    required this.generateReceipt, // Constructor parameter for the generateReceipt function.
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        centerTitle: true, // Display 'Shopping Cart' as the app bar title.
      ),
      body: ListView.builder(
        itemCount: cart
            .length, // Set the number of items in the ListView to the length of the cart.
        itemBuilder: (context, index) {
          final product = cart[index]; // Get the product at the current index.
          return Card(
            color: Colors.green.shade100,
            child: SizedBox(
              height: 100,
              width: 200,
              child: ListTile(
                title: Text(product
                    .title), // Display the product title in the ListTile.
                subtitle: Text(
                    '\$${product.price.toStringAsFixed(2)}'), // Display the product price in fixed decimal format.
                trailing: IconButton(
                  icon: Icon(Icons
                      .remove_shopping_cart), // Display a remove shopping cart icon.
                  onPressed: () => removeFromCart(
                      product), // Call removeFromCart when the IconButton is pressed.
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generateReceipt(); // Call generateReceipt when the FloatingActionButton is pressed.
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Receipt generated as receipt.pdf')));
          // Show a snackbar to inform the user that the receipt has been generated.
        },
        child: Icon(Icons
            .receipt), // Display a receipt icon on the FloatingActionButton.
      ),
    );
  }
}
