import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/presentation/bloc/chars_bloc_bloc.dart';
import 'package:rick_and_morty_app/presentation/screens/char_page.dart';
import 'package:rick_and_morty_app/presentation/widgets/gridView.dart';
import 'package:rick_and_morty_app/presentation/widgets/listView.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/theme_provider.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  TextEditingController controller = TextEditingController();
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharsBlocBloc>(context).add(GetCharsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: const TextStyle(color: AppColors.greyLtext),
              controller: controller,
              onChanged: (value) {
                BlocProvider.of<CharsBlocBloc>(context)
                    .add(GetCharsEvent(name: value));
              },
              decoration: InputDecoration(
                
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.greyLtext,
                ),
                fillColor: context
                    .watch<ThemeProvider>()
                    .theme
                    .inputDecorationTheme
                    .fillColor,
                filled: true,
                hintStyle: const TextStyle(
                  color: AppColors.greyLtext,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: 0.44,
                ),
                hintText: "Найти персонажа",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "ВСЕГО ПЕРСОНАЖЕЙ: 200 ",
                  style: TextStyle(
                    color: AppColors.greyLtext,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.60,
                    letterSpacing: 1.50,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                  child: Icon(
                    isGridView ? Icons.grid_view : Icons.list,
                    color: AppColors.greyLtext,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CharsBlocBloc, CharsBlocState>(
                builder: (context, state) {
                  if (state is CharsBlocSuccess) {
                    return isGridView
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: state.model.results?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                _openCharPage(state.model.results?[index]);
                              },
                              child: GridViewWidget(
                                characters:
                                    state.model.results?[index] ?? MyCharacter(),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.model.results?.length ?? 0,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                _openCharPage(state.model.results?[index]);
                              },
                              child: ListViewWidget(
                                characters:
                                    state.model.results?[index] ?? MyCharacter(), onTap: () {  
                                        _openCharPage(state.model.results?[index]);
                                    },
                              ),
                            ),
                          );
                  }
                  if (state is CharsBlocError) {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/pngs/4e17e96d57ba205ebfee7639eb7afa0e.png",
                            width: 250,
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            "Персонаж с таким именем не найден",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyLtext,
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: 0.15,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCharPage(MyCharacter? character) {
    if (character != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CharPage(data: character),
        ),
      );
    }
  }
}
