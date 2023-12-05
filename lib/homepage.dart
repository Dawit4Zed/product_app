import 'package:flutter/material.dart';
import 'package:product_app/cartpage.dart';
import 'package:product_app/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = []; // List to store fetched products.
  List<Product> cart = []; // List to store products added to the cart.

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Call the method to fetch products when the widget initializes.
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        products = data
            .map((json) => Product.fromJson(json))
            .toList(); // Map JSON data to Product objects.
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void addToCart(Product product) {
    setState(() {
      cart.add(product); // Add a product to the cart.
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cart.remove(product); // Remove a product from the cart.
    });
  }

  void clearCart() {
    setState(() {
      cart.clear(); // Clear all items from the cart.
    });
  }

  Future<void> generateReceipt() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Receipt',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            for (var item in cart)
              pw.Text('${item.title} - \$${item.price.toStringAsFixed(2)}'),
            pw.SizedBox(height: 10),
            pw.Text(
                'Total: \$${cart.map((item) => item.price).fold(0.0, (a, b) => a + b).toInt()}'),
          ],
        ),
      ),
    );

    // Save the PDF file
    final Uint8List pdfBytes = await pdf.save();
    final file = File('receipt.pdf');
    await file.writeAsBytes(pdfBytes); // Write PDF bytes to a file.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products App'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.fromLTRB(20, 50, 20, 5),
            color: Colors.green.shade100,
            child: SizedBox(
              height: 100,
              width: 200,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.image),
                ),
                title: Text(
                  product.title,
                  style: TextStyle(
                    color: Colors.black54.withOpacity(1),
                  ),
                ),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () => addToCart(product),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(
                cart: cart,
                removeFromCart: removeFromCart,
                clearCart: clearCart,
                generateReceipt: generateReceipt),
          ),
        ),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
