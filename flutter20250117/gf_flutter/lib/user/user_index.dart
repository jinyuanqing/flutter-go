import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gf_view/admin/admin_deng_lu.dart';
 import "/generate/usermenuclass.dart";
import 'wenzhang/Wenzhangfenlei.dart';
import '/quan_ju.dart';
import 'package:get/get.dart' as Get;
// ignore_for_file: deprecated_member_use
import 'package:lpinyin/lpinyin.dart';
// import 'middle_tab.dart';
import '../model1.dart';
import 'package:flutter/material.dart';
import 'zhaopin/zhaopingangwei.dart';
import 'package:provider/provider.dart';
import '/quan_ju.dart';
// import '网站信息.dart';
import 'dart:io';
import '/main.dart';
import 'gongsijianjie/Jianjie.dart';
import 'zhuce/trigger_zhuce.dart';
import 'zhuce/zhuce.dart';
import 'package:bot_toast/bot_toast.dart';
import '/user/user_deng_lu.dart';
import 'package:flutter_gf_view/admin/admin_index.dart';
import '/widgets/http.dart';
import '/common.dart';

late TabController tabController2; //需要定义一个Controller

class User_index extends StatelessWidget {
  const User_index({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        //  MaterialApp(
        //   builder: BotToastInit(), //BotToastInit移动到此处
        //   navigatorObservers: [BotToastNavigatorObserver()],
        //   title: websitename,
        //   //去掉右上角的debug贴纸
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     primarySwatch: primary,
        //   ),
        //   home: const MyHomePage(title: "游学综合网"),
        // );
        const MyHomePage(title: zhan_dian_ming_cheng);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  @override
  //bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController email_controll = TextEditingController();
  PageController pageController = PageController();

  bool is_ok = false;
  String labeltext = '请填写邮箱';
  @override
  void initState() {
  
    super.initState();
//  get_menu_user();
Provider.of<Model1>(context, listen: false).tabsname_user =caidan_user_1_2;//;不要用Model1.watch().
  print(Provider.of<Model1>(context, listen: false).tabsname_user );
    //共2次 ..2次初始化
   tabController2 = TabController(length:  Provider.of<Model1>(context, listen: false).tabsname_user  .length, vsync: this);
   
  //共2次 ..1次初始化
    //  tabController2 = TabController(length:  Provider.of<Model1>(context, listen: false).tabsname_user  .length, vsync: this);
   
   var res = Get.Get.parameters["isok"];
    print("激活邮箱结果:");
    print(res);
  }

//获取后台有权限的菜单
void get_menu_user() async {
    {



 var response = await YXHttp().http_post(map0api["获取前台菜单"]!, {"Username" :"123"});

    var json01 = (response);
    // ignore: avoid_print
    print(json01.length);
    // print(json0["data"][0]["Id"]);
    // print(json0["data"][1]["Id"]);
    // print(json0["data"][2]["Id"]);
    caidan_user_1_2 = [];
    for (var i = 0; i < json01.length; i++) {
      // isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
      List<String> list0 = [];

      if (json01[i]["Children"] != null) {
        list0.add(json01[i]["userMenuName"]);
        if (json01[i]["Children"].length >= 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < json01[i]["Children"].length; i1++) {
            list0.add(json01[i]["Children"][i1]["userMenuName"]);
          }
          caidan_user_1_2.add(list0);
        }
      } else {
        list0.add(json01[i]["userMenuName"]);
        caidan_user_1_2.add(list0);
      }
    }
     print("前台菜单:");
    // print(caidan_user_1_2);
       
  Provider.of<Model1>(context, listen: false).tabsname_user =caidan_user_1_2;//;不要用Model1.watch().
  print(Provider.of<Model1>(context, listen: false).tabsname_user );
    //共2次 ..2次初始化
   tabController2 = TabController(length:  Provider.of<Model1>(context, listen: false).tabsname_user  .length, vsync: this);
   
   setState(() {});
      // if (response.statusCode == 200) {
      //   if (response.data["code"] == "0") {
      //     // print("成功!");
      //     List<dynamic> res = response.data["data"];

      //     tabsname_admin = res;
      //     // thumbnail = s1;
      //     //   host_url + s1.substring(1); //从第2个字符开始截取
      //     print(res);
      //     for (var i = 0; i < res.length; i++) {
      //       tabsname_admin.add(res[i]["fenlei_name"]);
      //     }
      //     setState(() {});
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print("主页面刷新了");
    Size _size = MediaQuery.of(context).size;
    // Model1 a = Provider.of<Model1>(context);
    // tabController1 = TabController(length:context.read<Model1>().tabsname_admin.length, vsync: this);
    //    tabController1.index = context.read<Model1>().tabsname_admin.length-1; //设置默认菜单索引
    Model1 model1 = context.watch<Model1>();
    return Scaffold(
        key: _scaffoldKey,
        drawer: Container(child: chou_ti_windows()), //抽屉左侧菜单
        appBar: PreferredSize(
          child: AppBar(
            //打开抽屉菜单
            leading: _size.width < 1000
                ? new IconButton(
                    icon: new Icon(Icons.settings),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    })
                : Text("侧面菜单"),

            centerTitle: true,

            title: Text(widget.title),

            //AppBar标题文字后面放置图标

            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(
                  Icons.account_balance,
                  // color: Colors.black,
                ),
                label: Text("注册",
                    style: TextStyle(
                      // color: Color.fromARGB(255, 8, 8, 8),
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Get.Get.defaultDialog(
                    title: "提示",
                    middleText: "设置成功了!",
                    content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return TriggerZhuce();
                    }),
                    barrierDismissible: true, //	是否可以通过点击背景关闭弹窗

                    // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
                  );
                },
              ),
              if (username == "未登录")
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.black,
                  ),
                  label: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 20,
                      child: Text('$username',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  onPressed: () {
                    // _scaffoldKey.currentState!.openDrawer();
                    Get.Get.to(AdminDengLu());
                    // Get.Get.to(UserDengLu());
                    print(1);
                  },
                ),
              if (username != "未登录")
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.black,
                  ),
                  label: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 20,
                      child: Text(model1.nickname,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ))),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();

                    print(2);
                  },
                ),
            ],

            bottom: TabBar(
              //生成Tab菜单
                 onTap: (index) {
                  // print("tab切换");
                   print(model1.tabsname_user[index]);//当前点击的菜单名
                  pageController.jumpToPage(index);
                },
              controller: tabController2,
              tabs: model1.tabsname_user.map((e) => Tab(text: e[0])).toList(),//把每个菜单的第一个放入菜单,其余作为二级菜单.前台菜单:[[首页], [文章, 资讯, 技术], [招聘], [简介], [图片], [产品]]

              isScrollable: true,
              labelColor: Colors.white, //选中的颜色
              indicatorColor: Colors.black, //指示器颜色,下划线色
              unselectedLabelColor: Colors.white, //未选中颜色
              unselectedLabelStyle:   const TextStyle(
                //未选中的颜色
                fontSize: 25,
                //color: Colors.white,//与属性一致unselectedLabelColor
                //  backgroundColor: Colors.grey[200]
              ),
              labelStyle:   const TextStyle(
                //选中的颜色
                fontSize: 20,
                //color: Colors.white,//与属性一致unselectedLabelColor
                backgroundColor: Colors.black,
              ),
              // indicatorSize:TabBarIndicatorSize.tab,
            ),
          ),
          preferredSize: Size.fromHeight(size_appbar), //设置appbar高度
        ),
        body: 
        
        
        // TabBarView(
          PageView(
          // onPageChanged: (index) {
          // print("onPageChanged");   print(index);
          //   tabController1.animateTo(index);
          // },
          controller: pageController,
          children: ( menu_user_class.values).toList(), //model1.tabs_user_page,
          // List<Widget>.generate(menu_user_class.length, (int i) {
          //             return //KeyedSubtree(
          //                 // child:
          //                menu_user_class.values[i]; //,
          //             //key: Key('${i}'));
          //           }),
      

        // List<Widget>.generate(model1.tabs_user_page.length, (int i) {
        //               return //KeyedSubtree(
        //                   // child:
        //                   model1.tabs_user_page[i]; //,
        //               //key: Key('${i}'));
        //             }),
      


          //  [//前台用户菜单页面集合
          //   Zhaopingangwei(),
          //  wenzhangfenlei(),
            // Jianjie(),
            //       Zhaopingangwei(),
            // wenzhangfenlei(),
            // Jianjie(),
          // ],
        )
        // drawer: Container(child: zuo_ce_cai_dan()),
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  // bool email(String input) {
  //   //验证邮箱

  //   if (input == null || input.isEmpty) return false;
  //   // 邮箱正则

  //   String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  //   return RegExp(regexEmail).hasMatch(input);
  // }

  Future send_email() async {
    FormData formdata = new FormData.fromMap({
      "Email": email_controll.text,
      // "fenlei": "",
      //  "YingpinzheId": '''{"应聘者":${json_str1}}''',
    });
    var response = await YXHttp().http_post(map0api["获取系统时间并发送邮件"]!, formdata);
    // var response = await dio.post(map0api["获取系统时间"]!, data: formData1);

    // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行
    // reslut.insert(reslut.length ,json_result);
    // print(json_result.runtimeType);
    // reslut.addAll(json_result);

    print("获取时间");
    print(response["Encrypt_time"]);
    // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
    // print(response.data["data"]["Time"]);

    setState(
        () {}); //报错:setState() called after dispose(): Shaixuan1#d85eb(lifecycle state: defunct, not mounted)

    // } else {
    //   return;
    // }
    //   load = true;
  }
}

//抽屉窗口
class chou_ti_windows extends StatefulWidget {
  ////
  @override
  _zuo_ce_cai_danState createState() => _zuo_ce_cai_danState();
}

class _zuo_ce_cai_danState extends State<chou_ti_windows>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  @override
  void initstate() {
    super.initState();
    print("left菜单初始化");
  }

  @override
  Widget build(BuildContext context) {
    Model1 model = context.watch<Model1>();
    print("用户前台抽屉页新了");
    return Container(
      // color: primary,
      color: Color.fromARGB(255, 0x56, 0x9E, 0xFE),
      // width: 300,
      //alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    //  child: Text("头像"),
                    //头像半径
                    radius: 60,
                    //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                    backgroundImage: NetworkImage(touxiang),
                  ),
                  Text(
                    "${context.watch<Model1>().nickname}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    // height: 200,
                    child: Text(
                      maxLines: 4,
                      style: TextStyle(
                          // color: Colors.grey[500],
                          fontSize: 15),
                      "${context.watch<Model1>().qianming}",
                      softWrap: true,
                    ),
                  ),
                ]),
            ElevatedButton.icon(
              icon: Icon(
                Icons.account_balance,
                // color: Colors.black,
              ),
              label: Text("用户中心",
                  style: TextStyle(
                    // color: Color.fromARGB(255, 8, 8, 8),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                Get.Get.toNamed("zhuce");
              },
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.account_balance,
                // color: Colors.black,
              ),
              label: Text("后台发文",
                  style: TextStyle(
                    // color: Color.fromARGB(255, 8, 8, 8),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                // Get.Get.to(AdminDengLu());
                Get.Get.to(Admin_index());
              },
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.account_balance,
                // color: Colors.black,
              ),
              label: Text("资料修改",
                  style: TextStyle(
                    // color: Color.fromARGB(255, 8, 8, 8),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                Get.Get.toNamed("zhuce");
              },
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.account_balance,
                // color: Colors.black,
              ),
              label: Text("退出",
                  style: TextStyle(
                    // color: Color.fromARGB(255, 8, 8, 8),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                Get.Get.toNamed("zhuce");
              },
            ),
          ]),
    );
  }
}

class d1 extends StatefulWidget {
  const d1({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<d1> createState() => _d1();
}

class _d1 extends State<d1> {
  int _counter = 0;
  bool is_ok = false;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Button label'),
              onPressed: () {
                print(12);

                Get.Get.defaultDialog(
                  title: "提示",
                  middleText: "设置成功了!",
                  content: Column(
                    children: [
                      Text("邮箱激活验证,10分钟内登陆邮箱进行验证操作:"),
                    ],
                  ),
                  barrierDismissible: false, //	是否可以通过点击背景关闭弹窗
                  confirm: ElevatedButton(
                      onPressed: () {
                        /// 检查邮箱格式

                        if (1 == 1) {
                          print("验证成功");
                          is_ok = true;
                          setState(() {});
                          print(is_ok);

                          is_ok = false;
                        } else {
                          print("验证不成功");
                          is_ok = false;
                        }

                        // Get.Get.back();
                        // Get.Get.toNamed(
                        //     "/a"); //跳到后台登录页
                      },
                      child: Text("确定")),
                  // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
