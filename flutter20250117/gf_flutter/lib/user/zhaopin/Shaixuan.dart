// 人才招聘页
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; //网络获取数据
import 'package:flutter_gf_view/color_schemes.g.dart';
import 'package:flutter_gf_view/widgets/widget_shai_xuan.dart';
import 'dart:convert' as convert; //转换dio网络获得的数据
import 'package:get/get.dart' as Get;
// import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_gf_view/quan_ju.dart'; //调用吐司库
import 'package:get/get.dart' as Get1; //formdate 与dio中的formdate相冲突.因此加上as
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import '/quan_ju.dart';
import '/model1.dart';
import 'Shaixuan.dart';
import '/user/zhaopin/zhaopin_xiangqing.dart';

class Shaixuan extends StatefulWidget {
  final gangwei_id;
  Shaixuan({
    Key? key,
    @required this.gangwei_id,
  }) : super(key: key);

  @override
  Shaixuan1 createState() => Shaixuan1();
}

ScrollController controller1 =
    new ScrollController(); //此变量为全局变量,可在main.dart直接调用.类间只能调用常用类型的变量

class Shaixuan1 extends State<Shaixuan> {
  List<List<String>> list_baoxian = [];
  int a1 = 90;
  double height_button = 28; //筛选的按钮大小
  //职位
  //var color_zhiweiwenben = List<Color>(); //或

//List<String> zhiweiwenben = List(50);//固定长度的list
  List<String> zhiweiwenben = []; //职位文字

//工作地点
  List<Color> color_zhiweiwenben = []; //list数组长度可变,使用add增加元素
  List<Color> color_didianwenben = []; //list数组长度可变,使用add增加元素
  List<Color> color_xueliwenben = []; //list数组长度可变,使用add增加元素
//List<String> zhiweiwenben = List(50);//固定长度的list
  List<String> didianwenben = []; //职位文字,长度可变的list
  List<String> xueliwenben = []; //学历文字,长度可变的list
  int dangqiansuoyin_zhiwei = 0; //工作岗位的当前索引
  int dangqiansuoyin_didian = 0; //工作地点的当前索引
  int dangqiansuoyin_xueli = 0; //学历的当前索引
  String dangqianwenben_zhiwei = ""; //当前工作职位的文本
  String dangqianwenben_didian = ""; //当前工作地点的文本
  String dangqianwenben_xueli = ""; //当前学历的文本
  bool bool_show_zhiwei = false; //职位  在筛选条件中是否显示
  bool bool_show_didian = false; //地点  在筛选条件中是否显示
  bool bool_show_xueli = false; //学历  在筛选条件中是否显示

  List<String> _load_data1 = List.empty(); //加载数据数据

  var biao_ti;
  int page = 0;
  bool load = true;
  int? data_count;

  var json_result = [];
  List<Color> yinying = [];
  List<dynamic> article_list =
      []; //空的list所以不能使用下标索引要添加add数据才行,等价于  var article_list = List(1);//1个长度的list
  var json_obj;
  var json_pic;
  List<dynamic> list_yingpinzhe_id = [];
  List<dynamic> list_zhaopin_pics = []; //招聘的图片集合
  String gangwei_id = "";
  late Widget Widget_wenben;

  void set_wenben(List<String> list, List<String> wenben, Color color1) {
    //设置职位显示的文本
    for (var element in wenben) {
      list.add(element);
      //color_xueliwenben.add(color1);
    }
  }

  Future get_gangwei(int page2) async {
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
        responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        //baseUrl: "http://baidu.com/",
      );

      List<Map<String, String>> a1 = [
        {"id": "1", "name": "jin"},
        {"id": "59", "name": "yuan"},
        {"id": "11", "name": "qing"}
      ]; //输出的map值不带双引号{id:1,name:jin},传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

      a1.add({"id": "2", "name": "a"});
      String json_str1 = convert.jsonEncode(
          a1); //传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

      // print(json_str1);
      FormData formData1 = new FormData.fromMap({
        "token": token,
        "page": page,
        // "GongSiMing": "游学电子99",
        //  "YingpinzheId": '''{"应聘者":${json_str1}}''',
      });

      var response = await dio.post(map0api["获取招聘岗位"]!, data: formData1);
      // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行
      // article_list.insert(article_list.length ,json_result);
      // print(json_result.runtimeType);
      // article_list.addAll(json_result);
      if (response.statusCode == 200) {
        if ((response.data["code"] == "0") &
            (response.data["data"]["res"] != null)) {
          print("获取岗位");
          // print(response.data["data"]["res"]);

          // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
          article_list.insertAll(
              article_list.length, response.data["data"]["res"]);

          for (int i = (page - 1) * 10; i < article_list.length; i++) {
            json_obj = convert.jsonDecode(article_list[i][
                "yingpinzhe_id"]); //yingpinzhe_id在数据库中存放的json类型数据.此处dio返回的是json对象,而json对象中的["yingpinzhe_id"]的数据库中的存放结果却是json字符串
            //所以这里需要进行转换成json对象.然后使用json的操作
            json_pic = convert.jsonDecode(article_list[i]["tupian"]); //存放招聘的图片
            var list2 = List.from(json_obj["应聘者"]);
            var list3 = List.from(json_pic["pics"]);
            // list_yingpinzhe_id.insertAll(
            //     list_yingpinzhe_id.length, list2);//
            list_yingpinzhe_id.add(list2); //应聘者id
            list_zhaopin_pics.add(list3); //应聘的图片

            //   print(article_list[i]["baoxian"].toString().substring(1,article_list[i]["baoxian"].toString().length -1 ).split(","));

            //  print(article_list[i]["baoxian"].toString().substring(1,article_list[i]["baoxian"].toString().length -1 ).split(",")[0]);
            //            print(article_list[i]["baoxian"].toString().substring(1,article_list[i]["baoxian"].toString().length -1 ).split(",")[1]);
            list_baoxian.add(article_list[i]["baoxian"]
                .toString()
                .substring(1, article_list[i]["baoxian"].toString().length - 1)
                .split(","));
            // list_baoxian.insertAll(
            //     list_baoxian.length,
            //     article_list[i]["baoxian"]
            //         .toString()
            //         .substring(
            //             1, article_list[i]["baoxian"].toString().length - 1)
            //         .split(","));
          }
          print("list_baoxian:");
          print(list_baoxian);
          print(list_baoxian.length);
          // int num1 = (List.from(json_obj["应聘者"]).length);
          // print(json_obj["应聘者"][num1 - 1]["id"]);

          // print(list_yingpinzhe_id);
          print("article_list.length:");
          print(article_list.length);
          //    print("article_list");
          //  print(article_list);
          // print(list_yingpinzhe_id[0][0]["id"]);
          // print(article_list.length);
          //  print(response.data["data"]["num"]);
          // print(response.data["data"]["res"][response.data["data"]["num"]-1]["yingpinzhe_id"]);
          // print(response.data["data"]["res"][0]["yingpinzhe_id"] [0]);

          //   print(response.data["data"]["res"][0]["yingpinzhe_id"]["应聘者"][0]["name"]);
          //   String json_str2 = convert.jsonEncode(response.data["data"]);
          //   print(json_str2);
          // if (mounted) {
          //   setState(
          //       () {}); //报错:setState() called after dispose(): Shaixuan1#d85eb(lifecycle state: defunct, not mounted)

          // } else {
          //   return;
          // }
          load = true;
        } else {
          print('加载到最后');
          load = false;
          //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
        }
      }
      //   print("article_list结束");
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

  void fa_bu(int page2) async {
    // page = page2-1;
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
        responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        //baseUrl: "http://baidu.com/",
      );
      List baoxian1 = ["五险一金", "双休", "单休", "中午供饭"];

      String baoxian2 = baoxian1.toString();
      print(baoxian2);
      List<Map<String, String>> a1 = [
        {"id": "1", "name": "jin"},
        {"id": "59", "name": "yuan"},
        {"id": "11", "name": "qing"}
      ]; //输出的map值不带双引号{id:1,name:jin},传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号
      Map<String, String> b = {};
      b["id"] = "12";
      b["name"] = "youxue";
      a1.add(b);
      String json_str1 = convert.jsonEncode(
          a1); //传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

      print(json_str1);
      FormData formData1 = new FormData.fromMap({
        "Renshu": "12",
        "GongSiMing": "游学电子99",
        "YingpinzheId": '''{"应聘者":${json_str1}}''',
        "Baoxian": baoxian2,
      });

      var response = await dio.post(map0api["招聘信息发布"]!, data: formData1);
      // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行
      // article_list.insert(article_list.length ,json_result);
      // print(json_result.runtimeType);
      // article_list.addAll(json_result);

      // Get1.Get.defaultDialog(
      //     title: "提示消息:",
      //     // content: Text("content"),
      //     middleText: "处理完成!", //content与middleText写一个
      //     titlePadding: EdgeInsets.all(10),
      //     titleStyle:
      //         TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
      //     middleTextStyle: TextStyle(color: Colors.blue, fontSize: 20),
      //     confirm: ElevatedButton(onPressed: () {}, child: Text("确定")),
      //     cancel: ElevatedButton(onPressed: () {}, child: Text("取消")));

      if ((response.data["code"] == "0") & (response.data["data"] != null)) {
        print(response.data["data"]);
      } else {
        print('加载到最后');

        //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }
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

  void get_count() async {
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
        responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        //  baseUrl: "http://baidu.com/",
      );

      //Dio  dio = new Dio(options);
      //Response response = await dio.get("http://baidu.com/", queryParameters: {"id": 12, "name": "wendu"});
      print('page:');
      print(page);
      //此url地址本地可以 ,部署后会发现localhost无法访问,应该写成域名
      //response = await dio.get("http://localhost/index/index/api_getcount/",queryParameters: {});
      var response = await dio.get(
          "http://localhost/index.php/index/index/api_get_count_zhao_pin",
          queryParameters: {});
      data_count = int.parse(response.data.toString());

      print("data_count:");
      print(data_count);

      //   print("article_list结束");
      // return  print(json_result[0]["biao_ti"]);

      setState(() {
        //biao_ti= json_result[0]["biao_ti"];
      });
//      print(response.headers);
//      print(response.request);
//      print(response.statusCode);
      // Dio().get("http://www.baidu.com");
      // print("baidu请求:");//print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // controller1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("rczp_init");

    gangwei_id = widget.gangwei_id;
    //article_list.add("value");
    article_list = [];
    // set_color_zhiweiwenben(Colors.blue);
    // set_color_zhiweiwenben(Colors.white);
    // set_color_zhiweiwenben(Colors.white);

    List<String> hangye = [
      "不限",
      "软件",
      "硬件",
      "销售",
      "设计",
      "动漫",
    ];

    set_wenben(zhiweiwenben, hangye, Colors.blue);

    // set_color_didianwenben(Colors.blue);
    // set_color_didianwenben(Colors.white);
    // set_color_didianwenben(Colors.white);

    List<String> didian = [
      "不限",
      "锦州市",
      "义县",
      "黑山",
      "北镇",
      "凌海",
    ];

    set_wenben(didianwenben, didian, Colors.blue);

    List<String> xueli = ["不限", "小学", "初中", "高中", "大专", "本科", "本科以上"];

    set_wenben(xueliwenben, xueli, Colors.blue);
    // print(xueliwenben);
    // print("颜色" + color_zhiweiwenben.toString());
    // bool_show_zhiwei = false;
    //Widget_wenben = buildGrid();
    //首先初始化获取列表数量
    page = 1;
    search(page);
    // get_gangwei(1);
    //监听滚动事件，打印滚动位置
    controller1.addListener(() {
      var pix = controller1.position.pixels;
      var max = controller1.position.maxScrollExtent;
      if (pix == max) {
        //已下拉到底部，调用加载更多方法
        if (load) {
          _loadMoreData();
          //   load = false;
        }
      }
    });
  }
// @override
// void didChangeDependencies(){

// }
  void search(int page) async {
    print("搜索函数");
    late Response response;
    int dataCount;
    try {
      Dio dio = Dio(); // 使用默认配置
      // 配置dio实例
      var options = BaseOptions(
       connectTimeout:Duration(seconds: connectTimeout0),
        receiveTimeout:Duration(seconds: connectTimeout0),
        responseType: ResponseType.json,
      );
      // if (is_clear) gangwei_id = "";
      response = await dio.post(map0api["招聘信息搜索"]!, queryParameters: {
        "token": token,
        // "Gongsiming": (controller.text), //公司名
        "Gangwei": gangwei_id, //岗位id
        // "Riqi1": "", //日期
        // "Riqi2": (controller3.text), //日期
        // "Xueli": xueli1, //学历
        // "Quanzhi": quanzhi1, //全职
        // "Dizhi": didian1,
        "Page": page, //页
      });

      if (response.statusCode == 200) {
        print("返回请求结果是:");
        // print(response.data["data"]["res"]);
        if (response.data["code"] == "0") {
          if (response.data["data"]["res"] == null) {
            // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
            print('加载到最后');
            Get.Get.snackbar("提示窗:", "没有数据了",
                snackPosition: SnackPosition.BOTTOM);
            load = false;
            // setState(() {
            //   //_yibu = true;
            //   //搜索时候必须刷新页面,否则listview还是显示原有的信息.必须在这里进行刷新.如果在search()结束后返回的函数中进行刷新,就不起作用了
            // });
          } else {
            article_list.insertAll(
                article_list.length, response.data["data"]["res"]);
            print("article_list长度:");
            print(article_list.length);
            // print(result);
            // Model1 model1 = context.watch<Model1>();
            // model1.shaixuan(article_list);
            Provider.of<Model1>(context, listen: false).shaixuan(
                article_list); //在initstate中使用provider.注意 listen: false

            load = true;
            yinying = List.filled(
                article_list.length, Colors.blue); //填充card组件的阴影默认值为5
            //对获取的数据库数据进行解析,获取图片和应聘者的json.
            for (int i = (page - 1) * 10; i < article_list.length; i++) {
              json_obj = convert.jsonDecode(article_list[i][
                  "yingpinzhe_id"]); //yingpinzhe_id在数据库中存放的json类型数据.此处dio返回的是json对象,而json对象中的["yingpinzhe_id"]的数据库中的存放结果却是json字符串
              //所以这里需要进行转换成json对象.然后使用json的操作
              json_pic =
                  convert.jsonDecode(article_list[i]["tupian"]); //存放招聘的图片
              var list2 = List.from(json_obj["应聘者"]);
              var list3 = List.from(json_pic["pics"]);
              list_yingpinzhe_id.add(list2); //应聘者id
              list_zhaopin_pics.add(list3); //应聘的图片
              //   print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(","));

              //  print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(",")[0]);
              //            print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(",")[1]);
              list_baoxian.add(article_list[i]["baoxian"]
                  .toString()
                  .substring(
                      1, article_list[i]["baoxian"].toString().length - 1)
                  .split(","));
              // list_baoxian.insertAll(
              //     list_baoxian.length,
              //     result[i]["baoxian"]
              //         .toString()
              //         .substring(
              //             1, result[i]["baoxian"].toString().length - 1)
              //         .split(","));
            }

            //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
          }
          setState(() {
            // Provider.of<Model1>(context, listen: false).shaixuan(
            //     article_list); //在initstate中使用provider.注意 listen: false

            //_yibu = true;
            //搜索时候必须刷新页面,否则listview还是显示原有的信息.必须在这里进行刷新.如果在search()结束后返回的函数中进行刷新,就不起作用了
          });
          //   print("result结束");
          // return  print(json_result[0]["biao_ti"]);

        }
      }
    } catch (e) {
      print(e);
    }
  }

//加载更多

  Future _loadMoreData() async {
    print("加载更多");
    await Future.delayed(Duration(seconds: 0), () {
      page = page + 1;
      search(page);
      // print(page);
      // fa_bu(page);
      // get_gangwei(page).then((value) => setState(() {}));
      // print("object");
      //  article_list.addAll(json_result);

      // load = true;
      // } else {
      //   //BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
      //   print('加载到最后');
      // }
    });
  }

  Widget buildGrid() {
    print(zhiweiwenben.length);
    int ii = 0;
    List<Widget> titles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var i = 0; i < zhiweiwenben.length; i++) {
      titles.add(Row(children: <Widget>[
        ElevatedButton(
          child: Text(zhiweiwenben[i]), //软件
          // color: color_zhiweiwenben[i],
          onPressed: () {
            setState(() {
              bool_show_zhiwei = true; //显示筛选的控件
              color_zhiweiwenben[dangqiansuoyin_zhiwei] = Colors.white;
              color_zhiweiwenben[i] = Colors.blue;
              print(i);
              print(color_zhiweiwenben);
              print(dangqiansuoyin_zhiwei);
              dangqiansuoyin_zhiwei = i;
              dangqianwenben_zhiwei = zhiweiwenben[i];
            });
          },
        ),
      ]));
    }
    content =
        Row(children: titles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
            //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
            );

    return //content; //for生成的这个控件不会自动刷新,必须直接写在return的下方才行
        StatefulBuilder(
      //局部刷新控件
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          // mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(zhiweiwenben.length, (int i) {
            return ElevatedButton(
              child: Text(zhiweiwenben[i]), //软件
              // color: color_zhiweiwenben[i],
              onPressed: () {
                setState(() {
                  bool_show_zhiwei = true; //显示筛选的控件
                  color_zhiweiwenben[dangqiansuoyin_zhiwei] = Colors.white;
                  color_zhiweiwenben[i] = Colors.blue;
                  print(bool_show_zhiwei);
                  print(dangqiansuoyin_zhiwei);
                  print(color_zhiweiwenben);

                  dangqiansuoyin_zhiwei = i;
                  dangqianwenben_zhiwei = zhiweiwenben[i];
                });
              },
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build筛选页面");
    Model1 model1 = context.watch<Model1>();
    //
    // print("context.watch<Model1>().article_list");
    // print(context.watch<Model1>().article_list);
    return Scaffold(
        body: Container(
            // color: yemian_beijingse,
            child: CustomScrollView(
              controller: controller1,
              // shrinkWrap: true,
              // 内容
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('人尽其才'),
                    background: Image(
                      image: AssetImage('images/zhao_pin.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate(
                            // Column(
                            //  padding: new EdgeInsets.all(5.0),
                            // scrollDirection: Axis.vertical,//垂直滚动
                            // controller:  controller1,
                            <Widget>[
                              Container(
    color: Color.fromARGB(255, 255, 255, 255),
                                child: 
                            
                          Widget_shai_xuan(
                            gangwei_id: gangwei_id,
                            text: [
                              "地区",
                              "学历",
                              "全/兼",
                            ],
                            list_text: [
                              ["不限", "市区", "义县", "凌海", "黑山", "北镇"],
                              ["不限", "本科以上", "本科", "专科", "高中", "无要求"],
                              [
                                "不限",
                                "全职",
                                "兼职",
                              ]
                            ],
                            )),
                        ]))),
                // listSliver,
                SliverFixedExtentList(
                  itemExtent: 200, //高度
                  delegate: SliverChildBuilderDelegate(
                    // childCount: article_list.length,
                    childCount: context.watch<Model1>().article_list.length,

                    (context, index) {
                      // print("context.watch<Model1>().article_list");
                      // print(context.watch<Model1>().article_list);
                      return Container(
                          //color: Color.fromARGB(255, 255, 255, 255),
                          //height: 500, //给listview设定高度
                          child: Row(children: [
                        Expanded(
                            child:
                                // Scrollbar(
                                //   child:

                                GestureDetector(
                                    //添加触摸动作事件onTap
                                    child: Container(
                          height: 200,
                          margin: EdgeInsets.all(10),
                          //padding: EdgeInsets.all(10),
                          // alignment: Alignment.center,
                          // color: Color.fromARGB(255, 255, 255, 255),
                          child: Card(
                            // color: Color.fromARGB(255, 61, 177, 255), // 背景色
                            // shadowColor:
                            //     Color.fromARGB(255, 255, 205, 25), // 阴影颜色
                            elevation: 20, // 阴影高度
                            borderOnForeground:
                                false, // 是否在 child 前绘制 border，默认为 true
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10), // 外边距

                            // 边框
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.yellow,
                                width: 1,
                              ),
                            ),
                            child:
                                // Expanded(//
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // children: <Widget>[

                                Wrap(
                                    direction: Axis.horizontal,
                                    spacing: MediaQuery.of(context).size.width <
                                            700
                                        ? 100.0
                                        : 100, // 主轴(水平)方向间距.获取屏幕宽度根据宽度调节水平方向的元素控件间距,达到pc端间隔设置小点100,而手机端则间隔拉大1000使元素可以独自在一行上
                                    // spacing:40.0,
                                    runSpacing: 40.0, // 纵轴（垂直）方向间距
                                    alignment: WrapAlignment.center, //沿主轴方向居中
                                    runAlignment:
                                        WrapAlignment.center, //y轴方向的对齐方式
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center, //水平居中
                                    children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text("序号:${index}  ")),
                                      Expanded(
                                          child: Text(
                                              "岗位:${map_gangwei[int.parse(context.watch<Model1>().article_list[index]["gangwei"])]}")),
                                      Expanded(
                                          child: Text(
                                              "学历:${context.watch<Model1>().article_list[index]["xueli"]}")),
                                      Expanded(
                                          child: Text(
                                              "薪酬:${context.watch<Model1>().article_list[index]["xinchou"]}")),
                                      Expanded(
                                          child: Text(
                                              "全职:${context.watch<Model1>().article_list[index]["quanzhi"]}")),

                                      Expanded(
                                          child: Text(
                                              "地点:${context.watch<Model1>().article_list[index]["dizhi"]}")),
                                      Expanded(
                                          child: Text(
                                              "ID:${context.watch<Model1>().article_list[index]["id"]}")),
                                      Expanded(
                                        child: Text(
                                            "公司:${context.watch<Model1>().article_list[index]["gong_si_ming"]}"),
                                      ),
                                      Expanded(
                                        child: Text(
                                            "招聘数:${context.watch<Model1>().article_list[index]["renshu"]}"),
                                        // color: Colors.black12,
                                      ),

                                      // Expanded(
                                      //   child: Text(
                                      //       "应聘数:${list_yingpinzhe_id[index].length}"),
                                      //   // color: Colors.black12,
                                      // ),

                                      // Row(
                                      //     children: List<Widget>.generate(
                                      //         list_yingpinzhe_id[index]
                                      //             .length, (index1) {
                                      //   return Text(
                                      //       "应聘者id:${list_yingpinzhe_id[index][index1]["id"]},");
                                      // })),
                                      // Row(
                                      //     children: List<Widget>.generate(
                                      //         list_yingpinzhe_id[index]
                                      //             .length, (index2) {
                                      //   return Text(
                                      //       "应聘者name:${list_yingpinzhe_id[index][index2]["name"]},");
                                      // })),

                                      ElevatedButton.icon(
                                        icon: Icon(Icons.article),
                                        // style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             primary)),
                                        label: Text("详细"),
                                        // color: Colors.black12,
                                        onPressed: () {
                                          Get1.Get.to(Zhaopin_xiangqing(
                                            id: article_list[index]["id"],
                                            gong_si_ming: article_list[index]
                                                ["gong_si_ming"],
                                            gangwei: article_list[index]
                                                ["gangwei"],
                                            xueli: article_list[index]["xueli"],
                                            renshu: article_list[index]
                                                ["renshu"],
                                            yaoqiu: article_list[index]
                                                ["yaoqiu"],
                                            baoxian: list_baoxian[index],
                                            xinchou: article_list[index]
                                                ["xinchou"],
                                            lianxifangshi: article_list[index]
                                                ["lianxifangshi"],
                                            liulanshu: article_list[index]
                                                ["liulanshu"],
                                            created_at: article_list[index]
                                                ["created_at"],
                                            updated_at: article_list[index]
                                                ["updated_at"],
                                            list_yingpinzhe_id:
                                                list_yingpinzhe_id[index],
                                            kaishishijian: article_list[index]
                                                ["kaishishijian"],
                                            jieshushijian: article_list[index]
                                                ["jieshushijian"],
                                            youxiang: article_list[index]
                                                ["youxiang"],
                                            tupian: list_zhaopin_pics[index],
                                            qita: article_list[index]["qita"],
                                            quanzhi: article_list[index]
                                                ["quanzhi"],
                                            dizhi: article_list[index]["dizhi"],
                                            gongzuonianxian: article_list[index]
                                                ["gongzuonianxian"],
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //     children: List<Widget>.generate(
                                  //         list_baoxian[index].length, (index1) {
                                  //   return Text(
                                  //       "${list_baoxian[index][index1]},");
                                  // })),

                                  // Text(
                                  //     article_list[index]["id"].toString()),

                                  // Icon(
                                  //   Icons.party_mode,
                                  //   size: 100,
                                  // ),

//  ),

//           Expanded(
//                        flex:4,
//    child:

                                  // Column(
                                  //   children: <Widget>[
                                  //     Text(article_list[index]
                                  //             ["gong_si_name"]
                                  //         .toString()),
                                  //     Text(article_list[index]["gang_wei"]
                                  //         .toString()),
                                  //   ],
                                  // ),

// ),

                                  //  Column(
                                  //   children: <Widget>[
                                  //    Expanded(

                                  //                    flex:8,
                                  // child:
                                  // Column(children: <Widget>[
                                  //   Text(article_list[index]["bao_xian"]
                                  //       .toString()),
                                  //   Text(article_list[index]["xin_chou"]
                                  //       .toString()),
                                  //   Text(article_list[index]["xue_li"]
                                  //       .toString()),
                                  // ]),
                                  // ),
                                  //  ],
                                  //  ),

//            Expanded(
//                        flex:2,
//    child:

                                  // Column(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     ElevatedButton(
                                  //         onPressed: () {},
                                  //         child: Text("查看"))
                                  //   ],
                                  // )

//  ),
                                ]),

                            //      ),

                            // ]
                          ),
                        ))),
                      ]));
                    },
                  ),
                )
              ],
              //  )
            )));
  }
}
