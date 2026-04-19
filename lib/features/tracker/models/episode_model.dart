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
    final progress = json['progress'] as Map<String, dynamic>? ?? {};
    final features = json['features'] as Map<String, dynamic>? ?? {};

    return EpisodeModel(
      title: json['title'] ?? '',
      released: json['released'] ?? false,
      storyProgress: progress['story'] ?? 0,
      programmingProgress: progress['programming'] ?? 0,
      artProgress: progress['art'] ?? 0,
      completedFeatures: List<String>.from(features['completed'] ?? []),
      inProgressFeatures: List<String>.from(features['in_progress'] ?? []),
      plannedFeatures: List<String>.from(features['planned'] ?? []),
    );
  }
}
