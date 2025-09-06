import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart'; //调用弹出吐司框
import 'package:dio/dio.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:flutter_gf_view/widgets/http.dart';
import '/widgets/pagenum.dart';
import 'dart:math' as math;
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/foundation.dart';
// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import '/model1.dart';

import '../../widgets/article_xiang_qing.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart' as Get; //get包和dio包都有此Response类型,防止冲突
import "/common.dart";

List<double> yinying = [];
var article_list = [];

class Article_list extends StatefulWidget {
  //文章列表
  final String lanmu_name;
  final String lanmu_id;
  const Article_list(
      {Key? key, required this.lanmu_name, required this.lanmu_id})
      : super(key: key);

  @override
  _Article_list createState() => _Article_list();
}

class _Article_list extends State<Article_list>
    with AutomaticKeepAliveClientMixin {
  @override
  // late String lanmu1;
  bool get wantKeepAlive => true;
  int data_count = 0;
  var json_result = [];

  ScrollController controller2 = new ScrollController();
  ScrollController controller3 = new ScrollController();
  ScrollController controller4 = new ScrollController();
  var biao_ti;
  int page = 0;
  bool load = true;
  late Response response;
  @override
  void dispose() {
    article_list.clear();
    //dio.dispose();
    super.dispose();
    print("文章管理dispose");
  }

  Widget divider1 = Divider(
      //  color: Colors.blue,
      );
  Widget divider2 = Divider(
      //color: Colors.green
      );

  //构造listtile
  Widget _title(int index) {
    return Text(
      (article_list[index]["id"]).toString() +
          "." +
          article_list[index]["biaoti"],
      style: TextStyle(
        // color: Color.fromARGB(255, 82, 122, 255),
        fontSize: 15,
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
    double width0,
  ) {
    return Image.network(
      article_list[index]["suoluetu"],
      height: width0 * 0.618,
      width: width0,
    );
  }

  Future get_data(int page) async {
    try {
      Dio dio = Dio(); // 使用默认配置

      var options = BaseOptions(
        connectTimeout: Duration(seconds: connectTimeout0),
        receiveTimeout: Duration(seconds: connectTimeout0),
        responseType: ResponseType.json,
        // validateStatus: (status) {
        //   // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        //   return true;
        // },
        //baseUrl: "http://baidu.com/",
      );

      //  print('page:');
      // print(page);
      //response = await dio.get("http://localhost/index/index/api_getdata/",queryParameters: {"page": page});此url地址本地可以 ,部署后会发现localhost无法访问,应该写成域名或者直接/
      response = await dio.get(map0api["据条件获取文章"]!, queryParameters: {
        "Fenleiid": widget.lanmu_id,
        "page": page,
        "token": token
      });
      print(response.data);
      if ((response.data["code"] == "0") & (response.data["data"] != null)) {
        // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
        load = true;
        article_list.insertAll(article_list.length, response.data["data"]);
        yinying = List.filled(article_list.length, 5.0); //填充card组件的阴影默认值为5
        setState(() {});
      } else {
        print('加载到最后');
        load = false;

        //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }

      print("article_list开始1");
    } catch (e) {
      print(e);
    }
  }
//加载更多

  Future _loadMoreData() async {
    print('加载更多');
    await Future.delayed(Duration(seconds: 0), () {
      setState(() {
        //if (page < ((data_count ~/ 10))) {
        //~/除完取整
        page = page + 1;

        // print(article_list);
        get_data(page);

        // get_count();

        // load = true;
        // } else {
        // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
        // print('加载到最后');
        //  }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    print("文章管理initState");
    // lanmu1 = widget.lanmu;
    // get_count();

    get_data(page = 1).then((value) =>  get_zhiding());
   
    //监听滚动事件，打印滚动位置
    controller2.addListener(() {
      var pix = controller2.position.pixels;
      var max = controller2.position.maxScrollExtent;
      // print("pix:${pix}");
      // print("max:${max}");
      if (pix >= max - 300) {
        //已下拉到底部，调用加载更多方法
        if (load) {
          _loadMoreData();
          // load = false;
        }
      }
    });
  }

  List images = [
    // "https://picsum.photos/id/20/370/262.jpg",
  ];
  List<String> titles = [];
   List<int> id = [];
bool isshow=false;
  Future get_zhiding() async {
    dynamic res = await YXHttp().http_get(map0api["据条件获取文章"]!, {
      "page": 1, //1页10条数据.后台做的限制
      "zhiding": 1, //置顶标记
      "token": token,
    });
    print('res');
    print(res);

    for (var element in res) {
      titles.add(element["biaoti"]);
      images.add(element["suoluetu"]);
        id.add(element["id"]);
    }
    setState(() {
  isshow=true;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    print("isshow");    print(isshow);
if(isshow){
    print("文章管理build");
    double width1 = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Icons.navigate_before,
              //     size: 30,
              //     color: Colors.redAccent,
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              Expanded(
                flex: 10,
                child: Container(
                  //height: 30.0,
                  // color: Colors.red,
                  child: Text(
                    '分类--${widget.lanmu_name}',
                    // style: TextStyle(
                    //   color: Color.fromARGB(255, 22, 21, 21),
                    //   fontSize: 15,
                    // ),
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
        body: LayoutBuilder(builder: (context, constraints) {
          double h = constraints.maxHeight;
          return Container(
              color: yemian_beijingse,
              child: ListView(
                  shrinkWrap: true,
                  controller: controller2,
                  children: [
           
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //  Expanded(
                                      //               flex: 2,child:

                                      Container(

                                          //height: 1500,

                                          child: ListView.separated(
                                        shrinkWrap:
                                            true, //可以省略外层的Container容器高度.但是listview会展开内容,不会显示滚动条,
                                        //  controller: controller2,
                                        //physics:  NeverScrollableScrollPhysics(), //禁用滑动事件
                                        itemCount:
                                            article_list.length, //(page+1)*10,
                                        //此处直接给具体数字初始显示时汇报个错: RangeError (index): Index out of range: no indices are valid: 0
                                        //itemCount: 33,   //列表项构造器
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Article_Article_liebiao_click_article(
                                            index: index,
                                            width1: width1 / 3 * 2 -
                                                100, //根据屏幕宽度获取组件的宽度
                                          );
                                        },
                                        //分割器构造器
                                        //下划线widget预定义以供复用。

                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Visibility(
                                              visible: true,
                                              child: Divider(
                                                  color: Color.fromARGB(
                                                      0, 0, 0, 0), //透明色
                                                  thickness: 10.0,
                                                  height: 20.0,
                                                  indent: 0.0,
                                                  endIndent: 0.0));
                                          //index % 2 == 0 ? divider1 : divider2;
                                        },
                                      )),
                                      Pagenum(
                                        total: 150,
                                        page: 10,
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //  Expanded(
                                      //               flex: 2,child:
                                      Container(
                                        // color: Color.fromARGB(255, 255, 255, 255),
                                        child: Text(
                                          "置顶文章",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            shadows: [
                                              Shadow(
                                                  color: Color.fromARGB(
                                                      255, 142, 139, 138),
                                                  blurRadius: 2,
                                                  offset: Offset(3, 3))
                                            ],
                                          ),
                                        ),
                                      ),
                                Container(
                                          //轮播图
                                          height: 300,
                                          width: 500,
                                          child:      Swiper(
                                            //             itemWidth: 600.0,
                                            // itemHeight: 200.0,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return  MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
         },
        onEnter: (event) {
          print("进入");
        
        },
        onExit: (event) {
          
        },
        child: Image.network(
                                                images[index],
                                                fit: BoxFit.fill,
                                               ) );
                                            },
                                            onTap: (index) {
                                              print(index);
                                                print(  id[index]);
    Get.Get.toNamed(
                                                              "/article_content",
                                                              parameters: {
                                                                "source":
                                                                    "1", //0为后台文章管理页面的跳转.1为前台
                                                                "typeid":
                                                                    encryptBase64(
                                                                        "3"),
                                                                "id": encryptBase64(
                                                                    id[index]
                                                                          
                                                                        .toString()),
                                                             
                                                              }); 

                                            },
                                            indicatorLayout:
                                                PageIndicatorLayout.SCALE,
                                            autoplay: false,
                                            itemCount: images.length,
                                            pagination: new SwiperPagination(
                                                margin: new EdgeInsets.all(0.0),
                                                builder:
                                                    new SwiperCustomPagination(
                                                        builder: (BuildContext
                                                                context,
                                                            SwiperPluginConfig
                                                                config) {
                                                  return new ConstrainedBox(
                                                    child: new Container(
                                                        color: Colors.white,
                                                        child: new Text(
                                                          "${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}",
                                                          style: new TextStyle(
                                                              fontSize: 20.0),
                                                        )),
                                                    constraints:
                                                        new BoxConstraints
                                                            .expand(
                                                            height: 50.0),
                                                  );
                                                })),
                                            control: new SwiperControl(
                                              color: Color.fromARGB(
                                                  255, 245, 188, 2),
                                            ),
                                          )),
                                      Container(
                                        // color: Color.fromARGB(255, 255, 255, 255),
                                        child: Text(
                                          "火爆文章",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            shadows: [
                                              Shadow(
                                                  color: Color.fromARGB(
                                                      255, 142, 139, 138),
                                                  blurRadius: 2,
                                                  offset: Offset(3, 3))
                                            ],
                                          ),
                                        ),
                                      ),

                                      Container(
                                          color: Colors.white,
                                          width: 500,
                                          // alignment: Alignment.center,
                                          //   height: 400,
                                          child: Column(
                                              children: List<Widget>.generate(
                                                  article_list.length > 9
                                                      ? 9
                                                      : article_list.length,
                                                  (int i) {
                                            return Row(children: [
                                              Container(
                                                // height: 20,
                                                child: Chip(
                                                  shape: CircleBorder(), //圆形的数字
                                                  backgroundColor: Colors
                                                      .yellowAccent[700], //,
                                                  label: new Text(
                                                    '${i + 1}',
                                                    style: new TextStyle(
                                                        // fontSize: 10,
                                                        // color: Colors.black,
                                                        // backgroundColor: Colors.grey[200]
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  //包裹text的组件,可以使text自动换行.注意的上层需要是row组件
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                    TextButton(
                                                        style: ButtonStyle(
                                                            //设置按钮的文字居中靠左
                                                            alignment: Alignment
                                                                .centerLeft),
                                                        onPressed: () {
                                                          print(
                                                              "article_list[i][id]");
                                                          print(article_list[i]
                                                              ["id"]);

                                                          Get.Get.toNamed(
                                                              "/article_content",
                                                              parameters: {
                                                                "source":
                                                                    "1", //0为后台文章管理页面的跳转.1为前台
                                                                "typeid":
                                                                    encryptBase64(
                                                                        "3"),
                                                                "id": encryptBase64(
                                                                    article_list[i]
                                                                            [
                                                                            "id"]
                                                                        .toString()),
                                                                // "title":
                                                                //    encryptBase64(   article_list[
                                                                //             i][
                                                                //         "biaoti"]),
                                                                // "nei_rong":
                                                                //  encryptBase64( article_list[i][
                                                                //             "neirong"]),

                                                                // "zuo_zhe":
                                                                //      encryptBase64( article_list[
                                                                //             i][
                                                                //         "zuozhe"]),
                                                                // "ri_qi":
                                                                //      encryptBase64( article_list[
                                                                //             i][
                                                                //         "updated_at"]),
                                                                // "dianzanshu":
                                                                //     encryptBase64(  article_list[i]
                                                                //             [
                                                                //             "dianzanshu"]
                                                                //         .toString()),
                                                                // "yuedushu":   encryptBase64(article_list[
                                                                //             i][
                                                                //         "yuedushu"]
                                                                //     .toString()),
                                                              }); //等同于Get.Get.toNamed("/article_content?typeid=3&id=111111111111111111111 youxue");//这里参数长度90k多,且浏览器url地址显示各个参数.这里的传统用法是传递一个文章id给文章详情页然后详情页获取这个id.如果考虑文章分页应该再传递一个文章分类的typeid进去.                                                          // Get.Get.to(
                                                          //     Article_xiang_qing(
                                                          //   //文章详情

                                                          // )); //必须带上参数名,然后是值
                                                        },
                                                        child: Text(
                                                          (article_list[i]
                                                                      ["id"])
                                                                  .toString() +
                                                              "." +
                                                              article_list[i]
                                                                  ["biaoti"],
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    160,
                                                                    160),
                                                            fontSize: 15,
                                                          ),
                                                          softWrap: true,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 1,
                                                        )),
                                                  ])),
                                              // Container(
                                              //   height: 5 * 2,
                                              //   color: Colors.amber,
                                              // ),
                                            ]);
                                          }))),

                                      Container(
                                        // color: Color.fromARGB(255, 143, 155, 156),
                                        child: Text(
                                          "精华文章",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            shadows: [
                                              Shadow(
                                                  color: Color.fromARGB(
                                                      255, 142, 139, 138),
                                                  blurRadius: 2,
                                                  offset: Offset(3, 3))
                                            ],
                                          ),
                                        ),
                                      ),

                                      Container(
                                          alignment: Alignment.center,
                                          height: 800, //constraints.maxHeight,
                                          width: 500,
                                          child: ListView.separated(
                                            controller: controller4,
                                            itemCount: article_list.length > 9
                                                ? 9
                                                : article_list.length,
                                            //此处直接给具体数字初始显示时汇报个错: RangeError (index): Index out of range: no indices are valid: 0
                                            //itemCount: 33,   //列表项构造器
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                //添加触摸动作事件onTap
                                                child: Card(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      if (width1 <
                                                          800.0) //执行2种布局
                                                        Expanded(
                                                            // flex: 1,
                                                            child:
                                                                //width:MediaQuery.of(context).size.width,
                                                                // height: 300.0,

                                                                // Wrap(children: [
                                                                Wrap(
                                                                    // direction: Axis.vertical,
                                                                    // direction: Axis.horizontal,
                                                                    // spacing: 3.0, // 主轴(水平)方向间距
                                                                    runSpacing:
                                                                        140.0, // 纵轴（垂直）方向间距
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .center, //水平或者垂直居中
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
                                                                    spacing:
                                                                        150, //这个参数不起作用,因为是垂直方向
                                                                    children: [
                                                              //  Row( children: [

                                                              Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                      child: _suo_lue_tu(
                                                                          index,
                                                                          50)),
                                                                  Container(
                                                                      child: _title(
                                                                          index)),
                                                                  Container(
                                                                    //width: 50,
                                                                    // alignment:
                                                                    //     Alignment.centerRight,
                                                                    child: _riqi(
                                                                        index),
                                                                  ),
                                                                  Container(
                                                                    //  width: 50,
                                                                    // alignment:
                                                                    //     Alignment.centerRight,
                                                                    child: _zuozhe(
                                                                        index),
                                                                  )
                                                                ],
                                                              ),
                                                              //  Container(
                                                              //  // width: 50,
                                                              //   // alignment:
                                                              //   //     Alignment.center,
                                                              //   child: _riqi(index),
                                                              // ),
                                                              // Container(
                                                              // //  width: 50,
                                                              //   // alignment:
                                                              //   //     Alignment.center,
                                                              //   child: _zuozhe(index),
                                                              // )
                                                              //  ]),
                                                            ])
                                                            // ]),
                                                            )
                                                      else
                                                        //                           LayoutBuilder(builder: (context, constraints) {
                                                        //  print(constraints.maxHeight);
                                                        //     return
                                                        IntrinsicWidth(
                                                            //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
                                                            child: Row(
                                                                //mainAxisSize: MainAxisSize.min,

                                                                children: [
                                                              //  _suo_lue_tu(index),

                                                              Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      _suo_lue_tu(
                                                                          index,
                                                                          100)),
                                                              //  IntrinsicWidth(
                                                              //     //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
                                                              //   child: Row(children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    //Row(children: [_title(index)],),
                                                                    Container(
                                                                        // alignment:
                                                                        //     Alignment
                                                                        //         .center,
                                                                        // width:
                                                                        //     300,
                                                                        child: _title(
                                                                            index)),
                                                                    Container(
                                                                      //width: 50,
                                                                      // alignment:
                                                                      //     Alignment.centerRight,
                                                                      child: _riqi(
                                                                          index),
                                                                    ),
                                                                    Container(
                                                                      //  width: 50,
                                                                      // alignment:
                                                                      //     Alignment.centerRight,
                                                                      child: _zuozhe(
                                                                          index),
                                                                    )
                                                                  ],
                                                                ),
                                                              ) //]
                                                              // )
                                                              // ),
                                                            ]))

                                                      //;})
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  print('haha');
                                                  Get.Get.toNamed(
                                                      "/article_content?typeid=3&id=${article_list[index]["id"]}&source=1");
                                                  // Get.Get.to(Article_xiang_qing(
                                                  //   //文章详情
                                                  //   title: article_list[index]
                                                  //       ["biaoti"],
                                                  //   nei_rong:
                                                  //       article_list[index]
                                                  //           ["neirong"],
                                                  //   //id: article_list[index]["id"],
                                                  //   zuo_zhe: article_list[index]
                                                  //       ["zuozhe"],
                                                  //   ri_qi: article_list[index]
                                                  //       ["updated_at"],
                                                  //   dianzanshu:
                                                  //       article_list[index]
                                                  //           ["dianzanshu"],
                                                  //   yuedushu:
                                                  //       article_list[index]
                                                  //           ["yuedushu"],
                                                  // ) //必须带上参数名,然后是值
                                                  // );
                                                  // Navigator.push(context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) {
                                                  //   return Article_xiang_qing(
                                                  //     //文章详情
                                                  //     title: article_list[index]
                                                  //         ["biaoti"],
                                                  //     nei_rong: article_list[index]
                                                  //         ["neirong"],
                                                  //     //id: article_list[index]["id"],
                                                  //     zuo_zhe: article_list[index]
                                                  //         ["zuozhe"],
                                                  //     ri_qi: article_list[index]
                                                  //         ["riqi"],
                                                  //   ); //必须带上参数名,然后是值
                                                  // }));
                                                },
                                              );
                                            },
                                            //分割器构造器
                                            //下划线widget预定义以供复用。

                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Visibility(
                                                  visible: true,
                                                  child: Divider(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      thickness: 10.0,
                                                      height: 10.0,
                                                      indent: 0.0,
                                                      endIndent: 0.0));
                                              //index % 2 == 0 ? divider1 : divider2;
                                            },
                                          )),
                                    ],
                                  )),
                            ])),
                  ]));
        }));
  }else{return Container(child:Text("数据加载中"));}}
}

//文章列表页点击文章,显示文章详情
class Article_Article_liebiao_click_article extends StatefulWidget {
  int index;
  double width1;
  Article_Article_liebiao_click_article(
      {Key? key, required this.index, required this.width1})
      : super(key: key);

  @override
  _Article_liebiao_click_article createState() =>
      _Article_liebiao_click_article();
}

class _Article_liebiao_click_article
    extends State<Article_Article_liebiao_click_article> {
  int yuedushu = 0;
  Future xiugaiyuedushu() async {
    int num1 = article_list[widget.index]["yuedushu"] + 1;
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
      connectTimeout: Duration(seconds: connectTimeout0),
      receiveTimeout: Duration(seconds: connectTimeout0),
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
      "id": article_list[widget.index]["id"],
      //  "yuedushu": article_list[widget.index]["yuedushu"] + 1,
      "token": token
      // "fenleiid": fenlei_id,
      //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
    });
    var response = await dio.post(
      map0api["更新文章阅读数"]!,
      data: formData1,
      // queryParameters: {"token": token},
      // options: Options(
      //   headers: {
      //     Headers.contentLengthHeader:
      //         img.length, // 设置content-length
      //   }, )
    );
    print("服务器返回数据是:${response.data}");

    if (response.data["code"] == "0") {
      yuedushu = response.data["data"];
      // print(list["id"]);
      print("修改阅读数成功!");
      return yuedushu;
      //show_dialog(context, "更新成功");
    } else {
      print("修改阅读数失败!");
      // show_dialog(context, "更新失败");
    }
    // String s1 = response.data["pic_url"];
    // thumbnail =
    //     host_url + s1.substring(1); //从第2个字符开始截取
    // print(thumbnail);
    // setState(() {});
  }

  //构造listtile
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
    // print(index);
    // print(article_list[index]["updated_at"].toString());
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
      height: height0,
      width: height0 / 0.618,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //添加触摸动作事件onTap
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        // onHover: (event) {
        //   yinying[index] = 10.0;
        //   setState(() {
        //     // print("刷新了");
        //   });
        // },
        onEnter: (event) {
          // print("进入");
          setState(() {
            yinying[widget.index] = 10.0;
          });
        },
        onExit: (event) {
          setState(() {
            yinying[widget.index] = 5.0;
            // print("刷新了");
          });
        },
        child: Card(
            color: const Color.fromARGB(0xff, 0xef, 0xef, 0xef),
            shadowColor: Colors.black, // 阴影颜色
            elevation: yinying[widget.index], // 阴影高度
            borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
            // 边框
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              // side: BorderSide(
              //   color: Color.fromARGB(255, 179, 176, 176),
              //   width: 10,
              // ),
            ),
            child: (widget.width1 < 800.0)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        //执行2种布局
                        Expanded(
                            // flex: 1,
                            child:
                                //width:MediaQuery.of(context).size.width,
                                // height: 300.0,

                                // Wrap(children: [
                                Wrap(
                                    // direction: Axis.vertical,
                                    // direction: Axis.horizontal,
                                    // spacing: 3.0, // 主轴(水平)方向间距
                                    runSpacing: 140.0, // 纵轴（垂直）方向间距
                                    alignment: WrapAlignment.center, //水平或者垂直居中
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
                                    spacing: 150, //这个参数不起作用,因为是垂直方向
                                    children: [
                              //  Row( children: [

                              Column(
                                children: <Widget>[
                                  Container(
                                      child: _suo_lue_tu(widget.index, 300)),
                                  Container(child: _title(widget.index)),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 400,
                                      child: _subtitle(widget.index)),

                                  //  Container(
                                  //     //width: 50,
                                  //     child: ListTile(
                                  //     //报错Another exception was thrown: BoxConstraints forces an infinite width.
                                  //     leading: Transform.rotate(
                                  //       //旋转90度
                                  //       angle: math.pi / 2,
                                  //       child: Icon(
                                  //         Icons.touch_app,
                                  //         size: 30,
                                  //       ),
                                  //     ),
                                  //     title: _title(index),
                                  //     subtitle:
                                  //         _subtitle(index),
                                  //  )),
                                  Container(
                                    //width: 50,
                                    // alignment:
                                    //     Alignment.centerRight,
                                    child: _riqi(widget.index),
                                  ),
                                  Container(
                                    //  width: 50,
                                    // alignment:
                                    //     Alignment.centerRight,
                                    child: _zuozhe(widget.index),
                                  )
                                ],
                              ),
                              //  Container(
                              //  // width: 50,
                              //   // alignment:
                              //   //     Alignment.center,
                              //   child: _riqi(index),
                              // ),
                              // Container(
                              // //  width: 50,
                              //   // alignment:
                              //   //     Alignment.center,
                              //   child: _zuozhe(index),
                              // )
                              //  ]),
                            ])
                            // ]),
                            )
                      ])
                : Container(
                    color: const Color.fromARGB(255, 0xef, 0xef, 0xef),
                    width: widget.width1,
                    height: 300,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Container(

                                    // height: 300.0,
                                    child: _suo_lue_tu(widget.index, 300)),
                              ]),

                          IntrinsicWidth(
                              //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
                              child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //Row(children: [_title(index)],),

                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            width: widget.width1 - 450,
                                            height: 80,
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 20),
                                            child: Column(
                                              children: <Widget>[
                                                //  _title(index)
                                                Text(
                                                  article_list[widget.index]
                                                              ['id']
                                                          .toString() +
                                                      "." +
                                                      article_list[widget.index]
                                                          ["biaoti"],
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 65, 65, 66),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ))),
                                    Divider(
                                      height: 2,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                            //  color: Colors.red,
                                            alignment: Alignment.center,
                                            width: 424,
                                            // height: 100,
                                            // padding: const EdgeInsets
                                            //     .only(
                                            //         top:
                                            //            5,
                                            //         left:
                                            //             20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  article_list[widget.index]
                                                          ["zhaiyao"]
                                                      .toString(),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                      color: Color(0xff6A6A6A),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ))),
                                    Divider(
                                      height: 2,
                                    ),

                                    Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
//  color: Colors.amber,
                                            child: Text("作者:  ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                            margin: EdgeInsets.only(right: 00),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          Expanded(
                                            child: Container(
                                              //  color: Colors.yellow,
                                              child: Text(
                                                  article_list[widget.index]
                                                          ["zuozhe"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          Color(0xff6A6A6A))),
                                              margin:
                                                  EdgeInsets.only(right: 00),
                                              alignment: Alignment.centerRight,
                                            ),
                                          )
                                        ]),

                                    // Expanded(child:
                                    Container(
                                        // height: 15,
                                        // color: Colors.amber,
                                        padding: EdgeInsets.only(bottom: 1),
                                        child: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.end,

                                          children: [
                                            Icon(Icons.remove_red_eye,
                                                size: 20),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                              article_list[widget.index]
                                                          ["yuedushu"] >
                                                      99999
                                                  ? "99999+"
                                                  : article_list[widget.index]
                                                          ["yuedushu"]
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Icon(Icons.thumb_up, size: 20),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                                article_list[widget.index]
                                                            ["dianzanshu"] >
                                                        99999
                                                    ? "99999+"
                                                    : article_list[widget.index]
                                                            ["dianzanshu"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                            Expanded(
                                              flex: 10,
                                              child: Container(
                                                // color: Colors.yellow,
                                                child: Text(
                                                    article_list[widget.index]
                                                            ["updated_at"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.blue[300])),
                                                margin:
                                                    EdgeInsets.only(right: 0),
                                                alignment:
                                                    Alignment.centerRight,
                                              ),
                                            ),
                                          ],
                                        ))
                                    // )
                                  ],
                                ),
                              )
                            ],
                          )),
                          // ])
                        ]))
            // Row(//mainAxisSize: MainAxisSize.min,

            //     children: [

            //   IntrinsicWidth(
            //       //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
            //       child: Row(

            //         children: [
            //     Expanded(flex: 1, child: _suo_lue_tu(widget.index, 300))
            //   ])),
            //   IntrinsicWidth(
            //       //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
            //       child: Row(
            //     children: [
            //       Expanded(
            //         flex: 2,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             //Row(children: [_title(index)],),
            //             Container(
            //                 alignment: Alignment.center,
            //                 width: 400,
            //                 child: _title(widget.index)),
            //             Container(
            //                 alignment: Alignment.center,
            //                 width: 400,
            //                 child: _subtitle(widget.index)),

            //             Container(
            //               //   width: 150,
            //               // alignment:
            //               //     Alignment.centerRight,
            //               child: _riqi(widget.index),
            //             ),
            //             Container(
            //               // width: 150,
            //               // alignment:
            //               //     Alignment.centerRight,
            //               child: _zuozhe(widget.index),
            //             )
            //           ],
            //         ),
            //       )
            //     ],
            //   )),
            // ])

            ),
      ),
      onTap: () {
        // print('haha');
        //执行完成 xiugaiyuedushu()后,执行 Get.Get.to(Article_xiang_qing)语句
        xiugaiyuedushu().then((value) async {
          //value是xiugaiyuedushu()异步函数执行后的返回值.
          print(value);

          var result = await Get.Get.toNamed("/article_content", parameters: {
            "source": "1", //0为后台文章管理页面的跳转.1为前台,
            "typeid": encryptBase64(
                article_list[widget.index]["fenleiid"].toString()),
            "id": encryptBase64(article_list[widget.index]["id"].toString()),
          }); //等同于Get.Get.toNamed("/article_content?typeid=3&id=111111111111111111111 youxue");//这里参数长度90k多,且浏览器url地址显示各个参数.这里的传统用法是传递一个文章id给文章详情页然后详情页获取这个id.如果考虑文章分页应该再传递一个文章分类的typeid进去.                                                          // Get.Get.to(

          // var result = await Get.Get.to(Article_xiang_qing(
          //   //文章详情
          //   title: article_list[widget.index]["biaoti"],
          //   nei_rong: article_list[widget.index]["neirong"],
          //   id: article_list[widget.index]["id"],
          //   zuo_zhe: article_list[widget.index]["zuozhe"],
          //   ri_qi: article_list[widget.index]["updated_at"],
          //   dianzanshu: article_list[widget.index]["dianzanshu"],
          //   yuedushu: yuedushu,
          // ));
          //此语句会在上一句await跳转后的页面或者类关闭后再执行.这里是文章详情页关闭后,会返回result变量.代码位于文章详情页的appbar中,是  Get.Get.back(result: { "dianzanshu": dianzanshu, });
          article_list[widget.index]["dianzanshu"] =
              int.parse(result!["dianzanshu"]);
          setState(() {});
        }); //必  须带上参数名,然后是值
      },
    );
  }
}
