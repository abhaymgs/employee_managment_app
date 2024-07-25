import 'package:flutter/cupertino.dart';

class CupertinoUtils {
  static void showDatePicker(context,
      {required DateTime selectedDate,
      required Function(DateTime) onDateTimeChanged,
      Function()? onDone}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: CupertinoColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 230,
                child: CupertinoDatePicker(
                  backgroundColor: CupertinoColors.white,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  onDateTimeChanged: onDateTimeChanged,
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  if (onDone != null) onDone();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
