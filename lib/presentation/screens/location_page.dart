import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/location_model.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import 'package:rick_and_morty_app/theme/theme_provider.dart';

class LocPage extends StatelessWidget {
  final Location data;

  const LocPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Scaffold(
      backgroundColor: themeProvider.themeColor,
      appBar: AppBar(
        title: Text(data.name ?? ""),
        backgroundColor: themeProvider.themeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 280,
                color: AppColors.bg,
                child: data.url != null
                    ? Image.network(data.url!)
                    : const Text("No Image"),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                data.name ?? "",
                style: AppFonts.w700s34.copyWith(color: themeProvider.characterName),
              ),
              const SizedBox(
                height: 16,
              ),
              LocationDetailsWidget(
                type: data.type ?? '',
                dimension: data.dimension ?? '',
                residents: data.residents ?? [],
                url: data.url ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationDetailsWidget extends StatelessWidget {
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;

  const LocationDetailsWidget({
    Key? key,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
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
          const SizedBox(height: 8),
          Text(
            'URL: $url',
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}