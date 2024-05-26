import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/presentation/screens/locations_screen.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_consts.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import 'package:rick_and_morty_app/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.arrow_back),
        title: Text(
          "Настройки",
          style: AppFonts.w500s20.copyWith(color: themeProvider.textColor),
        ),
        backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditWidget(themeProvider: themeProvider),
            const SizedBox(height: 20),
            EditButton(themeProvider: themeProvider),
            const SizedBox(height: 17),
            const Linetwo(),
            const SizedBox(height: 17),
            Text(
              "Внешний вид",
              style: AppFonts.w500s10.copyWith(color: themeProvider.textColor),
            ),
            const SizedBox(height: 15),
            ThemeChangeWidget(
              themeProvider: themeProvider,
              title: "Темная тема",

              tetx:
  themeProvider.isDarkTheme ? "Выключен" : "Включен",
          
               icon: IconButton(
          onPressed: () {
            context.read<ThemeProvider>().changeTheme();
          },
          icon: Icon(
            themeProvider.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
            color: themeProvider.characterName,
          ),
        ),
            ),
            const SizedBox(height: 30),
            const Linetwo(),
            const SizedBox(height: 17),
            Text(
              "О приложении",
              style: AppFonts.w500s10.copyWith(color: themeProvider.textColor),
            ),
            const SizedBox(height: 14),
            Text(
              "Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концентрированной темной материи.",
              style:
                  AppFonts.w400s14.copyWith(color: themeProvider.textColor),
            ),
            const SizedBox(height: 30),
            const Linetwo(),
            const SizedBox(height: 17),
            Text(
              "Версия приложения",
            style:  AppFonts.w400s14.copyWith(color: themeProvider.textColor),
            ),
            Text(
              "Rick & Morty v1.0.0",
              style:
                AppFonts.w400s14.copyWith(color: themeProvider.textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class Linetwo extends StatelessWidget {
  const Linetwo({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.lihgtMode.withOpacity(0.70),
      ),
      height: 2.0,
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({Key? key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.buttonColor),
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
        ),
        child: Text(
          "Редактировать",
          style: AppFonts.w400s16.copyWith(color: AppColors.buttonColor),
        ),
      ),
    );
  }
}

class EditWidget extends StatelessWidget {
  const EditWidget({Key? key, required this.themeProvider, this.image});
  final File? image;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: image != null ? FileImage(image!) : null,
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${SharedPrefsWidget.prefs.getString(AppConsts.name) ?? ""} ${SharedPrefsWidget.prefs.getString(AppConsts.lastName) ?? ""}",
              style:
                  AppFonts.w400s16.copyWith(color: themeProvider.characterName),
            ),
            const SizedBox(height: 5),
            Text(
              SharedPrefsWidget.prefs.getString(AppConsts.login) ?? "",
              style: AppFonts.w400s14.copyWith(color: themeProvider.textColor),
            )
          ],
        ),
      ],
    );
  }
}class ThemeChangeWidget extends StatelessWidget {
  const ThemeChangeWidget({
    Key? key,
    required this.themeProvider,
    required this.title,
    required this.tetx,
    required this.icon,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final String title;
  final String tetx;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    Color textColor = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Row(
      children: [
        Icon(
          CupertinoIcons.paintbrush,
          color: themeProvider.characterName,
          size: 26,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppFonts.w400s16.copyWith(color: themeProvider.characterName),
            ),
            const SizedBox(height: 5),
            Text(
              tetx,
              style: AppFonts.w400s14.copyWith(color: textColor),
            ),
          ],
        ),
        const Spacer(),
        icon,
      ],
    );
  }
}


class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, this.image}) : super(key: key);

  final File? image;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  File? _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeProvider.characterName,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Редактировать профиль",
          style:  AppFonts.w500s20.copyWith(color: themeProvider.textColor),
         
        ),
        backgroundColor: themeProvider.themeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: _image != null ? FileImage(_image!) : null,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                await _getImageFromGallery();
              },
              child: Text(
                "Изменить фото",
                style: AppFonts.w400s16.copyWith(color: AppColors.blue),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Профиль",
              
              style:  AppFonts.w500s20.copyWith(color: themeProvider.textColor),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            _buildEditableField(
              themeProvider: themeProvider,
              title: "Изменить имя",
              initialValue: SharedPrefsWidget.prefs.getString(AppConsts.name) ?? "",
              onSave: (newValue) {
                // Обновить имя в SharedPreferences
                SharedPrefsWidget.prefs.setString(AppConsts.name, newValue);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Имя обновлено',
                  style:  AppFonts.w500s20.copyWith(color: themeProvider.textColor),),
                ));
              },
            ),
            const SizedBox(height: 26),
            _buildEditableField(
              themeProvider: themeProvider,
              title: "Изменить логин",
              
              initialValue: SharedPrefsWidget.prefs.getString(AppConsts.login) ?? "",
              onSave: (newValue) {
                // Обновить логин в SharedPreferences
                SharedPrefsWidget.prefs.setString(AppConsts.login, newValue);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Логин обновлен'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required ThemeProvider themeProvider,
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    TextEditingController controller = TextEditingController(text: initialValue);

    return Row(
      children: [
        Icon(
          CupertinoIcons.paintbrush,
          color: themeProvider.characterName,
          size: 26,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: controller,
            style: AppFonts.w400s16.copyWith(color: themeProvider.characterName),
            decoration: InputDecoration(
              labelText: title,
              labelStyle: AppFonts.w500s16.copyWith(color: themeProvider.characterName),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.characterName),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.characterName),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.characterName),
              ),
            ),
            onFieldSubmitted: (newValue) {
              onSave(newValue);
            },
          ),
        ),
      ],
    );
  }
}