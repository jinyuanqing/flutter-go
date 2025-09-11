import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Bubble {
  final Offset position;
  final double radius;
  final Color color;
  final Offset velocity;
  final bool isShattered;
  final List<Bubble>? fragments;
  final double fallDistance;

  Bubble({
    required this.position,
    required this.radius,
    required this.color,
    required this.velocity,
    this.isShattered = false,
    this.fragments,
    this.fallDistance = 0.0,
  });

  Bubble copyWith({
    Offset? position,
    double? radius,
    Color? color,
    Offset? velocity,
    bool? isShattered,
    List<Bubble>? fragments,
    double? fallDistance,
  }) {
    return Bubble(
      position: position ?? this.position,
      radius: radius ?? this.radius,
      color: color ?? this.color,
      velocity: velocity ?? this.velocity,
      isShattered: isShattered ?? this.isShattered,
      fragments: fragments ?? this.fragments,
      fallDistance: fallDistance ?? this.fallDistance,
    );
  }
}


class BubbleAnimation extends StatefulWidget {
  final Size containerSize;
  final VoidCallback onBubbleShattered;

  const BubbleAnimation({
    super.key,
    required this.containerSize,
    required this.onBubbleShattered,
  });

  @override
  State<BubbleAnimation> createState() => _BubbleAnimationState();
}

class _BubbleAnimationState extends State<BubbleAnimation> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;  bool _isGeneratingBubbles = true;  Future<void>? _bubbleGenerationFuture;
  final List<Bubble> _bubbles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateBubbles)..repeat();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _spawnBubble());
  }

  void _spawnBubble() {
    if (!_isGeneratingBubbles || !mounted) return;

    final size = widget.containerSize;
    final bubble = Bubble(
      position: Offset(
        _random.nextDouble() * size.width,
        _random.nextDouble() * size.height * -0.5, // 从容器顶部外随机位置生成
      ),
      radius: _random.nextDouble() * 20 + 10,
      color: Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      ),
      velocity: Offset(
        (_random.nextDouble() - 0.5) * 2,
        _random.nextDouble() * 3 + 2,
      ),
    );

    setState(() => _bubbles.add(bubble));

    _bubbleGenerationFuture = Future.delayed(
      Duration(milliseconds: _random.nextInt(1000) + 500),
      () => _spawnBubble(),
    );
  }

  void _updateBubbles() {
      if (!mounted) return;
      setState(() {
        final size = widget.containerSize;
        for (int i = 0; i < _bubbles.length; i++) {
          final bubble = _bubbles[i];
          if (bubble.isShattered) {
            _updateFragments(i);
            continue;
          }

          // 重力和反弹
          final newVelocity = bubble.velocity + const Offset(0, 0.1);
          final newPosition = bubble.position + newVelocity;

          // 水平边界检测与反弹
          double clampedX = newPosition.dx;
          double clampedVx = newVelocity.dx;
          if (newPosition.dx - bubble.radius < 0) {
            clampedX = bubble.radius;
            clampedVx = -clampedVx * 0.8;
          } else if (newPosition.dx + bubble.radius > size.width) {
            clampedX = size.width - bubble.radius;
            clampedVx = -clampedVx * 0.8;
          }

          if (newPosition.dy + bubble.radius > size.height) {
            // 碰撞地面，弹起并破碎
            _shatterBubble(i, newPosition, newVelocity);
          } else {
            _bubbles[i] = bubble.copyWith(
              position: Offset(clampedX, newPosition.dy),
              velocity: Offset(clampedVx, newVelocity.dy),
            );
          }
        }
      });
    }

  void _shatterBubble(int index, Offset position, Offset velocity) {
    final bubble = _bubbles[index];
    final fragments = List.generate(10, (_) {
      return Bubble(
        position: position,
        radius: bubble.radius * 0.2,
        color: bubble.color.withOpacity(_random.nextDouble() * 0.5 + 0.5),
        velocity: Offset(
          (velocity.dx * 0.5) + (_random.nextDouble() - 0.5) * 5,
          (velocity.dy * -0.3) + (_random.nextDouble() - 0.5) * 3,
        ),
      );
    });

    _bubbles[index] = bubble.copyWith(
      isShattered: true,
      fragments: fragments,
    );
    
    widget.onBubbleShattered();
  }

  void _updateFragments(int index) {
    final bubble = _bubbles[index];
    if (bubble.fragments == null) return;
    const maxFallDistance = 150.0; // 碎片最大下坠距离

    for (int i = 0; i < bubble.fragments!.length; i++) {
      final fragment = bubble.fragments![i];
      final newVelocity = fragment.velocity + const Offset(0, 0.1);
      final newPosition = fragment.position + newVelocity;
      final newFallDistance = fragment.fallDistance + newVelocity.dy.abs();

      // 检查是否达到最大下坠距离
      if (newFallDistance > maxFallDistance) {
        // 达到最大下坠距离后，让碎片逐渐消失
        bubble.fragments![i] = fragment.copyWith(
          radius: fragment.radius * 0.95,
        );
      } else {
        bubble.fragments![i] = fragment.copyWith(
          position: newPosition,
          velocity: newVelocity,
          radius: fragment.radius * 0.99,
          fallDistance: newFallDistance,
        );
      }
    }

    // 移除完全消失的气泡
    if (bubble.fragments!.every((f) => f.radius < 0.5)) {
      _bubbles.removeAt(index);
    } else {
      _bubbles[index] = bubble.copyWith(fragments: bubble.fragments);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // 应用恢复前台，继续生成气泡和动画
        if (!_isGeneratingBubbles) {
          _isGeneratingBubbles = true;
          _animationController.repeat();
          _spawnBubble();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // 应用退到后台或不活跃，暂停生成气泡和动画
        _isGeneratingBubbles = false;
        _animationController.stop();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    // 取消气泡生成的异步任务
    // 使用一个 CancelableOperation 来实现可取消的任务
    // 但当前代码使用的是 Future，无法直接调用 cancel 方法
    // 这里可以将 _bubbleGenerationFuture 标记为 null 来避免后续任务执行
    _isGeneratingBubbles = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
return CustomPaint(
        size: widget.containerSize,
        painter: BubblePainter(bubbles: _bubbles),
      );
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double height;

  WavePainter({
    required this.progress,
    required this.color,
    required this.height,
  }) : super(repaint: AlwaysStoppedAnimation(progress));

  @override
  void paint(Canvas canvas, Size size) {
    // 创建两个波浪的paint
    final paint1 = Paint()..color = color.withOpacity(0.8);
    final paint2 = Paint()..color = color.withValues(alpha: 0.5);
    
    // 波浪路径计算
    final waveHeight = height * progress;
    final waveWidth1 = size.width / 8; // 第一个波浪的宽度
    final waveWidth2 = size.width / 12; // 第二个波浪的宽度
    
    // 第一个波浪
    final path1 = Path();
    path1.moveTo(0, size.height);
    
    for (double i = 0; i < size.width; i++) {
      final y = waveHeight * sin((i / waveWidth1) + (progress * 2 * pi)) + (size.height - waveHeight);
      path1.lineTo(i, y);
    }
    
    path1.lineTo(size.width, size.height);
    path1.close();
    
    // 第二个波浪 (相位偏移)
    final path2 = Path();
    path2.moveTo(0, size.height);
    
    for (double i = 0; i < size.width; i++) {
      final y = waveHeight * 0.7 * sin((i / waveWidth2) + (progress * 2 * pi) + (pi / 4)) + (size.height - waveHeight * 0.7);
      path2.lineTo(i, y);
    }
    
    path2.lineTo(size.width, size.height);
    path2.close();
    
    // 绘制两个波浪
    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.color != color ||
           oldDelegate.height != height;
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final bubble in bubbles) {
      final paint = Paint()..color = bubble.color;
      if (bubble.isShattered && bubble.fragments != null) {
        for (final fragment in bubble.fragments!) {
          canvas.drawCircle(fragment.position, fragment.radius, paint);
        }
      } else {
        canvas.drawCircle(bubble.position, bubble.radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) => true;
}

class Posui extends StatefulWidget {
  const Posui({Key? key}) : super(key: key);

  @override
  State<Posui> createState() => _PosuiState();
}

class _PosuiState extends State<Posui> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  late Animation<double> _radiusAnimation;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  final Random _random = Random();
  final String _text = '动态圆环文字效果';
  final Color _textColor = Colors.black;
  final Color _highlightColor = const Color.fromARGB(255, 204, 66, 238);
  final Color _circleColor = const Color.fromARGB(223, 53, 156, 240);
  final double _circleWidth = 10.0;
  bool _showWave = false;
  Color _waveColor = Colors.blue;

  void _startWaveAnimation() {
    setState(() {
      _showWave = true;
      _waveColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
    
    _waveController.reset();
    _waveController.forward().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _showWave = false);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // 水平移动动画0-1接近文字,-0.2到文字的左侧一段距离
    _xAnimation = Tween<double>(begin: -0.2, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // 初始化波浪动画控制器
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.easeInOut,
      ),
    );




  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Stack(
        children: [
        //  BubbleAnimation(),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 225, 225).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(children: [
                    BubbleAnimation(
                      containerSize: const Size(350, 200),
                      onBubbleShattered: _startWaveAnimation,
                    ),
                    CustomPaint(
                      painter: CircleTextPainter(
                        text: _text,
                        textColor: _textColor,
                        highlightColor: _highlightColor,
                        circleColor: _circleColor,
                        circleWidth: _circleWidth,
                        xPos: _xAnimation.value,
                        yPos: 0.5,
                        radiusRatio: 0.3 + 0.2 * sin(_xAnimation.value * pi),
                      ),
                      size: const Size(350, 200),
                    ),
                    if (_showWave)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 20,
                        child: AnimatedBuilder(
                          animation: _waveAnimation,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: WavePainter(
                                progress: _waveAnimation.value,
                                color: _waveColor,
                                height: 20,
                              ),
                              size: const Size(350, 20),
                            );
                          },
                        ),
                      ),
                  ]));}))
          ],
             // ),
            );
             
  }
}

class CircleTextPainter extends CustomPainter {
  final String text;
  final Color textColor;
  final Color highlightColor;
  final Color circleColor;
  final double circleWidth;
  final double xPos;
  final double yPos;
  final double radiusRatio;

  CircleTextPainter({
    required this.text,
    required this.textColor,
    required this.highlightColor,
    required this.circleColor,
    required this.circleWidth,
    required this.xPos,
    required this.yPos,
    required this.radiusRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 计算圆环参数
    final double maxRadius = min(size.width, size.height) * radiusRatio / 2;
    final double centerX = size.width * 0.2 + xPos * size.width * 0.6;
    final double centerY = size.height * 0.2 + yPos * size.height * 0.6;

    // 绘制气泡填充，添加阴影效果
    final Paint bubblePaint = Paint()
      ..color = circleColor.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);

    // 绘制气泡边框
    final Paint borderPaint = Paint()
      ..color = circleColor.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(Offset(centerX, centerY), maxRadius, bubblePaint);
    // 绘制气泡边框
    canvas.drawCircle(Offset(centerX, centerY), maxRadius, borderPaint);

    // 绘制文字
    // 创建文字片段列表
    List<TextSpan> textSpans = [];
    // 临时TextPainter用于计算原始字符宽度
    final TextPainter tempPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: 24)),
      textDirection: TextDirection.ltr,
    );
    tempPainter.layout(minWidth: 0, maxWidth: size.width);
    final double baseCharWidth = tempPainter.width / text.length;

    // 为每个字符创建带动态样式的TextSpan
    for (int i = 0; i < text.length; i++) {
      // 计算字符中心位置
      final double charX = (size.width - tempPainter.width) / 2 + i * baseCharWidth + baseCharWidth / 2;
      final double charY = (size.height - tempPainter.height) / 2 + tempPainter.height / 2;
      final double distance = sqrt(pow(charX - centerX, 2) + pow(charY - centerY, 2));
        textSpans.add(TextSpan(
        text: text[i],
        style: TextStyle(
          fontSize: distance < maxRadius * 0.5 ? 36 : 24,
          fontWeight: FontWeight.bold,
          color: distance < maxRadius * 0.5 ? highlightColor : textColor,
        ),
      ));
    }

    // 创建最终TextPainter
    final TextPainter textPainter = TextPainter(
      text: TextSpan(children: textSpans),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final double textX = (size.width - textPainter.width) / 2;
    final double textY = (size.height - textPainter.height) / 2;

    // 创建文字路径
    final Path textPath = Path();
    textPainter.paint(canvas, Offset(textX, textY));

    // 移除重复绘制的高亮文字逻辑
  }

  @override
  bool shouldRepaint(covariant CircleTextPainter oldDelegate) {
    return oldDelegate.xPos != xPos ||
           oldDelegate.yPos != yPos ||
           oldDelegate.radiusRatio != radiusRatio;
  }
}