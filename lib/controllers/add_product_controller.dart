import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hackerkernal/views/home_page.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  var nameController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var imagePath = Rx<String?>(null);
  var selectedCategory = Rx<String?>(null);
  var isLoading = false.obs;

  var nameError = Rx<String?>(null);
  var priceError = Rx<String?>(null);
  var categoryError = Rx<String?>(null);

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  @override
  void onClose() {
    nameController.value.dispose();
    priceController.value.dispose();
    super.onClose();
  }

  void submitProduct(
      Function(Map<String, String>) onAddProduct,
      Function(Map<String, String>) onAddAccessory,
      BuildContext context) async {
    if (isLoading.value) return;

    if (nameController.value.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Product name is required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final price = priceController.value.text.trim();

    if (price.isEmpty) {
      Fluttertoast.showToast(
        msg: "Price is required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final priceValue = double.tryParse(price);
    if (priceValue == null) {
      Fluttertoast.showToast(
        msg: "Enter a valid price",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (selectedCategory.value == null) {
      Fluttertoast.showToast(
        msg: "Please select a category",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    final productData = {
      'name': nameController.value.text.trim(),
      'price': price,
      'image': imagePath.value ?? '',
      'category': selectedCategory.value!,
    };

    if (selectedCategory.value == 'Product') {
      onAddProduct(productData);
    } else if (selectedCategory.value == 'Accessories') {
      onAddAccessory(productData);
    }
    nameController.value.clear();
    priceController.value.clear();
    imagePath.value = null;
    selectedCategory.value = null;

    isLoading.value = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
