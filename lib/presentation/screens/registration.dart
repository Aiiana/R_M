import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/presentation/screens/home_page.dart';
import 'package:rick_and_morty_app/presentation/widgets/widgets_filter.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_consts.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';

class Auth extends StatelessWidget {
  Auth({Key? key});

  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "assets/pngs/rick_and_morty.png",
            width: 267,
            height: 376,
          ),
          const SizedBox(height: 50),
          AuthTextField(
            controller: controllerLogin,
            text: 'Логин',
            hintText: 'Логин',
            prefixIcon: const Icon(
              Icons.person,
              color: AppColors.textFieldText,
            ),
          ),
          const SizedBox(height: 15),
          AuthTextField(
            obscureText: true,
            controller: controllerPassword,
            text: 'Пароль',
            hintText: 'Пароль',
            prefixIcon: controllerPassword.text.isEmpty
                ? const Icon(
                    Icons.lock_outline,
                    color: AppColors.textFieldText,
                  )
                : const Icon(Icons.lock_open_sharp),
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            text: "Войти",
            onPressed: () async {
              String savedLogin =
                  (await SharedPreferences.getInstance()).getString(AppConsts.login) ?? "";
              String savedPassword =
                  (await SharedPreferences.getInstance()).getString(AppConsts.passWord) ?? "";

              if (controllerLogin.text.isEmpty || controllerPassword.text.isEmpty) {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialogWidget(
                      text: "Введите логин и пароль",
                    );
                  },
                );
              } else if (controllerLogin.text == savedLogin && controllerPassword.text == savedPassword) {
                (await SharedPreferences.getInstance()).setBool('isLoggedIn', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialogWidget(
                      text: "Неправильный логин или пароль",
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(height: 30),
          const CreateAccauntTextButton(),
        ],
      ),
    );
  }
}

class CreateAccScreen extends StatelessWidget {
  const CreateAccScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerLastName = TextEditingController();
    final TextEditingController controllerMiddleName = TextEditingController();
    final TextEditingController controllerLogin = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Создать аккаунт",
              style: AppFonts.w700s34.copyWith(
                color: AppColors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AuthTextField(
            controller: controllerName, text: 'Имя', hintText: "Имя"),
          const SizedBox(
            height: 15,
          ),
          AuthTextField(
            controller: controllerLastName,
            text: 'Фамилия',
            hintText: "Фамилия"),
          const SizedBox(
            height: 15,
          ),
          AuthTextField(
            controller: controllerMiddleName,
            text: 'Отчество',
            hintText: "Отчество"),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: 319,
            height: 2,
            color: AppColors.lineColor,
          ),
          const SizedBox(
            height: 40,
          ),
          AuthTextField(
            controller: controllerLogin,
            text: 'Логин',
            hintText: 'Логин',
          ),
          const SizedBox(
            height: 15,
          ),
          AuthTextField(
            obscureText: true,
            controller: controllerPassword,
            text: 'Пароль',
            hintText: 'Пароль',
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppColors.textFieldText,
            )),
          const SizedBox(
            height: 50,
          ),
          CustomElevatedButton(
              text: "Создать",
              onPressed: () async {
                final SharedPreferences pref = await SharedPreferences.getInstance();
                if (controllerName.text.isEmpty ||
                    controllerLastName.text.isEmpty ||
                    controllerMiddleName.text.isEmpty ||
                    controllerLogin.text.isEmpty ||
                    controllerPassword.text.isEmpty) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialogWidget(
                        text: "Все поля должны быть запонены",
                      );
                    },
                  );

                  return;
                }

                await pref.setString(AppConsts.name, controllerName.text);
                await pref.setString(
                    AppConsts.lastName, controllerLastName.text);
                await pref.setString(
                    AppConsts.middleName, controllerMiddleName.text);
                await pref.setString(AppConsts.login, controllerLogin.text);
                await pref.setString(
                    AppConsts.passWord, controllerPassword.text);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 319,
      height: 48,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: onPressed,
          child: Text(
            text,
            style: AppFonts.w400s16.copyWith(color: AppColors.white),
          )),
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);
  final TextEditingController controller;
  final String text;
  final String hintText;
  final Icon? prefixIcon;
  final bool obscureText;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35
),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppFonts.w400s14.copyWith(color: AppColors.fontColor),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: obscureText,
              obscuringCharacter: "*",
              controller: controller,
              style: AppFonts.w400s14.copyWith(color: AppColors.textFieldText),
              decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  hintText: hintText,
                  hintStyle:
                      AppFonts.w400s14.copyWith(color: AppColors.textFieldText),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.textFieldColor),
                  ),
                  fillColor: AppColors.textFieldColor,
                  filled: true,
                  border: InputBorder.none)),
        ],
      ),
    );
  }
}

class CreateAccauntTextButton extends StatelessWidget {
  const CreateAccauntTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "У вас еще нет аккаунта?",
          style: AppFonts.w400s14.copyWith(color: AppColors.textFieldText),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateAccScreen()));
            },
            child: Text(
              "Создать ",
              style: AppFonts.w400s14
                  .copyWith(color: AppColors.textButtonColor),
            ))
      ],
    );
  }
}
