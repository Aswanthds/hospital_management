import 'package:flutter/material.dart';
import 'package:hospital_pharmacy_web/data/models/medicine.dart';
import 'package:hospital_pharmacy_web/data/models/spreadsheet.dart';
import 'package:hospital_pharmacy_web/presentation/patients_list.dart';

class AssignMedicinePage extends StatefulWidget {
  final Patient patient;

  const AssignMedicinePage({required this.patient, super.key});

  @override
  State<AssignMedicinePage> createState() => _AssignMedicinePageState();
}

class _AssignMedicinePageState extends State<AssignMedicinePage> {
  final List<Medicine> _prescribedMedicines =
      []; // List of medicines prescribed by doctor
  final List<Medicine> _availableMedicines = medicines;
  final TextEditingController _quantityController = TextEditingController();
  Medicine? _selectedMedicine; // Selected medicine for assignment
  String _errorMessage = ''; // Track error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Medicine - ${widget.patient.name}'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text('Prescribed Medicines'),
                const Divider(),
                ListView.builder(
                  shrinkWrap: true, // Prevent excessive scrolling
                  itemCount: _prescribedMedicines.length,
                  itemBuilder: (context, index) {
                    final medicine = _prescribedMedicines[index];
                    return ListTile(
                      title: Text(medicine.drugName),
                    );
                  },
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Text('Available Medicines'),
                const Divider(),
                DropdownButton<Medicine>(
                  // Dropdown for selecting medicine to assign
                  isExpanded: true, // Fill available space
                  hint: const Text('Select Medicine'),
                  value: _selectedMedicine,
                  items: _availableMedicines
                      .map((medicine) => DropdownMenuItem(
                            value: medicine,
                            child: Text(medicine.drugName),
                          ))
                      .toList(),
                  onChanged: (medicine) =>
                      setState(() => _selectedMedicine = medicine),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Quantity:'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType
                            .number, // Allow only numbers for quantity
                      ),
                    ),
                  ],
                ),
                Text(_errorMessage,
                    style: const TextStyle(
                        color: Colors.red)), // Display error message
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _assignMedicine(),
                  child: const Text('Assign Medicine'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _assignMedicine() {
    setState(() {
      _errorMessage = ''; // Clear previous error message
    });

    if (_selectedMedicine == null) {
      setState(() => _errorMessage = 'Please select a medicine to assign.');
      return;
    }

    final quantity =
        int.tryParse(_quantityController.text) ?? 0; // Handle invalid input

    if (quantity <= 0) {
      setState(() =>
          _errorMessage = 'Please enter a valid quantity (positive number).');
      return;
    }

    if (quantity > _selectedMedicine!.unitNumber) {
      setState(() => _errorMessage =
          'Insufficient stock. Available stock: ${_selectedMedicine!.unitNumber}');
      return;
    }

    // Update medicine stock (assuming you have a function to update stock in your Pharmacy app)
    updateMedicineStock(
        _selectedMedicine!, _selectedMedicine!.unitNumber - quantity);

    // Add assigned medicine to prescribed list (assuming appropriate logic)
    // ... add medicine to prescribed list

    // Clear selection and quantity after successful assignment
    setState(() {
      _selectedMedicine = null;
      _quantityController.text = '';
    });
  }
}

// Replace with your actual function to update medicine stock in your app
void updateMedicineStock(Medicine medicine, int newStock) {
  // Implement logic to update medicine stock in your database or state management solution
  print('Medicine "${medicine.drugName}" stock updated to $newStock');
}
