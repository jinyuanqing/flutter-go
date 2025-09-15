import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart'; //调用弹出吐司框
import 'package:dio/dio.dart';

import 'package:flutter_gf_view/quan_ju.dart';
import '/widgets/persistentHeaderRoute.dart';
import 'dart:math' as math;
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/foundation.dart';
// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import '../../model1.dart';
// import 'package:flutter_gf_view/admin/left_menu/pages/widgets/Zhan_shi.dart';
import '../../widgets/article_xiang_qing.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'article_list.dart';
import 'package:get/get.dart' as Get; //get包和dio包都有此Response类型,防止冲突
import '/model1.dart';
import '/widgets/http.dart';

var _yibu;

class Wenzhangfenlei extends StatefulWidget {
  const Wenzhangfenlei({Key? key}) : super(key: key);

  @override
  _wenzhangfenlei createState() => _wenzhangfenlei();
}

// ignore: non_constant_identifier_names
List<String> list_fenlei = []; //栏目分类

class _wenzhangfenlei extends State<Wenzhangfenlei>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int data_count = 0;
  var json_result = [];
  var article_list = [];
  ScrollController controller1 = new ScrollController();
  var biao_ti;
  int page = 0;
  bool load = true;
  late Response response;

  int fenlei_id = 0;
  @override
  void dispose() {
    super.dispose();
    print("文章管理dispose");
  }

  Widget divider1 = const Divider(
      //  color: Colors.blue,
      );
  Widget divider2 = const Divider(
      //color: Colors.green
      );

  //构造listtile
  Widget _title(int index) {
    return Text(
      (article_list[index]["id"]).toString() +
          "." +
          article_list[index]["biaoti"],
      style: const TextStyle(
        // color: Color.fromARGB(255, 82, 122, 255),
        fontSize: 20,
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    ); //json_result[index]["id"]
    //Text((article_list[index]["id"]).toString());//整形转字符串toString,字符串到int/double:int.parse('1234')
  }

  Widget _subtitle(int index) {
    return Text(article_list[index]["zhaiyao"]
        .toString()); //substring(0,i)取字符串的前i个字符.substring(i)去掉字符串的前i个字符.
  }

  Widget _riqi(int index) {
    return Text("发布日期:" + article_list[index]["riqi"].toString());
  }

  Widget _zuozhe(int index) {
    return Text("作者:" + article_list[index]["zuozhe"].toString());
  }

  Widget _id(int index) {
    return Text(article_list[index]["id"]);
  }

  Widget _suo_lue_tu(
    int index,
    double width0,
  ) {
    return Image.network(
      article_list[index]["suoluetu"],
      height: width0 * 0.618,
      width: width0,
    );
  }

  void get_data(int page2) async {
    page = page2;
    try {
      Dio dio = Dio(); // 使用默认配置

      var options = BaseOptions(
        connectTimeout: Duration(seconds: connectTimeout0),
        receiveTimeout: Duration(seconds: connectTimeout0),
        responseType: ResponseType.json,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        //baseUrl: "http://baidu.com/",
      );

      //  print('page:');
      // print(page);
      //response = await dio.get("http://localhost/index/index/api_getdata/",queryParameters: {"page": page});此url地址本地可以 ,部署后会发现localhost无法访问,应该写成域名或者直接/
      response = await dio.get(map0api["前台获取文章"]!,
          queryParameters: {"page": page, "token": token});
      print(response.data["data"]);
      if (response.data["data"] == null) {
        // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
        print('加载到最后');
        load = false;
      } else {
        article_list.insertAll(
            article_list.length,
            response.data[
                "data"]); //此处response.data不用进行json转换.已经是json的map形式了.直接用json[""]就行
        load = true; //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }

      // print("ffff:${response.data["article"][0]}");
      // json_result = convert.jsonDecode(response.data["article"].toString());
      //   print("json_result:${json_result}");
      //  article_list.addAll(json_result);

      // article_list = response.data["article"];
      print("article_list开始1");
      // print(article_list);

      // print("article_list开始2");
      // print(article_list);

      //   print("article_list结束");
      // return  print(json_result[0]["biao_ti"]);

      setState(() {
        //biao_ti= json_result[0]["biao_ti"];
      });
//      print(response.headers);
//      print(response.request);
//      print(response.statusCode);
      // Dio().get("http://www.baidu.com");
      //  print("baidu请求:");//print(response);
    } catch (e) {
      print(e);
    }
  }
//加载更多

  Future _loadMoreData() async {
    print('加载更多');
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        //if (page < ((data_count ~/ 10))) {
        //~/除完取整
        page = page + 1;

        // print(article_list);
        get_data(page);

        // get_count();

        // } else {
        // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
        // print('加载到最后');
        //  }
      });
    });
  }

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    super.initState();
    print("文章管理initState");

    get_fenlei();
//_yibu =get_article_for_id( );//无需传入参数,使用默认值
// print(1);
// print(article_list);print(1);
    //监听滚动事件，打印滚动位置
    controller1.addListener(() {
      var pix = controller1.position.pixels;
      var max = controller1.position.maxScrollExtent;
      if (pix == max) {
        //已下拉到底部，调用加载更多方法
        if (load) {
          _loadMoreData();
          // load = false;
        }
      }
    });
  }

  List<dynamic> fenlei_name_id = [];
  void get_fenlei() async {
    {
// // 或者通过传递一个 `options`来创建dio实例
      BaseOptions options = BaseOptions(
        // baseUrl: url1,
        connectTimeout: Duration(seconds: connectTimeout0),
        receiveTimeout: Duration(seconds: connectTimeout0),
        contentType:
            "application/json", //默认json传输.配合'Content-Type':'application/json',
      );
      Dio dio = Dio(options);

      var response =
          await dio.get(map0api["获取文章分类"]!, queryParameters: {"token": token});
      print("服务器返回数据是:${response.data}");
      if (response.statusCode == 200) {
        if (response.data["code"] == "0") {
          // print("成功!");
          List<dynamic> res = response.data["data"];

          fenlei_name_id = res;
          // thumbnail = s1;
          //   host_url + s1.substring(1); //从第2个字符开始截取
          print(res);
          for (var i = 0; i < res.length; i++) {
            list_fenlei.add(res[i]["fenlei_name"]);
          }
          setState(() {});
        }
      }
    }
  }

  List<String> titles = ["Flutter Swiper is awosome", "Really nice", "Yeap"];

  MaterialColor _color = Colors.orange;
  @override
  Widget build(BuildContext context) {
    List images = [
      Image.network(
        "https://picsum.photos/id/1/600/500",
        fit: BoxFit.fill,
      ),
      Image.network(
        "https://picsum.photos/id/2/200/300",
        fit: BoxFit.fill,
      ),
      Image.network(
        "https://picsum.photos/id/3/200/300",
        fit: BoxFit.fill,
      )
    ];
    //super.build(context);
    print("文章管理build");
    double width1 = MediaQuery.of(context).size.width;
    return Center(child: LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 1000,
        child: NestedScrollPage(),
      );

//       ListView(children: [

//         Padding(
//             padding: const EdgeInsets.all(0.0),
//             child:
//                 // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 //     Expanded(
//                 // flex: 1,
//                 //      child:
//                 Container(
//                     decoration: const BoxDecoration(
//                       // color: Color.fromARGB(255, 113, 113, 113),
//                       gradient: LinearGradient(
//                           //渐变位置
//                           begin: Alignment.topRight, //右上
//                           end: Alignment.bottomLeft, //左下
//                           stops: [
//                             0.0,
//                             1.0
//                           ], //[渐变起始点, 渐变结束点]
//                           //  //渐变颜色[始点颜色, 结束颜色]
//                           colors: [
//                             Color.fromARGB(255, 66, 246, 147),
//                             Color.fromARGB(255, 113, 178, 243)
//                           ]),

//                       // border: new Border.all(width: 2.0, color: Colors.red),
//                       borderRadius:
//                           BorderRadius.all(Radius.circular(00.0)), //边框圆角
//                       // image: DecorationImage(
//                       //背景图片
//                       // image: AssetImage('images/7.png'),
//                       //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
//                       // centerSlice: Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
//                       // ),
//                     ),
//                     // height:500,//constraints.maxHeight, //- size_appbar,
//                     child:  Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [

//           //             Image.asset(height: 100,width: double.infinity,
//           //   " /images/0.jpg",
//           //   fit: BoxFit.cover,
//           // ),

//                       ],
//                     ))),
//         Row(
//           children: [
//             Expanded(
//                 child: Wrap(
//                     //
//                     alignment: WrapAlignment.center,
//                     runAlignment: WrapAlignment.center,
//                     children:
//                         List<Widget>.generate(list_fenlei.length, (int i) {
//                       return ConstrainedBox(
//                         constraints:
//                             const BoxConstraints(minHeight: 485, minWidth: 750),
//                         child: Container(
//                           width: 750,
//                           //  height: 535,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Card(
//                                 color: const Color(0xFFF7F30B),
//                                 // ignore: sort_child_properties_last
//                                 child: Column(
//                                   children: <Widget>[
//                                     Container(
//                                         padding: const EdgeInsets.only(
//                                             left: 25,
//                                             right: 25,
//                                             top: 25,
//                                             bottom: 15),
//                                         child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Expanded(
//                                                   child:
//                                                    Wrap(
//                                                 //
//                                                 alignment: WrapAlignment.center,
//                                                 runAlignment:
//                                                     WrapAlignment.center,
//                                                 children: [
//                                                   ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               60),
//                                                       child: Image.asset(
//                                                           fit: BoxFit.cover,
//                                                           width: 324,
//                                                           height: 294,
//                                                           "/images/6.jpeg")),
//                                                   Container(
//                                                     width: 350,
//                                                       height: 294, //与图片同高
//                                                       padding: const EdgeInsets.only(
//                                                           top: 10, left: 20),
//                                                       child: Column(
//                                                         children: <Widget>[
//                                                           Container(
//                                                               padding: const EdgeInsets
//                                                                   .only(
//                                                                       left: 20),
//                                                               child: Text(
//                                                                 '${list_fenlei[i]}',
//                                                                 style: const TextStyle(
//                                                                     color: Color(
//                                                                         0xff333333),
//                                                                     fontSize:
//                                                                         36,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500),
//                                                               )),
//                                                           Row(
//                                                             children: [
//                                                               Container(
//                                                                  width: 300,
//                                                                   height: 198,
//                                                                   padding: const EdgeInsets
//                                                                       .only(
//                                                                           top:
//                                                                               10,
//                                                                           left:
//                                                                               20),
//                                                                   child: const Column(
//                                                                     children: <Widget>[
//                                                                       Text(
//                                                                         softWrap:
//                                                                             true,
//                                                                         overflow:
//                                                                             TextOverflow.ellipsis,
//                                                                         maxLines:
//                                                                             8,
//                                                                         '栏目简介:Go 是一个开源的编程语言，它能让构造简单、可靠且高效的软件变得容易.Go是从2007年末由Robert Griesemer, Rob Pike, Ken Thompson主持开发，后来还加入了Ian Lance Taylor, Russ Cox等人，并最终于2009年11月开源，在2012年早些时候发布了Go 1稳定版本。现在Go的开发已经是完全开放的，并且拥有一个活跃的社区.Go 是一个开源的编程语言，它能让构造简单、可靠且高效的软件变得容易.Go是从2007年末由Robert Griesemer, Rob Pike, Ken Thompson主持开发，后来还加入了Ian Lance Taylor, Russ Cox等人，并最终于2009年11月开源，在2012年早些时候发布了Go 1稳定版本。现在Go的开发已经是完全开放的，并且拥有一个活跃的社区',
//                                                                         style: TextStyle(
//                                                                             color: Color(
//                                                                                 0xff6A6A6A),
//                                                                             fontSize:
//                                                                                 15,
//                                                                             fontWeight:
//                                                                                 FontWeight.w500),
//                                                                       ),
//                                                                     ],
//                                                                   ))
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ))
//                                                 ],
//                                               )),
//                                             ])),
//                                     Container(
//                                         padding: const EdgeInsets.only(
//                                           bottom: 0,
//                                         ),
//                                         width: 771,
//                                         height: 193,
//                                         child: Padding(
//                                             // ElevatedButton has default 5 padding on top and bottom
//                                             padding: const EdgeInsets.symmetric(
//                                               vertical: 2,
//                                             ),
//                                             // DecoratedBox contains our linear gradient
//                                             child: DecoratedBox(
//                                                 decoration: const BoxDecoration(
//                                                   gradient:
//                                                       LinearGradient(colors: [
//                                                     Color(0xffF9E320),
//                                                     Color(0xffC5F006),
//                                                   ]),
//                                                   // Round the DecoratedBox to match ElevatedButton
//                                                   borderRadius: BorderRadius.only(
//                                                       bottomRight:
//                                                           Radius.circular(
//                                                               90)), //底部右下角圆角背景
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     // Container(
//                                                     //     padding:
//                                                     //         const EdgeInsets.only(
//                                                     //             left: 10),
//                                                     //     child: ClipOval(
//                                                     //         //圆裁切.
//                                                     //         // borderRadius: BorderRadius.circular(360*2),
//                                                     //         child: Container(
//                                                     //             width: 90,
//                                                     //             height: 90,
//                                                     //             color: const Color(
//                                                     //                 0xffEBEBEB),
//                                                     //             alignment:
//                                                     //                 Alignment
//                                                     //                     .center,
//                                                     //             child: SizedBox(
//                                                     //                 width: 60,
//                                                     //                 height: 60,
//                                                     //                 child: Image.asset(
//                                                     //                     fit: BoxFit.cover,
//                                                     //                     // width: 50,
//                                                     //                     // height: 50,
//                                                     //                     "/images/wenjianjia.png"))))),
//                                                     // ElevatedButton(
//                                                     //   style: ElevatedButton
//                                                     //       .styleFrom(
//                                                     //     // Enables us to see the BoxDecoration behind the ElevatedButton
//                                                     //     backgroundColor:
//                                                     //         Colors.transparent,
//                                                     //     // Fits the Ink in the BoxDecoration
//                                                     //     tapTargetSize:
//                                                     //         MaterialTapTargetSize
//                                                     //             .shrinkWrap,
//                                                     //   ).merge(
//                                                     //     ButtonStyle(
//                                                     //       // Elevation declared here so we can cover onPress elevation
//                                                     //       // Declaring in styleFrom does not allow for MaterialStateProperty
//                                                     //       elevation:
//                                                     //           MaterialStateProperty
//                                                     //               .all(000),
//                                                     //     ),
//                                                     //   ),
//                                                     //   child: const Text(
//                                                     //     '进   入',
//                                                     //     style: TextStyle(
//                                                     //         fontSize: 64,
//                                                     //         fontWeight:
//                                                     //             FontWeight.bold,
//                                                     //         color:
//                                                     //             Colors.black),
//                                                     //   ),
//                                                     //   onPressed: () {

//                                                     //   },
//                                                     // ),

//                                                   Expanded(child:
//   Container(
// // color: Colors.amber,
// //  height:193 ,
// height:double.infinity,//不用设置具体数值,直接沾满父组件高度.
// // alignment: Alignment.center,
//     child:
// //  IntrinsicHeight(  //继承最外层的高度

//         TextButton.icon( style: ButtonStyle(shape:MaterialStateProperty.all<RoundedRectangleBorder>(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(bottomRight:   Radius.circular(
//                                                               90))
//       ),
//     ), ),
//   icon:
//             Image.asset(
//                                                                         fit: BoxFit.cover,
//                                                                         // width: 50,
//                                                                         // height: 50,
//                                                                         "/images/wenjianjia.png"

//   ),
//   onPressed: () {  for (var i1 = 0;
//                                                             i1 <
//                                                                 fenlei_name_id
//                                                                     .length;
//                                                             i1++) {
//                                                           if (list_fenlei[i] ==
//                                                               fenlei_name_id[i1]
//                                                                   [
//                                                                   "fenlei_name"]) {
//                                                             //当选择下拉文本时,获取文本对应的id
//                                                             print(
//                                                                 fenlei_name_id[
//                                                                     i1]["id"]);
//                                                             fenlei_id =
//                                                                 fenlei_name_id[
//                                                                     i1]["id"];
//                                                             break;
//                                                           }
//                                                         }
//                                                         // Get.Get.to(wenzhangzhanshi(
//                                                         //     lanmu: fenlei_id.toString()));//传递分类id
//                                                         Get.Get.to(Article_list(
//                                                           lanmu_name:
//                                                               list_fenlei[i],
//                                                           lanmu_id: fenlei_id
//                                                               .toString(),
//                                                         )); //传递分类id对应的名称
//                                                         },
//   label:
//    Text("进入" , style: TextStyle(
//                                                             fontSize: 64,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color:
//                                                                 Colors.black),),
// )
// // )
// )
// ),

//                                                   ],
//                                                 ))))
//                                   ],
//                                 ),
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(90.0),
//                                       topRight: Radius.zero,
//                                       bottomLeft: Radius.zero,
//                                       bottomRight: Radius.circular(90.0)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );

//                       // Padding(
//                       //     padding: const EdgeInsets.only(
//                       //         bottom: 20, top: 20, left: 20.0, right: 20.0),
//                       //     child: ElevatedButton(
//                       //         onPressed: () {

//                       //         },
//                       //         child: Text(
//                       //           "${list_fenlei[i]}",
//                       //           style: TextStyle(fontSize: 25),
//                       //         ))

//                       //         );
//                     }))),
//           ],
//         )

      // ]);
    }));
  }
}

class Pagenum extends StatefulWidget {
  const Pagenum({Key? key, required this.total, this.page = 10})
      : super(key: key);

  final int total; //总页数
  final int page; //每页的文章数目,默认每页10个文章
  @override
  State<Pagenum> createState() => _Pagenum();
}

class _Pagenum extends State<Pagenum> {
  int _counter = 0;
  // bool is_pressed = false;

  int page = 0;
  bool load = true;

  List<bool> is_pressed = List.filled(9, false); //保存高亮显示的标记
  List<int> a0 = List.filled(9, 0); //保存显示的页码数字,最多显示9个.左右各4个,中间一个,共计9个

  List<int> temp = List.filled(9, 0); //保存初始显示的页码数字
  int current_pagenum = 0; //当前点击的页码
  // @override
  void initState() {
    for (int i = 0; i < a0.length; i++) {
      a0[i] = i + 1; //初始显示的页码数字为1-9
    }
    //print(a0);
  }

  void pagenum(int a) async {
    //点击页码 数字的跳转.
    if ((a >= 1) & (a <= (widget.total / widget.page).ceil())) {
      //传递进来的页码数字范围要>=1,<=总条数/每页的条数(即总页数)
      current_pagenum =
          a; //把传递进来的参数a赋值给当前页码变量current_pagenum,用于确定当前的页码数字,方便上下一页的点击
      // if (a <= ((widget.total / widget.page).ceil()) - 4) {
      temp.fillRange(0, 9, 0); //即将显示的页码数字清零,此处就是一个临时数组,用于存储计算出来的页码
      // }
      is_pressed.fillRange(0, is_pressed.length, false); //选中页码的状态数组清0
      if (a - 4 > 0) {
        //把显示的页码范围放入temp数组中
        if (a <= ((widget.total / widget.page).ceil()) - 4) {
          //显示页码范围数字后5个
          for (int i = 0; i < 9; i++) {
            if (a + i - 4 <= ((widget.total / widget.page).ceil())) {
              temp[i] = a + i - 4;
            } else {
              break;
            }
          }
        } else {
          for (int i = 0; i < 9; i++) {
            //分段处理页码显示1-4
            temp[i] = (widget.total / widget.page).ceil() - 8 + i;
          }
        }

        for (int i = 0; i < a0.length; i++) {
          //当前的选择页码设置高亮标记
          //a0长度9
          a0[i] = temp[i];
          if (a == a0[i]) is_pressed[i] = true; //当前选择的按钮页码数字等于临时数组中的值时,标记为真
        }

        print(temp);
      } else {
        //页码数字<4时为情况2

        for (int i = 0; i < 9; i++) {
          if (i + 1 <= ((widget.total / widget.page).ceil())) {
            //i+1<总的页数时
            temp[i] = i + 1; //直接显示1-9数字
          } else {
            break; //停止循环
          }
        }
        for (int i = 0; i < a0.length; i++) {
          a0[i] = temp[i];
          if (a == a0[i]) is_pressed[i] = true;
        }

        print(temp);
      }
    }

    var json_str = {
      "token": token,
    };

    BaseOptions options1 = BaseOptions(
      // baseUrl: url1,
      connectTimeout: Duration(seconds: connectTimeout0), //嵌套的dio请求这里要给0
      receiveTimeout: Duration(seconds: connectTimeout0),
      contentType: Headers.jsonContentType,
      // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
    );
    Dio dio = Dio(options1);
    var response =
        await dio.get(map0api["退出"]!, queryParameters: json_str); //发送退出请求

    if ((response.statusCode == 200) & (response.data["code"] == "0")) {
      print("退出登陆");
    } else {
      print(response.data);
      print("退出失败");
    }

    setState(() {});
  }

  void pagenum111(int a) {
    //点击页码 数字的跳转.
    if ((a >= 1) & (a <= (widget.total / widget.page).ceil())) {
      //传递进来的页码数字范围要>=1,<=总条数/每页的条数(即总页数)
      current_pagenum =
          a; //把传递进来的参数a赋值给当前页码变量current_pagenum,用于确定当前的页码数字,方便上下一页的点击
      temp.fillRange(0, 9, 0); //即将显示的页码数字清零,此处就是一个临时数组,用于存储计算出来的页码
      is_pressed.fillRange(0, is_pressed.length, false); //选中页码的状态数组清0
      if (a - 4 > 0) {
        //页码数字>4时为情况1
        for (int i = 0; i < 5; i++) {
          //分段处理页码显示1-4
          temp[i] = a - 4 + i;
        }

        for (int i = 5; i < 9; i++) {
          //分段处理页码显示5-9
          if (a + i - 4 <= ((widget.total / widget.page).ceil())) {
            temp[i] = a + i - 4;
          } else {
            break;
          }
        }
        for (int i = 0; i < a0.length; i++) {
          //a0长度9
          a0[i] = temp[i];
          if (a == a0[i]) is_pressed[i] = true; //当前选择的按钮页码数字等于临时数组中的值时,标记为真
        }

        print(temp);
      } else {
        //页码数字<4时为情况2
        //a-4<=0
        for (int i = 0; i < a; i++) {
          temp[i] = i + 1;
        }
        // print(temp);

        for (int i = a; i < 9; i++) {
          if (i + 1 <= ((widget.total / widget.page).ceil())) {
            temp[i] = i + 1;
          } else {
            break;
          }
        }
        for (int i = 0; i < a0.length; i++) {
          a0[i] = temp[i];
          if (a == a0[i]) is_pressed[i] = true;
        }

        print(temp);
      }
    }

    setState(() {});
  }

  /// 處理點擊按鈕背景顏色
  /// 設置當前按鈕為不可點擊時，設置onPressed回調為null。
  MaterialStateProperty<Color> createTextBtnBgColor() {
    return MaterialStateProperty.resolveWith((states) {
      if (is_pressed[0]) {
// If the button is pressed, return green, otherwise blue
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromARGB(255, 19, 103, 180);
        } else if (states.contains(MaterialState.disabled)) {
          return const Color(0x509cf6);
        }
      }
      return const Color.fromARGB(255, 255, 255, 255);

      ///擴展String函數
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building");
    print(is_pressed);
    int pagenum_int = (widget.total / widget.page).ceil();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 1, //heroTag随意给值,能区分即可
              onPressed: () {
                pagenum(current_pagenum - 1);
              },
              child: const Text("上一页")),
          if ((a0[0] <= pagenum_int) & (a0[0] > 0))
            TextButton(
                style: is_pressed[0]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[0]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 138, 138, 138);

                        ///擴展String函數
                      }))
                    : null,
                //1
                onPressed: () {
                  //  is_pressed.fillRange(0, is_pressed.length, false);
                  //  is_pressed[0] = true;
                  pagenum(a0[0]);
                },
                child: Text(
                  a0[0].toString(),
                )),
          if ((a0[1] <= pagenum_int) & (a0[1] > 0))
            TextButton(
                //2
                style: is_pressed[1]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[1]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  //is_pressed.fillRange(0, is_pressed.length, false);
                  // is_pressed[1] = true;
                  pagenum(a0[1]); //is_pressed = true;
                },
                child: Text(
                  a0[1].toString(),
                )),
          if ((a0[2] <= pagenum_int) & (a0[2] > 0))
            TextButton(
                //3
                style: is_pressed[2]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[2]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  //is_pressed.fillRange(0, is_pressed.length, false);
                  // is_pressed[2] = true;
                  pagenum(a0[2]);
                },
                child: Text(
                  a0[2].toString(),
                )),
          if ((a0[3] <= pagenum_int) & (a0[3] > 0))
            TextButton(
                //4
                style: is_pressed[3]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[3]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  //is_pressed.fillRange(0, is_pressed.length, false);
                  // is_pressed[3] = true;
                  pagenum(a0[3]);
                },
                child: Text(
                  a0[3].toString(),
                )),
          if ((a0[4] <= pagenum_int) & (a0[4] > 0))
            TextButton(
                //5
                style: is_pressed[4]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[4]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  // is_pressed.fillRange(0, is_pressed.length, false);
                  //is_pressed[4] = true;
                  pagenum(a0[4]);
                },
                child: Text(
                  a0[4].toString(),
                )),
          if ((a0[5] <= pagenum_int) & (a0[5] > 0))
            TextButton(
                //6
                style: is_pressed[5]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[5]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  //  is_pressed.fillRange(0, is_pressed.length, false);
                  //  is_pressed[5] = true;
                  pagenum(a0[5]);
                },
                child: Text(
                  a0[5].toString(),
                )),
          if ((a0[6] <= pagenum_int) & (a0[6] > 0))
            TextButton(
                //7
                style: is_pressed[6]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[6]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  // is_pressed.fillRange(0, is_pressed.length, false);
                  // is_pressed[6] = true;
                  pagenum(a0[6]);
                },
                child: Text(
                  a0[6].toString(),
                )),
          if ((a0[7] <= pagenum_int) & (a0[7] > 0))
            TextButton(
                //8
                style: is_pressed[7]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[7]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  // is_pressed.fillRange(0, is_pressed.length, false);
                  //  is_pressed[7] = true;
                  pagenum(a0[7]);
                },
                child: Text(
                  a0[7].toString(),
                )),
          if ((a0[8] <= pagenum_int) & (a0[8] > 0))
            TextButton(
                //9
                style: is_pressed[8]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[8]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return const Color(0x509cf6);
                          }
                        }
                        return const Color.fromARGB(255, 86, 76, 233);

                        ///擴展String函數
                      }))
                    : null,
                onPressed: () {
                  // is_pressed.fillRange(0, is_pressed.length, false);
                  //  is_pressed[8] = true;
                  pagenum(a0[8]);
                },
                child: Text(
                  a0[8].toString(),
                )),
          FloatingActionButton(
              heroTag: 2,
              onPressed: () {
                pagenum(current_pagenum + 1);
              },
              child: const Text("下一页")),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NestedScrollPage extends StatefulWidget {
  const NestedScrollPage({super.key});

  @override
  State<NestedScrollPage> createState() => _NestedScrollPageState();
}

class _NestedScrollPageState extends State<NestedScrollPage> {
  final List<String> _tabs = const ['tab1', 'tab2', "tab3", "tab4"];
 late Future<bool>  _yibu; // 修改类型为Future<bool>?
// var _yibu;
  var article_list = []; 

  Future<bool> get_article_for_id({int page = 1, int fenlei_id = 1}) async {
    try{
   
    var res = await YXHttp().http_get(
        map0api["获取文章"]!, {"page": page, "token": token, "fenleiid": fenlei_id});

    article_list = res;
   
  return true;
    }catch (e) {
       print("请求出错: $e"); // 添加错误处理
      print(e);
      return false;
    } 
     
  }

  @override
  void initState() {
    super.initState();
    print("z子组件初始化");
    _yibu = get_article_for_id(); // 保持不变
  }

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false, //不i显示顶部appbar位置左侧的返回按钮.
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildHeader(context, innerBoxIsScrolled),
          ];
        },
        body: _buildTabBarView(),
      ),
    );
  }

  // 头部
  Widget _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return // SliverOverlapAbsorber 的作用是处理重叠滚动效果，
        // 防止 CustomScrollView 中的滚动视图与其他视图重叠。
        SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver:
          // SliverAppBar 的作用是创建可折叠的顶部应用程序栏，
          // 它可以随着滚动而滑动或固定在屏幕顶部，并且可以与其他 Sliver 小部件一起使用。
          SliverAppBar(
        primary: false, titleSpacing: 0,
        // backgroundColor: const Color.fromARGB(0, 212, 226, 255), // 设置 AppBar 的背景颜色为白色
        title: Container(
          color: const Color.fromARGB(0, 51, 47, 47),
          child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Text(
                      "公告:网站永久域名为",
                      style: TextStyle(
                        fontFamily: "Schyler",
                        fontSize: 20,
                        // color: Color.fromARGB(255, 166, 255, 2)
                      ),
                    )),
              ])),
        ),
        automaticallyImplyLeading: false, //浮顶时候,不显示顶部appbar位置左侧的返回按钮.
        pinned: true, //必须为真,否则无法浮顶效果
        elevation: 160, //影深
        expandedHeight: 300.0,
        forceElevated: innerBoxIsScrolled, //为true时展开有阴影
        flexibleSpace: FlexibleSpaceBar(
          // title: null, // 设置标题为空
          //     titlePadding: EdgeInsets.only(left: 0, right: 0), // 设置标题的padding为0

          background: Image.asset(
            "/images/shouye1.png",
            fit: BoxFit.fill,
          ),
        ),

        // 分类列表
        bottom: MyCustomAppBar(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(list_fenlei.length, (int i) {
                    return ActionChip(
                      avatar: CircleAvatar(
                          //   backgroundColor: Colors.blue,
                          child: Icon(font_menu_icon[i])),
                      label: Text(
                        list_fenlei[i],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          // backgroundColor: Colors.grey[200]
                        ),
                      ),
                      onPressed: () async {
                        print(list_fenlei[i]);
                        // 立即跳转到索引为 1 的页面
                        pageController.jumpToPage(i);

// print(i);
  //  article_list=[];
  _yibu=  get_article_for_id(page: 1, fenlei_id: i+1) ;//不必使用setstate(),FutureBuilder组件监控_yibu变化,变化后重新构建组件.
     

                      },
                    );
                  })),
//                PreferredSize(
// preferredSize: Size.fromHeight(40),
// child: Material(
// color: const Color.fromARGB(255, 153, 243, 165), // 设置背景颜色
// child:
              // TabBar(

              //    indicatorColor: Colors.transparent,//指示器设置为透明色
              //  // indicatorColor: Colors.blue, // 指示器颜色

              // labelColor: Colors.black, // 选中标签颜色
              // unselectedLabelColor: Colors.grey, // 未选中标签颜色
              //   tabs:  List<Widget>.generate(list_fenlei.length, (int i) {
              //         return    Chip(
              //                             avatar: CircleAvatar(
              //                              //   backgroundColor: Colors.blue,
              //                                 child:    Icon(
              //                                  font_menu_icon[i]
              //                                   )),
              //                             label:
              //                             Text( list_fenlei[i]),

              //                           );})

              //  )
              // )
              // ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return PageView(
      controller: pageController,
      children:

          // list_fenlei.map((String name) {
          List<Widget>.generate(list_fenlei.length, (int i) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(list_fenlei[i]),
                slivers: <Widget>[
                  // SliverOverlapInjector 的作用是处理重叠滚动效果，
                  // 确保 CustomScrollView 中的滚动视图不会与其他视图重叠。
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),

                  // 横向滚动
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 400,
                      child: PageView(
                        children: [
                          Container(
                            height: 50,
                            color: Colors.yellow,
                            child: const Center(child: Text('横向滚动')),
                          ),
                          Container(color: Colors.green),
                          Container(color: Colors.blue),
                          SizedBox(
                              width: 100,
                              height: 10,
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.transparent;
                                    },
                                  ),
                                ),
                                child: const Text(
                                  '保存',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                  print(1);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),

                  // 固定高度内容
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      color: Colors.greenAccent,
                      child: Center(child: Text(list_fenlei[i])),
                    ),
                  ),

                  // 列表
                  buildContent(list_fenlei[i]),

                  FutureBuilder<bool>(
                      //异步加载dio数据
                      future:
                          _yibu, // fan防止每次Widget刷新future:fetchData()就会重新获取数据
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                         print("snapshot.data");
                         print(snapshot.data);
                         print(article_list.length);
                        if (snapshot.data == true) {
                          return
                              // 列表 100 行
                              SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                print(index);
                                return ListTile(
                                    title: Text(
                                        "${article_list[index]['biaoti']}"));
                              },
                              childCount: article_list.length,
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                            child: Container(
                              height: 100,
                              color: Colors.white,
                              child: const Center(child: Text('加载中...')),
                            ),
                          );
                        }
                      }),
                ],
              );
            },
          ),
        );
      }).toList(),
    );
  }

  // 内容列表
  Widget buildContent(String name) => SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverFixedExtentList(
          itemExtent: 48.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('$name - $index'),
              );
            },
            childCount: 10,
          ),
        ),
      );
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  const MyCustomAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight + 0);//此处0可以调整浮顶组件的高度.kToolbarHeight=56;

  Size get preferredSize =>
      const Size.fromHeight(32); //此处0可以调整浮顶组件的高度.kToolbarHeight=56;
}