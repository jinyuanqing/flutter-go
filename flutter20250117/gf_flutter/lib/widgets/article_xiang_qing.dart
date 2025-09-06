// import 'package:flutter/foundation.dart'; //引入平台判别
// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:photo_view/photo_view.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
// import 'package:flutter_quill/widgets/controller.dart';
// import 'package:flutter_quill/widgets/editor.dart';
// import 'Zhan_shi.dart';
// import 'dart:math';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_gf_view/widgets/http.dart';
 import '/common.dart';
import '/model1.dart';
import 'package:get/get.dart' as Get;
//编辑器
import 'package:flutter/services.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:visual_editor/visual-editor.dart';
// import '/admin/edtor/const/sample-highlights.const.dart';
// import '/admin/edtor/services/editor.service.dart';
import '/admin/edtor/widgets/demo-scaffold.dart';
// import '/admin/edtor/widgets/loading.dart';
import '../user/fabuzhe/center_user.dart'; //发布者的个人中心

// 文章详情页
// ignore: camel_case_types
class Article_xiang_qing extends StatefulWidget {
  final title;
  final nei_rong;
  final id;
  final zuo_zhe;
  final ri_qi;
  final dianzanshu;
  final yuedushu;
  final typeid;
  final source;
  const Article_xiang_qing(
      {Key? key,
      // @required this.id,
      // @required this.title,
      // @required this.nei_rong,
      // @required this.zuo_zhe,
      // @required this.dianzanshu,
      // @required this.yuedushu,
      // @required this.ri_qi,
this.source,
      this.id,
      this.title,
      this.nei_rong,
      this.zuo_zhe,
      this.dianzanshu,
      this.yuedushu,
      this.ri_qi,
      this.typeid //文章的分类id

      })
      : super(key: key); //注意这是需要参数的类的定义,继承自StatelessWidget

  @override
  State<StatefulWidget> createState() => _Article_xiang_qing();
}

// ignore: camel_case_types
class _Article_xiang_qing extends State<Article_xiang_qing> {
 late StateSetter  _reloadTextSetter;
  //class article_xiang_qing extends StatelessWidget{
  //final title;final nei_rong; final id;final zuo_zhe;final ri_qi;
  // article_xiang_qing({Key key, @required this.title,@required this.nei_rong,@required this.id,@required this.zuo_zhe,@required this.ri_qi}): super(key: key);//注意这是需要参数的类的定义,继承自StatelessWidget
  final FocusNode _focusNode = FocusNode();
  var title, ri_qi, zuo_zhe, nei_rong, id;
  String fabuzhe_qianming = ""; //发布者签名
  var scrollController0 = ScrollController(); //编辑器用
  var _scrollController1 = ScrollController(); //窗口右侧的listview用
  var _scrollController2 = ScrollController(); //窗口右侧的listview用
  var _showBackTop = false;
  int article_num = 0;
  int a1 = 25;
  String dianzanshu = "";
  String yuedushu = "";
  ScrollController _arrowsController = ScrollController();
  double _alignmentY = 0.0;
  //  final _editorService = EditorService();

  EditorController? _controller;

  @override
  void dispose() {
    super.dispose();
  }



  Future get_article(String id,String typeid) async {
 
    FormData formData1 =   FormData.fromMap({
      "token": token,//无token也可以浏览
      "id": id,
        // "typeid": typeid,
    });

  var response = await YXHttp().http_post(map0api["指定条件获取文章"]!, formData1);
      title =  response["res"][0]['biaoti'].toString();  
      nei_rong =
        response["res"][0]['neirong'];
      zuo_zhe = response["res"][0]['zuozhe'];
      dianzanshu =response["res"][0]['dianzanshu'].toString();
      yuedushu =response["res"][0]['yuedushu'].toString();

      ri_qi = response["res"][0]['updated_at'];
      typeid = response["res"][0]['fenleiid'].toString();
 print("${typeid } ,${ri_qi } ${yuedushu } ${dianzanshu } ${zuo_zhe } ${nei_rong } ${title } " );
   
     }

  @override
  void initState() {
    super.initState();
    print("文章详情");
    print(widget.source);print( Get.Get.parameters['source']);
   
    print("token");print(token);
    //如果标题不为空,则执行请求.否则直接跳过api获取标题,内容等

      if (Get.Get.parameters['source'] =="1") {   var id0 = Get.Get.parameters['id'];
    var typeid = Get.Get.parameters['typeid'];
   id = decryptBase64( id0! );
     typeid = decryptBase64( typeid! );
     
      get_article(id,typeid).then((value) =>setState(() {
        _loadDocument(nei_rong); isbuild=true;
      })); 
    
     }else{

 print("nei_rong");
   print(widget.nei_rong);
   
      title = widget.title;
      ri_qi=widget.ri_qi;
      zuo_zhe=widget.zuo_zhe;  _loadDocument(widget.nei_rong); isbuild=true;}

  

    // get_num(zuo_zhe);
    _scrollController1.addListener(() {
      setState(() => _showBackTop = _scrollController1.position.pixels >= 100);
      // print(_scrollController1.position.maxScrollExtent);
      // print(_scrollController1.position.pixels);
      //  print(MediaQuery.of(context).size.height);
      if (_scrollController1.position.pixels >=
          (_scrollController1.position.maxScrollExtent)) //当前滚动条位置=最大滚动距离则
      {
        print("到底部了");

        // _scrollController1.jumpTo(10);
        // print(_scrollController1.position.pixels);
      }

      // _scrollController.position.pixels 获取当前滚动部件滚动的距离
      // 当滚动距离大于 100 之后，显示回到顶部按钮
      // setState(() => _showBackTop = _scrollController.position.pixels >= 100);
    });

    
   
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('滚动组件最大滚动距离:${metrics.maxScrollExtent}');
    print('当前滚动位置:${metrics.pixels}');
    _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    return true;
  }

   void _loadDocument(dynamic neirong)   {
print("test1");
//  nei_rong='''[{"insert":"这是第一个修改得的内容"},{"insert":"\n","attributes":{"header":3}}]''';
    var s =  neirong.replaceAll('\n', '\\n');
    //  final deltaJson = await rootBundle.loadString( widget.nei_rong, );
    final document = DeltaDocM.fromJson(jsonDecode(s));

    setState(() {
      _controller = EditorController(document: document);
    });
  }

  Widget _scaffold({required List<Widget> children}) => DemoScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );

  Widget _editor() =>
      //  Flexible(
      //       child:
      Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: VisualEditor(
          controller: _controller!,
          scrollController: scrollController0,
          focusNode: _focusNode,
          config: EditorConfigM(
            placeholder: 'Enter text',
            readOnly: true,
          ),
        ),
      );
 
  xiugaidianzanshu() async {
    //更新修改文章

    // 或者通过传递一个 `options`来创建dio实例
    BaseOptions options = BaseOptions(
      headers: {
        //  'Content-Type': 'application/json',
        "Accept":
            "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
        // 'Sec-Fetch-Mode': 'navigate',
      },
      // baseUrl: url1,
      connectTimeout:Duration(seconds: connectTimeout0),
      receiveTimeout:Duration(seconds: connectTimeout0),
      //contentType: "application/json", //默认json传输.配合'Content-Type':'application/json',
    );
    Dio dio = Dio(options);
    // dio.options.contentType =
    //     Headers.formUrlEncodedContentType;

    // FormData formData1 = new FormData.fromMap({
    //   // 支持文件数组上传
    //   "file": await MultipartFile.fromFile("/favicon.png",
    //       filename: "1.png"), //是一个流
    // });
    // String sr = '[{"name":"Jack"},{"name1":"Rose"}]';
    //    print("文本:${title_control?.text}");
    FormData formData1 = new FormData.fromMap({
      "id": id,"token": token,
      // "dianzanshu": 0,//不传入任何信息即可.
    });
    var response = await dio.post(
      map0api["更新文章点赞数"]!,
      data: formData1,
      // queryParameters: {"token": token},
      // options: Options(
      //   headers: {
      //     Headers.contentLengthHeader:
      //         img.length, // 设置content-length
      //   }, )
    );
    print("服务器返回数据是:${response.data}");
    if (response.statusCode == 200) {
      if (response.data["code"] == "0") {
        dianzanshu = response.data["data"].toString();
        // print(list["id"]);
        print("修改点赞数成功!");
        // Get.Get.snackbar("结果", "点赞成功");
        setState(() {});
        Get.Get.defaultDialog(
          title: "提示",
          middleText: "点赞成功哦!",
          // confirm: ElevatedButton(
          //     onPressed: () {
          //       // Get.Get.toNamed(
          //       //     "/a"); //跳到后台登录页
          //     },
          //     child: Text("确定")),
          // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
        );
        //show_dialog(context, "更新成功");
      } else {
        // show_dialog(context, "更新失败");
      }
      // String s1 = response.data["pic_url"];
      // thumbnail =
      //     host_url + s1.substring(1); //从第2个字符开始截取
      // print(thumbnail);
      // setState(() {});
    }
  }
bool isbuild=false;
  @override
  Widget build(BuildContext context) {
    print("文章详情页build");
    if(isbuild){  


    
    return Scaffold(
        floatingActionButton: _showBackTop // 当需要显示的时候展示按钮，不需要的时候隐藏，设置 null
            ? FloatingActionButton(
                onPressed: () {
                  // scrollController 通过 animateTo 方法滚动到某个具体高度
                  // duration 表示动画的时长，curve 表示动画的运行方式，flutter 在 Curves 提供了许多方式
                  _scrollController1.animateTo(0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: Icon(Icons.vertical_align_top),
              )
            : null,
        appBar: new AppBar(
          leading: new IconButton(
            tooltip: '返回上一页',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Get.Get.to(wenzhanguanli(), arguments: 1);
              //回传页面值

              // if (is_save == 1) {
              Get.Get.back(result: {
                "dianzanshu": dianzanshu,
              }); //没有时,初始化1次和build执行2次,但是页面加载不到result中的值。

              // }
            },
          ),
          title: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Container(
                  //height: 30.0,
                  // color: Colors.red,
                  child: Text(
                    '标题:$title',
                    style: TextStyle(
                      color: Color.fromARGB(255, 22, 21, 21),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 6,
              //   child: Container(
              //     height: 30.0,
              //     color: Color.fromARGB(255, 230, 235, 230),
              //   ),
              // ),
            ],
          ),
        ),
        body: //Scrollbar
// ScrollConfiguration(//隐藏listview自带的滚动条,使用自定义的滚动条.仿佛只针对一个listview控件
//     behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//     child:
            //   DraggableScrollbar.arrows(//自定义滚动条
            // heightScrollThumb: 96,//滚动条高度
            // alwaysVisibleScrollThumb: true,
            // backgroundColor: Color.fromARGB(255, 3, 193, 241),
            // padding: EdgeInsets.only(right: 4.0),
            // controller: _arrowsController,
            // Expanded(flex: 1,
            //   child:
            // Center(
            //     child:
            ListView(
                //shrinkWrap: true,//解决Listview 无限高度
//  itemCount: 1,
                //外层的cloumn不能有,否则不显示listview
                controller: _scrollController1, //_arrowsController,
                // itemBuilder: (BuildContext context, int index) {
                children: <Widget>[
              Column(children: <Widget>[
                Text("发布日期:${ri_qi}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, //剧中对齐
                  crossAxisAlignment: CrossAxisAlignment.start, //顶部对齐
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            children: [
                                StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                         _reloadTextSetter = setState;
                    return
                              _editor();}),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FloatingActionButton(
                                        onPressed: () {
                                              _reloadTextSetter(() {});
                                          xiugaidianzanshu();
                                        },
                                        child: Icon(Icons.favorite),
                                      ),
                                      Text("赞 $dianzanshu"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FloatingActionButton(
                                        onPressed: () {
                                          //   xiugaidianzanshu();
                                        },
                                        child: Icon(Icons.import_contacts),
                                      ),
                                      Text("阅读 $yuedushu"),
                                    ],
                                  )
                                ],
                              )
                            ],
                          );
                        })),
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 00,
                                    left: 50,
                                    bottom: 50,
                                    right: 10), //边距
                                padding: EdgeInsets.only(
                                  top: 50,
                                  bottom: 50,
                                ),
                                color: Colors.grey[200],
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.tight,
                                              flex: 1,
                                              //  height: 200,
                                              child: Wrap(
                                                alignment: WrapAlignment.center,
                                                children: [
                                                  // Container(
                                                  //   width: 100,
                                                  //   height: 100,
                                                  //   child: // 水平/垂直方向平铺组件
                                                  // Flexible(
                                                  //   // fit: FlexFit.tight,
                                                  //   flex: 2,
                                                  //   // 设置宽度充满父容器
                                                  //   // widthFactor: 1, heightFactor: 1,
                                                  //   // 要设置的水平 / 垂直方向的平铺操作的组件
                                                  //   child:
                                                  CircleAvatar(
                                                    //  child: Text("头像"),
                                                    //头像半径
                                                    radius: 60,
                                                    //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                                                    backgroundImage: NetworkImage(
                                                        'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
                                                  ),
                                                  // ),

                                                  // Flexible(
                                                  //     flex: 2,
                                                  //     fit: FlexFit.tight,
                                                  //     // fit: FlexFit.loose,
                                                  //     // flex: 100,
                                                  //     // 设置宽度充满父容器
                                                  //     // widthFactor: 1, heightFactor: 1,
                                                  //     // 要设置的水平 / 垂直方向的平铺操作的组件
                                                  //     child:

                                                  Container(
                                                      color: Color.fromARGB(
                                                          255, 202, 209, 216),
                                                      width: 300,
                                                      // height: 200,
                                                      child: Column(
                                                          //列中文本可以自动换行
                                                          // mainAxisAlignment: MainAxisAlignment.start,
                                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "发布者:${zuo_zhe}",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            Container(
                                                              // alignment: Alignment.center,
                                                              // width: 200,
                                                              // height: 200,
                                                              child: Text(
                                                                maxLines: 4,
                                                                style: TextStyle(
                                                                    // color: Colors.grey[500],
                                                                    fontSize: 15),
                                                                fabuzhe_qianming,
                                                                softWrap: true,
                                                              ),
                                                            )
                                                          ])),
                                                  // ),

                                                  // Flexible(
                                                  //     flex: 2,
                                                  //     child: ConstrainedBox(
                                                  //         constraints: const BoxConstraints(
                                                  //             // minWidth: 550,
                                                  //             // minHeight: 250,
                                                  //             // maxHeight: 300,
                                                  //             // maxWidth: 550,
                                                  //             ),
                                                  //         child: SizedBox(
                                                  //             // height: 100,
                                                  //             // width: 550,
                                                  //             // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                                                  //             child: ElevatedButton(
                                                  //           child: const Text(
                                                  //             '这一个按钮11',
                                                  //             style: TextStyle(fontSize: 36.0 * 1),
                                                  //           ),
                                                  //           onPressed: () {},
                                                  //         )))),
                                                  // Flexible(
                                                  //     flex: 2,
                                                  //     child: SizedBox(
                                                  //         // height: SizeConfig.blockSizeVertical * 20,
                                                  //         // width: 250,
                                                  //         // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                                                  //         child: ElevatedButton(
                                                  //       child: const Text(
                                                  //         '这一个按钮2',
                                                  //         style: TextStyle(fontSize: 36.0 * 1),
                                                  //       ),
                                                  //       onPressed: () {},
                                                  //     ))),
                                                ],
                                              )),
                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   children: [
                                      Wrap(
                                        spacing: 30.0, // 主轴(水平)方向间距
                                        runSpacing: 10.0, // 纵轴（垂直）方向间距

                                        crossAxisAlignment: WrapCrossAlignment
                                            .center, //可解决不同组件的中心对齐
                                        alignment: WrapAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            icon: Icon(Icons.article),
                                            // style: ButtonStyle(
                                            //     backgroundColor:
                                            //         MaterialStateProperty.all(
                                            //             primary)),
                                            label: Text("文章:${article_num}"),
                                            // color: Colors.black12,
                                            onPressed: () {
                                              // print("跳转");
                                              Get.Get.to(
                                                  Center_user(zuozhe: zuo_zhe));
                                            },
                                          ),
                                          // Container(
                                          //     height: 20,
                                          //     child: VerticalDivider(
                                          //       thickness: 2.0,
                                          //       color: Colors.grey[500],
                                          //      // width: 100,
                                          //     )), //垂//垂直分割线
                                          ElevatedButton.icon(
                                            icon:
                                                Icon(Icons.format_align_center),
                                            // style: ButtonStyle(
                                            //     backgroundColor:
                                            //         MaterialStateProperty.all(
                                            //             primary)),
                                            label: Text("关注他"),
                                            // color: Colors.black12,
                                            onPressed: () {},
                                          ),
                                        ],
                                      )
                                      //   ],
                                      // )
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10,
                                    left: 50,
                                    bottom: 50,
                                    right: 10), //边距
                                padding: EdgeInsets.only(
                                  top: 50,
                                  bottom: 50,
                                ),
                                color: Colors.grey[200],
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                            //可以实现外层row->exp-列->中文字换行
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children:

                                                    // List.generate(20, (index) {
                                                    //   return Text("$index");
                                                    // }),
                                                    [
                                              Text(
                                                "最近发布",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              ListView.builder(
                                                  shrinkWrap:
                                                      true, //解决Listview 无限高度.没有此句不显示列表哦.因为高度没有给定
                                                  controller:
                                                      _scrollController2,
                                                  itemCount:
                                                      15, //给定了数值,就要用shrinkWrap=true
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return TextButton(
                                                        onPressed: () {},
                                                        child:
                                                            Text("文章$index"));
                                                  })
                                            ])),
                                      ]),
                                    ]),
                              ),
                            ])),
                  ],
                ),
              ])
            ])

        // )

        );
  }else
  {

    return Container(child: Text(" "),);
  }
  
  }

  Future<bool> get_num(String zuozhe) async {
    Map<String, dynamic> formData1 = {
      "token": token,
      "Zuozhe": zuo_zhe, //作者
    };

    var num = await YXHttp().http_get(map0api["获取全部文章数量"]!, formData1);

    print("获取作者的获取全部文章数量");

    article_num = num["Num"];

    setState(() {});

    return true;
  }
}
