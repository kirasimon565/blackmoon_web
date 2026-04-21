class EpisodeModel {
  final String title;
  final bool released;
  final int storyProgress;
  final int programmingProgress;
  final int artProgress;
  final List<String> completedFeatures;
  final List<String> inProgressFeatures;
  final List<String> plannedFeatures;

  EpisodeModel({
    required this.title,
    required this.released,
    required this.storyProgress,
    required this.programmingProgress,
    required this.artProgress,
    required this.completedFeatures,
    required this.inProgressFeatures,
    required this.plannedFeatures,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    // Safely cast the nested maps, defaulting to empty maps if null
    final progress = json['progress'] as Map<String, dynamic>? ?? {};
    final features = json['features'] as Map<String, dynamic>? ?? {};

    return EpisodeModel(
      title: json['title'] as String? ?? 'Unknown Episode',
      released: json['released'] as bool? ?? false,
      
      // Using `num?` before `.toInt()` prevents Flutter Web casting crashes
      storyProgress: (progress['story'] as num?)?.toInt() ?? 0,
      programmingProgress: (progress['programming'] as num?)?.toInt() ?? 0,
      artProgress: (progress['art'] as num?)?.toInt() ?? 0,
      
      // Safely map dynamic lists to strict String lists
      completedFeatures: List<String>.from(features['completed'] ?? []),
      inProgressFeatures: List<String>.from(features['in_progress'] ?? []),
      plannedFeatures: List<String>.from(features['planned'] ?? []),
    );
  }
}
