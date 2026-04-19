import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';
import 'progress_bar.dart';

class EpisodeCardWithRebecca extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeCardWithRebecca({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReleased = episode.released;
    final String statusText = isReleased ? 'Released' : 'In Progress';

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;

        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          height: isMobile ? null : 240,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withAlpha(20)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              /// 🔥 REBECCA (RIGHT SIDE)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: isMobile ? 0.5 : 0.4,
                    child: Opacity(
                      opacity: 0.35,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          'assets/images/characters/rebecca_half.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.centerRight,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// 🔥 DARK OVERLAY (so text is always readable)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.backgroundSecondary.withAlpha(230),
                        AppColors.backgroundSecondary.withAlpha(120),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              /// 🔥 CONTENT
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          episode.title,
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        /// STATUS BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isReleased
                                ? AppColors.accent.withAlpha(40)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isReleased
                                  ? AppColors.accent
                                  : AppColors.textSecondary.withAlpha(120),
                            ),
                          ),
                          child: Text(
                            statusText,
                            style: AppTextStyles.bodySecondary.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isReleased
                                  ? AppColors.accent
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// PROGRESS
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProgressBar(
                            label: 'Story',
                            percentage: episode.storyProgress,
                          ),
                          const SizedBox(height: 12),
                          ProgressBar(
                            label: 'Programming',
                            percentage: episode.programmingProgress,
                          ),
                          const SizedBox(height: 12),
                          ProgressBar(
                            label: 'Art & Media',
                            percentage: episode.artProgress,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
