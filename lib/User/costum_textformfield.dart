import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class CostumTextformfield extends StatefulWidget {
  final String title;
  // final bool isDropdown;
  // final List<String>?isDropdownItems;
   
  const CostumTextformfield({super.key, required this.title, });

  @override
  State<CostumTextformfield> createState() => _CostumTextformfieldState();
}

class _CostumTextformfieldState extends State<CostumTextformfield> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: CostumColor().costum_color_2,
            borderRadius: BorderRadius.circular(10)),
        child: 

        
       TextFormField(
          decoration: InputDecoration(
            isDense: true,
              hintStyle: CostumFontStyle(
                      color: CostumColor().costum_color_3,
                      fontSize: 15,
                      fontWeight: FontWeight.normal)
                  .getFontstyle_2(),
              hintText: widget.title,
              fillColor: CostumColor().costum_color_2,
              // border: OutlineInputBorder(
              //     // gapPadding: 10,
      
              //     borderRadius: BorderRadius.circular(10)),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        ),
      ),
    );
  }
}
