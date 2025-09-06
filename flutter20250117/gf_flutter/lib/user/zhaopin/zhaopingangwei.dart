import 'package:flutter/material.dart';
import 'Shaixuan.dart';
import 'package:get/get.dart' as Get1; //formdate 与dio中的formdate相冲突.因此加上as
import '/model1.dart';
import '/quan_ju.dart';
import 'package:dio/dio.dart'; //网络获取数据
import 'dart:convert';

class Zhaopingangwei extends StatefulWidget {
  const Zhaopingangwei({Key? key}) : super(key: key);

  @override
  _ZhaopingangweiState createState() => _ZhaopingangweiState();
}

class _ZhaopingangweiState extends State<Zhaopingangwei>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //与with AutomaticKeepAliveClientMixin一起

  var _futBuiHom;
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;
  int currentSelectIndex = 0;
  List gang0wei0text = [
    //列表的列表集合.第一个项为分类,其余为岗位.//这里有个问题就是这个列表必须有2个空列表,否则首次渲染时,navigation_rail菜单会有个报错,提示菜单项少于2项
    ["", ""], ["", ""],
  ];

  int page = 0;
  List<dynamic> reslut =
      []; //空的list所以不能使用下标索引要添加add数据才行,等价于  var reslut = List(1);//1个长度的list
  var json_obj;
  PageController PageController1 = PageController(
    //用来配置PageView中默认显示的页面 从0开始
    initialPage: 0,
    //为true是保持加载的每个页面的状态
    keepPage: true,
  );
  void _handleGetNetData() async {
    await _getNetData();
    setState(() {});
  }

  Future<String> _getNetData() async {
    print("_getNetData");
    return await Future.delayed(Duration(seconds: 2), () => "从互联网上获取的数据111111");
  }

  @override
  void initState() {
    // TODO: implement initState
    print(0);
    super.initState();
    // _futBuiHom = _getNetData();
    // get_gangwei_xifen(0);
  }

  Future get_gangwei_xifen(int page2) async {
    page = page2;
    print("page");
    print(page);
    try {
      Dio dio = Dio(); // 使用默认配置
      // 配置dio实例
      // dio.options.baseUrl = "https://www.xx.com/api";
      //   dio.options.connectTimeout = 5000; //5s
      // dio.options.receiveTimeout = 3000;
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      var options = BaseOptions(
        connectTimeout:Duration(seconds: connectTimeout0),
        receiveTimeout:Duration(seconds: connectTimeout0),
        responseType: ResponseType.json,
        // validateStatus: (status) {
        //   // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        //   return true;
        // },
        //baseUrl: "http://baidu.com/",
      );

      List<Map<String, String>> a1 = [
        {"id": "1", "name": "jin"},
        {"id": "59", "name": "yuan"},
        {"id": "11", "name": "qing"}
      ]; //输出的map值不带双引号{id:1,name:jin},传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

      a1.add({"id": "2", "name": "a"});
      // String json_str1 = convert.jsonEncode(
      //     a1); //传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

      // print(json_str1);
      FormData formData1 = new FormData.fromMap({
        "token": token,
        "fenlei": "",
        //  "YingpinzheId": '''{"应聘者":${json_str1}}''',
      });

      var response = await dio.post(map0api["获取岗位分类和岗位细分"]!, data: formData1);
      // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行
      // reslut.insert(reslut.length ,json_result);
      // print(json_result.runtimeType);
      // reslut.addAll(json_result);
      if (response.statusCode == 200) {
        if ((response.data["code"] == "0") &
            (response.data["data"]["res"] != null)) {
          print("获取岗位");
          // print(response.data["data"]["res"]);

          // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
          reslut.insertAll(reslut.length, response.data["data"]["res"]);
          gang0wei0text = reslut;

          print("gang0wei0text:");
          print(gang0wei0text);
          print(gang0wei0text.length);
          // int num1 = (List.from(json_obj["应聘者"]).length);
          // print(json_obj["应聘者"][num1 - 1]["id"]);

          // print(list_yingpinzhe_id);
          print("reslut.length:");
          print(reslut.length);
          //根据传递过来的岗位id查岗位名称
          for (var ele in response.data["data"]["id_gangwei"]) {
            //json转map.给list<jsonmap>中的项添加一个键值,必须先把其中的jsonmap变成通过json.decode转成map

            Map a1 = json.decode(json.encode(
                ele)); //json.encode(ele)把ele转为map类型的字符串,再经过json.decode把map字符串转为map
            map_gangwei.addAll({a1["id"]: a1["gangwei"]});
            // gangwei.assign(a1["id"], a1["gangwei"]);
          }
          //    print("reslut");
          //  print(reslut);
          // print(list_yingpinzhe_id[0][0]["id"]);
          // print(reslut.length);
          //  print(response.data["data"]["num"]);
          // print(response.data["data"]["res"][response.data["data"]["num"]-1]["yingpinzhe_id"]);
          // print(response.data["data"]["res"][0]["yingpinzhe_id"] [0]);

          //   print(response.data["data"]["res"][0]["yingpinzhe_id"]["应聘者"][0]["name"]);
          //   String json_str2 = convert.jsonEncode(response.data["data"]);
          //   print(json_str2);
          // if (mounted) {
          setState(
              () {}); //报错:setState() called after dispose(): Shaixuan1#d85eb(lifecycle state: defunct, not mounted)

          // } else {
          //   return;
          // }
          //   load = true;
        } else {
          print('加载到最后');
          //  load = false;
          //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
        }
      }
      //   print("reslut结束");
      // return  print(json_result[0]["biao_ti"]);

      setState(() {});
//      print(response.headers);
//      print(response.request);
//      print(response.statusCode);
      // Dio().get("http://www.baidu.com");
      //  print("baidu请求:");//print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return LayoutBuilder(builder: (context, constraints) {
      print("fenlei:");
      print(fenlei);
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //  mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ConstrainedBox(//约束控件

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //2端对齐
              children: [
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Text("分类"),
                ),
                Container(
                    height: constraints.maxHeight - 180, //设置菜单滚动条的高度.
                    //width: 100,
                    // constraints: BoxConstraints(
                    //    minHeight: constraints.maxHeight,),
                    child: SingleChildScrollView(
                        //滚动视图外层必须有高限制
                        // reverse:false,
                        scrollDirection: Axis.vertical,
                        // controller: _scrollController1, //垂直滚动
                        child: ConstrainedBox(
                            //约束控件
                            //alignment:Alignment.center,
                            constraints: BoxConstraints(
                                // minWidth: 100,
                                // maxWidth: 200,     minHeight: constraints.minHeight,
                                //  maxHeight: constraints.maxHeight,
                                ),
                            child: IntrinsicHeight(
                                //获取子组件的高度.没有此组件,NavigationRail会提示高度异常
                                child: NavigationRail(
                              minWidth: 50,
                              //  elevation: 20,
                              destinations: //菜单项fenlei第一项是选择,所以去除这个.选择是筛选时候下拉框默认显示值
                                  List.generate(fenlei.length - 1, (index) {
                                return NavigationRailDestination(
                                  icon: Icon(Icons.favorite_border),
                                  selectedIcon: Icon(Icons.favorite),
                                  label: Text('${fenlei[index + 1]}'),
                                );
                              }),

                              // minExtendedWidth:72,
                              selectedIndex: _selectedIndex,
                              groupAlignment: groupAligment,
                              onDestinationSelected: (int index) {
                                setState(() {
                                  _selectedIndex = index;
                                  PageController1.jumpToPage(index);
                                });
                              },
                              labelType: labelType,
                              // leading:  FloatingActionButton(
                              //         elevation: 0,
                              //         onPressed: () {
                              //           // Add your onPressed code here!
                              //         },
                              //         child: Text("分类"),
                              //       )
                              //     ,
                              trailing: showTrailing
                                  ? IconButton(
                                      onPressed: () {
                                        // Add your onPressed code here!
                                      },
                                      icon:
                                          const Icon(Icons.more_horiz_rounded),
                                    )
                                  : const SizedBox(),
                            ))))),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Text("分类"),
                )
              ],
            ),

            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 300,
                      child: PageView.builder(
                        scrollDirection: Axis.vertical, //垂直滚动
                        controller: PageController1,
                        pageSnapping: true, //整页滚动
                        itemCount: gangwei_fenlei.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 300,
                            color: yemian_beijingse,
                            child: Center(
                                child: Column(children: [
                              Text(
                                  "${gangwei_fenlei[index][0]}"), //岗位列表的第一项是分类名,其他为岗位
                              Wrap(
                                children: List.generate(
                                    gangwei_fenlei[index].length - 1, (index1) {
                                  //循环生成ElevatedButton
                                  return ElevatedButton(
                                    onPressed: () {
//岗位按钮触发

//根据岗位名称获取岗位id
                                      String gangwei_id = "";
                                      List<dynamic> list_values = map_gangwei
                                          .values
                                          .toList(); //把map_gangwei的值变成list

                                      List<dynamic> list_keys = map_gangwei.keys
                                          .toList(); //把map_gangwei的键变成list

                                      for (int i = 0;
                                          i < list_values.length;
                                          i++) {
                                        print(list_values[i]);
                                        if (list_values[i] ==
                                            gangwei_fenlei[index][index1 + 1]) {
                                          //如果list_values的元素=当前选项的岗位名称,则取list_keys的值,这个值就是岗位_id

                                          gangwei_id = list_keys[i].toString();
                                        }
                                      }
                                      print("23");
                                      Get1.Get.to(
                                          Shaixuan(gangwei_id: gangwei_id));
                                    },
                                    child: Text(
                                      "${gangwei_fenlei[index][index1 + 1]}", //第二项开始是岗位名
                                    ),
                                  );
                                }),
                              )
                            ])),
                          );
                        },
                        onPageChanged: (int index) {
                          print("当前的页面是 $index");

                          ///滑动PageView时，对应切换选择高亮的标签
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      )),

                  // const SizedBox(height: 20),
                  // OverflowBar(
                  //   spacing: 10.0,
                  //   children: <Widget>[
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           showLeading = !showLeading;
                  //         });
                  //       },
                  //       child:
                  //           Text(showLeading ? 'Hide Leading' : 'Show Leading'),
                  //     ),

                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    // );
  }
}
