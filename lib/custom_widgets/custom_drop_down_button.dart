import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/priority_provider.dart';

class CustomDropDownButton extends StatefulWidget {
  ValueChanged<String?> onChanged;
  //final String val;
   CustomDropDownButton({super.key,required this.onChanged});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Consumer<PriorityProvider>(
        builder: (context, value, child) => DropdownButton<String>(
          value: value.dropdownValue,
          elevation: 3,
          // onChanged: (String? newValue) {
          //   value.setDropDownValue(newValue!);
          // },
          onChanged: widget.onChanged,
          items: value.items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}
