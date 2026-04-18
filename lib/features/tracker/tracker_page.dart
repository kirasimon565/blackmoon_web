import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/layout/responsive_container.dart';
import 'models/episode_model.dart';
import 'widgets/episode_card.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  List<EpisodeModel> _episodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/tracker_data.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> episodesJson = data['episodes'] ?? [];

      setState(() {
        _episodes = episodesJson.map((e) => EpisodeModel.fromJson(e)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error visually if needed
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
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_episodes.isEmpty)
              const Center(child: Text('No data available.'))
            else
              ..._episodes.map((episode) => EpisodeCard(episode: episode)),
          ],
        ),
      ),
    );
  }
}
