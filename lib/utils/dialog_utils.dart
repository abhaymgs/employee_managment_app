import 'package:employee_managment_app/data_source/employee_data_source.dart';
import 'package:employee_managment_app/dialogs/employee_dialog.dart';
import 'package:employee_managment_app/models/employee.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static showEmployeeDialog(context, {Employee? employee}) {
    final data = EmployeeDataTableSource(context);
    showDialog(
      context: context,
      builder: (_) {
        return EmployeeDialog(
          employee: employee,
          onSave: (employee) {
            data.createOrUpdate(employee);
          },
        );
      },
    );
  }
}
