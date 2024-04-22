import 'package:flutter/material.dart';
import 'package:hospital_pharmacy_web/core/widgets/custom_button.dart';
import 'package:hospital_pharmacy_web/core/widgets/custom_divider.dart';

class AddDrugPage extends StatefulWidget {
  const AddDrugPage({super.key});

  @override
  State<AddDrugPage> createState() => _AddDrugPageState();
}

class _AddDrugPageState extends State<AddDrugPage> {
  // Variables to hold form values
  String genericName = '';
  String drugName = '';
  String batchNumber = '';
  String hsnCode = '';
  String expiryDate = '';
  String unitNumber = '';
  String typeValue = '';
  String drugDealer = '';
  String manufacturer = '';
  double purchaseCost = 0.0;
  double gst = 0.0;
  double discount = 0.0;
  double mrp = 0.0;

  // Dropdown values for type
  List<String> typeOptions = ['', 'Type1', 'Type2', 'Type3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Drug'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return _buildLargeScreenLayout();
            } else {
              return _buildSmallScreenLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildFormSection(
            title: 'Drug Information',
            children: [
              _buildTextField('Generic Name', genericName),
              _buildTextField('Drug Name', drugName),
              _buildTextField('Batch Number', batchNumber),
              _buildTextField('HSN Code', hsnCode),
              _buildExpiryDateField(
                'Expiry Date',
              ),
              _buildTextField('Unit or Number', unitNumber),
              _buildDropDownField('Type', typeValue, typeOptions),
            ],
          ),
        ),
        const VerticalDivider(thickness: 1),
        Expanded(
          child: _buildFormSection(
            title: 'Additional Details',
            children: [
              //_buildDropDownField('Type', typeValue, typeOptions),
              _buildTextField('Drug Dealer', drugDealer),
              _buildTextField('Manufacturer', manufacturer),
              _buildTextField('Purchase Cost (₹)',
                  purchaseCost.toString()), // Assuming INR currency
              _buildTextField('GST (%)', gst.toString()),
              _buildTextField('Discount (%)', discount.toString()),
              _buildTextField(
                  'MRP (₹)', mrp.toString()),
              const SizedBox(height: 10,) ,// Assuming INR currency,
              CustomButton(
                label: "Save Drug",
                icon: Icons.save,
                onPressed: () {},
                width: double.maxFinite,
                backgroundColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    return Column(
      children: [
        _buildFormSection(
          title: 'Drug Information',
          children: [
            _buildTextField('Generic Name', genericName),
            _buildTextField('Drug Name', drugName),
            _buildTextField('Batch Number', batchNumber),
            _buildTextField('HSN Code', hsnCode),
            _buildExpiryDateField('Expiry Date'),
            _buildTextField('Unit or Number', unitNumber),
             _buildDropDownField('Type', typeValue, typeOptions),
          ],
        ),
        _buildFormSection(
          title: 'Additional Details',
          children: [
           //_buildDropDownField('Type', typeValue, typeOptions),
            _buildTextField('Drug Dealer', drugDealer),
            _buildTextField('Manufacturer', manufacturer),
            _buildTextField('Purchase Cost (₹)',
                purchaseCost.toString()), // Assuming INR currency
            _buildTextField('GST (%)', gst.toString()),
            _buildTextField('Discount (%)', discount.toString()),
            _buildTextField('MRP (₹)', mrp.toString()),
            const SizedBox(height: 10,) ,
            CustomButton(
              label: "Save Drug",
              icon: Icons.save,
              onPressed: () {},
              width: double.maxFinite,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormSection(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const CustomDivider(
            width: double.infinity,
            height: 1.5,
            color: Colors.black12,
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildExpiryDateField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.datetime, // Set keyboard type for hint
        decoration: InputDecoration(
          labelText: labelText,
          hintText: 'MM/YYYY', // Display hint for format
        ),
        onChanged: (newValue) {
          setState(() {
            expiryDate = _formatAndValidateExpiryDate(newValue);
            // Move cursor to year section after adding slash
            if (expiryDate.length == 3 && expiryDate.endsWith('/')) {
              final textController = TextEditingController.fromValue(
                TextEditingValue(
                    text: expiryDate,
                    selection: const TextSelection.collapsed(offset: 2)),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) => textController
                  .selection = const TextSelection.collapsed(offset: 2));
            }
          });
        },
      ),
    );
  }

  String _formatAndValidateExpiryDate(String input) {
    if (input.isEmpty) return ''; // Handle empty input

    // Validate format (MM/YYYY)
    final regExp = RegExp(r'^([0-1][0-9]|2[0-3])[/]([0-9]{0,4})$');
    if (!regExp.hasMatch(input)) return expiryDate;

    return input; // Only validate format, don't modify input length
  }

  Widget _buildTextField(String labelText, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
        onChanged: (newValue) {
          setState(() {
            // Update corresponding variable based on labelText
            switch (labelText) {
              case 'Generic Name':
                genericName = newValue;
                break;
              case 'Drug Name':
                drugName = newValue;
                break;
              // ... Add cases for other labels
            }
          });
        },
      ),
    );
  }

  Widget _buildDropDownField(
      String labelText, String value, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            typeValue = newValue!;
          });
        },
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}
