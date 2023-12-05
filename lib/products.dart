class Product {
  // Properties that define a product
  final int id; // Unique identifier for the product.
  final String title; // Name or title of the product.
  final double price; // Price of the product.
  final String image; // URL or path to the image representing the product.

  // Constructor for creating a Product instance with required parameters
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  // Factory method to create a Product instance from JSON data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'], // Extract the 'id' field from the JSON data.
      title: json['title'], // Extract the 'title' field from the JSON data.
      price: json['price'].toDouble(), // Convert the 'price' field to a double.
      image: json['image'], // Extract the 'image' field from the JSON data.
    );
  }
}
