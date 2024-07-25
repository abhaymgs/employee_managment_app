import 'package:employee_managment_app/models/employee.dart';
import 'package:employee_managment_app/utils/date_time_util.dart';
import 'package:flutter/material.dart';

class EmployeeDialogProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController selectedDateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setEmployee(Employee employee) {
    nameController.text = employee.name;
    salaryController.text = employee.salary.toString();
    _selectedDate = employee.expiryDate;
    selectedDateController.text = DateTimeUtil.ddMMYYYY(employee.expiryDate);
    notifyListeners();
  }

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    selectedDateController.text = DateTimeUtil.ddMMYYYY(newDate);
    notifyListeners();
  }

  void disposeControllers() {
    nameController.dispose();
    salaryController.dispose();
    selectedDateController.dispose();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Employee createOrUpdateEmployee(Employee? existingEmployee) {
    final employee = existingEmployee?.copyWith(
          name: nameController.text,
          expiryDate: _selectedDate,
          salary: double.parse(salaryController.text),
        ) ??
        Employee(
          name: nameController.text,
          expiryDate: _selectedDate,
          salary: double.parse(salaryController.text),
        );
    return employee;
  }
}
