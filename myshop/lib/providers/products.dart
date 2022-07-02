import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './product.dart';
import '../Models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;

  // void showFavoriteOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get favoriteItems {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  final String authToken;
  final String userId;
  Products(this.authToken, this._items, this.userId);

  List<Product> get items {
    //We return a copy of the _items so because in dart we pass data in reference type
    //And if we passed the _items to another place then we would have direct access to the entire list of the Products and we could change the data of that list
    //Hence we return the list of Products within the items list as a list
    // if (_showFavoritesOnly) {
    //   return _items.where((productItems) => productItems.isFavorite).toList();
    // }
    return [..._items];
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-update-f199a-default-rtdb.firebaseio.com/products.json?auth=$authToken');

    try {
      //This sends a post request to the url
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'id': product.id,
            'creatorId': userId,
          },
        ),
      );
      final newProduct = Product(
        title: product.title,
        id: json.decode(response.body)['name'], //Gets the backend id
        imageUrl: product.imageUrl,
        price: product.price,
        description: product.description,
      );
      print(newProduct.id);
      _items.add(newProduct);

      //This will notify all the widgets which are interested in the List of items that items list has been modified
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
  // )

//_items.add(value);

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-update-f199a-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          },
        ),
      );
      _items[prodIndex] = newProduct;
    } else {
      print('.......');
    }
    notifyListeners();
  }

  //In this method instead of updating the values using async await we will
  //Optimistically update the values
  //Just to show an alternative method of async await

  // void deleteProduct(String id) {
  //   final url = Uri.https(
  //       'flutter-update-f199a-default-rtdb.firebaseio.com', 'products/$id');

  //   //Copying the value which will be deleted
  //   final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
  //   var existingProduct = _items[existingProductIndex];

  //   //Hence this will keep the deleted item in the memory
  //   _items.removeAt(existingProductIndex);

  //   //In this method we can roll back if the element which we were trying to delete wasn't deleted
  //   //But, if the deletion is successful then we remove the reference to that product element from the memory
  //   notifyListeners();
  //   //Delete does not throw an error if the server returns a error status code
  //   //Even though an error occurs delete goes into then block
  //   http.delete(url).then((response) {
  //     if (response.statusCode >= 400) {
  //       throw HttpException('Could not delete Product');
  //     }
  //     existingProduct = null;
  //   }).catchError((_) {
  //     _items.insert(existingProductIndex, existingProduct);
  //     notifyListeners();
  //   });
  // }

  //In order to stay consistent with the rest of the code we will use async await

  void deleteProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-update-f199a-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

    //Copying the value which will be deleted
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    //Hence this will keep the deleted item in the memory
    _items.removeAt(existingProductIndex);

    //In this method we can roll back if the element which we were trying to delete wasn't deleted
    //But, if the deletion is successful then we remove the reference to that product element from the memory
    notifyListeners();
    //Delete does not throw an error if the server returns a error status code
    //Even though an error occurs delete goes into then block

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      throw HttpException('Could not delete Product');
    } //throw is like return cancels the further execution
    existingProduct = null;

    notifyListeners();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-update-f199a-default-rtdb.firebaseio.com/products.json?auth=$authToken$filterString');
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return null;

      url = Uri.parse(
          'https://flutter-update-f199a-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');

      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite: favoriteData == null
                ? false
                : favoriteData[prodId] ??
                    false, //?? checks if the value is null then it will fallback to the next value
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
