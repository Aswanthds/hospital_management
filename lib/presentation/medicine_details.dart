import 'package:flutter/material.dart';
import 'package:hospital_pharmacy_web/data/models/spreadsheet.dart';

class MedicineDetails extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetails({required this.medicine, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Medicine Details'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Drug Information
            Text(
              'Drug Name: ${medicine.drugName}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text('Generic Name: ${medicine.genericName}'),
            const SizedBox(height: 10),
            Text('Batch Number: ${medicine.batchNumber}'),
            const SizedBox(height: 10),
            const Divider(thickness: 1), // Separator

            // Stock Information
            Text('Stock Balance: ${medicine.unitNumber}'),
            const SizedBox(height: 10),

            const Divider(thickness: 1), // Separator

            Text('Expiry Date: ${medicine.expiryDate}'),
            const SizedBox(height: 10),
            Text('Unit Number: ${medicine.unitNumber}'),
            const SizedBox(height: 10),
            Text('Type: ${medicine.type}'),
            const SizedBox(height: 10),
            Text('Manufacturer: ${medicine.manufacturer}'),
            const SizedBox(height: 10),
            Text('Purchase Cost (₹): ₹ ${medicine.purchaseCost}'),
            const SizedBox(height: 10),
            Text('GST %: ${medicine.gst} %'),
            const SizedBox(height: 10),
            Text('Discount %: ${medicine.discount} %'),
            const SizedBox(height: 10),
            Text('MRP (₹): ${medicine.mrp} (₹)'),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
