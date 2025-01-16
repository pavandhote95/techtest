import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackerkernal/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  List<Map<String, String>> _products = [];
  List<Map<String, String>> _accessories = [];
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool showAllProducts = false;
  bool showAllAccessories = false;

  Future<void> loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _products = (prefs.getStringList('products') ?? []).map((item) {
      final parts = item.split('|');
      return {
        'name': parts[0],
        'image': parts[1],
        'price': parts[2],
      };
    }).toList();
  }

  Future<void> loadAccessories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessories = (prefs.getStringList('accessories') ?? []).map((item) {
      final parts = item.split('|');
      return {
        'name': parts[0],
        'image': parts[1],
        'price': parts[2],
      };
    }).toList();
  }

  Future<void> addProduct(Map<String, String> product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDuplicate = _products.any((existingProduct) =>
        existingProduct['name']!.toLowerCase() ==
        product['name']!.toLowerCase());

    if (isDuplicate) {
      Fluttertoast.showToast(
        msg: "Product already exists!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(231, 243, 242, 242),
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    }

    _products.add(product);
    prefs.setStringList(
      'products',
      _products.map((p) => '${p['name']}|${p['image']}|${p['price']}').toList(),
    );

    Fluttertoast.showToast(
      msg: "Product added successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(231, 243, 242, 242),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> addAccessory(Map<String, String> accessory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDuplicate = _accessories.any((existingAccessory) =>
        existingAccessory['name']!.toLowerCase() ==
        accessory['name']!.toLowerCase());

    if (isDuplicate) {
      Fluttertoast.showToast(
        msg: "Accessory already exists!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(231, 243, 242, 242),
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    }

    _accessories.add(accessory);
    prefs.setStringList(
      'accessories',
      _accessories
          .map((a) => '${a['name']}|${a['image']}|${a['price']}')
          .toList(),
    );

    Fluttertoast.showToast(
      msg: "Accessory added successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(231, 243, 242, 242),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
    Fluttertoast.showToast(
      msg: "Logout",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 27, 101, 250),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> deleteProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _products.removeAt(index);
    prefs.setStringList(
      'products',
      _products.map((p) => '${p['name']}|${p['image']}|${p['price']}').toList(),
    );

    Fluttertoast.showToast(
      msg: "Product deleted successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(231, 243, 242, 242),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> deleteAccessory(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessories.removeAt(index);
    prefs.setStringList(
      'accessories',
      _accessories
          .map((a) => '${a['name']}|${a['image']}|${a['price']}')
          .toList(),
    );

    Fluttertoast.showToast(
      msg: "Accessory deleted successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(231, 243, 242, 242),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  List<Map<String, String>> get filteredProducts {
    final searchText = searchController.text.toLowerCase();
    final itemsToShow =
        showAllProducts ? _products : _products.take(2).toList();
    return itemsToShow.where((product) {
      return product['name']!.toLowerCase().contains(searchText);
    }).toList();
  }

  List<Map<String, String>> get filteredAccessories {
    final searchText = searchController.text.toLowerCase();
    final itemsToShow =
        showAllAccessories ? _accessories : _accessories.take(2).toList();
    return itemsToShow.where((accessory) {
      return accessory['name']!.toLowerCase().contains(searchText);
    }).toList();
  }
}
