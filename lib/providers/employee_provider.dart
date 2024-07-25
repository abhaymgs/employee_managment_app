import 'package:employee_managment_app/data_source/employee_data_source.dart';
import 'package:employee_managment_app/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  final EmployeeDataTableSource _data;

  EmployeeProvider(this._data);

  EmployeeDataTableSource get data => _data;

  int _sortColumnIndex = 0;
  int get sortColumnIndex => _sortColumnIndex;

  bool _sortAscending = true;
  bool get sortAscending => _sortAscending;

  void sort<T>(Comparable<T> Function(Employee e) getField, int columnIndex,
      bool ascending) {
    _data.sort<T>(getField, ascending);
    _sortColumnIndex = columnIndex;
    _sortAscending = ascending;
    notifyListeners();
  }
}
