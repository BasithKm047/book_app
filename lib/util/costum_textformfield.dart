import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class CostumTextformfield extends StatefulWidget {
  final String title;
  final TextEditingController controller;

  // final bool isDropdown;
  // final List<String>?isDropdownItems;

  const CostumTextformfield({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  State<CostumTextformfield> createState() => _CostumTextformfieldState();
}

class _CostumTextformfieldState extends State<CostumTextformfield> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
            color: CostumColor().costum_color_3,
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          keyboardType: widget.title=='Book name'? TextInputType.text:TextInputType.number,
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.normal)
                .getFontstyle_2(),
            controller: widget.controller,
            decoration: InputDecoration(
                isDense: true,
                hintStyle: CostumFontStyle(
                        color: CostumColor().costum_color_1,
                        fontSize: 15,
                        fontWeight: FontWeight.normal)
                    .getFontstyle_2(),
                hintText: widget.title,
                fillColor: CostumColor().costum_color_1,
                // border: OutlineInputBorder(
                //     // gapPadding: 10,

                //     borderRadius: BorderRadius.circular(10)),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter ${widget.title} ';
              } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
                // Allowing spaces in description
                return 'Only letters, numbers, and spaces are allowed';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
      ),
    );
  }
}
