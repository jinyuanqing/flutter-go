
import 'package:flutter/material.dart';
import '/user/particle/particle_page.dart';
import '/user/particle/particle_widget.dart';
import '/user/config.dart';
import 'dart:math';
import '/user/wenzixiaoguo/glass.dart';

import '/user/wenzixiaoguo/dazi.dart';
import '/user/wenzixiaoguo/daxiao.dart';
import '/user/wenzixiaoguo/fangda.dart';
import '/user/wenzixiaoguo/bolang.dart';
import '/user/wenzixiaoguo/zuoyou.dart';

import '/user/wenzixiaoguo/posui.dart';
import 'package:glass_kit/glass_kit.dart';

class UserGather extends StatelessWidget {  
  // 从配置文件中获取变量
  double get deviationRatio => AppConfig.deviationRatio;
   List<Map<String, dynamic>> get article_list => AppConfig.articleList;
  List<double> get shadow => AppConfig.shadow; // 已重命名为shadow

  const UserGather({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    
    
      Stack(children: <Widget>[
            const Positioned.fill(child: AnimatedBackground()),
            Positioned.fill(child: ParticlesWidget(AppConfig.particleCount)),
            Positioned.fill(
                child: LayoutBuilder(builder: (context, constraints) {
              //  //print('constraints.maxWidth');
              //   //print(constraints.maxWidth);

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
Row(
  children: <Widget>[
   Container(
        height: 600,width: constraints.maxWidth,
        alignment: Alignment.center,
        child: Stack(
          
          
          
          children: <Widget>[


    Positioned.fill(child: 
    Image.network(AppConfig.bannerImage, ),
    ),
   Row(  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
   //Image.network('https://picsum.photos/420/400',height: 400,),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
 Container(width: constraints.maxWidth,
        alignment: Alignment.center,
        child: Text(AppConfig.welcomeText,
          style: TextStyle(fontSize: 30, color: Colors.white)),
       ),
   Container(width: constraints.maxWidth,
        alignment: Alignment.center,
        child: Text(AppConfig.domainText,
          style: TextStyle(fontSize: 30, color: Colors.white)),
       ),

      ],
    )
      

   ],
   )

]

),
        ),
      // ),
    
  ],
),









                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConfig.latestText,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 20),
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                        Text(
                          AppConfig.entryText,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                      ],
                    ),

                    Wrap(
                      spacing: 20.0,runSpacing:15.0,
                      children: <Widget>[
                       // Expanded(child:
                    
                      // Expanded(child:  
                        Container(
                          width: 300,
                          height: 400,
                          child: CircleTextEffect(),
                       // )
                         ),
                        //  Expanded(child: 
                         Container(
                          width: 300,
                          height: 400,
                          child: Bolang_text(),
                          // ) 
                          ),

                              Container(
                         width: 300,
                          height: 400,
                          child: Posui(),
                      //   )
                         ),
                        //  Expanded(child:
                          Container(
                          width: 300,
                          height: 400,
                          child: Zuoshangyouxia_text(),
                          // ) 
                          ),
                        //  Expanded(child: 
                         Container(
                         width: 300,
                          height: 400,
                          child: Fangda_text(),
                          // )
                           ),
                      ],
                    ),

                    Text(AppConfig.latestEntryText,
                        style: TextStyle(fontSize: 20, color: Colors.blue)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConfig.todayText,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 20),
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                        Text(
                          AppConfig.openServerText,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                      ],
                    ),
   Wrap(
                      spacing: 20.0,runSpacing:15.0,
                      children: <Widget>[
 
Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: GlassContainer(
          height: 300,
          width: 350,
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 241, 237, 237).withOpacity(0.40),
              const Color.fromARGB(255, 174, 194, 177).withOpacity(0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.60),
              Colors.white.withOpacity(0.10),
              Colors.purpleAccent.withOpacity(0.05),
              Colors.purpleAccent.withOpacity(0.60),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.39, 0.40, 1.0],
          ),
          blur: 20,
          borderRadius: BorderRadius.circular(24.0),
          borderWidth: 2.0,
          borderColor:const Color.fromARGB(118, 255, 193, 7),
          elevation: 3.0,
          isFrostedGlass: true,
          shadowColor: Colors.purple.withOpacity(0.20),
          child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
)

          ) 
        ),
      ),

Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),

Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),


          Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),
          Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),Container(
       // alignment: Alignment.center,
        decoration:const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/0.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:
      GlassContainer.frostedGlass( height: 300, width: 350,  borderColor:Colors.amber,child:const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遥遥领先中国区"),
                  Text("无限金币MCU掉落芯片"),
                Text("2025年1月17日"),
  ],
))

          ) ),

                      ]),


                    Text(AppConfig.serverInfoText,
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                    Container(
                      width: constraints.maxWidth-50,
                      height: 400,
                      child: TypewriterText(
                        text: AppConfig.promotionText,
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 49, 48, 48),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConfig.excellentText,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 20),
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                        Text(
                          AppConfig.recommendText,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                      ],
                    ),
                    //图片组
                    ImageLayoutPage(
                      width: constraints.maxWidth,
                      

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConfig.latestText,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 20),
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                        Text(
                          AppConfig.publishText,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                      ],
                    ),
                    card1(constraints.maxWidth), card1(constraints.maxWidth),
                    // card1(constraints.maxWidth), card1(constraints.maxWidth),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConfig.stationText,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 20),
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                        Text(
                          AppConfig.selectedText,
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w900,
                              fontSize: 35),
                        ),
                      ],
                    ),

                    Container(
                      height: 500,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.5, 1.0),
                          end: Alignment(0.5, -1.0),
                          colors: [
                            Color.fromARGB(255, 183, 18, 233),
                            const Color(0xFFD41872),
                            const Color(0xFFFF0066),
                          ],
                          stops: [0.0, 0.78, 1.0],
                        ),
                      ),
                      child: ImageSwitchWidget(
                        deviationRatio: deviationRatio,
                        childWidth: 150 * 2,
                        childHeight: 300,
                        children: AppConfig.bannerImages
                            .map((imageUrl) => Image.network(imageUrl))
                            .toList(),
                      ),
                    ),
                    // 移除 Expanded，直接使用 Padding
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            AppConfig.allText,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 20, 20, 20),
                                fontWeight: FontWeight.w900,
                                fontSize: 35),
                          ),
                          Text(
                            AppConfig.serverText,
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontSize: 35),
                          ),
                        ],
                      ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: ResponsiveGrid(),
                    ),
                  ],
                ),
              );
            }))
          ]) ;

  }
   



  Widget _title(int index) {
    return Text(
      (article_list[index]["id"]).toString() +
          "." +
          article_list[index]["biaoti"],
      style: TextStyle(
        color: Color.fromARGB(255, 13, 13, 14),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      softWrap: true,
      overflow: TextOverflow.clip,
      maxLines: 2,
    ); //json_result[index]["id"]
    //Text((article_list[index]["id"]).toString());//整形转字符串toString,字符串到int/double:int.parse('1234')
  }

  Widget _subtitle(int index) {
    return Text(article_list[index]["zhaiyao"]
        .toString()); //substring(0,i)取字符串的前i个字符.substring(i)去掉字符串的前i个字符.
  }

  Widget _riqi(int index) {
    // //print(index);
    // //print(article_list[index]["updated_at"].toString());
    return Text("发布日期:" + article_list[index]["updated_at"].toString());
  }

  Widget _zuozhe(int index) {
    return Text("作者:" + article_list[index]["zuozhe"].toString());
  }

  Widget _id(int index) {
    return Text(article_list[index]["id"]);
  }

  Widget _suo_lue_tu(
    int index,
    double height0,
  ) {
    return Image.network(
      article_list[index]["suoluetu"],
      // height: height0,
      // width: height0 / 0.618,
      fit: BoxFit.fill,
    );
  }

  Widget card1(double width1) {
    final scaleFactor = (width1 / 800).clamp(0.1, 2.0);
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 10, bottom: 100)),
      GestureDetector(
        //添加触摸动作事件onTap
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            // //print("进入");
            // setState(() {//会让界面慢哦.大约1s后鼠标才变成手掌
            //   shadow[0] = 10.0;
            // });
          },
          onExit: (event) {
            // setState(() {
            //   shadow[0] = 15.0;
            //   // //print("刷新了");
            // });
          },
          child: Card(
              color: const Color.fromARGB(255, 233, 230, 230),
              shadowColor: const Color.fromARGB(255, 12, 12, 12), // 阴影颜色
              elevation: shadow[0], // 阴影高度
              borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
              // 边框
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                // side: BorderSide(
                //   color: Color.fromARGB(255, 179, 176, 176),
                //   width: 10,
                // ),
              ),
              child: (width1 < 750.0)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          //执行2种布局
                          Expanded(
                              // flex: 1,
                              child:
                                  //width:width1,
                                  // height: 300.0,

                                  // Wrap(children: [
                                  Wrap(
                                      // direction: Axis.vertical,
                                      // direction: Axis.horizontal,
                                      // spacing: 3.0, // 主轴(水平)方向间距
                                      runSpacing: 140.0, // 纵轴（垂直）方向间距
                                      alignment:
                                          WrapAlignment.center, //水平或者垂直居中
                                      // runAlignment:
                                      //     WrapAlignment.center, //y轴方向的对齐方式
                                      // crossAxisAlignment: WrapCrossAlignment
                                      //     .center, //水平或者垂直居中
                                      // spacing: MediaQuery.of(context)
                                      //             .size
                                      //             .width <
                                      //         800
                                      //     ? 150.0
                                      //     : 50,
                                      spacing: 300, //这个参数不起作用,因为是垂直方向
                                      children: [
                                //  Row( children: [

                                Column(
                                  children: <Widget>[
                                    Container(child: _suo_lue_tu(0, width1)),
                                    Container(child: _title(0)),
                                    Container(
                                        alignment: Alignment.center,
                                        width: 300,
                                        child: _subtitle(0)),
                                    Container(
                                      //width: 50,
                                      // alignment:
                                      //     Alignment.centerRight,
                                      child: _riqi(0),
                                    ),
                                    Container(
                                      //  width: 50,
                                      // alignment:
                                      //     Alignment.centerRight,
                                      child: _zuozhe(0),
                                    )
                                  ],
                                ),
                              ]))
                        ])
                  : Container(
                      color: const Color.fromARGB(255, 0xef, 0xef, 0xef),
                      width: width1 - 30,
                      //height: 400,
                      height: width1 / 3 * 0.618,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Expanded(
                            //       flex: 2,
                            //   child:
                            Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Container(
                                      height: width1 / 3 * 0.618,
                                      //  height: 400,
                                      child: _suo_lue_tu(0, width1)),
                                ]),
                            // ),

                            // IntrinsicWidth(
                            //     //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
                            //     child:
                            Expanded(
                              flex: 3,
                              child: Container(
                                  // height: 10.0,
                                  color:
                                      const Color.fromARGB(255, 244, 243, 243),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //Row(children: [_title(index)],),

                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(
                                                      article_list[0]['id']
                                                              .toString() +
                                                          "." +
                                                          article_list[0]
                                                              ["biaoti"],
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 65, 65, 66),
                                                          fontSize:
                                                              20 * scaleFactor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    )),
                                                  ],
                                                )
                                                // )

                                                ),
                                            Divider(
                                              height: 2,
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    //  color: Colors.red,
                                                    alignment: Alignment.center,
                                                    //  width: 424,
                                                    // height: 100,
                                                    // padding: const EdgeInsets
                                                    //     .only(
                                                    //         top:
                                                    //            5,
                                                    //         left:
                                                    //             20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          article_list[0]
                                                                  ["zhaiyao"]
                                                              .toString(),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff6A6A6A),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ))),
                                            Divider(
                                              height: 2,
                                            ),

                                            Expanded(
                                                flex: 2,
                                                child:

                                                    // Expanded(child:
                                                    Container(
                                                        // height: 15,
                                                        // color: Colors.amber,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              spacing: 30,
                                                              children: [
                                                                Expanded(
                                                                    child: Wrap(
                                                                        alignment:
                                                                            WrapAlignment
                                                                                .center,
                                                                        runAlignment:
                                                                            WrapAlignment
                                                                                .center,
                                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                                        spacing:
                                                                            30,
                                                                        children: [
                                                                      Icon(
                                                                          Icons
                                                                              .remove_red_eye,
                                                                          size:
                                                                              20),
                                                                      Text(
                                                                        article_list[0]["yuedushu"] >
                                                                                99999
                                                                            ? "99999+"
                                                                            : article_list[0]["yuedushu"].toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w200),
                                                                      ),
                                                                      Icon(
                                                                          Icons
                                                                              .thumb_up,
                                                                          size:
                                                                              20),
                                                                      Text(
                                                                          article_list[0]["dianzanshu"]
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w200)),
                                                                    ]))
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              spacing: 30,
                                                              children: [
                                                                Expanded(
                                                                    child: Wrap(
                                                                        alignment:
                                                                            WrapAlignment
                                                                                .center,
                                                                        runAlignment:
                                                                            WrapAlignment
                                                                                .center,
                                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                                        spacing:
                                                                            30,
                                                                        children: [
                                                                      Text(
                                                                          "-----",
                                                                          style: TextStyle(
                                                                              fontSize: 18 * scaleFactor,
                                                                              color: Color(0xff6A6A6A))),
                                                                      Text(
                                                                          article_list[0]["zuozhe"]
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 18 * scaleFactor,
                                                                              color: Color(0xff6A6A6A))),
                                                                      Text(
                                                                          softWrap:
                                                                              true,
                                                                          article_list[0]["updated_at"]
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 20 * scaleFactor,
                                                                              color: Colors.blue[300])),
                                                                    ])),
                                                              ],
                                                            ),

                                                            // Expanded(
                                                            //   flex: 1,
                                                            //   child:
                                                            //       Container(),
                                                            // ),
                                                          ],
                                                        )))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              // ])
                            )
                          ]))),
        ),
        onTap: () {
          //print('haha');
          //执行完成 xiugaiyuedushu()后,执行 Get.Get.to(Article_xiang_qing)语句
          // xiugaiyuedushu().then((value) async {
          //   //value是xiugaiyuedushu()异步函数执行后的返回值.
          //   //print(value);

          //   var result = await Get.Get.toNamed("/article_content", parameters: {
          //     "source": "1", //0为后台文章管理页面的跳转.1为前台,
          //     "typeid": encryptBase64(
          //         article_list[0]["fenleiid"].toString()),
          //     "id": encryptBase64(article_list[0]["id"].toString()),
          //   }); //等同于Get.Get.toNamed("/article_content?typeid=3&id=111111111111111111111 youxue");//这里参数长度90k多,且浏览器url地址显示各个参数.这里的传统用法是传递一个文章id给文章详情页然后详情页获取这个id.如果考虑文章分页应该再传递一个文章分类的typeid进去.                                                          // Get.Get.to(

          //   //此语句会在上一句await跳转后的页面或者类关闭后再执行.这里是文章详情页关闭后,会返回result变量.代码位于文章详情页的appbar中,是  Get.Get.back(result: { "dianzanshu": dianzanshu, });
          //   article_list[0]["dianzanshu"] =
          //       int.parse(result!["dianzanshu"]);
          //   setState(() {});
          // }); //必  须带上参数名,然后是值
        },
      )
    ]);
  }
}

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 计算可用宽度（减去内边距）
        final availableWidth = constraints.maxWidth - 24;

        // 确定列数（每列最小150像素）
        //  int columnCount = (availableWidth / 150).floor();
        // 更清晰的分段列数计算
        int columnCount;
        if (constraints.maxWidth < 500) {
          columnCount = 1;
        } else if (constraints.maxWidth < 800) {
          columnCount = 2;
        } else if (constraints.maxWidth < 1200) {
          columnCount = 3;
        } else {
          columnCount = (availableWidth / 150).floor();
        }
        columnCount = columnCount.clamp(1, 4); // 限制在1-4列之间

        // 计算每列宽度（减去间距）
        final columnWidth =
            (availableWidth - (columnCount - 1) * 12) / columnCount;
        ////print(1);
        return GridView.builder(
          // 新增：根据内容自适应高度（关键修复）
          shrinkWrap: true,
          // 新增：禁用自身滚动（外层 SingleChildScrollView 已处理滚动）
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: columnWidth / (columnWidth * 1.2), // 宽高比
          ),
          itemCount: 20,
          itemBuilder: (context, index) => AnimatedHoverCard(
            index: index,
            maxWidth: columnWidth,
          ),
        );
      },
    );
  }
}

class AnimatedHoverCard extends StatefulWidget {
  final int index;
  final double maxWidth;

  const AnimatedHoverCard({
    Key? key,
    required this.index,
    required this.maxWidth,
  }) : super(key: key);

  @override
  State<AnimatedHoverCard> createState() => _AnimatedHoverCardState();
}

class _AnimatedHoverCardState extends State<AnimatedHoverCard>
    with SingleTickerProviderStateMixin {
  int index = 0;
  double maxWidth = 0;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _shadowColorAnimation;
  late Animation<double> _borderAnimation; // 新增：边框动画
  double gaodu = 1.8;
  bool _isHovered = false;
  List<Offset> _mousePositions = [];
  final int _maxPositions = 10;

  // const ResponsiveCard({
  //   super.key,
  //   required this.index,
  //   required this.maxWidth,
  // });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print("每次缩放页面,不执行initState");

    // 初始化动画控制器，设置动画时长为3秒
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // 修改为3秒
    );

    // 定义图片缩放动画
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.95),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.95, end: 1.0),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // 定义阴影颜色动画
    _shadowColorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 51, 240, 2).withOpacity(0.5),
      end: Colors.blue.withOpacity(0.7),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    // 新增：定义边框动画 - 从0到1表示边框绘制进度
    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut, // 线性弹跳动画
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    index = 0;
    maxWidth = widget.maxWidth;
    // 确保卡片至少有150像素宽
    final effectiveWidth = maxWidth < 150 ? 150.0 : maxWidth;

    // 根据卡片宽度计算缩放比例（以250为基准）
    final scaleFactor = (effectiveWidth / 250).clamp(0.7, 1.3);

    return MouseRegion(
      onEnter: (event) => _onHover(true),
      onExit: (event) => _onHover(false),
      onHover: (event) {
        setState(() {
          _mousePositions.insert(0, event.localPosition);
          if (_mousePositions.length > _maxPositions) {
            _mousePositions.removeLast();
          }
        });
      },
      // cursor: SystemMouseCursors.click,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(10),
                //  width: maxWidth,
                //  height: maxWidth*gaodu,
                constraints: BoxConstraints(
                  minWidth: 122,
                  // maxWidth: maxWidth,
                  maxWidth: maxWidth.clamp(
                      122, double.infinity), // 确保maxWidth不小于minWidth
                  minHeight: 204,
                  //  maxHeight:  maxWidth*gaodu,
                  maxHeight: (maxWidth * gaodu)
                      .clamp(204, double.infinity), // 确保maxHeight不小于minHeight
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: _shadowColorAnimation.value!,
                      blurRadius: 10,
                      offset: const Offset(0, 5), //阴影偏移5
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // 原有卡片内容
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), //卡片的圆角
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // 图片区域
                              Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Transform.scale(
                                      scale: _scaleAnimation.value,
                                      child: IgnorePointer(
                                        ignoring: false, // 允许事件传递
                                        child: GestureDetector(
                                          // 添加 GestureDetector 监听点击事件
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                final screenSize =
                                                    MediaQuery.of(context).size;
                                                return Dialog(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 197, 191, 191),
                                                  insetPadding: EdgeInsets.zero,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop(); // 点击图片外部关闭对话框
                                                    },
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "滚轮可缩放图片,点击图片可关闭!"),
                                                        SizedBox(
                                                          width: screenSize
                                                              .width, // 宽度为屏幕宽度的一半
                                                          height: screenSize
                                                                  .height /
                                                              2, // 高度为屏幕高度的一半
                                                          child:
                                                              InteractiveViewer(
                                                            // 支持缩放和拖动
                                                            child:
                                                                Image.network(
                                                              'https://picsum.photos/id/${index + 100}/600/400',
                                                              fit: BoxFit
                                                                  .contain, //fill会填充但是图片会变形
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child:

                                                // Image.network(
                                                //   widget.imageUrl,
                                                //   fit: BoxFit.cover,
                                                //   alignment: Alignment.center,
                                                // ),
                                                _buildImage(scaleFactor,
                                                    effectiveWidth),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              // 文字描述区域
                              // Expanded(
                              //   flex: 2,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(16.0),
                              //     child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              // Text(
                              //   "这是一个自适应布局示例，当宽度缩小时文字会自动换行显示",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .titleLarge
                              //       ?.copyWith(
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              // ),
                              const SizedBox(height: 8),
                              _buildTextContent(scaleFactor, index),
                              //),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          )),
                    ),
                    // 新增：绘制边框动画
                    if (_isHovered)
                      Positioned(
                          // 调整边框的位置
                          child: IgnorePointer(
                              ignoring: true,
                              child: CustomPaint(
                                size: Size(maxWidth, maxWidth * gaodu),
                                painter: ParticleBorderPainter(
                                  progress: _borderAnimation.value,
                                  colors: [
                                    // 多种颜色混合
                                    Colors.yellow.withOpacity(0.8),
                                    Colors.blue.withOpacity(0.8),
                                    Colors.red.withOpacity(0.8),
                                    Colors.green.withOpacity(0.8),
                                  ],
                                  particleSize: 3.0, // 粒子大小
                                  borderRadius: 12.0, // 与卡片的圆角一致
                                  offset: 5.0, // 边框与卡片的距离
                                  particleCount: 150, // 粒子数量
                                  vsync: this,
                                ),
                              ))),
                  ],
                ),
              );
            },
          ),
          // 绘制鼠标光斑拖尾特效和光晕
          if (_isHovered)
            IgnorePointer(
                ignoring: true,
                child: CustomPaint(
                  size: Size(maxWidth, maxWidth * gaodu),
                  painter: MouseTrailPainter(
                    positions: _mousePositions,
                    colors: [
                      Colors.yellow.withOpacity(0.8),
                      //  Colors.blue.withOpacity(0.8),
                      Colors.red.withOpacity(0.8),
                      // Colors.green.withOpacity(0.8),
                    ],
                    particleSize: 5.0,
                    haloRadius: 30.0, // 可调整光晕半径
                    haloColor: const Color.fromARGB(255, 120, 236, 1)
                        .withOpacity(1), // 可调整光晕颜色
                  ),
                )),
        ],
      ),
    );
  }
  

  Widget _buildImage(double scaleFactor, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Colors.grey[200],
        height: width * 0.65, // 高度基于宽度
        width: double.infinity,
        child: Image.network(
          'https://picsum.photos/id/${index + 100}/600/400',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildTextContent(double scaleFactor, int index) {
    // 根据缩放比例计算字体大小
    final baseFontSize = 14.0 * scaleFactor;

    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '卡片 ${index + 1}',
            style: TextStyle(
              fontSize: baseFontSize * 1.2,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '这是一个自适应布局示例，当宽度缩小时文字会自动换行显示.这是一个自适应布局示例，当宽度缩小时文字会自动换行显示这是一个自适应布局示例，当宽度缩小时文字会自动换行显示',
            style: TextStyle(fontSize: baseFontSize * 0.8),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            '状态：${_getStatus(index)}',
            style: TextStyle(
              fontSize: baseFontSize * 0.9,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _getStatus(int index) {
    final statuses = ['正常', '警告', '完成', '待处理'];
    return statuses[index % statuses.length];
  }

  void _onHover(bool isHovered) {
    if (isHovered != _isHovered) {
      setState(() {
        _isHovered = isHovered;
        if (!isHovered) {
          _mousePositions.clear();
        }
      });

      if (isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }
}

// 自定义绘制类，用于绘制鼠标光斑拖尾特效
class MouseTrailPainter extends CustomPainter {
  final List<Offset> positions;
  final List<Color> colors;
  final double particleSize;
  final double haloRadius; // 新增：光晕半径
  // 使用 Color 构造函数直接创建带有透明度的颜色
  final Color haloColor; // 新增：光晕颜色

  MouseTrailPainter({
    required this.positions,
    required this.colors,
    required this.particleSize,
    this.haloRadius = 20.0, // 默认光晕半径
    // 使用 Color 构造函数直接设置透明度
    this.haloColor = const Color.fromARGB(218, 227, 250, 17), // 默认光晕颜色
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.isNotEmpty) {
      // 绘制鼠标周围的光晕
      final haloPaint = Paint()
        ..color = haloColor
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0); // 模糊效果增强光晕
      canvas.drawCircle(positions.first, haloRadius, haloPaint);
    }

    for (int i = 0; i < positions.length; i++) {
      final opacity = 1.0 - (i / positions.length);
      final color = colors[i % colors.length].withOpacity(opacity);
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.0);

      canvas.drawCircle(positions[i], particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MouseTrailPainter oldDelegate) {
    return oldDelegate.positions != positions ||
        oldDelegate.colors != colors ||
        oldDelegate.haloRadius != haloRadius ||
        oldDelegate.haloColor != haloColor;
  }
}

// 新增：自定义绘制类，用于绘制边框动画
class BorderPainter extends CustomPainter {
  final double progress; // 绘制进度，0.0-1.0
  final Color color;
  final double width;
  final double borderRadius;
  final double offset; // 新增：边框与卡片的距离
  BorderPainter({
    required this.progress,
    required this.color,
    required this.width,
    required this.borderRadius,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      -offset, // 向左偏移
      -offset, // 向上偏移
      size.width + offset * 2, // 宽度增加两倍的偏移量
      size.height + offset * 2, // 高度增加两倍的偏移量
    );
    final roundedRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final path = Path();
    path.addRRect(roundedRect);

    final dashPath = Path();
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      final length = metric.length;
      dashPath.addPath(
        metric.extractPath(0, length * progress),
        Offset.zero,
      );
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant BorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class ParticleBorderPainter extends CustomPainter {
  final double progress; // 绘制进度，0.0-1.0
  final List<Color> colors; // 多种颜色列表
  final double particleSize;
  final double borderRadius;
  final double offset; // 边框与卡片的距离
  final int particleCount; // 粒子数量
  final TickerProvider vsync; // 用于控制闪烁动画

  ParticleBorderPainter({
    required this.progress,
    required this.colors, // 修改为颜色列表
    required this.particleSize,
    required this.borderRadius,
    required this.offset,
    this.particleCount = 100, // 默认粒子数量
    required this.vsync,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      -offset, // 向左偏移
      -offset, // 向上偏移
      size.width + offset * 2, // 宽度增加两倍的偏移量
      size.height + offset * 2, // 高度增加两倍的偏移量
    );
    final roundedRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final path = Path();
    path.addRRect(roundedRect);

    final metrics = path.computeMetrics().toList();
    final totalLength = metrics.fold(0.0, (sum, metric) => sum + metric.length);

    for (int i = 0; i < particleCount; i++) {
      final particleProgress = (i / particleCount) * progress;
      final targetLength = totalLength * particleProgress;

      double currentLength = 0.0;
      for (final metric in metrics) {
        if (currentLength + metric.length >= targetLength) {
          final position = metric
              .getTangentForOffset(targetLength - currentLength)
              ?.position;
          if (position != null) {
            final colorIndex = i % colors.length; // 根据索引选择颜色
            final baseColor = colors[colorIndex];
            // 生成随机闪烁因子
            final random = Random(DateTime.now().millisecondsSinceEpoch + i);
            final blinkFactor =
                (sin(progress * 2 * pi + random.nextDouble() * 2 * pi) + 1) / 2;
            final color = baseColor
                .withOpacity(0.5 + 0.5 * blinkFactor); // 透明度在 0.5 到 1 之间变化
            final paint = Paint()
              ..color = color
              ..style = PaintingStyle.fill
              ..maskFilter =
                  MaskFilter.blur(BlurStyle.normal, 3.0); // 添加模糊效果，模拟荧光
            canvas.drawCircle(position, particleSize, paint);
          }
          break;
        }
        currentLength += metric.length;
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticleBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.colors != colors;
  }
}

class ImageSwitchPage extends StatefulWidget {
  const ImageSwitchPage({Key? key}) : super(key: key);

  @override
  State<ImageSwitchPage> createState() => _ImageSwitchPageState();
}

class _ImageSwitchPageState extends State<ImageSwitchPage> {
  var deviationRatio = 0.8; //轨迹的偏移比例,是轨迹更圆一些,还是更扁一些

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: "3D画廊",

      // ),
      body: Center(
        child: Column(
          // 修改为居中对齐
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(235, 33, 149, 243),
                    Color.fromARGB(255, 2, 128, 255)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ImageSwitchWidget(
                  deviationRatio: deviationRatio,
                  childWidth: 150 * 2,
                  childHeight: 400,
                  children: [
                    //         AnimatedHoverCard(
                    //   imageUrl: 'https://picsum.photos/400/300',
                    //   title: '风景图片',
                    //   description: '这是一张美丽的风景照片，展示了大自然的壮丽景色。',
                    // ),
                    Image.network('https://picsum.photos/400/300'),
                    Image.network('https://picsum.photos/400/300'),
                    Image.network('https://picsum.photos/400/300'),
                    Image.network('https://picsum.photos/400/300'),
                    Image.network('https://picsum.photos/400/300'),
                  ]),
            )),
            Slider(
              value: deviationRatio,
              onChanged: (value) {
                setState(() {
                  deviationRatio = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class ImageSwitchWidget extends StatefulWidget {
  const ImageSwitchWidget({
    Key? key,
    this.children,
    this.childWidth = 80,
    this.childHeight = 80,
    this.deviationRatio = 0.8,
    this.minScale = 0.4,
    this.circleScale = 1,
  }) : super(key: key);

  //所有的子控件
  final List<Widget>? children;

  //每个子控件的宽
  final double childWidth;

  //每个子控件的高
  final double childHeight;

  //偏移X系数  0-1
  final double deviationRatio;

  //最小缩放比 子控件的滑动时最小比例
  final double minScale;

  //圆形缩放系数
  final double circleScale;

  @override
  State<StatefulWidget> createState() => ImageSwitchState();
}

class ImageSwitchState extends State<ImageSwitchWidget>
    with TickerProviderStateMixin {
  //所有子布局的位置信息
  List<Point> childPointList = [];

  //滑动系数
  final slipRatio = 0.5;

  //开始角度
  double startAngle = 0;

  //旋转角度
  double rotateAngle = 0.0;

  //按下时X坐标
  double downX = 0.0;

  //按下时的角度
  double downAngle = 0.0;

  //大小
  late Size size;

  //半径
  double radius = 0.0;

  late AnimationController _controller;
  late Animation<double> animation;

  late double velocityX;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    );

    animation = Tween<double>(begin: 1, end: 0).animate(animation)
      ..addListener(() {
        //当前速度
        var velocity = animation.value * -velocityX;
        var offsetX = radius != 0 ? velocity * 5 / (2 * pi * radius) : velocity;
        rotateAngle += offsetX;
        setState(() => {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///子控件集
  List<Point> _childPointList({Size size = Size.zero}) {
    // size = Size(
    //   max(widget.childWidth, size.width * widget.circleScale),
    //   max(widget.childWidth, size.height * widget.circleScale),
    // );
    // size=Size(size.width,size.height+150);

    childPointList.clear(); //清空之前的数据
    if (widget.children?.isNotEmpty ?? false) {
      //子控件数量
      int count = widget.children?.length ?? 0;
      //平均角度
      double averageAngle = 360 / count;
      //半径
      radius = size.width / 2 - widget.childWidth / 2;
      for (int i = 0; i < count; i++) {
        //当前子控件的角度
        double angle = startAngle + averageAngle * i - rotateAngle;
        //当前子控件的中心点坐标  x=width/2+sin(a)*R   y=height/2+cos(a)*R
        var centerX = size.width / 2 + sin(radian(angle)) * radius;
        var centerY = size.height / 2 +
            cos(radian(angle)) * radius * cos(pi / 2 * widget.deviationRatio);
        var minScale = min(widget.minScale, 0.99);
        var scale = (1 - minScale) / 2 * (1 + cos(radian(angle - startAngle))) +
            minScale;
        //scale=1; //会让图片上扬
        //print(scale);
        //print(widget.childWidth);
        //print(widget.childHeight);
        childPointList.add(Point(
          centerX,
          centerY,
          widget.childWidth * scale,
          widget.childHeight * scale,
          centerX - widget.childWidth * scale / 2,
          centerY - widget.childHeight * scale / 2,
          centerX + widget.childWidth * scale / 2,
          centerY + widget.childHeight * scale / 2,
          scale,
          angle,
          i,
        ));
      }
      childPointList.sort((a, b) {
        return a.scale.compareTo(b.scale);
      });
    }
    return childPointList;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints constraints,
    ) {
      // 使用约束的最大宽度和高度
      size = Size(constraints.maxWidth, constraints.maxHeight);
      //print('size: $size');
      return GestureDetector(
        ///水平滑动按下
        onHorizontalDragDown: (DragDownDetails details) {
          _controller.stop();
        },

        ///水平滑动开始
        onHorizontalDragStart: (DragStartDetails details) {
          //记录拖动开始时当前的选择角度值
          downAngle = rotateAngle;
          //记录拖动开始时的x坐标
          downX = details.globalPosition.dx;
        },

        ///水平滑动中
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          //滑动中X坐标值
          var updateX = details.globalPosition.dx;
          //计算当前旋转角度值并刷新
          rotateAngle = (downX - updateX) * slipRatio + downAngle;
          if (mounted) setState(() {});
        },

        ///水平滑动结束
        onHorizontalDragEnd: (DragEndDetails details) {
          //x方向上每秒速度的像素数
          velocityX = details.velocity.pixelsPerSecond.dx;
          _controller.reset();
          _controller.forward();
        },

        ///滑动取消
        onHorizontalDragCancel: () {},
        behavior: HitTestBehavior.opaque,
        child: CustomPaint(
          size: size,
          child: Stack(
            alignment: Alignment.center,
            children: _childPointList(size: size).map(
              (Point point) {
                return Positioned(
                  width: point.width,
                  left: point.left,
                  top: point.top,
                  child: Transform(
                    transform: Matrix4.rotationY(radian(point.angle)),
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 16,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: widget.children![point.index],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      );
    });
  }

  ///角度转弧度
  double radian(double angle) {
    return angle * pi / 180;
  }
}

///子控件属性对象
class Point {
  Point(this.centerX, this.centerY, this.width, this.height, this.left,
      this.top, this.right, this.bottom, this.scale, this.angle, this.index);

  double centerX;
  double centerY;
  double width;
  double height;
  double left;
  double top;
  double right;
  double bottom;
  double scale;
  double angle;
  int index;
}

class ImageLayoutPage extends StatefulWidget {
  final double width;
  const ImageLayoutPage({super.key, required this.width});
// ImageLayoutPage(this.width,{super.key, });

  @override
  State<ImageLayoutPage> createState() => _ImageLayoutPageState();
}

class _ImageLayoutPageState extends State<ImageLayoutPage> {
  bool _isHovered = false;

  double width1 = 0;
  // 定义高宽比
  static const double aspectRatio = 0.618;

  @override
  void initState() {
    super.initState();
    // _opacity = beginOpacity;
    width1 = widget.width;
    print("width1");
    print(width1);
  }

  // 使用国内图片URL，访问速度更快
  String _getImageUrl() {
    //return 'https://img95.699pic.com/xsj/0t/8v/2h.jpg';
    return 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d';
  }

  // 构建侧边图片
  Widget _buildSideImage(double screenwidth, double width, double height) {
  
return 
//  (constraints.maxWidth>800)? 
   
  screenwidth>800?
  Expanded(
      child:
       Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.network(
          _getImageUrl(),
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
     ),
    ) : 
     Container(
      child:
       Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.network(
          _getImageUrl(),
          width: width,
          height: height,
     
        ),
  
    ));
   
  
   
  }

  // 构建带箭头的走马灯
  Widget _buildCarouselWithArrows(
      BuildContext context, Widget child, ScrollController controller) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            final screenWidth = width1;
            final scrollDistance = screenWidth / 5 + 2.0; // 加上间距
            if (controller.hasClients) {
              controller.animateTo(
                controller.offset - scrollDistance,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        Expanded(child: child),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            final screenWidth = width1;
            final scrollDistance = screenWidth / 5 + 2.0; // 加上间距
            if (controller.hasClients) {
              controller.animateTo(
                controller.offset + scrollDistance,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ],
    );
  }
// void onChanged(bool value) {
//    setState(() {
//      // _opacity = value ? endOpacity : beginOpacity;
//    //   //print(_opacity);
//     });
//  }

  // 构建底部图片
  Widget _buildBottomImage(BuildContext context, int index, double height) {
    // 示例文字 - 可根据实际需求修改内容
    final shortText = "图片标题$index：这是一段可以换行的10个字文字"; // 控制在10字左右
    final longText = "图片详细描述$index：这是鼠标悬浮时显示的20个字完整内容"; // 控制在20字左右

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 图片区域
          Image.network(
            _getImageUrl(),
            width: width1 / 5,
            height: height,
            fit: BoxFit.cover,
          ),
          // 图片顶层文字区域
          MouseRegion(
            onEnter: (event) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (event) {
              setState(() {
                _isHovered = false;
              });
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // 短文本 - 始终显示
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  transform: _isHovered
                      ? Matrix4.translationValues(0, -70, 0)
                      : Matrix4.identity(),
                  child: Container(
                    width: width1 / 5, height: 70,
                    padding: const EdgeInsets.all(4.0),
                    color:
                        const Color.fromARGB(211, 64, 73, 59), // 半透明背景，提高文字可读性
                    child: Text(
                      shortText,
                      maxLines: 2, // 允许最多两行换行
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, // 超出部分显示省略号
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // 长文本 - 鼠标悬浮时显示
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: Container(
                    height: 70,
                    width: width1 / 5,
                    padding: const EdgeInsets.all(4.0),
                    color: const Color.fromARGB(137, 245, 25, 25),
                    child: Text(
                      longText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // 成员变量已添加到State类中
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = width1;
    final mainImageHeight = 400.0; //creenWidth * 0.4; // 根据屏幕宽度动态计算高度
    final mainImageWidth = mainImageHeight / aspectRatio; // 根据高度和比例计算宽度
    const bottomImageCount = 5; // 自定义底部图片数量
    final bottomImagePadding = 4.0 * bottomImageCount; // 总水平padding
    final bottomImageHeight = mainImageHeight;
    final bottomImageWidth = bottomImageHeight / aspectRatio; // 根据高度和比例计算宽度

    // 确保主图片宽度不超过屏幕宽度
    final adjustedMainImageWidth =
        mainImageWidth > screenWidth ? screenWidth : mainImageWidth;
    // 计算侧边可用宽度
    final sideWidth = (screenWidth - adjustedMainImageWidth) / 2;
    // 计算侧边图片宽度
    final sideImageHeight = mainImageHeight / 2 - 4;
    final sideImageWidth =sideWidth /
        24; //sideImageHeight / aspectRatio.clamp(0.0, sideWidth / 12);

    final leftCarouselController = ScrollController();
    final rightCarouselController = ScrollController();

    return LayoutBuilder(builder: (context, constraints) {
            print('constraints.maxWidth1');
             print(constraints.maxWidth);
             
             
                     print('constraints.maxWidth1');
             print(constraints.maxWidth);


                    print("sideImageHeight");
                           print(sideImageHeight);
                                  print("sideImageWidth");
                                         print(sideImageWidth);


              return
              SingleChildScrollView(
        //可不加
        child: Column(
      children: [
        //  上部图片区域
        ConstrainedBox(
          constraints: BoxConstraints(
          minWidth: 0.0, // 最小宽度
maxWidth:  constraints.maxWidth,//double.infinity, // 最大宽度
         maxHeight:  constraints.maxWidth > 800?mainImageHeight:double.infinity,
        // maxHeight:double.infinity,
       // maxHeight:400,
          ), //必须有最大宽度
child: constraints.maxWidth > 800
    ? Row(
        children: [
          // 左侧垂直图片列表 - 占1/3宽度
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(children: [
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight),
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight)
                ]),
                Row(children: [
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight),
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight)
                ]),
              ],
            ),
          ),
          // 中间主图片 - 占1/3宽度
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: mainImageHeight,
                maxWidth: mainImageWidth,
                minHeight: mainImageHeight,
                minWidth: mainImageWidth),
            child: Image.network(
              _getImageUrl(),
              fit: BoxFit.cover,
            ),
          ),
          // 右侧垂直图片列表 - 占1/3宽度
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(children: [
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight),
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight)
                ]),
                Row(children: [
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight),
                  _buildSideImage(constraints.maxWidth ,sideImageWidth, sideImageHeight)
                ]),
              ],
            ),
          ),
        ],
      )
    : Column(
        children: [
          Text("213"),Container(width: 00,height: 00,color: Colors.amber,),
          _buildSideImage(constraints.maxWidth ,400, 400),
      _buildSideImage(constraints.maxWidth ,600, 400),
      _buildSideImage(constraints.maxWidth ,600, 400),
      _buildSideImage(constraints.maxWidth ,600, 400),
          // ConstrainedBox(
          //   constraints: BoxConstraints(
          //       maxHeight: mainImageHeight,
          //       maxWidth: mainImageWidth,
          //       minHeight: mainImageHeight,
          //       minWidth: mainImageWidth),
          //   child: Image.network(
          //     _getImageUrl(),
          //     fit: BoxFit.cover,
          //   ),
          // ),
        _buildSideImage(constraints.maxWidth ,600, 400),   
        _buildSideImage(constraints.maxWidth ,600, 400),
      _buildSideImage(constraints.maxWidth ,600, 400),
      _buildSideImage(constraints.maxWidth ,600, 400),
      _buildSideImage(constraints.maxWidth ,600, 400),
        ],
      ),



        ),
        const SizedBox(height: 10), // 上部图片和底部图片之间的间距
        // 底部水平图片行
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: 300, maxWidth: width1), //必须有最大宽度
          child: _buildCarouselWithArrows(
            context,
            Container(
              height: mainImageHeight,
              child: ListView.builder(
                // 新增：根据内容自适应高度（关键修复）
                shrinkWrap: true,
                // 新增：禁用自身滚动（外层 SingleChildScrollView 已处理滚动）
                physics: const NeverScrollableScrollPhysics(),
                controller: rightCarouselController,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
            itemBuilder: (context, index) => Padding(
  padding: EdgeInsets.symmetric(horizontal: 2.0),
  child: BottomImageWidget(
    index: index,
    height: mainImageHeight - 30,
    width: width1,

    imageUrl: _getImageUrl(),
  ),
),
              ),
            ),
            rightCarouselController,
          ),
        ),
      ],
    ));});
  }
}
// 新增独立的底部图片组件
class BottomImageWidget extends StatefulWidget {
  final int index;
  final double height;
  final double width;

  final String imageUrl;

  const BottomImageWidget({
    super.key,
    required this.index,
    required this.height,
    required this.width,
    required this.imageUrl,
  });

  @override
  State<BottomImageWidget> createState() => _BottomImageWidgetState();
}

class _BottomImageWidgetState extends State<BottomImageWidget> {
  bool _isHovered = false; // 每个实例独立状态

  @override
  Widget build(BuildContext context) {
    final shortText = "图片标题${widget.index}：这是一段可以换行的10个字文字";
    final longText = "图片详细描述${widget.index}：这是鼠标悬浮时显示的20个字完整内容";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            widget.imageUrl,
            width: MediaQuery.of(context).size.width / 5,
            height: widget.height,
            fit: BoxFit.cover,
          ),
          MouseRegion(
            onEnter: (event) => setState(() => _isHovered = true),
            onExit: (event) => setState(() => _isHovered = false),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                transform: _isHovered
                    ? Matrix4.translationValues(0, -70, 0)
                    : Matrix4.identity(),
                child: Container(     width: widget.width / 5, height: 70,

                    padding: const EdgeInsets.all(4.0),
                    color:
                        const Color.fromARGB(211, 64, 73, 59), // 半透明背景，提高文字可读性
                    child: Text(
                      shortText,
                      maxLines: 2, // 允许最多两行换行
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis, // 超出部分显示省略号
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),), // 保持原有样式
              ),
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: Container(height: 70,
                    width:  widget.width / 5,
                    padding: const EdgeInsets.all(4.0),
                    color: const Color.fromARGB(137, 245, 25, 25),
                    child: Text(
                      longText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),), // 保持原有样式
              ),
            ]),
          ),
        ],
      ),
    );
  }
}