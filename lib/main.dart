import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_pharmacy_web/data/models/medicine.dart';
import 'package:hospital_pharmacy_web/presentation/add_drug.dart';
import 'package:hospital_pharmacy_web/presentation/dashboard.dart';
import 'package:hospital_pharmacy_web/presentation/patients_list.dart';
import 'package:hospital_pharmacy_web/presentation/stockupdate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PharmacyHomePage(),
    );
  }
}

class PharmacyHomePage extends StatefulWidget {
  const PharmacyHomePage({super.key});

  @override
  State<PharmacyHomePage> createState() => _PharmacyHomePageState();
}

class _PharmacyHomePageState extends State<PharmacyHomePage> {
  int _selectedPage = 0; // Index of the currently selected sidebar item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pharmacy'),
        // Optional leading icon for opening sidebar on mobile
        leading: LayoutBuilder(
          // Use LayoutBuilder for screen size check
          builder: (context, constraints) {
            return constraints.maxWidth < 600 // Adjust breakpoint as needed
                ? IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () =>
                        _openSidebar(), // Separate function for opening
                  )
                : const SizedBox();
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            // Desktop/Tablet layout
            return Row(
              children: [
                _buildSidebar(),
                Expanded(child: _buildBody()),
              ],
            );
          } else {
            return Stack(
              // Stack for mobile layout with overlaying sidebar
              children: [
                _buildBody(),
                _isSidebarOpen
                    ? _buildSidebar(
                        isOverlay: true) // Overlay sidebar on mobile
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }

  bool _isSidebarOpen = false; // Track sidebar visibility for mobile

  void _openSidebar() {
    setState(() => _isSidebarOpen = !_isSidebarOpen);
  } // Separate function for opening/closing sidebar

  Widget _buildSidebar({bool isOverlay = false}) {
    return NavigationDrawer(
      children: [
         ListTile(
          title: const Text('Patients List'),
          leading: const Icon(Icons.person_2_rounded),
          selected: _selectedPage == 0,
          onTap: () => setState(() {
            _selectedPage = 0;
            _isSidebarOpen = false; // Close sidebar on selection (mobile)
          }),
        ),
        ListTile(
          title: const Text('Dashboard'),
          leading: const Icon(Icons.dashboard),
          selected: _selectedPage == 1,
          onTap: () => setState(() {
            _selectedPage = 1;
            _isSidebarOpen = false; // Close sidebar on selection (mobile)
          }),
        ),
        ListTile(
          title: const Text('Add Drug'),
          leading: const Icon(Icons.add),
          selected: _selectedPage == 2,
          onTap: () => setState(() {
            _selectedPage = 2;
            _isSidebarOpen = false; // Close sidebar on selection (mobile)
          }),
        ),
        ListTile(
          title: const Text('Stock Update'),
          leading: const Icon(Icons.inventory),
          selected: _selectedPage == 3,
          onTap: () => setState(() {
            _selectedPage = 3;
            _isSidebarOpen = false; // Close sidebar on selection (mobile)
          }),
        ),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
            
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    // Body content will be replaced based on _selectedPage
    switch (_selectedPage) {
       case 0:
        return const PatientListPage();
      case 1:
        return const PharmacyDashboard();
      case 2:
        return const AddDrugPage();
      case 3:
        return PharmacyStockUpdate(
          medicines: medicines,
          onStockUpdate: (p0, p1) {
            print("${p0.toJson()} , $p1");
          },
        ); // Replace with actual stock update content (Widget 3)
      default:
        return const Text('Error: Invalid Page');
    }
  }
}
