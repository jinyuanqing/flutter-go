import 'package:flutter_gf_view/global.dart';
import 'package:get/get.dart';
import 'dart:async';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  int countValue = 2;

  late Timer _timer;

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  // 启动Timer,1s执行一次countValue-1
  void _startTimer() {
    final Duration duration = Duration(seconds: 1);

    _timer = Timer.periodic(duration, (timer) {
      countValue = countValue - 1;
      if (this.mounted) {
        setState(() {});
      }
      print('CountValue');
      print(countValue);
      if (countValue <= 0) {
        cancelTimer();
        Get.toNamed("/a");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer(); //开始倒计时
    //自动跳转2.1
    // Future.delayed(Duration(seconds: 5), () {
    //   // Get.to(Text("data"));
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    //自动跳转2.2
// Future.delayed(Duration(seconds: 3), () {
//      Get.to(Text("data"));
//     });

    return Scaffold(
        appBar: AppBar(
          title: const Text('页面提示'),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  "您访问的页面有误,请确认后重新访问.5s后跳转到登录页面. ",
                  style: TextStyle(fontSize: 29),
                ),
                Text(
                  " ${countValue}",
                  style: TextStyle(fontSize: 39),
                ),
              ],
            )));
  }
}
