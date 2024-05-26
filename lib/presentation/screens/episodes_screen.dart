import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc/episode_bloc_bloc.dart';
import 'package:rick_and_morty_app/presentation/screens/char_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/theme_provider.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  
    BlocProvider.of<EpisodeBlocBloc>(context).add(GetEpisodesEvent(url: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(color: AppColors.greyLtext),
                controller: controller,
                onChanged: (value) {
                  BlocProvider.of<EpisodeBlocBloc>(context)
                      .add(GetEpisodesEvent(url: ''));
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
                  hintText: "Найти эпизод",
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
              const Row(
                children: [
                  Text(
                    "ЭПИЗОДЫ ",
                    style: TextStyle(
                      color: AppColors.greyLtext,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 1.60,
                      letterSpacing: 1.50,
                    ),
                  ),
                ],
              ),
              BlocBuilder<EpisodeBlocBloc, EpisodeBlocState>(
                builder: (context, state) {
                  if (state is EpisodeBlocSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.episodeModel.results!.length,
                      itemBuilder: (context, index) {
                        final episode = state.episodeModel.results![index];
                        return Episode(
                          episode: episode,
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}