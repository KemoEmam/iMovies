import 'package:flutter/material.dart';

import '../../logic/trending_cubit.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: DropdownButton(
        autofocus: true,
        underline: Container(height: 0, color: Colors.transparent),
        dropdownColor: Colors.black.withOpacity(0.6),
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.amber,
          size: 30,
        ),
        value: TrendingDayCubit.get(context).val,
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text(
              'Daily',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text(
              'Weekly',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            TrendingDayCubit.get(context).changeTrendState(value!);
          });
        },
      ),
    );
  }
}
