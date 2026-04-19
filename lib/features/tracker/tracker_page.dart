import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/layout/responsive_container.dart';
import 'models/episode_model.dart';
import 'widgets/episode_card_with_rebecca.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  late Future<List<EpisodeModel>> _episodesFuture;

  @override
  void initState() {
    super.initState();
    _episodesFuture = fetchTracker();
  }

  Future<List<EpisodeModel>> fetchTracker() async {
    final response = await http.get(Uri.parse('https://solitary-glitter-c0f6.natalieparker1444.workers.dev/tracker'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> episodesJson = data['episodes'] ?? [];
      return episodesJson.map((e) => EpisodeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tracker data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Episode Tracker', style: AppTextStyles.h1),
            const SizedBox(height: 16),
            const Text(
              'Track development progress and episode status.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 48),
            FutureBuilder<List<EpisodeModel>>(
              future: _episodesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load data. Please try again later.',
                      style: AppTextStyles.body,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data available.',
                      style: AppTextStyles.body,
                    ),
                  );
                }

                final episodes = snapshot.data!;
                return Column(
                  children: episodes.map((episode) => EpisodeCardWithRebecca(episode: episode)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
