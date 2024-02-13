import 'package:flutter/material.dart';
import 'package:nasiya_app/presentation/pages/clients/clients_page.dart';
import 'package:nasiya_app/presentation/pages/payments/payments_page.dart';

import '../employees/employees_page.dart';
import '../sales/sales_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentPage = 0;

  final pages = [
    const SalesPage(),
    const ClientsPage(),
    const EmployeesPage(),
    const PaymentsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) => setState(() {
          currentPage = index;
        }),
        elevation: 12,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('assets/icons/sales.png')
            ),
            label: 'Sotuvlar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('assets/icons/clients.png')
            ),
            label: 'Mijozlar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('assets/icons/employees.png')
            ),
            label: 'Hodimlar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('assets/icons/payments.png')
            ),
            label: 'To\'lovlar',
          )
        ],
      ),
      body: pages[currentPage],
    );
  }
}