import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final TextEditingController controller;

  const DatePickerWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = "${picked.toLocal()}".split(' ')[0]; // Format date as yyyy-mm-dd
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.date_range),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: S.of(context).invoiceDate,
          ),
        ),
      ),
    );
  }
}
