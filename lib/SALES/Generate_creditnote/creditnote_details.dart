import 'package:flutter/material.dart';
import 'package:ssipl_billing/SALES/Generate_creditnote/creditnote_template.dart';
import 'package:ssipl_billing/SALES/Generate_creditnote/generate_creditnote.dart';
import 'package:ssipl_billing/button.dart';
import 'package:ssipl_billing/common_modules/style.dart';
import 'package:ssipl_billing/textfield.dart';

class creditnoteDetails extends StatefulWidget {
  const creditnoteDetails({super.key});

  @override
  State<creditnoteDetails> createState() => _creditnoteDetailsState();
}

class _creditnoteDetailsState extends State<creditnoteDetails> {
  // final TextEditingController titleController = TextEditingController();
  final TextEditingController clientaddressnameController = TextEditingController();
  final TextEditingController clientaddressController = TextEditingController();
  final TextEditingController billingaddressnameController = TextEditingController();
  final TextEditingController billingaddressController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    clientaddressnameController.text = creditnote_client_addr_name;
    clientaddressController.text = creditnote_client_addr;
    billingaddressnameController.text = creditnote_bill_addr_name;
    billingaddressController.text = creditnote_bill_addr;

    // titleController.text = creditnote_title ?? '';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
                key: formKey1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        // Textfield_1(
                        //   readonly: false,
                        //   text: 'Title',
                        //   controller: titleController,
                        //   icon: Icons.title,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter Title';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Client Address name',
                          controller: clientaddressnameController,
                          icon: Icons.people,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Client Address name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Client Address ',
                          controller: clientaddressController,
                          icon: Icons.location_history_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Client Address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Textfield_1(
                          readonly: false,
                          text: 'Billing Address name',
                          controller: billingaddressnameController,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Billing Address name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Textfield_1(
                          readonly: false,
                          text: 'Billing Address',
                          controller: billingaddressController,
                          icon: Icons.price_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Billing Address';
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
                              colors: Colors.green,
                              text: 'Add Details',
                              onPressed: () {
                                if (formKey1.currentState?.validate() ?? false) {
                                  creditnote_client_addr_name = clientaddressnameController.text;
                                  creditnote_client_addr = clientaddressController.text;
                                  creditnote_bill_addr_name = billingaddressnameController.text;
                                  creditnote_bill_addr = billingaddressController.text;

                                  // creditnote_title = titleController.text;
                                  Generate_creditnote.nextTab();
                                }
                                // if (_formKey.currentState?.validate() == true) {

                                // }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 25),
            const SizedBox(
              width: 660,
              child: Text(
                textAlign: TextAlign.center,
                'The Client requirement shown beside can be used as a reference for generating the creditnote. Ensure that all the details inherited are accurate and thoroughly verified before generating the PDF documents.',
                style: TextStyle(color: Color.fromARGB(255, 124, 124, 124), fontSize: Primary_font_size.Text7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
