import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/shared_sliver_app_bar.dart';
import '../../../shared/widgets/shared_footer.dart';
import 'models/episode_model.dart';
import 'widgets/episode_card_with_rebecca.dart';
import 'widgets/black_rose_painter.dart';

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
      backgroundColor: Colors.black, // Dark background
      body: Stack(
        children: [
          // L0: Global Background
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

          // L1: Rebecca Image
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.45,
            child: Image.asset(
              'assets/images/characters/rebecca_symbol_base.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),

          // L2: Black Rose Symbol
          Positioned(
            top: 80,
            right: 60,
            child: CustomPaint(
              painter: BlackRosePainter(),
              size: const Size(24, 24),
            ),
          ),

          // L3: Solid Black Left-to-Transparent Gradient Overlay
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

          // L4: CustomScrollView
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // SliverAppBar
              const SharedSliverAppBar(),

              // Hero Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 120, left: 24, right: 24, bottom: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to Dreadmoor.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: Colors.white.withAlpha(200),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Nothing here is ever as it seems.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: Colors.white.withAlpha(200),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "EPISODE TRACKER",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h1.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.12 >
                                  72.0
                              ? 72.0
                              : (MediaQuery.of(context).size.width * 0.12 < 32.0
                                  ? 32.0
                                  : MediaQuery.of(context).size.width * 0.12),
                          fontWeight: FontWeight.w900, // Very heavy weight
                          letterSpacing: -2, // Tight tracking
                          color: Colors.white, // Pure white
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
