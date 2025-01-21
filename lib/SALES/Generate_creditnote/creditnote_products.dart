import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssipl_billing/SALES/Generate_creditnote/generate_creditnote.dart';
import 'package:ssipl_billing/SALES/Generate_creditnote/creditnote_template.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class creditnoteProducts extends StatefulWidget {
  const creditnoteProducts({super.key});

  @override
  State<creditnoteProducts> createState() => _creditnoteProductsState();
}

class _creditnoteProductsState extends State<creditnoteProducts> {
  int? editIndex1;
  final formKey1 = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  final TextEditingController hsnController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController GSTController = TextEditingController();
  void _clearFields() {
    setState(
      () {
        remarksController.clear();
        productNameController.clear();
        hsnController.clear();
        priceController.clear();
        quantityController.clear();
        GSTController.clear();
        // SGSTController.clear();
      },
    );
  }

  void _addproduct() {
    if (formKey1.currentState?.validate() ?? false) {
      // Check if a product with the same values already exists
      bool exists = creditnote_productDetails.any((product) =>
          product['productName'] == productNameController.text &&
          product['remarks'] == remarksController.text &&
          product['hsn'] == hsnController.text &&
          product['price'] == double.parse(priceController.text) &&
          product['quantity'] == int.parse(quantityController.text) &&
          product['gst'] == double.parse(GSTController.text));

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('This product already exists.'),
          ),
        );
        return; // Exit the method without adding the product
      }

      setState(() {
        creditnote_productDetails.add({
          'productName': productNameController.text,
          'remarks': remarksController.text,
          'hsn': hsnController.text,
          'price': double.parse(priceController.text),
          'quantity': int.parse(quantityController.text),
          'gst': double.parse(GSTController.text),
        });

        _clearFields();
        // print(creditnote_productDetails.length);
      });
    }
  }

  void _updateproduct() {
    if (formKey1.currentState?.validate() ?? false) {
      setState(
        () {
          creditnote_productDetails[editIndex1!] = {
            'productName': productNameController.text,
            'remarks': remarksController.text,
            'hsn': hsnController.text,
            'price': double.parse(priceController.text),
            'quantity': int.parse(quantityController.text),
            'gst': double.parse(GSTController.text),
            // 'productSGST': SGSTController.text,
          };
          _clearFields();
          editIndex1 = null;
        },
      );
    }
  }

  void _editproduct(int index) {
    Map<String, dynamic> product = creditnote_productDetails[index];
    setState(
      () {
        productNameController.text = product['productName'] ?? '';
        remarksController.text = product['remarks'] ?? '';
        hsnController.text = product['hsn'] ?? '';
        priceController.text = product['price'].toString();
        quantityController.text = product['quantity'].toString();
        GSTController.text = product['gst'].toString();
        // SGSTController.text = product['productSGST'] ?? '';
        editIndex1 = index; // Set the index of the item being edited
      },
    );
    // print('Edit------------------${selected_notify_Items}');
  }

  void _resetEditingState() {
    setState(
      () {
        _clearFields();
        editIndex1 = null;
      },
    );
  }

  Widget creditnote_productDetailss() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < creditnote_productDetails.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _editproduct(i);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Primary_colors.Light),
                  height: 40,
                  width: 300,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              '${i + 1}. ${creditnote_productDetails[i]['productName']}', // Display camera type from map
                              style: const TextStyle(color: Primary_colors.Color1, fontSize: Primary_font_size.Text7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  creditnote_productDetails.removeAt(i);
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 25),
                    Textfield_1(
                      readonly: false,
                      text: 'Product Name',
                      controller: productNameController,
                      icon: Icons.production_quantity_limits,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Product name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    Textfield_1(
                      readonly: false,
                      text: 'HSN',
                      controller: hsnController,
                      icon: Icons.numbers,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter HSN';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        readOnly: false,
                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          // labelText: text,
                          hintText: 'Product GST',
                          hintStyle: TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.price_change,
                            color: Colors.white,
                          ),
                        ),
                        controller: GSTController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Product GST';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        readOnly: false,
                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          // labelText: text,
                          hintText: 'Product Price',
                          hintStyle: TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            color: Colors.white,
                          ),
                        ),
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Product price';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        readOnly: false,
                        style: const TextStyle(fontSize: Primary_font_size.Text7, color: Colors.white),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Primary_colors.Dark,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          // labelText: text,
                          hintText: 'Product Quantity',
                          hintStyle: TextStyle(
                            fontSize: Primary_font_size.Text7,
                            color: Color.fromARGB(255, 167, 165, 165),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.production_quantity_limits,
                            color: Colors.white,
                          ),
                        ),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Product Quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    Textfield_1(
                      readonly: false,
                      text: 'Remarks',
                      controller: remarksController,
                      icon: Icons.production_quantity_limits,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add the remarks';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button1(
                          colors: Colors.red,
                          text: editIndex1 == null ? 'Back' : 'Cancle',
                          onPressed: () {
                            editIndex1 == null ? Generate_creditnote.backTab() : _resetEditingState(); // Reset editing state when going back
                          },
                        ),
                        const SizedBox(width: 30),
                        Button1(
                          colors: editIndex1 == null ? Colors.blue : Colors.orange,
                          text: editIndex1 == null ? 'Add product' : 'Update',
                          onPressed: editIndex1 == null ? _addproduct : _updateproduct,
                        ),
                      ],
                    ),
                  ],
                ),
                // if (length != 0) const SizedBox(width: 60),
                if (creditnote_productDetails.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Primary_colors.Dark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 15),
                          child: Column(
                            children: [
                              const Text(
                                'Product List',
                                style: TextStyle(fontSize: Primary_font_size.Text10, color: Primary_colors.Color1, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 295,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: creditnote_productDetailss(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      if (creditnote_productDetails.isNotEmpty)
                        Button1(
                          colors: Colors.green,
                          text: 'Submit',
                          onPressed: () {
                            creditnote_products.clear();
                            // Step 1: Add non-duplicate items to creditnote_products
                            for (var entry in creditnote_productDetails) {
                              // final isDuplicate = creditnote_products.any((product) => product.productName == entry['productName'] && product.hsn == entry['hsn'] && product.gst == entry['gst'] && product.price == entry['price'] && product.quantity == entry['quantity']);

                              // if (!isDuplicate) {
                              final index = creditnote_products.length + 1; // Generate serial number
                              creditnote_products.add(Product(index.toString(), entry['productName'] as String, entry['hsn'] as String, entry['gst'] as double, entry['price'] as double,
                                  entry['quantity'] as int, entry['remarks'] as String));
                              // }
                            }

                            // Step 2: Group products by GST and calculate total for each group
                            creditnote_gstTotals = creditnote_products
                                .fold<Map<double, double>>({}, (Map<double, double> accumulator, Product product) {
                                  accumulator[product.gst] = (accumulator[product.gst] ?? 0) + product.total;
                                  return accumulator;
                                })
                                .entries
                                .map((entry) => {
                                      'gst': entry.key,
                                      'total': entry.value,
                                    })
                                .toList();

                            if (kDebugMode) {
                              print(creditnote_gstTotals);
                            }

                            // Step 3: Navigate to the next tab
                            Generate_creditnote.nextTab();
                          },
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
