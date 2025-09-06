import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gf_view/admin/left_menu/pages/gerenzhongxin.dart';
import 'package:flutter_gf_view/admin/left_menu/pages/wenzhangguanli.dart';
import 'package:flutter_gf_view/admin/left_menu/pages/yonghuxinxi.dart';
import 'package:flutter_gf_view/admin/left_menu/pages/zhaopinfabu.dart';
import 'package:flutter_gf_view/user/zhuce/zhuce.dart';
import 'package:flutter_gf_view/widgets/RouteMiddle.dart';
import 'package:flutter_gf_view/widgets/article_xiang_qing.dart';
import 'package:flutter_gf_view/widgets/message.dart';
// import 'package:flutter_gf_view/admin/left_menu/pages/%E6%96%87%E7%AB%A0%E5%8F%91%E5%B8%83.dart';
import 'package:get/get.dart'; //as Get;//get包和dio包都有此Response类型,防止冲突
import 'admin/admin_index.dart';
import 'package:provider/provider.dart';
import 'quan_ju.dart';
import 'model1.dart';
import 'dart:convert';
import 'user/user_index.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; //国际化
import 'admin/left_menu/pages/zhandianmingcheng.dart';
import 'dart:ui'; //图片过滤器ImageFilter需要引入的包
import 'package:bot_toast/bot_toast.dart';
import 'admin/admin_deng_lu.dart';
import 'user/fabuzhe/center_user.dart';
import 'color_schemes.g.dart';
 import '/config/menu.dart';
  import '/common.dart';

void main() {
  //  // 捕获 Flutter 框架内的同步错误（UI 构建、布局、绘制等）
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   FlutterError.presentError(details); // 保留默认的控制台输出
  //   // 这里可以加上报逻辑，比如发送到 Sentry、日志服务器等
  // };

  // // 捕获 Flutter 框架外的异步错误（如 Future、插件调用等）
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   // 记录或上报错误
  //   return true; // 返回 true 表示错误已处理
  // };
  runApp(MultiProvider(
      // key: ObjectKey(islogin),
      providers: [ChangeNotifierProvider<Model1>(create: (_) => Model1())],
      child: GetMaterialApp(scrollBehavior: AppScrollBehavior(),//给网页端的横向滚动组件添加鼠标手势滑动
     unknownRoute:  GetPage(name: '/notfound', page: () => const Message()),//未知路由的显示页面
        // builder: BotToastInit(), //BotToastInit移动到此处
        // navigatorObservers: [BotToastNavigatorObserver()],
        //  initialRoute: '/a',
          initialRoute: '/a',
          
        getPages:page_route,
// onGenerateRoute:(settings) { print(settings.name);//使用方法不对.
//   // if (settings.name == '/article_content') {
   
//     return GetPageRoute(
//         page: () =>Center(
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text("提示信息"),
//             ),
//             body: Center(
//               child:  Text("根据url创建对应的widget哦!")
//             ),
//           ),
//         ), 
//  );
 
// },
        routingCallback: (routing) {//所有路由执行前都会执行这里
          print(routing!.current);

          if (routing.current == '/article_content') {
 
Future.delayed(Duration(seconds: 3), (){
    Get.rawSnackbar(title: '参数不对哦', message: '参数不对哦');
});
          
          }
        },

             localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,GlobalCupertinoLocalizations.delegate, // 添加这行
        ],
        supportedLocales: [
          //此处
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        // home: const MyApp()
        //     locale: const Locale('zh', 'CN'), // 默认指定的语言翻译
        // fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
        title: websitename,
        //去掉右上角的debug贴纸
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            appBarTheme: AppBarTheme(backgroundColor: lightColorScheme.primary),
            colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
//         theme: ThemeData(
        //后台首页,前台首页的工具栏
//           //primaryColor:primary,
//           // colorScheme: ColorScheme.fromSeed(seedColor:primary),
//           colorScheme: ColorScheme.fromSeed(
//               seedColor: primary,
//               // background: yemian_beijingse,
//               // surface: primary,
//               brightness: Brightness.light),
//           // .copyWith(background: yemian_beijingse),
//             // useMaterial3: false,
//         ),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return const MyHomePage(title: zhan_dian_ming_cheng)  ;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

//定义一个controller
  TextEditingController _unameController = TextEditingController();

  TextEditingController _pwdController = TextEditingController();
  static GlobalKey homeKey = GlobalKey();
  //关键代码
  static currentInstance() {
    var state =
        _MyHomePageState.homeKey.currentContext!.findAncestorStateOfType();
    return state;
  }

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Called when the widget is inserted into the tree.
  ///
  /// This method is called when the widget is inserted into the tree. This
  /// happens after the widget is created.
/******  4a959fea-9435-4710-bc55-4fcefc47e875  *******/
  void initState() {
    super.initState();
    print("root初始化");
  }

  // void denglu() async {
  //   var options = BaseOptions(
  //     baseUrl: ' ',
  //     connectTimeout: 5000,
  //     receiveTimeout:Duration(seconds: connectTimeout0),
  //   );
  //   Dio dio = Dio(options);
  //   var response = await dio.post(map0api["登录"]!,
  //       // data: {'Name': '联系方式(电话)', 'Password': 'jinjin1984'});
  //       data: {'Name': 'user22', 'Password': 'jinjin1984'});
  //   print(response);
  // }

  // @override
  // void initState() {
  //   setState(() {
  //     print("刷新页面 ");

  //     // print(context.read<Model1>().tabsname_admin );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return AdminDengLu();
  }
}



class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}