import 'package:flutter/material.dart';

import '../../data/model/employee_model.dart';

class EmployeeItem extends StatelessWidget {
  EmployeeModel? employeeModel;

  EmployeeItem({
    super.key,
    required this.employeeModel
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
              onTap: () {

              },
              leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset('assets/icons/employee.png'),
                  )
              ),
              title: Text('${employeeModel?.name}'),
              subtitle: Text('${employeeModel?.emailOrPhoneNumber}')
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16
              ),
              child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black26
              )
          )
        ]
    );
  }
}