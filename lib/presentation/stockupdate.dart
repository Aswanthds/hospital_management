import 'package:flutter/material.dart';

import 'package:hospital_pharmacy_web/data/models/spreadsheet.dart'; // Assuming this path is correct

class PharmacyStockUpdate extends StatefulWidget {
  final List<Medicine> medicines; // List of medicine objects
  final Function(Medicine, int) onStockUpdate; // Callback for stock update

  const PharmacyStockUpdate({
    super.key,
    required this.medicines,
    required this.onStockUpdate,
  });

  @override
  State<PharmacyStockUpdate> createState() => _PharmacyStockUpdateState();
}

class _PharmacyStockUpdateState extends State<PharmacyStockUpdate> {
  String? _selectedMedicine; // Use nullable String for empty selection
  int _newStock = 0;

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButtonFormField<String>(
            value: _selectedMedicine,
            hint: const Text('Select Medicine'),
            items: widget.medicines
                .map((medicine) => DropdownMenuItem<String>(
                      value: medicine.drugName,
                      child: Text(medicine.drugName),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedMedicine = value),
          ),
        ),
        if (_selectedMedicine != null &&
            _selectedMedicine!
                .isNotEmpty) // Check for both null and empty string
          ...[
          // Show form only if medicine is selected
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'New Stock',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) =>
                  setState(() => _newStock = int.tryParse(value) ?? 0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedMedicine != null &&
                  _selectedMedicine!.isNotEmpty &&
                  _newStock > 0) {
                final selectedMedicine = widget.medicines.firstWhere(
                    (medicine) => medicine.drugName == _selectedMedicine);
                widget.onStockUpdate(selectedMedicine, _newStock);
                setState(() {
                  _selectedMedicine = '';
                  _newStock = 0;
                });
              }
            },
            child: const Text('Update Stock'),
          ),
        ],
      ],
    );
  }
}
