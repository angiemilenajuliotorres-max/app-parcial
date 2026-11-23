class VideoModel {
  final String id;
  final String videoUrl;
  final String username;
  final String description;
  final String musicTitle;
  int likesCount;
  final int commentsCount;
  final int sharesCount;
  bool isLiked;

  VideoModel({
    required this.id,
    required this.videoUrl,
    required this.username,
    required this.description,
    required this.musicTitle,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    this.isLiked = false,
  });

  static List<VideoModel> sampleVideos = [
    VideoModel(
      id: '1',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      username: '@naturaleza_viva',
      description: 'Mariposa monarca en alta definición 🦋✨ #nature #macro #flutter #parcial',
      musicTitle: 'Sonido original - Naturaleza y Vida',
      likesCount: 14200,
      commentsCount: 382,
      sharesCount: 154,
    ),
    VideoModel(
      id: '2',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      username: '@abejitas_colombia',
      description: 'Polinizando en el jardín botánico 🐝🌸 ¡Cuidemos el planeta! #bees #ecologia',
      musicTitle: 'Sonido ambiental - Jardines del Mundo',
      likesCount: 28900,
      commentsCount: 520,
      sharesCount: 310,
    ),
    VideoModel(
      id: '3',
      videoUrl: 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/face-demographics-walking.mp4',
      username: '@city_walks',
      description: 'Caminando por el centro urbano en un día soleado 🚶‍♂️🏙️ #citylife #walk #vibe',
      musicTitle: 'Chill Lo-Fi Beats - Urban Mood',
      likesCount: 8430,
      commentsCount: 195,
      sharesCount: 87,
    ),
    VideoModel(
      id: '4',
      videoUrl: 'https://raw.githubusercontent.com/intel-iot-devkit/sample-videos/master/people-detection.mp4',
      username: '@tech_ai_trends',
      description: 'Detección inteligente de personas y flujo peatonal con IA 🤖📊 #tech #ai #software',
      musicTitle: 'Cyberpunk Synthwave - Future Code',
      likesCount: 35100,
      commentsCount: 840,
      sharesCount: 420,
    ),
  ];
}
