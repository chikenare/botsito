import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, {required String title, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: 4),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(75),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.greenAccent,
              size: 28,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     // Acción tipo "Deshacer"
            //   },
            //   style: TextButton.styleFrom(
            //     foregroundColor: Colors.greenAccent,
            //     padding: EdgeInsets.zero,
            //     minimumSize: Size(50, 30),
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   ),
            //   child: Text(
            //     'DESHACER',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}
