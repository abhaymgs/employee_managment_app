import 'package:employee_managment_app/models/employee.dart';
import 'package:employee_managment_app/utils/date_time_util.dart';
import 'package:employee_managment_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeDataTableSource extends DataTableSource {
  late BuildContext _context;

  final List<Employee> _employees = [];
  List<Employee> _filteredEmployees = [];
  final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '\$');

  // Private static instance of the singleton
  static final EmployeeDataTableSource _instance =
      EmployeeDataTableSource._internal();

  // Private constructor
  EmployeeDataTableSource._internal();

  // Factory constructor
  factory EmployeeDataTableSource(BuildContext context) {
    _instance._context = context;
    return _instance;
  }

  // Initialize employee data
  void initializeEmployeeData(int count) {
    if (_employees.isEmpty) {
      // Ensure data is only initialized once
      for (int i = 0; i < count; i++) {
        _addEmployee(Employee(
          id: i + 1,
          name: 'Employee ${i + 1}',
          expiryDate: DateTime.now().add(Duration(days: i * 30)),
          salary: (i + 1) * 1000.0,
        ));
      }
    }
  }

  void createOrUpdate(Employee employee) {
    int index = _employees.indexWhere((e) => e.id == employee.id);
    if (index != -1) {
      _employees[index] = employee;
    } else {
      _addEmployee(employee);
      return;
    }
    _filteredEmployees = List.from(_employees);
    notifyListeners();
  }

  void _addEmployee(Employee employee) {
    final id = rowCount + 1;
    _employees.add(employee.copyWith(id: id));
    _filteredEmployees = List.from(_employees);
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    if (query.isEmpty) {
      _filteredEmployees = List.from(_employees);
    } else {
      _filteredEmployees = _employees
          .where((employee) =>
              employee.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Employee e) getField, bool ascending) {
    _filteredEmployees.sort((a, b) {
      if (!ascending) {
        final Employee c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _filteredEmployees.length) return null;
    final Employee employee = _filteredEmployees[index];
    return DataRow.byIndex(
      onSelectChanged: (value) {
        DialogUtils.showEmployeeDialog(_context, employee: employee);
      },
      index: index,
      cells: [
        DataCell(Text(employee.id.toString())),
        DataCell(Text(employee.name)),
        DataCell(Text(DateTimeUtil.ddMMYYYY(employee.expiryDate))),
        DataCell(Text(_currencyFormat.format(employee.salary))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _employees.length;

  @override
  int get selectedRowCount => 0;
}
