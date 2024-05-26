import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/location_model.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc_loc/location_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc_loc/location_event.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc_loc/location_state.dart';


import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import 'package:rick_and_morty_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_page.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial event to fetch locations
    BlocProvider.of<LocationBlocBloc>(context).add(GetLocationEvent(url: ''));
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
                  BlocProvider.of<LocationBlocBloc>(context)
                      .add(GetLocationEvent(name: value, url: ''));
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<ThemeProvider>().changeTheme();
                    },
                    icon: const Icon(
                      Icons.filter_list,
                      color: AppColors.greyLtext,
                    ),
                  ),
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
                  hintText: "Найти локацию",
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
                    "ВСЕГО ЛОКАЦИЙ: 200 ",
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
              BlocBuilder<LocationBlocBloc, LocationState>(
                builder: (context, state) {
                  if (state is LocationSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.locationModel.results!.length,
                      itemBuilder: (context, index) {
                        final location = state.locationModel.results![index];
                        return ListViewLocationWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocPage(data: location),
                              ),
                            );
                          },
                          location: location,
                        );
                      },
                    );
                  } else if (state is LocationError) {
                    return Center(child: Text(""));
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

class ListViewLocationWidget extends StatelessWidget {
  const ListViewLocationWidget({
    Key? key,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  final Location location;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                location.url ?? '',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name ?? '',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 1.4,
                        letterSpacing: 0.15,
                      ),
                    ),
                    Text(
                      "${location.type} - ${location.dimension}",
                      style: const TextStyle(
                        color: AppColors.greyLtext,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.4,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key, required this.locationIndex}) : super(key: key);
  final int locationIndex;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    BlocProvider.of<LocationBlocBloc>(context).add(GetLocationEvent(url: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Scaffold(
      backgroundColor: themeProvider.themeColor,
      body: BlocBuilder<LocationBlocBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocationSuccess) {
            final location = state.locationModel.results?[widget.locationIndex];
            if (location == null) {
              return const Center(child: Text('Location not found.'));
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 280,
                      child: Image.network(
                        location.url ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: const Icon(Icons.broken_image, color: Colors.white),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      location.name ?? "",
                      style: AppFonts.w700s34.copyWith(color: themeProvider.characterName),
                    ),
                    const SizedBox(height: 16),
                    LocationDetailsWidget(
                      type: location.type ?? '',
                      dimension: location.dimension ?? '',
                      residents: location.residents ?? [],
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class LocationDetailsWidget extends StatelessWidget {
  final String type;
  final String dimension;
  final List<String> residents;

  const LocationDetailsWidget({
    Key? key,
    required this.type,
    required this.dimension,
    required this.residents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type: $type',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Dimension: $dimension',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Residents:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ...residents.map((resident) => Text(resident)).toList(),
        ],
      ),
    );
  }
}

class SharedPrefsWidget extends StatefulWidget {
  const SharedPrefsWidget({Key? key, required this.child});

  final Widget child;

  static late SharedPreferences prefs;

  @override
  _SharedPrefsWidgetState createState() => _SharedPrefsWidgetState();
}

class _SharedPrefsWidgetState extends State<SharedPrefsWidget> {
  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    SharedPrefsWidget.prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
