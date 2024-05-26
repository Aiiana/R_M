import 'package:flutter/material.dart';

import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 319,
      height: 188,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Ошибка",
          style: AppFonts.w500s20,
        ),
        content:  Text(
          text,
          style: AppFonts.w400s14,
        ),
        actions: [
          Center(
            child: SizedBox(
                width: 259,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.blue,width: 1))
                  ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ок",
                      style: AppFonts.w400s16.copyWith(
                          color: AppColors.blue,),
                    )),
                    
              ),
          ),
            SizedBox(height: 25,)
        ],
      ),
    );
  }
}
class StatusText extends StatelessWidget {
  const StatusText({
    Key? key,
    required this.characterIndex,
    required this.status,
    required this.onThemeChange, // Add callback for theme change
  }) : super(key: key);

  final int characterIndex;
  final String status;
  final VoidCallback onThemeChange; // Callback for theme change

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.black;
    if (status == 'Alive') {
      statusColor = AppColors.green;
    } else if (status == 'Dead') {
      statusColor = AppColors.red;
    } else if (status == 'unknown') {
      statusColor = Colors.grey;
    }
    return GestureDetector( // Use GestureDetector for tap handling
      onTap: onThemeChange, // Invoke the callback when tapped
      child: Text(
        status,
        style: AppFonts.w500s20.copyWith(color: statusColor),
      ),
    );
  }
}