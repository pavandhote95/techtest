import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hackerkernal/controllers/add_product_controller.dart';

// Import the controller

class AddProductPage extends StatelessWidget {
  final Function(Map<String, String>) onAddProduct;
  final Function(Map<String, String>) onAddAccessory;

  const AddProductPage({
    required this.onAddProduct,
    required this.onAddAccessory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddProductController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'Add Product',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(231, 243, 242, 242),
                    border: Border.all(
                      color: const Color.fromARGB(18, 123, 123, 123),
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(149, 0, 0, 0),
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => FadeInDown(
                    duration: Duration(milliseconds: 1100),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: controller.nameController.value,
                                decoration: InputDecoration(
                                  labelText: 'Product Name',
                                  errorText: controller.nameError.value,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: TextFormField(
                                controller: controller.priceController.value,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  errorText: controller.priceError.value,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (controller.imagePath.value != null)
                              Center(
                                child: Image.file(
                                  File(controller.imagePath.value!),
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                            else
                              InkWell(
                                onTap: controller.pickImage,
                                child: Center(
                                  child: Container(
                                    height: 150,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.image,
                                    size: 20, color: Colors.white),
                                label: const Text(
                                  'Pick Image',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 101, 250),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                ),
                                onPressed: controller.pickImage,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: DropdownButtonFormField<String>(
                                value: controller.selectedCategory.value,
                                items: ['Product', 'Accessories']
                                    .map((category) => DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        ))
                                    .toList(),
                                decoration: InputDecoration(
                                  labelText: 'Select Category',
                                  errorText: controller.categoryError.value,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onChanged: (value) {
                                  controller.selectedCategory.value = value;
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => controller.submitProduct(
                                      onAddProduct, onAddAccessory, context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 27, 101, 250),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                  ),
                                  child: controller.isLoading.value
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3.0,
                                          ),
                                        )
                                      : const Text(
                                          "Add Product",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        });
  }
}
