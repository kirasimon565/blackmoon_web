import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/shared_sliver_app_bar.dart';
import '../../../shared/widgets/shared_footer.dart';
import 'models/episode_model.dart';

// You can define this in your AppColors, but setting it here for the Everbyte vibe
const Color _everbyteBg = Color(0xFF12151E); 
const Color _accentPink = Color(0xFFFF4D79);
const Color _accentOrange = Color(0xFFF2A679);

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
    // Assuming this fetches your episode data
    _episodesFuture = fetchTracker(); 
  }

  Future<List<EpisodeModel>> fetchTracker() async {
    // Your existing fetch logic here...
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
      backgroundColor: _everbyteBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SharedSliverAppBar(),

          // 1. Hero Image (Rebecca Fading)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Image of Rebecca
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
                  
                  // Black Rose Symbol / Custom branding in top right
                  Positioned(
                    top: 40,
                    right: 40,
                    child: Image.asset(
                      'assets/images/branding/black_rose.png', // Replace with your asset
                      width: 40,
                      color: _accentPink,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Text Intro Section (Updated for BlackMoon / Dreadmoor)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OFFICIAL DEVELOPMENT STATUS FOR DREADMOOR", 
                    style: AppTextStyles.bodySecondary.copyWith(
                      color: _accentOrange,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "EPISODE\nTRACKER",
                    style: AppTextStyles.h1.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Rich text with BlackMoon/Dreadmoor lore
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.6,
                      ),
                      children: [
                        const TextSpan(text: "Welcome to the shadows of Dreadmoor. If you are looking for the latest "),
                        _buildHighlightTag("development progress"),
                        const TextSpan(text: " on the search for Rebecca Stone, or want to know what "),
                        _buildHighlightTag("interactive features"),
                        const TextSpan(text: " the BlackMoon team is building into the engine, you are in the right place. Nothing's as it seems. Keep an eye on the meters below to see what is currently in production."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Episode 1 is currently in development.", // Updated status
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),

          // 3. Progress Bars Section
          // In reality, map this to your _episodesFuture data. 
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const TrackerProgressBar(title: "STORY", percentage: 1.0),
                const SizedBox(height: 32),
                const TrackerProgressBar(title: "PROGRAMMING", percentage: 1.0),
                const SizedBox(height: 32),
                const TrackerProgressBar(title: "GRAPHICS & MEDIA", percentage: 1.0),
                const SizedBox(height: 48),
                
                // Upcoming Features Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_accentPink, Color(0xFFC7365F)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Upcoming Features",
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
              ]),
            ),
          ),

          const SharedFooter(),
        ],
      ),
    );
  }

  // Helper widget to create the pink highlight pills in the text
  InlineSpan _buildHighlightTag(String text) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: _accentPink,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// CUSTOM PROGRESS BAR WIDGET
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
        Text(
          title,
          style: AppTextStyles.body.copyWith(
            color: _accentPink,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 4.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15), // Dim grey track
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              color: _accentPink, // The filled part
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${(percentage * 100).toInt()}%',
                style: AppTextStyles.h1.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
