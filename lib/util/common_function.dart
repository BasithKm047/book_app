  import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

int createUniqueId() => DateTime.now().microsecondsSinceEpoch % 0xFFFFFFFF;
  AlertDialog alertDialogForDelete<T>({
    required BuildContext context,
    required T
        itemDetails, // The item to be deleted (e.g., Book, Genre, Author, Language)
    required String
        itemType, // The type of item to be deleted (e.g., "book", "genre")
    required void Function(T)
        deleteFunction, // The callback function to delete the item
  }) {
    return AlertDialog(
      backgroundColor: CostumColor().costum_color_3,
      title: Text(
        'Do you want to delete this $itemType?',
        style: CostumFontStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ).getFontstyle(),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            backgroundColor: CostumColor().costum_color_1,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without any action
          },
          child: Text(
            'No',
            style: CostumFontStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ).getFontstyle(),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            backgroundColor: CostumColor().costum_color_1,
          ),
          onPressed: () {
            deleteFunction(
                itemDetails); // Call the delete function with the item
            Navigator.of(context).pop(); // Close the dialog after deletion
          },
          child: Text(
            'Yes',
            style: CostumFontStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ).getFontstyle(),
          ),
        ),
      ],
    );
  }


   AlertDialog alertDialogForLogout<T>({
    required BuildContext context,
    required T
        itemDetails, // The item to be deleted (e.g., Book, Genre, Author, Language)
    // required String
    //     itemType, // The type of item to be deleted (e.g., "book", "genre")
    required void Function(T)
        deleteFunction, // The callback function to delete the item
  }) {
    return AlertDialog(
      backgroundColor: CostumColor().costum_color_3,
      title: Text(
        'Do you want Logout ',
        style: CostumFontStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ).getFontstyle(),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            backgroundColor: CostumColor().costum_color_1,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without any action
          },
          child: Text(
            'No',
            style: CostumFontStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ).getFontstyle(),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            backgroundColor: CostumColor().costum_color_1,
          ),
          onPressed: () {
            deleteFunction(
                itemDetails); // Call the delete function with the item
            Navigator.of(context).pop(); // Close the dialog after deletion
          },
          child: Text(
            'Yes',
            style: CostumFontStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ).getFontstyle(),
          ),
        ),
      ],
    );
  }

  String newReleases='New Releases';
  String recent='Recently Read';
  String favourite='Favourite';
  String Finished='Finished';
  String WantToRead='Want to Read';

 Future<dynamic> Dailogueforlottie(BuildContext context,String dailogue) {
    return showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Column(
        children: [
          Lottie.asset(
            animate: true,
            repeat: false,
            'Asset/animation.json'),
             Text(dailogue,
            style:  TextStyle(color: Colors.black,fontSize: 15),)
        ],
      ),
    
    );

  },);
  }


