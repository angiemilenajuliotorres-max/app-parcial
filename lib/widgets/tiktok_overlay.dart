import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/video_model.dart';

class TiktokOverlay extends StatefulWidget {
  final VideoModel video;
  final bool isPlaying;

  const TiktokOverlay({
    super.key,
    required this.video,
    required this.isPlaying,
  });

  @override
  State<TiktokOverlay> createState() => _TiktokOverlayState();
}

class _TiktokOverlayState extends State<TiktokOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _discAnimController;

  @override
  void initState() {
    super.initState();
    _discAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    if (widget.isPlaying) {
      _discAnimController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant TiktokOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_discAnimController.isAnimating) {
      _discAnimController.repeat();
    } else if (!widget.isPlaying && _discAnimController.isAnimating) {
      _discAnimController.stop();
    }
  }

  @override
  void dispose() {
    _discAnimController.dispose();
    super.dispose();
  }

  String _formatCount(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${widget.video.commentsCount} comentarios',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildCommentTile(
                      username: '@flutter_fan',
                      comment: '¡Excelente video para el parcial! 🚀',
                      time: 'hace 2h',
                      likes: '24',
                    ),
                    _buildCommentTile(
                      username: '@dev_mobile',
                      comment: 'La interfaz quedó idéntica a TikTok 👏',
                      time: 'hace 4h',
                      likes: '58',
                    ),
                    _buildCommentTile(
                      username: '@coding_life',
                      comment: 'Muy fluido el deslizamiento vertical 🔥',
                      time: 'hace 6h',
                      likes: '12',
                    ),
                  ],
                ),
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Añadir comentario...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF2C2C2C),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Color(0xFFFE2C55)),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Comentario publicado'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentTile({
    required String username,
    required String comment,
    required String time,
    required String likes,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFF25F4EE),
            child: Text(
              username[1].toUpperCase(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  comment,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.favorite_border, color: Colors.white38, size: 16),
              Text(likes,
                  style: const TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 12.0, bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Lado Izquierdo: Información del Creador y Audio
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre de Usuario
                  Row(
                    children: [
                      Text(
                        widget.video.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified,
                        color: Color(0xFF25F4EE),
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Descripción del Video
                  Text(
                    widget.video.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          color: Colors.black87,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  // Título de la Música
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.video.musicTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Lado Derecho: Iconos de Interacción Estilo TikTok
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Avatar del creador con botón +
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFF2C2C2C),
                        child: Text(
                          widget.video.username.length > 1
                              ? widget.video.username[1].toUpperCase()
                              : 'T',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFE2C55),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // 2. Botón Me Gusta (Like)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.video.isLiked = !widget.video.isLiked;
                      if (widget.video.isLiked) {
                        widget.video.likesCount++;
                      } else {
                        widget.video.likesCount--;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        widget.video.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.video.isLiked
                            ? const Color(0xFFFE2C55)
                            : Colors.white,
                        size: 38,
                        shadows: const [
                          Shadow(color: Colors.black87, blurRadius: 4),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatCount(widget.video.likesCount),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 3. Botón Comentarios
                GestureDetector(
                  onTap: () => _showCommentsBottomSheet(context),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.comment_rounded,
                        color: Colors.white,
                        size: 36,
                        shadows: [
                          Shadow(color: Colors.black87, blurRadius: 4),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatCount(widget.video.commentsCount),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 4. Botón Compartir
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('¡Enlace de video copiado al portapapeles!'),
                        backgroundColor: const Color(0xFF25F4EE),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const Icon(
                        Icons.share_rounded,
                        color: Colors.white,
                        size: 34,
                        shadows: [
                          Shadow(color: Colors.black87, blurRadius: 4),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatCount(widget.video.sharesCount),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // 5. Disco de música giratorio
                AnimatedBuilder(
                  animation: _discAnimController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _discAnimController.value * 2 * math.pi,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFF2C2C2C), Colors.black],
                          ),
                          border: Border.all(color: Colors.white30, width: 2),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
