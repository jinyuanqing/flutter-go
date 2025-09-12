//毛边玻璃

import 'dart:ui';
import 'package:flutter/material.dart';


// 核心毛边玻璃组件
class FrostedGlassBox extends StatelessWidget {
  final double width;
  final double height;
  final double blurRadius;
  final Widget child;
  final BorderRadiusGeometry borderRadius;

  const FrostedGlassBox({
    super.key,
    required this.width,
    required this.height,
    required this.blurRadius,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        // 毛边层 - 使用透明度渐变创建模糊边界
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.01),
              Colors.white.withValues(alpha: 0.05),
            ],
            stops: const [0.0, 1.0],
          ),
          // 玻璃卡片基础样式
          borderRadius: borderRadius,
        ),
        // 模糊层核心
        child: Stack(
          children: [
            // 模糊背景层
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurRadius,
                sigmaY: blurRadius,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ),
            ),
            // 表面光泽层（增强玻璃质感）
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
            // 锯齿边缘层
            IgnorePointer(
              child: _JaggedEdgeOverlay(borderRadius: borderRadius),
            ),
            // 内容层
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

// 锯齿边缘效果
class _JaggedEdgeOverlay extends StatelessWidget {
  final BorderRadiusGeometry borderRadius;

  const _JaggedEdgeOverlay({required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CustomPaint(
        painter: _JaggedEdgePainter(),
        size: Size.infinite,
      ),
    );
  }
}

class _JaggedEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        colors: [
          Color(0x22FFFFFF),
          Color(0x44FFFFFF),
          Color(0x22FFFFFF),
        ],
      ).createShader(Offset.zero & size);
    
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(25),
      ));
    
    // 创建锯齿路径
    _addJaggedPath(path, size);
    
    canvas.drawPath(path, borderPaint);
  }

  void _addJaggedPath(Path path, Size size) {
    const step = 8.0;
    final points = <Offset>[];
    
    // 生成锯齿点
    for (double x = 0; x <= size.width; x += step) {
      final y = 2 * (x % 15 / 15) - 1; // -1~1 的波动
      points.add(Offset(x, y));
    }
    
    path
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    
    // 添加锯齿线
    for (final point in points) {
      path.relativeLineTo(1, point.dy);
    }
    
    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}