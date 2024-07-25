import 'package:employee_managment_app/models/employee.dart';
import 'package:employee_managment_app/providers/employee_dialog_provider.dart';
import 'package:employee_managment_app/utils/cupertino_utils.dart';
import 'package:employee_managment_app/widgets/outlined_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDialog extends StatelessWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  EmployeeDialog({required this.onSave, this.employee});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeDialogProvider(),
      child: EmployeeDialogContent(employee: employee, onSave: onSave),
    );
  }
}

class EmployeeDialogContent extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  EmployeeDialogContent({required this.onSave, this.employee});

  @override
  _EmployeeDialogContentState createState() => _EmployeeDialogContentState();
}

class _EmployeeDialogContentState extends State<EmployeeDialogContent> {
  late EmployeeDialogProvider employeeProvider;

  @override
  void initState() {
    super.initState();
    employeeProvider =
        Provider.of<EmployeeDialogProvider>(context, listen: false);
    if (widget.employee != null) {
      employeeProvider.setEmployee(widget.employee!);
    }
  }

  @override
  void dispose() {
    employeeProvider.disposeControllers();
    super.dispose();
  }

  void _submit() {
    if (!employeeProvider.validateForm()) return;

    final employee = employeeProvider.createOrUpdateEmployee(widget.employee);
    widget.onSave(employee);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<EmployeeDialogProvider>(
          builder: (context, provider, child) {
            return Form(
              key: provider.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Add Employee",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedInputField(
                    hintText: "Enter name",
                    validator: (name) {
                      if (name != null && name.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                    textEditingController: provider.nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedInputField(
                    keyboardType: TextInputType.number,
                    hintText: "Enter salary",
                    validator: (salary) {
                      if (salary != null && salary.isEmpty) {
                        return "Please enter salary";
                      }
                      return null;
                    },
                    textEditingController: provider.salaryController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedInputField(
                    textEditingController: provider.selectedDateController,
                    hintText: "DD/MM/YY",
                    readOnly: true,
                    validator: (date) {
                      if (date != null && date.isEmpty) {
                        return "Please enter date";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        CupertinoUtils.showDatePicker(context,
                            selectedDate: provider.selectedDate, onDone: () {
                          provider.updateSelectedDate(provider.selectedDate);
                        }, onDateTimeChanged: (newDateTime) {
                          provider.updateSelectedDate(newDateTime);
                        });
                      },
                      icon: const Icon(Icons.date_range),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: _submit,
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
