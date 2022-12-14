import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false
  });

  void toggleFavStatus() async {
    final oldStatus = isFavorite;
    isFavorite =! isFavorite;
    notifyListeners();
    final url = Uri.parse('https://flutter-http-2eaed-default-rtdb.firebaseio.com/products/${id}.json');
    try {
      final response = await http.patch(url, body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if(response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
        print(error);
    }
  }
}