import 'package:flutter/material.dart';
import 'package:hospital_pharmacy_web/data/models/medicine.dart';
import 'package:hospital_pharmacy_web/data/models/spreadsheet.dart';
import 'package:hospital_pharmacy_web/presentation/medicine_details.dart';

class PharmacyDashboard extends StatefulWidget {
  const PharmacyDashboard({super.key});

  @override
  State<PharmacyDashboard> createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  String _searchText = '';
  String _sortBy = 'expiry_date'; // Default sort

  @override
  Widget build(BuildContext context) {
    final filteredMedicines = medicines
        .where((medicine) =>
            medicine.drugName
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            medicine.batchNumber
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            medicine.genericName
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
        .toList();

    List<Medicine> sortedMedicines = filteredMedicines;
    if (_sortBy == 'expiry_date') {
      sortedMedicines.sort((a, b) => a.drugName.compareTo(b
          .drugName)); // Dummy sort by drug name (replace with actual expiry date logic)
    } else if (_sortBy == 'stock_balance') {
      sortedMedicines.sort((a, b) => b.unitNumber
          .compareTo(a.unitNumber)); // Sort by stock balance (descending)
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search (Drug Name, Batch Number, Generic Name)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _searchText = value),
                ),
              ),
              const SizedBox(width: 10.0),
              DropdownButton<String>(
                value: _sortBy,
                items: const [
                  DropdownMenuItem(
                    value: 'expiry_date',
                    child: Text('Expiry Date'),
                  ),
                  DropdownMenuItem(
                    value: 'stock_balance',
                    child: Text('Stock Balance'),
                  ),
                ],
                onChanged: (value) => setState(() => _sortBy = value!),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sortedMedicines.length,
            itemBuilder: (context, index) {
              final medicine = sortedMedicines[index];
              return ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => MedicineDetails(medicine: medicine),
                  );
                },
                title: Text(medicine.drugName),
                subtitle: Text(
                    'Batch: ${medicine.batchNumber}, Generic: ${medicine.genericName}'),
                trailing: Text('${medicine.unitNumber} Units'),
              );
            },
          ),
        ),
      ],
    );
  }
}
