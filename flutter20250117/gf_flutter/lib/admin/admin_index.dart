import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '/quan_ju.dart';
import 'package:get/get.dart';
// ignore_for_file: deprecated_member_use
import 'package:lpinyin/lpinyin.dart';
import 'middle_tab.dart';
import '../model1.dart';
import 'package:flutter/material.dart';
import 'left_menu/pages/left_menu.dart';
import 'package:provider/provider.dart';
import '/quan_ju.dart';
// import '网站信息.dart';
import 'dart:io';//不支持web
// import "package:path_provider/path_provider.dart";
import '/main.dart';
import '/user/user_index.dart';
import '/admin/left_menu/pages/shou_ye.dart';
// late TabController tabController2; //需要定义一个Controller
import 'package:shared_preferences/shared_preferences.dart';
class Admin_index extends StatelessWidget {
  const Admin_index({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("admin_index  build");

    return MaterialApp(
      title: websitename,
      //去掉右上角的debug贴纸
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor:primary,
        appBarTheme:
            AppBarTheme(backgroundColor: Color.fromRGBO(243, 183, 1, 1)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            // background: yemian_beijingse,
            // surface: primary,
            brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: websitename),
    );
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
  // @override
  //bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // List tabsname_admin = [
  //   "首页",
  //   "技术分享",
  //   "产品展示",
  //   "人才招聘",
  //   "公司简介",
  //   "联系我们",
  //   "人才招聘",
  //   "图片",
  //   "聊天"
  // ];

  @override
  void initState() {
    super.initState();
    //   tabController2 = TabController(length: tabsname_admin.length, vsync: this);
  }

  void createFileRecursively(String path, String filename) async {
    // Create a new directory, recursively creating non-existent directories.
    Directory(path).createSync(recursive: true); //创建路径
    // File(path + filename).createSync(); //创建文件
    //  print(PinyinHelper.getPinyin(filename, separator: ''));
    var file = File(path + filename);
    String filename1 = PinyinHelper.getPinyin(filename.split(".")[0],
        separator: ''); //把中文文件名改成拼音

    bool e = await file.exists(); //返回future所以要用await
    if (e) {
      //存在时不动作
      print("文件已经存在了,不能写入");
    } else {
      //不存在文件时,重新写入
//写入左侧菜单页面的模板
      file.writeAsStringSync(''' 
 import 'package:flutter/material.dart';
import 'dart:io';
class ${filename1} extends StatefulWidget {
  const ${filename1} ({Key? key}) : super(key: key);

  @override
  _${filename1}State createState() => _${filename1}State();
}

class _${filename1}State extends State<${filename1}> {
  @override
  Widget build(BuildContext context) {
    return Container(

child:
Text('${filename1}'),
      
    );
  }
}

    
   '''); //写入就会自动创建文件了,覆盖模式写入
    }
  }


  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print("admin_index主页面刷新了");
    Size _size = MediaQuery.of(context).size;
    Model1 model1 = Provider.of<Model1>(context);
    // tabController1 = TabController(length:context.read<Model1>().tabsname_admin.length, vsync: this);
    //    tabController1.index = context.read<Model1>().tabsname_admin.length-1; //设置默认菜单索引
    return Scaffold(
      key: _scaffoldKey,
      //drawer: zuo_ce_cai_dan(), //抽屉左侧菜单

      appBar: PreferredSize(
        child: AppBar(
          //打开抽屉菜单
          leading: _size.width < 1000
              ? new IconButton(
                  icon: new Icon(Icons.settings),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  })
              : Text(""),

          centerTitle: true,

          title: Text(widget.title),

          //AppBar标题文字后面放置图标

          actions: <Widget>[
          
            // ElevatedButton(onPressed: (){}, child: Text("2134")),
            TextButton.icon(
              icon: Icon(Icons.account_balance),
              label: Text("退出",
                  style: TextStyle(
                    color: Color.fromARGB(255, 6, 6, 6),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () async {



                var json_str = {
                  "token": token,
                };

                BaseOptions options1 = BaseOptions(
                  // baseUrl: url1,
                  connectTimeout:Duration(seconds: connectTimeout0), //嵌套的dio请求这里要给0
                  receiveTimeout:Duration(seconds: connectTimeout0),
                  contentType: Headers.jsonContentType,
                  // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
                  /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
                  /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
                  /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
                  /// 就会自动编码请求体.
                );
                Dio dio = Dio(options1);
                var response = await dio.get(map0api["退出"]!,
                    queryParameters: json_str); //发送退出请求

                if ((response.statusCode == 200) &
                    (response.data["msg"] == "success")) {
                  print("退出登陆");

                  // exit(0);
                  // setState(() {
                  //   // context.read<Model1>().change_isloginon(true);
                  //    islogin = true;
                  // });
//清空所有变量
                  fenlei = ["选择"];
                  isexpand = []; //左侧菜单的伸缩状态
                  token = "";
                  caidan_admin_1_2 = []; //1,2级菜单名称
                   caidan_admin=[];//所有菜单内容项
 
                  // caidan = [];
                  maps0caidan0index = {"首页": 0}; //tab屏打开的页面和页面索引
                  context.read<Model1>().tabsname_admin = ["首页"];
                  context.read<Model1>().tabs_admin_page = [
                    ShouYe(),
                  ]; //对于菜单的页面

                    username = "未登录";

                    touxiang = ""; //头像

                  context.read<Model1>().qianming = ""; //签名
                  context.read<Model1>().nickname = ""; //昵称

 final SharedPreferences prefs   = await SharedPreferences.getInstance();


prefs.remove("token");prefs.remove("username");


                  Get.offAllNamed("/a");
                } else {
                  print(response.data);
                  print("退出失败");
                }
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.abc),
              label: Text('前台',
                  style: TextStyle(
                    color: Color.fromARGB(255, 6, 6, 6),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                // islogin = true;
                Get.off(User_index());
                // context.read<Model1>().tabsname_admin = ["首页"];
                // List<Widget> tabs_admin_page = [
                //   //后台首页进入后,显示的tab菜单内容.退出后admin_index中清空所有变量里进行了重新清空操作
                //   ShouYe(),
                // ];
                // isexpand = []; //左侧菜单的伸缩状态
                // token = "";
                // caidan_admin_1_2 = []; //二级菜单组
                // caidan = [];
                maps0caidan0index = {"首页": 0}; //tab屏打开的页面和页面索引
                context.read<Model1>().tabsname_admin = ["首页"];
                context.read<Model1>().tabs_admin_page = [
                  ShouYe(),
                ]; //对于
                print(1);
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.person_add),
              label: Text(model1.nickname,
                  style: TextStyle(
                    color: Color.fromARGB(255, 6, 6, 6),
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
                print(1);
              },
            ),
          ],

          // bottom: TabBar(
          //   //生成Tab菜单
          //   controller: tabController2,
          //   tabsname_admin: tabsname_admin.map((e) => Tab(text: e)).toList(),
          //   isScrollable: true,
          //   labelColor: Colors.white, //选中的颜色
          //   indicatorColor: Colors.black, //指示器颜色,下划线色
          //   unselectedLabelColor: Colors.white, //未选中颜色
          //   unselectedLabelStyle: new TextStyle(
          //     //未选中的颜色
          //     fontSize: 25,
          //     //color: Colors.white,//与属性一致unselectedLabelColor
          //     //  backgroundColor: Colors.grey[200]
          //   ),
          //   labelStyle: new TextStyle(
          //     //选中的颜色
          //     fontSize: 20,
          //     //color: Colors.white,//与属性一致unselectedLabelColor
          //     backgroundColor: Colors.black,
          //   ),
          //   // indicatorSize:TabBarIndicatorSize.tab,
          // ),
        ),
        preferredSize: Size.fromHeight(size_appbar / 2), //设置appbar高度
      ),
      body: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Consumer<Model1>(builder: (context, model1, child) {
          //   return TextButton(
          //       onPressed: () {
          //         tabController1.index = 1;
          //       },
          //       child: Text("0"));
          // }),
          // Consumer(builder: (context, Model1 model1, child) {
          //   print('Text重绘了。。。。。。');
          //   return TextButton(
          //       onPressed: () {
          //         print(a.a1);
          //         print(model1.get_tabsname_admin());
          //       },
          //       child: Text("1"));
          // }),
          Expanded(
            flex: _size.width < screen_size ? 0 : 2,
            child: _size.width < screen_size
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : SingleChildScrollView(child: zuo_ce_cai_dan()),
          ),
          Expanded(
              flex: _size.width < screen_size ? 8 : 10,
              child: Center(
                  child:
                      // Text("data")
                      Tab1()
                  //     Consumer<Model1>(builder: (context, model1, child) {//consumer当model1有变化时就刷新内部. context.watch<Model1>();可以替代局部刷新
                  //   print("Consumer");
                  //   return Tab1(); //不能使用自动修复加上const，那样tab1就不会刷新了
                  // })

                  )),

          // SizedBox(
          //   height: 40.0,
          //   width: 40.0,
          //   child: IconButton(
          //     //iconSize: 20,
          //     onPressed: () {},
          //     icon: Icon(Icons.add),
          //   ),
          // ),
        ],
      ),
      drawer: Container(child: zuo_ce_cai_dan()),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
