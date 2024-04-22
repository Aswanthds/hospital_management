import 'package:flutter/material.dart';
import 'package:hospital_pharmacy_web/presentation/medicine_assign.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  final List<Patient> _patients = [
    // Replace with your patient data source
    Patient(name: 'John Doe', id: '12345'),
    Patient(name: 'Jane Smith', id: '54321'),
    // ... add more patients
  ];
  String _searchText = ''; // Track search text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Patient'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality (filter patients)
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients
              .where((p) =>
                  p.name.toLowerCase().contains(_searchText.toLowerCase()) ||
                  p.id.contains(_searchText))
              .toList()[index]; // Filter based on search
          return ListTile(
            title: Text(patient.name),
            subtitle: Text(patient.id),
            onTap: () => _onPatientSelected(
                patient), // Navigate to medicine assignment page
          );
        },
      ),
    );
  }

  void _onPatientSelected(Patient patient) {
    // Navigate to medicine assignment page with selected patient
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignMedicinePage(patient: patient),
      ),
    );
  }
}

class Patient {
  final String name;
  final String id;

  const Patient({required this.name, required this.id});
}
