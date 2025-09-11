import 'package:flutter/material.dart';
import 'dart:math';


class Fangda_text extends StatefulWidget {
  const Fangda_text({Key? key}) : super(key: key);

  @override
  State<Fangda_text> createState() => _Fangda_textState();
}

class _Fangda_textState extends State<Fangda_text> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  late Animation<double> _radiusAnimation;

  final Random _random = Random();
  final String _text = '动态圆环文字效果';
  final Color _textColor = Colors.black;
  final Color _highlightColor = const Color.fromARGB(255, 204, 66, 238);
  final Color _circleColor = const Color.fromARGB(223, 53, 156, 240);
  final double _circleWidth = 10.0;

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




  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 225, 225),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomPaint(
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
            );
          },
        ),
      
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