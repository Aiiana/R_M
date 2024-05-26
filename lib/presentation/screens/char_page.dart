import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/data/models/episode_model.dart';

import 'package:rick_and_morty_app/presentation/bloc/bloc/episode_bloc_bloc.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/theme_provider.dart';

class CharPage extends StatefulWidget {
  const CharPage({required this.data, super.key});
  final MyCharacter data;

  @override
  State<CharPage> createState() => _CharPageState();
}

class _CharPageState extends State<CharPage> {
  List<Episodes> episodeList = [];
  void getData() {
    for (int i = 0; i < widget.data.episode!.length; i++) {
      BlocProvider.of<EpisodeBlocBloc>(context)
          .add(GetEpisodesEvent(url: widget.data.episode![i]));
    }
  }

  @override
  void initState() {
      getData();
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.data.image ?? "",
                        height: 218,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 218,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff0B1E2D).withOpacity(0.65)),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    widget.data.name ?? '',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 34,
                    
                      height: 1.18,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.data.status ?? '',
                    style: TextStyle(
                      color: widget.data.status == "Alive"
                          ? AppColors.green
                          : AppColors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    
                      height: 1.60,
                      letterSpacing: 1.50,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.data.species ?? "",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                  
                      height: 1.50,
                      letterSpacing: 0.50,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      HZwidget(
                          title: "Пол", subtitle: widget.data.gender ?? ""),
                      const Spacer(),
                      HZwidget(
                          title: "Расса", subtitle: widget.data.species ?? ""),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            HZwidget(
                                title: "Месторождение",
                                subtitle: widget.data.origin?.name ?? ""),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right,
                            color: AppColors.greyLtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            HZwidget(
                                title: "Местоположение",
                                subtitle: widget.data.location?.name ?? ""),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right,
                            color: AppColors.greyLtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  const Divider(
                    height: 5,
                    color: AppColors.greyLtext,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Text(
                          " Эпизоды",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            height: 1.40,
                            letterSpacing: 0.15,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.data.episode?.length.toString() ?? "",
                          style: const TextStyle(
                            color: AppColors.greyLtext,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.33,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocListener<EpisodeBlocBloc, EpisodeBlocState>(
                    listener: (context, state) {
                      if (state is EpisodeBlocSuccess) {
                        episodeList.addAll(state.episodeModel.results ?? []);
                        setState(() {});
                      }
                    },
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: episodeList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Episode(episode: episodeList[index],),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 138,
              left: MediaQuery.of(context).size.width / 2 - 73,
              child: CircleAvatar(
                radius: 85,
                backgroundColor: context
                    .watch<ThemeProvider>()
                    .theme
                    .scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 73,
                  backgroundImage: NetworkImage(widget.data.image ?? ","),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episodes episode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(episode.image ?? ""),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "СЕРИЯ ${episode.id ?? ""}",
              style: const TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 10,
                height: 1.60,
                letterSpacing: 1.50,
              ),
            ),
            Text(
              episode.name ?? "",
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.50,
                letterSpacing: 0.50,
              ),
            ),
            Text(
              " ${episode.created ?? ""}",
              style: const TextStyle(
                color: AppColors.greyLtext,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.43,
                letterSpacing: 0.25,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class HZwidget extends StatelessWidget {
  const HZwidget({required this.title, required this.subtitle, super.key});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.lightgrey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.33,
            letterSpacing: 1.50,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.43,
            letterSpacing: 0.25,
          ),
        )
      ],
    );
  }
}
