
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.characters,
  });
  final MyCharacter characters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(characters.image ?? ''),
        ),
        const SizedBox(height: 18),
        Text(
          characters.status ?? '',
          style:  TextStyle(
            color:characters.status=="Alive"? AppColors.green:AppColors.red,
            fontWeight: FontWeight.w500,
            fontSize: 10,
            fontFamily: "Roboto",
            height: 1.60,
            letterSpacing: 1.50,
          ),
        ),
        Text(
          characters.name ?? '',
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: "Roboto",
            height: 1.50,
            letterSpacing: 0.50,
          ),
        ),
        Text(
          "${characters.species} - ${characters.gender}",
          style: const TextStyle(
            color: AppColors.greyLtext,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: "Roboto",
            height: 1.33,
            letterSpacing: 0.50,
          ),
        ),
      ],
    );
  }
}
