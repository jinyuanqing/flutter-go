import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int durationPerChar; // 每个字符的持续时间(毫秒)

  const TypewriterText({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(fontSize: 24, color: Colors.white),
    this.durationPerChar = 1500, // 默认0.5秒
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> with TickerProviderStateMixin
        {
  late AnimationController _controller; // 主控制器
  late Animation<int> _typingAnimation;
  late Animation<double> _cursorAnimation;
  late Animation<double> _glowAnimation;
  final double _cursorWidth = 2.0;
 late AnimationController _cursorController;
  late AnimationController _glowController; // 光芒动画控制器
  @override
  void initState() {
    super.initState();
    
    // 主控制器：控制整个动画序列
    // 总持续时间 = 字符数量 * 每个字符的持续时间
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.text.length * widget.durationPerChar),
      vsync: this,
    );
    _cursorController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),//光标
    )..repeat(reverse: true);
    // 光芒控制器：控制光芒动画持续时间比字符显示完成时间多5秒
    final int charDisplayDuration = widget.text.length * widget.durationPerChar;
    final int glowDuration = charDisplayDuration + 5000; // 多5秒
    _glowController = AnimationController(
      duration: Duration(milliseconds: glowDuration),
      vsync: this,
    )..repeat();
    // 打字动画：控制显示的字符数量
    _typingAnimation = IntTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

 
    _cursorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_cursorController);
    // _glowAnimation背景动画0 -1开始是完全透明度.0.2-1开始就不是完全透明
    _glowAnimation = Tween(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cursorController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  
 
                      
                      AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return     Stack(
          alignment: Alignment.center,
          children: [
            // 红色光芒效果
            if (_glowAnimation.value > 0)
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: Opacity(
                    opacity: _glowAnimation.value,
                    child: Container(
                      // height: 200,width: 300,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF4facfe),
                            Color(0xFF00f2fe),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
Row(
  children: <Widget>[
 // 文本和光标
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: null,
                text: TextSpan(
                  text: widget.text.substring(0, _typingAnimation.value),
                  style: widget.textStyle,
                  children: [
                    WidgetSpan(
                      child: Opacity(
                        opacity: _cursorAnimation.value < 0.5 ? 1.0 : 0.0,
                        child: Container(
                          width: _cursorWidth,
                          height: widget.textStyle.fontSize! * 1.2,
                          margin: const EdgeInsets.only(left: 2), 
                          color: const Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
  ],
)
           
          ],
         ) ;
      },

    );
  }
}