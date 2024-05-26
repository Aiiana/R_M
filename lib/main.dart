import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/dio/dio_settings.dart';
import 'package:rick_and_morty_app/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty_app/data/repositories/get_episode_data.dart';
import 'package:rick_and_morty_app/data/repositories/get_location_repo.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc/episode_bloc_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/chars_bloc_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc_loc/location_bloc.dart';
import 'package:rick_and_morty_app/presentation/screens/locations_screen.dart';
import 'package:rick_and_morty_app/presentation/screens/screensaver.dart';

import 'package:rick_and_morty_app/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(
    const SharedPrefsWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(builder: (context) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => DioSettings(),
            ),
            RepositoryProvider(
              create: (context) => GetCharsRepo(
                  dio: RepositoryProvider.of<DioSettings>(context).dio),
            ),
            RepositoryProvider(
              create: (context) => GetEpisodeDataRepo(
                  dio: RepositoryProvider.of<DioSettings>(context).dio),
            ),
            RepositoryProvider(
              create: (context) => LocationRepository(
                  dio: RepositoryProvider.of<DioSettings>(context).dio),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    CharsBlocBloc(repo: RepositoryProvider.of<GetCharsRepo>(context)),
              ),
              BlocProvider(
                create: (context) => EpisodeBlocBloc(
                    repo: RepositoryProvider.of<GetEpisodeDataRepo>(context)),
              ),
              BlocProvider(
                create: (context) => LocationBlocBloc(
                    repo: RepositoryProvider.of<LocationRepository>(context)),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: context.watch<ThemeProvider>().theme,
              home:  ScreenSaver(),
            ),
          ),
        );
      }),
    );
  }
}
class _SharedPrefsWidgetState extends State<SharedPrefsWidget> {
  late SharedPreferences prefs; // Remove static keyword

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return widget.child;
  }
}