import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/shared_sliver_app_bar.dart';
import '../../../shared/widgets/shared_footer.dart';
import '../../../shared/widgets/simple_rose_painter.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          // BACKGROUND
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF000000),
                    Color(0xFF05080C),
                  ],
                ),
              ),
            ),
          ),

          // REBECCA
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.45,
            child: Image.asset(
              'assets/images/characters/rebecca_symbol_base.png',
              fit: BoxFit.cover,
            ),
          ),

          // SOFT LEFT FADE (VERY IMPORTANT)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // BLACK ROSE SYMBOL
          Positioned(
            right: screenWidth * 0.15, // roughly top-right quadrant above shoulder
            top: 100,
            child: CustomPaint(
              painter: SimpleRosePainter(),
              size: const Size(24, 24),
            ),
          ),

          // L1: CustomScrollView
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // SliverAppBar
              const SharedSliverAppBar(),

              // Hero Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "YOU'RE VISITING THE NEW VERSION OF THE",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: const Color(0xFFD49A6A), // warm slightly orange/desaturated
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "EPISODE TRACKER",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h1.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.12 > 80.0
                            ? 80.0
                            : (MediaQuery.of(context).size.width * 0.12 < 40.0 ? 40.0 : MediaQuery.of(context).size.width * 0.12),
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Spacer instead of explanation text
              const SliverToBoxAdapter(child: SizedBox(height: 120)),

              // Items Section (Episode List)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: FutureBuilder<List<EpisodeModel>>(
                  future: _episodesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: Text(
                          'ERR_LOAD_DATA',
                          style: AppTextStyles.body.copyWith(
                            color: Colors.red,
                            fontFamily: 'monospace',
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Text(
                          'NO_DATA',
                          style: AppTextStyles.body.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      );
                    }

                    final episodes = snapshot.data!;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return EpisodeCardWithRebecca(
                              episode: episodes[index]);
                        },
                        childCount: episodes.length,
                      ),
                    );
                  },
                ),
              ),

              // Footer
              const SharedFooter(),
            ],
          ),
        ],
      ),
    );
  }
}
