import 'package:employee_managment_app/data_source/employee_data_source.dart';
import 'package:employee_managment_app/models/employee.dart';
import 'package:employee_managment_app/providers/employee_provider.dart';
import 'package:employee_managment_app/res/theme/theme_notifier.dart';
import 'package:employee_managment_app/utils/dialog_utils.dart';
import 'package:employee_managment_app/widgets/outlined_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = EmployeeDataTableSource(context);
    dataSource.initializeEmployeeData(20);
    return ChangeNotifierProvider(
        create: (_) => EmployeeProvider(dataSource),
        child: _buildScaffold(context, dataSource: dataSource));
  }

  Scaffold _buildScaffold(BuildContext ctx,
      {required EmployeeDataTableSource dataSource}) {
    var themeNotifier = Provider.of<ThemeNotifier>(ctx);
    return Scaffold(
      appBar: _buildHeader(themeNotifier),
      body: _buildBody(dataSource),
      floatingActionButton: _buildFloatingButton(ctx),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  AppBar _buildHeader(ThemeNotifier themeNotifier) {
    return AppBar(
      title: const Text('Employee Data Table'),
      actions: [
        Row(
          children: [
            Icon(
              themeNotifier.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            Transform.scale(
              scale: 0.7, // Adjust the scale factor to make the switch smaller
              child: Switch(
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  FloatingActionButton _buildFloatingButton(BuildContext ctx) {
    return FloatingActionButton(
      onPressed: () {
        DialogUtils.showEmployeeDialog(ctx);
      },
      child: const Icon(Icons.add),
    );
  }

  SingleChildScrollView _buildBody(EmployeeDataTableSource dataSource) {
    return SingleChildScrollView(
      child: Consumer<EmployeeProvider>(
        builder: (_, EmployeeProvider provider, __) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: OutlinedInputField(
                  onChanged: (query) {
                    provider.data.updateSearchQuery(query);
                  },
                  hintText: "Search name",
                ),
              ),
              PaginatedDataTable(
                columns: [
                  DataColumn(
                    label: const Text('ID'),
                    onSort: (columnIndex, ascending) => provider.sort<num>(
                        (Employee e) => e.id!, columnIndex, ascending),
                  ),
                  DataColumn(
                    label: const Text('Name'),
                    onSort: (columnIndex, ascending) => provider.sort<String>(
                        (Employee e) => e.name, columnIndex, ascending),
                  ),
                  DataColumn(
                    label: const Text('Expiry Date'),
                    onSort: (columnIndex, ascending) => provider.sort<DateTime>(
                        (Employee e) => e.expiryDate, columnIndex, ascending),
                  ),
                  DataColumn(
                    label: const Text('Salary'),
                    onSort: (columnIndex, ascending) => provider.sort<num>(
                        (Employee e) => e.salary, columnIndex, ascending),
                  ),
                ],
                source: dataSource,
                rowsPerPage: 10,
                columnSpacing: 30,
                horizontalMargin: 20,
                showCheckboxColumn: false,
                sortColumnIndex: provider.sortColumnIndex,
                sortAscending: provider.sortAscending,
              ),
            ],
          );
        },
      ),
    );
  }
}
