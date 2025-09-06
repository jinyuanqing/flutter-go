import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart'; //调用弹出吐司框
import 'package:dio/dio.dart';
import 'package:flutter_gf_view/admin/middle_tab.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:flutter_gf_view/widgets/http.dart';
import 'package:provider/provider.dart';
import '/widgets/pagenum.dart';
import 'dart:math' as math;
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/foundation.dart';
// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import '/model1.dart';

import '../../widgets/article_xiang_qing.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart' as Get; //get包和dio包都有此Response类型,防止冲突
import '/widgets/http.dart';

List<double> yinying = [];
var article_list = [];

class Center_user extends StatefulWidget {
  //发布者的文章列表
  final String zuozhe;

  const Center_user({
    Key? key,
    required this.zuozhe,
  }) : super(key: key);

  @override
  _Center_user createState() => _Center_user();
}

class _Center_user extends State<Center_user>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
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

  @override
  void dispose() {
    article_list.clear();
    super.dispose();
    tabController2.dispose();
    print("个人中心dispose");
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

  Future<bool> get_data(int fenlei_id, int page) async {
    await Future.delayed(Duration(seconds: 0), () async {
      var response;
      //  print('page:');
      // print(page);
      //response = await dio.get("http://localhost/index/index/api_getdata/",queryParameters: {"page": page});此url地址本地可以 ,部署后会发现localhost无法访问,应该写成域名或者直接/
      response = await YXHttp().http_post(map0api["指定条件获取文章"]!, {
        "Fenleiid": fenlei_id,
        "Zuozhe": widget.zuozhe,
        "page": page,
        "token": token
      });
      // print(response.data);

      if ((response["num"] != 0)) {
        // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
        load = true;

        article_list.insertAll(article_list.length, response["res"]);
        yinying = List.filled(article_list.length, 5.0); //填充card组件的阴影默认值为5
        print('获取的数据个数是${article_list.length}');
        //  tabController2 = TabController(length: tabsname_admin.length, vsync: this); //初始化1

        setState(() {});
        // return true;
      } else {
        print('获取的数据个数是0');
        load = false;
        //return false;
        //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }

      // print("article_list开始1");
    });
    return true;
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
        get_data(1, page);

        // get_count();

        // load = true;
        // } else {
        // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
        // print('加载到最后');
        //  }
      });
    });
  }

  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  double _pos = 0.0, _end = 0.0;
  var key;
  bool refresh = false;
  late TabController tabController2; //=
  //TabController(length: tabsname_admin.length, vsync: this); //需要定义一个Controller
  List<String> tabsname_admin = []; //["1", "2", "3", "4", "5", "6"];
  var _yibu;
  var _yibu1;
  String nickname = "";
  String qianming = "";
  String sex = "";
  String email = "";
  String create_at = "";
  String touxiang = "";

  String address = "";

  @override
  void initState() {
    super.initState();
    print("发布者的个人中心initState");
    _yibu1 = get_fenlei();
    getuserinfo(widget.zuozhe);
    tabController2 = TabController(length: tabsname_admin.length, vsync: this); //初始化1

    // get_fenlei().then((value) {
    //   setState(() {});
    //   tabController2 = TabController(length: value.length, vsync: this); //初始化1
    // });
    // tabController2 = TabController(
    //     length: tabsname_admin.length,
    //     vsync:
    //         this); //初始化2.否则报错Another exception was thrown: LateInitializationError: Field 'tabController2' has not been initialized
    article_list = [];
    _yibu = get_data(1, 1);
    _scrollController = new ScrollController();

    _scrollController1 = new ScrollController();
    //监听滚动事件，打印滚动位置
    // controller2.addListener(() {
    //   var pix = controller2.position.pixels;
    //   var max = controller2.position.maxScrollExtent;
    //   // print("pix:${pix}");
    //   // print("max:${max}");
    //   if (pix >= max - 300) {
    //     //已下拉到底部，调用加载更多方法
    //     if (load) {
    //       _loadMoreData();
    //       // load = false;
    //     }
    //   }
    // });
  }

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
  List<String> titles = ["Flutter Swiper is awosome", "Really nice", "Yeap"];

  getuserinfo(String zuozhe) async {
    FormData formData1 = new FormData.fromMap({
      "token": token,
      "nickname": widget.zuozhe,
    });

    var response = await YXHttp().http_post(map0api["根据用户名获取用户信息"]!, formData1);
    print(response);
    nickname = (response[0]["username"]);
    qianming = (response[0]["qianming"]);
    sex = (response[0]["sex"]);
    nickname = (response[0]["nickname"]);
    email = (response[0]["email"]);
    create_at = (response[0]["create_at"]); //创建时间
    touxiang = (response[0]["touxiang"]);
    address = (response[0]["address"]);
    print(nickname);
    print(qianming);
    print(sex);
    setState(() {});
  }

  Future<bool> get_fenlei() async {
    {
// // 或者通过传递一个 `options`来创建dio实例
      BaseOptions options = BaseOptions(
        // baseUrl: url1,
        connectTimeout:Duration(seconds: connectTimeout0),
        receiveTimeout:Duration(seconds: connectTimeout0),
        contentType:
            "application/json", //默认json传输.配合'Content-Type':'application/json',
      );
      Dio dio = Dio(options);

      var response =
          await dio.get(map0api["获取文章分类"]!, queryParameters: {"token": token});
      // print("服务器返回数据是:${response.data}");

      if (response.data["code"] == "0") {
        print("获取文章分类");
        // print(response);
        List<dynamic> res = response.data["data"];

        // thumbnail = s1;
        //   host_url + s1.substring(1); //从第2个字符开始截取
        article_fenlei_name_id = res;
        for (var i = 0; i < res.length; i++) {
          tabsname_admin.add(res[i]["fenlei_name"]);
        }
        tabController2 = TabController(length: tabsname_admin.length, vsync: this); //初始化1

        // tabController2 = TabController(length: tabsname_admin.length, vsync: this);
        // print(tabsname_admin);
        // setState(() {});
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    print("个人中心build");
    double width1 = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            tooltip: '返回上一页',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.Get.back();
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
                    '个人中心',
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
        body: LayoutBuilder(builder: (context, constraints) {
          double h = constraints.maxHeight;
          return Center(
              child: Column(
            children: [
              Container(
                  height: h,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              //key: UniqueKey(),
                                              color: Color.fromARGB(
                                                  255, 202, 201, 201),
                                              padding: EdgeInsets.all(10),
                                              width: constraints.maxWidth /
                                                  1, ////有2个宽度..此位置的为宽度1.Scrollbar外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                                              // height: MediaQuery.of(context).size.height - 200,

                                              child: GestureDetector(
                                                  child: Scrollbar(
                                                      //外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                                                      scrollbarOrientation:
                                                          ScrollbarOrientation
                                                              .top, //滚动条的显示方位
                                                    //  isAlwaysShown: false,
                                                      thickness:
                                                          0, //滚动条的高度0,就是隐藏了滚动条哦
                                                      controller:
                                                          _scrollController,
                                                      child:
                                                          SingleChildScrollView(
                                                        // reverse:false,
                                                        scrollDirection: Axis
                                                            .horizontal, //水平滚动
                                                        controller:
                                                            _scrollController,
                                                        child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            height: 30,
                                                            width: constraints
                                                                    .maxWidth /
                                                                1, //有2个宽度..此位置的为宽度2.Scrollbar外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                                                            child: FutureBuilder<
                                                                    bool>(
                                                                //因为外层有组件,因此这里设置key无法起到setstate刷新的作用.
                                                                //异步加载dio数据
                                                                future: _yibu1,
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            bool>
                                                                        snapshot) {
                                                                  print(
                                                                      "snapshot.data");
                                                                  print(snapshot
                                                                      .data);

                                                                  if (snapshot
                                                                          .data ==
                                                                      true) {
                                                                    return TabBar(
                                                                      //生成Tab菜单
                                                                      controller:
                                                                          tabController2,
                                                                      tabs: tabsname_admin
                                                                          .map((e) =>
                                                                              Tab(text: e))
                                                                          .toList(),
                                                                      onTap:
                                                                          (value) async {
                                                                        // print(value);
                                                                        // print(
                                                                        //     tabsname_admin[value]);

                                                                        //根据给定的文章分类名,获取文章分类id
                                                                        int article_fenlei_id =
                                                                            0;
                                                                        for (var i1 =
                                                                                0;
                                                                            i1 <
                                                                                article_fenlei_name_id.length;
                                                                            i1++) {
                                                                          //当给定tabsname_admin[value]文本=从库中获取的article_fenlei_name_id[ i1]["fenlei_name"]分类名时,获取文本对应的id
                                                                          if (tabsname_admin[value] ==
                                                                              article_fenlei_name_id[i1]["fenlei_name"]) {
                                                                            // print(
                                                                            //     "文章分类id:");
                                                                            // print(article_fenlei_name_id[
                                                                            //         i1]
                                                                            //     ["id"]);
                                                                            article_fenlei_id =
                                                                                article_fenlei_name_id[i1]["id"];
                                                                            break;
                                                                          }
                                                                        }
                                                                        print(
                                                                            article_fenlei_id); //文章分类id
                                                                        article_list =
                                                                            [];
                                                                        // setState(() {});
                                                                        //   yinying = [];
                                                                        refresh =
                                                                            true; //刷新futurebuilder外层组件的key
                                                                        get_data(
                                                                            article_fenlei_id,
                                                                            page);
                                                                      },
                                                                      isScrollable:
                                                                          true,
                                                                      labelColor:
                                                                          Colors
                                                                              .white, //选中的颜色
                                                                      indicatorColor: Color.fromARGB(
                                                                          255,
                                                                          233,
                                                                          78,
                                                                          78), //指示器颜色,下划线色
                                                                      unselectedLabelColor: Color.fromARGB(
                                                                          255,
                                                                          48,
                                                                          48,
                                                                          48), //未选中颜色
                                                                      unselectedLabelStyle:
                                                                          new TextStyle(
                                                                        //未选中的颜色
                                                                        fontSize:
                                                                            17,
                                                                        //color: Colors.white,//与属性一致unselectedLabelColor
                                                                        //  backgroundColor: Colors.grey[200]
                                                                      ),
                                                                      labelStyle:
                                                                          new TextStyle(
                                                                        //选中的颜色
                                                                        fontSize:
                                                                            18,
                                                                        //color: Colors.white,//与属性一致unselectedLabelColor
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            241,
                                                                            8,
                                                                            8),
                                                                      ),
                                                                      // indicatorSize:TabBarIndicatorSize.tab,
                                                                    );
                                                                  } else
                                                                    return Text(
                                                                        "12");
                                                                })),
                                                      )),
                                                  //手指按下时会触发此回调
                                                  onPanDown:
                                                      (DragDownDetails e) {
                                                    //打印手指按下的位置(相对于屏幕)
                                                    // print(
                                                    //     "用户手指按下：${e.globalPosition}");
                                                  },
                                                  //手指滑动时会触发此回调
                                                  onPanUpdate:
                                                      (DragUpdateDetails e) {
                                                    //用户手指滑动时，更新偏移，重新构建
                                                    // print("e");
                                                    // print(e);
                                                    refresh =
                                                        false; //不刷新futurebuilder外层组件的key
                                                    setState(() {
                                                      _pos += e.delta.dx;
                                                      if (_pos < 0) _pos = 0;
                                                      if (_pos >
                                                          _scrollController
                                                              .position
                                                              .maxScrollExtent) //pos的位置>控制器的最大滚动距离.控制器的最小滚动距离为0
                                                        _pos = _scrollController
                                                            .position
                                                            .maxScrollExtent;
                                                      _end += e.delta.dy;
                                                      // print(_scrollController.position.maxScrollExtent);
                                                      //   print(_scrollController.position.minScrollExtent);//
                                                      print("_pos");
                                                      print(_pos);
                                                      _scrollController
                                                          .jumpTo(_pos);
                                                    });
                                                  },
                                                  onPanEnd: (DragEndDetails e) {
                                                    //打印滑动结束时在x、y轴上的速度
                                                    // print(e.velocity);
                                                    // _left = 0;
                                                  })),
                                          Container(
                                              key: key = refresh == true
                                                  ? UniqueKey()
                                                  : ValueKey(
                                                      "1"), //强制setstate刷新组件.偶尔发现有时候,其中的futurebuilder的listview不刷新.因此FutureBuilder所在的最外层组件使用  key: UniqueKey(),来刷新外层的组件,进而刷新listviews
                                              height: 555,
                                              //width: 555,
                                              child: TabBarView(
                                                  controller: tabController2,
                                                  children:
                                                      List<Widget>.generate(
                                                          tabsname_admin.length, (int i) {
                                                    return FutureBuilder<bool>(
                                                        //因为外层有组件,因此这里设置key无法起到setstate刷新的作用.
                                                        //异步加载dio数据
                                                        future: _yibu,
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                          print(
                                                              "snapshot.data");
                                                          print(snapshot.data);

                                                          if (snapshot.data ==
                                                              true) {
                                                            print(
                                                                "article_list.length1");
                                                            print(article_list
                                                                .length);
                                                            return ListView
                                                                .separated(
                                                              shrinkWrap:
                                                                  true, //可以省略外层的Container容器高度.但是listview会展开内容,不会显示滚动条,
                                                              //  controller: controller2,
                                                              //physics:  NeverScrollableScrollPhysics(), //禁用滑动事件
                                                              itemCount:
                                                                  article_list
                                                                      .length, //(page+1)*10,
                                                              //此处直接给具体数字初始显示时汇报个错: RangeError (index): Index out of range: no indices are valid: 0
                                                              //itemCount: 33,   //列表项构造器
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                print(
                                                                    "article_list.length2");
                                                                print(
                                                                    article_list
                                                                        .length);
                                                                print("index");
                                                                print(index);
                                                                // if (article_list
                                                                //         .length >
                                                                //     0)
                                                                return Article_xiangqing_usercenter(
                                                                  index: index,
                                                                  width1:
                                                                      width1,
                                                                );
                                                                // else
                                                                //   return Text(
                                                                //       "数据加载中");
                                                              },
                                                              //分割器构造器
                                                              //下划线widget预定义以供复用。

                                                              separatorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Visibility(
                                                                    visible:
                                                                        true,
                                                                    child: Divider(
                                                                        color: Color.fromARGB(0, 0, 0, 0), //透明色
                                                                        thickness: 10.0,
                                                                        height: 20.0,
                                                                        indent: 0.0,
                                                                        endIndent: 0.0));
                                                                //index % 2 == 0 ? divider1 : divider2;
                                                              },
                                                            );
                                                          } else {
                                                            return const Text(
                                                                '数据加载中!');
                                                          }
                                                          // } else {
                                                          //   return const Text(
                                                          //       '数据加载中!');
                                                          // }
                                                        });
                                                  })))
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          //  Expanded(
                                          //               flex: 2,child:
                                          Container(
                                            // color: Color.fromARGB(255, 255, 255, 255),
                                            child: Text(
                                              "个人资料",
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
                                            // color: primary,
                                            color: Color.fromARGB(
                                                255, 44, 186, 246),
                                            width: 500,
                                            //alignment: Alignment.topLeft,
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircleAvatar(
                                                          //  child: Text("头像"),
                                                          //头像半径
                                                          radius: 60,
                                                          //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  touxiang),
                                                        ),
                                                        Text(
                                                          "${nickname}",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${sex}",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          //width: 200,
                                                          // height: 200,
                                                          child: Text(
                                                            maxLines: 4,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[500],
                                                                fontSize: 15),
                                                            "${qianming}",
                                                            softWrap: true,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${create_at}",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${address}",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${email}",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ]),
                                                ]),
                                          ),
                                          // Container(
                                          //   // color: primary,
                                          //   color: Color.fromARGB(
                                          //       255, 44, 186, 246),
                                          //   width: 500,
                                          //   //alignment: Alignment.topLeft,
                                          //   padding: EdgeInsets.all(10.0),
                                          //   child: Column(
                                          //       mainAxisAlignment:
                                          //       MainAxisAlignment
                                          //           .spaceEvenly,
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //       children: [
                                          //         Column(
                                          //             mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .center,
                                          //             crossAxisAlignment:
                                          //             CrossAxisAlignment
                                          //                 .center,
                                          //             children: [
                                          //               CircleAvatar(
                                          //                 //  child: Text("头像"),
                                          //                 //头像半径
                                          //                 radius: 60,
                                          //                 //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                                          //                 backgroundImage:
                                          //                 NetworkImage(
                                          //                     touxiang),
                                          //               ),
                                          //               Text(
                                          //                 "${context.watch<Model1>().nickname}",
                                          //                 style: TextStyle(
                                          //                   fontSize: 20,
                                          //                   fontWeight:
                                          //                   FontWeight.bold,
                                          //                 ),
                                          //               ),
                                          //               Container(
                                          //                 alignment:
                                          //                 Alignment.center,
                                          //                 //width: 200,
                                          //                 // height: 200,
                                          //                 child: Text(
                                          //                   maxLines: 4,
                                          //                   style: TextStyle(
                                          //                       color: Colors
                                          //                           .grey[500],
                                          //                       fontSize: 15),
                                          //                   "${context.watch<Model1>().qianming}",
                                          //                   softWrap: true,
                                          //                 ),
                                          //               ),
                                          //             ]),
                                          //       ]),
                                          // ),

                                          Container(
                                            // color: Color.fromARGB(255, 255, 255, 255),
                                            child: Text(
                                              "最新文章",
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
                                                  children:
                                                      List<Widget>.generate(
                                                          article_list.length >
                                                                  9
                                                              ? 9
                                                              : article_list
                                                                  .length,
                                                          (int i) {
                                                return Row(children: [
                                                  Container(
                                                    // height: 20,
                                                    child: Chip(
                                                      shape:
                                                          CircleBorder(), //圆形的数字
                                                      backgroundColor:
                                                          Colors.yellowAccent[
                                                              700], //,
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
                                                              // print(i);

                                                              Get.Get.to(
                                                                  Article_xiang_qing(
                                                                //文章详情
                                                                title:
                                                                    article_list[
                                                                            i][
                                                                        "biaoti"],
                                                                nei_rong:
                                                                    article_list[
                                                                            i][
                                                                        "neirong"],
                                                                //id: article_list[index]["id"],
                                                                zuo_zhe:
                                                                    article_list[
                                                                            i][
                                                                        "zuozhe"],
                                                                ri_qi: article_list[
                                                                        i][
                                                                    "updated_at"],
                                                                dianzanshu:
                                                                    article_list[
                                                                            i][
                                                                        "dianzanshu"],
                                                                yuedushu:
                                                                    article_list[
                                                                            i][
                                                                        "yuedushu"],
                                                              )); //必须带上参数名,然后是值
                                                            },
                                                            child: Text(
                                                              (article_list[i][
                                                                          "id"])
                                                                      .toString() +
                                                                  "." +
                                                                  article_list[
                                                                          i][
                                                                      "biaoti"],
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        162,
                                                                        160,
                                                                        160),
                                                                fontSize: 15,
                                                              ),
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
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
                                                  children:
                                                      List<Widget>.generate(
                                                          article_list.length >
                                                                  9
                                                              ? 9
                                                              : article_list
                                                                  .length,
                                                          (int i) {
                                                return Row(children: [
                                                  Container(
                                                    // height: 20,
                                                    child: Chip(
                                                      shape:
                                                          CircleBorder(), //圆形的数字
                                                      backgroundColor:
                                                          Colors.yellowAccent[
                                                              700], //,
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
                                                              // print(i);

                                                              Get.Get.to(
                                                                  Article_xiang_qing(
                                                                //文章详情
                                                                title:
                                                                    article_list[
                                                                            i][
                                                                        "biaoti"],
                                                                nei_rong:
                                                                    article_list[
                                                                            i][
                                                                        "neirong"],
                                                                //id: article_list[index]["id"],
                                                                zuo_zhe:
                                                                    article_list[
                                                                            i][
                                                                        "zuozhe"],
                                                                ri_qi: article_list[
                                                                        i][
                                                                    "updated_at"],
                                                                dianzanshu:
                                                                    article_list[
                                                                            i][
                                                                        "dianzanshu"],
                                                                yuedushu:
                                                                    article_list[
                                                                            i][
                                                                        "yuedushu"],
                                                              )); //必须带上参数名,然后是值
                                                            },
                                                            child: Text(
                                                              (article_list[i][
                                                                          "id"])
                                                                      .toString() +
                                                                  "." +
                                                                  article_list[
                                                                          i][
                                                                      "biaoti"],
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        162,
                                                                        160,
                                                                        160),
                                                                fontSize: 15,
                                                              ),
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
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
                                              height:
                                                  800, //constraints.maxHeight,
                                              width: 500,
                                              child: ListView.separated(
                                                controller: controller4,
                                                itemCount:
                                                    article_list.length > 9
                                                        ? 9
                                                        : article_list.length,
                                                //此处直接给具体数字初始显示时汇报个错: RangeError (index): Index out of range: no indices are valid: 0
                                                //itemCount: 33,   //列表项构造器
                                                itemBuilder:
                                                    (BuildContext context,
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
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                          child: _suo_lue_tu(
                                                                              index,
                                                                              50)),
                                                                      Container(
                                                                          child:
                                                                              _title(index)),
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
                                                                      child: _suo_lue_tu(
                                                                          index,
                                                                          100)),
                                                                  //  IntrinsicWidth(
                                                                  //     //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
                                                                  //   child: Row(children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        //Row(children: [_title(index)],),
                                                                        Container(
                                                                            alignment: Alignment
                                                                                .centerLeft,
                                                                            width:
                                                                                300,
                                                                            child:
                                                                                _title(index)),
                                                                        Container(
                                                                          //width: 50,
                                                                          // alignment:
                                                                          //     Alignment.centerRight,
                                                                          child:
                                                                              _riqi(index),
                                                                        ),
                                                                        Container(
                                                                          //  width: 50,
                                                                          // alignment:
                                                                          //     Alignment.centerRight,
                                                                          child:
                                                                              _zuozhe(index),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ) //]
                                                                  // )
                                                                  // ),
                                                                ])) //;})
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      print('haha');
                                                      Get.Get.to(
                                                          Article_xiang_qing(
                                                        //文章详情
                                                        title:
                                                            article_list[index]
                                                                ["biaoti"],
                                                        nei_rong:
                                                            article_list[index]
                                                                ["neirong"],
                                                        //id: article_list[index]["id"],
                                                        zuo_zhe:
                                                            article_list[index]
                                                                ["zuozhe"],
                                                        ri_qi:
                                                            article_list[index]
                                                                ["updated_at"],
                                                        dianzanshu:
                                                            article_list[index]
                                                                ["dianzanshu"],
                                                        yuedushu:
                                                            article_list[index]
                                                                ["yuedushu"],
                                                      ) //必须带上参数名,然后是值
                                                          );
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
                                                              255,
                                                              255,
                                                              255,
                                                              255),
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
                      ]))
            ],
          ));
        }));
  }
}

//文章列表页点击文章,显示文章详情
class Article_xiangqing_usercenter extends StatefulWidget {
  int index;
  double width1;
  Article_xiangqing_usercenter(
      {Key? key, required this.index, required this.width1})
      : super(key: key);

  @override
  _Article_liebiao_click_article createState() =>
      _Article_liebiao_click_article();
}

class _Article_liebiao_click_article
    extends State<Article_xiangqing_usercenter> {
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
      "id": article_list[widget.index]["id"],
      //  "yuedushu": article_list[widget.index]["yuedushu"] + 1,

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
        color: Color.fromARGB(255, 82, 122, 255),
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
    double width0,
  ) {
    return Image.network(
      article_list[index]["suoluetu"],
      height: width0 * 0.618,
      width: width0,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("显示列表");
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.width1 < 800.0) //执行2种布局
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(child: _suo_lue_tu(widget.index, 200)),
                          Container(child: _title(widget.index)),
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
              else
                //                           LayoutBuilder(builder: (context, constraints) {
                //  print(constraints.maxHeight);
                //     return
                Row(//mainAxisSize: MainAxisSize.min,

                    children: [
                  //  _suo_lue_tu(index),
                  IntrinsicWidth(
                      //没有这个组件,会提示  RenderFlex children have non-zero flex but incoming width constraints are unbounded
                      child: Row(children: [
                    Expanded(flex: 1, child: _suo_lue_tu(widget.index, 200))
                  ])),
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
                            Container(
                                alignment: Alignment.center,
                                width: 400,
                                child: _title(widget.index)),
                            Container(
                              //   width: 150,
                              // alignment:
                              //     Alignment.centerRight,
                              child: _riqi(widget.index),
                            ),
                            Container(
                              // width: 150,
                              // alignment:
                              //     Alignment.centerRight,
                              child: _zuozhe(widget.index),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                ]) //;})
            ],
          ),
        ),
      ),
      onTap: () {
        // print('haha');
        //执行完成 xiugaiyuedushu()后,执行 Get.Get.to(Article_xiang_qing)语句
        xiugaiyuedushu().then((value) async {
          //value是xiugaiyuedushu()异步函数执行后的返回值.
          print(value);
          var result = await Get.Get.to(Article_xiang_qing(
            //文章详情
            title: article_list[widget.index]["biaoti"],
            nei_rong: article_list[widget.index]["neirong"],
            id: article_list[widget.index]["id"],
            zuo_zhe: article_list[widget.index]["zuozhe"],
            ri_qi: article_list[widget.index]["updated_at"],
            dianzanshu: article_list[widget.index]["dianzanshu"],
            yuedushu: yuedushu,
          ));
          //此语句会在await后的页面或者类关闭后再执行
          article_list[widget.index]["dianzanshu"] = result!["dianzanshu"];
        }); //必  须带上参数名,然后是值
      },
    );
  }
}
