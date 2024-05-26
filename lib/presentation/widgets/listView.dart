
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    super.key,
   
    required this.characters,
    required this.onTap,
  });
  
final MyCharacter characters;
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 37,
              backgroundImage: NetworkImage(characters.image ??''),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characters.status??'',
                  style:TextStyle(
                    color: characters.status == "Живой" ? AppColors.green :characters.status == "Мертвый" ? AppColors.red:AppColors.greyLtext,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    fontFamily: "Roboto",
                    height: 1.60,
                    letterSpacing: 1.50,
                  ),
                ),
                Text(
                 characters.name ??'',
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
            )
          ],
        ),
      ),
    );
  }
}
