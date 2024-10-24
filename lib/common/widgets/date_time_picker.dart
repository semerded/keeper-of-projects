import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper_of_projects/common/widgets/text.dart';
import 'package:keeper_of_projects/data.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedDateTime; // Nullable DateTime to handle "No Due Date"

  // Function to open DatePicker and select a date
  Future<void> _pickDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // If the user picked a date, now pick the time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          // Combine date and time into a single DateTime object
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // Clear the selected date and time (set "No Due Date")
  void _clearDateTime() {
    setState(() {
      _selectedDateTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Date and time format using intl package
    final DateFormat formatter = DateFormat('dd-MM-yy HH:mm');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display selected date and time or "No Due Date"
        AdaptiveText(
          _selectedDateTime != null ? '${formatter.format(_selectedDateTime!)}' : 'No Due Date',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to open DatePicker and TimePicker
            IconButton(
              onPressed: () => _pickDateAndTime(context),
              icon: Icon(Icons.date_range_outlined),
              style: IconButton.styleFrom(backgroundColor: Palette.secondary),
            ),
            SizedBox(width: 20),
            // Button to clear selected date and time (set "No Due Date")
            IconButton(
              onPressed: _clearDateTime,
              icon: Icon(Icons.clear),
              style: IconButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
