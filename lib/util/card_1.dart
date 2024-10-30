import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  final String name;
  final String image_path;
   Card1({super.key, required this.name,required this.image_path});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: ResponsiveHelper(context).getResponsiveHeight(22),
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 114, 114, 114)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 10,
            ),
          
            Text(
              name,
              style: CostumFontStyle(
                      color: CostumColor().costum_color_6,
                      fontSize: ResponsiveHelper(context).getResponsiveFontSize(3.8),
                      fontWeight: FontWeight.w500)
                  .getFontstyle(),
            ),
            
            
            const SizedBox(
              width: 20,
            ),
            Divider(color: CostumColor().costum_color_3,thickness: 1,),
            const SizedBox(width: 10,),
            SizedBox(
              width: ResponsiveHelper(context).getResponsiveWidth(40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(fit: BoxFit.cover, image_path)),
            )
          ],
        ),
      ),
    );
  }

}
