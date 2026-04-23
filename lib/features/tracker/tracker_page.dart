import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/shared_sliver_app_bar.dart';
import '../../../shared/widgets/shared_footer.dart';
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
    final response = await http.get(Uri.parse(
        'https://solitary-glitter-c0f6.natalieparker1444.workers.dev/tracker'));

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
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SharedSliverAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.transparent, Colors.black],
                          stops: [0.0, 0.4],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/characters/rebecca_symbol_base.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                        errorBuilder: (context, error, stackTrace) => const SizedBox(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 40,
                    child: Image.asset(
                      'assets/images/branding/black_rose.png',
                      width: 40,
                      color: AppColors.accent,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SYSTEM LOG // METRICS", 
                    style: AppTextStyles.bodySecondary.copyWith(
                      color: AppColors.accentSecondary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "DEVELOPMENT\nTRACKER",
                    style: AppTextStyles.h1.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Replaced the Everbyte Pill-Text with a cinematic dossier log
                  Text(
                    "Live production readouts for Project Dreadmoor.\n\nMonitor the active development of our narrative architecture, interactive modules, and the ongoing search for Rebecca Stone. The metrics below reflect real-time engine status.",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Standalone Tagline
                  Text(
                    "Nothing's as it seems.",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),

          // THE REAL DYNAMIC DATA
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: FutureBuilder<List<EpisodeModel>>(
              future: _episodesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(color: AppColors.accent)),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text('ERR_LOAD_DATA: ${snapshot.error}', style: AppTextStyles.body.copyWith(color: Colors.red, fontFamily: 'monospace')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Text('NO_DATA_FOUND', style: AppTextStyles.body.copyWith(fontFamily: 'monospace')),
                  );
                }

                final episodes = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return EpisodeCardWithRebecca(episode: episodes[index]); 
                    },
                    childCount: episodes.length,
                  ),
                );
              },
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 64.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, const Color(0xFF8B0000)], // Darker crimson gradient transition
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4), // Sharp corners
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {},
                    child: Text("Upcoming Features", style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  ),
                ),
              ),
            ),
          ),
          const SharedFooter(),
        ],
      ),
    );
  }
}

// ==========================================
// SHARP, GLOWING PROGRESS BAR (BlackMoon Style)
// ==========================================
class TrackerProgressBar extends StatelessWidget {
  final String title;
  final double percentage; // 0.0 to 1.0

  const TrackerProgressBar({
    super.key,
    required this.title,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: AppTextStyles.body.copyWith(
                color: AppColors.accent, 
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace', 
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 4, // Sharp, thin track instead of chunky block
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20), 
            borderRadius: BorderRadius.zero, // Sharp edges
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.accent,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withAlpha(100),
                    blurRadius: 8, // Cinematic neon glow
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
