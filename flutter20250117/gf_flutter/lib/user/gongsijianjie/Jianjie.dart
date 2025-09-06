// 公司简介
import 'package:flutter/material.dart';

class Jianjie extends StatefulWidget {
  const Jianjie({super.key});

  @override
  State<StatefulWidget> createState() => new Jianjie1();
}

class Jianjie1 extends State<Jianjie> {
  ButtonStyle style1 = ButtonStyle(
    // foregroundColor:
    //     MaterialStateProperty.all(Color.fromARGB(255, 250, 250, 250)),
    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 10, 2, 2)),
    // overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 2, 221, 64))
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70, //设置整个页面的背景色.只有container能设置颜色.行列都不行

        child: ListView(children: <Widget>[
          Wrap(
            //warp自动伸缩布局
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
              LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/11.jpg',
                            //height: 600.0,
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                  //给row设置背景色
                  color: Color(0xfff0f0f0),
                  height: 600,
                  child: Row(
                    //列内的行
                    // mainAxisAlignment: MainAxisAlignment .end, //行内控件的居中.MainAxisAlignment（主轴）就是与当前控件方向一致的轴，而CrossAxisAlignment（交叉轴）就是与当前控件方向垂直的轴.行的主轴是水平,交叉轴是垂直的.列相反

                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, //垂直居中
                            //列内的控件都是竖着排,想横着排可以用row
                            children: <Widget>[
                              new Text(
                                '简介',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 30,
                                  color: Colors.black87,
                                  // backgroundColor: Colors.grey[200]
                                ),
                              ),

                              new Image.asset('images/logo.png',
                                  width: 200.0), //build目录新建image目录,然后放入图片即可
                            ]),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(

                            //列内的控件都是竖着排,想横着排可以用row
                            mainAxisAlignment: MainAxisAlignment.center, //垂直居中
                            children: <Widget>[
                              //子控件结束后加逗号

                              //Container(
                              // height: 200,//
                              //  decoration: const BoxDecoration(color: Colors.red),
                              // child:
                              new Text(
                                '   义县游学电子科技有限公司,成立于2016年7月1日,从事软件编程,硬件系统开发。以锦州市义县为中心，业务覆盖全国各个省市。我们一直坚持挑战先进技术领域，并不断探索“新兴”和“新型”的技术设计方式, 来满足不同客户的不同需求.'
                                '\r\n    通过"非盈利只为服务"的核心思想，围绕用户需求设计不同而优化的策略和解决方案，团队由顶尖的项目工程师、开发人员、产品经理和测试,调试人员组成，我们的产品应用在近百个客户业务项目中， 这也是来自农业,商业,工业不同领域的客户对我们的认可!',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 20,
                                  color: Colors
                                      .black87, //backgroundColor: Colors.grey[200]
                                ),
                              ),
                            ]),
                      ),
                    ],
                  )),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/3.webp',
                            //height: 600.0,
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                  //给row设置背景色
                  color: Color(0xfff0f0f0),
                  height: 600,
                  child: Row(
                    //列内的行
                    // mainAxisAlignment: MainAxisAlignment .end, //行内控件的居中.MainAxisAlignment（主轴）就是与当前控件方向一致的轴，而CrossAxisAlignment（交叉轴）就是与当前控件方向垂直的轴.行的主轴是水平,交叉轴是垂直的.列相反

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 5,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, //垂直居中
                            //列内的控件都是竖着排,想横着排可以用row
                            children: <Widget>[
                              new Text(
                                '技术人人都可掌握,纵观科学技术都是从生活中人或事物从中受到启发,或从前人累积下的宝贵智慧财富上发展起来的. 因此我们认为:技术不是商人获利的手段,而是应该成为服务社会的工具.',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  // backgroundColor: Colors.grey[200]
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: Color(0xfff7f7f7),
                            child: Column(

                                //列内的控件都是竖着排,想横着排可以用row
                                mainAxisAlignment:
                                    MainAxisAlignment.center, //垂直居中
                                children: <Widget>[
                                  //子控件结束后加逗号

                                  //Container(
                                  // height: 200,//
                                  //  decoration: const BoxDecoration(color: Colors.red),
                                  // child:
                                  new Text(
                                    '水来自大海,\r\n   \r\n     终回归大海!',
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontSize: 30,
                                      color: Colors
                                          .black87, //backgroundColor: Colors.grey[200]
                                    ),
                                  ),
                                ]),
                          )),
                      //  Expanded(flex: 1, child: Container()),
                    ],
                  )),
              Container(
                  //给row设置背景色
                  color: Color(0xfff0f0f0),
                  height: 600,
                  child: Row(
                    //列内的行
                    // mainAxisAlignment: MainAxisAlignment .end, //行内控件的居中.MainAxisAlignment（主轴）就是与当前控件方向一致的轴，而CrossAxisAlignment（交叉轴）就是与当前控件方向垂直的轴.行的主轴是水平,交叉轴是垂直的.列相反

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, //垂直居中
                            //列内的控件都是竖着排,想横着排可以用row
                            children: <Widget>[
                              new Text(
                                '从事擅长的领域',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 30,
                                  color: Colors
                                      .black87, //backgroundColor: Colors.grey[200]
                                ),
                              ),
                              new Text(
                                '软件开发,硬件设计!',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 40,
                                  color: Colors
                                      .black87, //backgroundColor: Colors.grey[200]
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                          flex: 5,
                          child: Container(
                            color: Color(0xfff7f7f7),
                            child: Column(

                                //列内的控件都是竖着排,想横着排可以用row
                                mainAxisAlignment:
                                    MainAxisAlignment.center, //垂直居中
                                children: <Widget>[
                                  //子控件结束后加逗号

                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        'images/5.webp',
                                        height: 600.0,
                                        fit: BoxFit.cover,
                                      )),
                                ]),
                          )),
                      //  Expanded(flex: 1, child: Container()),
                    ],
                  )),
              Container(
                  //给row设置背景色
                  color: Color(0xfff0f0f0),
                  height: 600,
                  child: Row(
                    //列内的行
                    // mainAxisAlignment: MainAxisAlignment .end, //行内控件的居中.MainAxisAlignment（主轴）就是与当前控件方向一致的轴，而CrossAxisAlignment（交叉轴）就是与当前控件方向垂直的轴.行的主轴是水平,交叉轴是垂直的.列相反

                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 8,
                        child: Column(

                            //列内的控件都是竖着排,想横着排可以用row
                            mainAxisAlignment: MainAxisAlignment.center, //垂直居中
                            children: <Widget>[
                              //子控件结束后加逗号

                              //Container(
                              // height: 200,//
                              //  decoration: const BoxDecoration(color: Colors.red),
                              // child:
                              new Text(
                                '你是职场精英,面对自己的技术水平越来越高,能力越来越强, 你是否想过: 如果我用自己的技术来服务更多人,是不是更好呢?你是职场小白,什么都不懂,面对大神的嘲笑,你是否想过: 如何提高一下技术水平,学习一些新技术呢?',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 20,
                                  color: Colors
                                      .black87, //backgroundColor: Colors.grey[200]
                                ),
                              ),
                              Text(
                                '公司对编程开发有兴趣的社会人士,专门提供线上一对一指导培训, 从理论到基础,从讲解到动手实践,全方位守护,助您一臂之力!',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 30,
                                  color: Colors
                                      .black87, //backgroundColor: Colors.grey[200]
                                ),
                              ),

                              GestureDetector(
                                  onTapDown: (details) {
                                    //GestureDetector控件的按下事件
                                    print(1);
                                    setState(() {
                                      style1 = ButtonStyle(
                                        // foregroundColor:
                                        //     MaterialStateProperty.all(
                                        //         Color.fromARGB(
                                        //             255, 250, 250, 250)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(255, 224, 3, 3)),
                                        // overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 2, 221, 64))
                                      );
                                    });

                                    Future.delayed(//3s后再次变色
                                        const Duration(milliseconds: 3000), () {
// Here you can write your code

                                      setState(() {
                                        style1 = ButtonStyle(
                                          // foregroundColor:
                                          //     MaterialStateProperty.all(
                                          //         Color.fromARGB(
                                          //             255, 250, 250, 250)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          // overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 2, 221, 64))
                                        );

                                        // Here you can write your code for open new view
                                      });
                                    });
                                  },
                                  onTapUp: (details) {
                                    //抬起事件,会被按钮的onpressed覆盖.
                                    print(2);
                                  },
                                  child: ElevatedButton(
//raisedbutton必须在materialAPP类中,否则不显示
                                    //   color: Colors.green, textColor: Colors.white,
                                    style: style1,
                                    child: new Text(
                                      '联系我们',
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 30,
                                        //  color: Colors.white,
                                        //  backgroundColor: Colors.green
                                      ),
                                    ),

                                    onPressed: () async {
                                      //  tabController1.index = 5; // print("按下了提交按钮");

                                      print("object");

                                      //       setState(() {

                                      // });
                                    },
                                  )),
                            ]),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  )),
            ],
          ),

          // width: 1620,
        ]));
  }

  Future<void> zi_xun_Dialog() async {
    //弹出咨询窗口

    showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              //  width: 30.0,
              height: 40.0,
              // color: Colors.red,
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Positioned(
                  //右上角关闭按钮
                  right: 10,
                  top: MediaQuery.of(context).padding.top,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text("联系我们:"),
              ]),
            ),
            content: Container(
                //  width: 30.0,
                height: 400.0,
                // color: Colors.red,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      new Text(
                        '客服QQ:761153454,微信/手机号:15241366729,联系人:游学',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 25,
                          color: Colors.black87,
                          // backgroundColor: Colors.grey[200]
                        ),
                      ),

                      //Expanded(
                      //child:
//                      PhotoView(
//                        imageProvider:
                      //   AssetImage("assets/images/an_li1.png"),
//                      )
                      //  ),
                    ],
                  ),
                )),
            actions: <Widget>[
              //对话框底部按钮
              ElevatedButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text("关闭"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}
