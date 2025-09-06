import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart'; //调用弹出吐司框
import 'package:dio/dio.dart';
import 'package:flutter_gf_view/widgets/http.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import '/widgets/pagenum.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:flutter_gf_view/model1.dart';
// import 'package:flutter_gf_view/user/rencaizhaopin/rencaizhaopin.dart';
import 'dart:math' as math;
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/foundation.dart';
// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import "/common.dart";
import 'package:intl/intl.dart'; //时间格式化
import 'package:flutter_localizations/flutter_localizations.dart'; //国际化,时间选择需要使用
import 'package:get/get.dart' as Get;
import 'dart:async'; //引入局部刷新组件的控制器StreamController
import '../../../widgets/article_xiang_qing.dart';
import '../../../widgets/wenzhangbianji.dart';
import '../../../widgets/sou_suo.dart'; //引入搜索组件

class wenzhanguanli extends StatefulWidget {
  const wenzhanguanli({Key? key}) : super(key: key);

  @override
  _houtaishezhi1State createState() => _houtaishezhi1State();
}

var article_list = [];

class _houtaishezhi1State extends State<wenzhanguanli>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // @override
  // Widget build(BuildContext context) {
  //   //super.build(context);
  //   print("文章管理build");
  //   return   Wen8zhang8guan8li();
  // }
// }

// class Wen8zhang8guan8li extends StatefulWidget {
//   const Wen8zhang8guan8li({Key? key}) : super(key: key);

//   @override
//   _Wen8zhang8guan8liState createState() => _Wen8zhang8guan8liState();
// }

// class _Wen8zhang8guan8liState extends State<Wen8zhang8guan8li> {
  int data_count = 0;
  int ii = -1;
  var json_result = [];

  ScrollController controller1 = new ScrollController();
  var biao_ti;
  int page = 0;
  bool load = true;
  late Response response;
  List<String> list_zuozhe = <String>['1', 'Two', 'Three', 'Four'];
//定义一个controller
  TextEditingController _unameController = TextEditingController();
  String dropdownValue = "";
  String dropdownValue1 = "";
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  StreamController _streamController2 = StreamController<dynamic>();
  StreamController _streamController1 = StreamController<dynamic>();
  List<String> list_zhiding = []; //存放置顶的控制器
  List<String> list_jinghua = []; //存放精华的控制器

  StreamController<String> streamController3 = StreamController();
  int shuaxin_id = -1; //文章管理列表中需要刷新的文章id
  int fenlei_id = 0;
  bool is_clear = false;
  List<String> fenlei = ["分类"];
  List<String> fenlei2 = [];
  List<dynamic> fenlei_name_id = [];
  String fenlei1 = "";
  String zhiding = "";
  String jinghua = "";
  bool is_search = false; //是搜索还是全部查询
  @override
  void dispose() {
    super.dispose();
    article_list.clear();
    // for (int i = 0; i < streamController_zhiding.length; i++) {
    //   streamController_zhiding[i].close();
    // }
    // for (int i = 0; i < streamController_jinghua.length; i++) {
    //   streamController_jinghua[i].close();
    // }
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
      ("id:" + (context.watch<Model1>(). article_list1[index]["id"]).toString()) +
          "标题:" +
         context.watch<Model1>(). article_list1[index]["biaoti"],
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 20,
      ),
    ); //json_result[index]["id"]
    //Text((article_list[index]["id"]).toString());//整形转字符串toString,字符串到int/double:int.parse('1234')
  }

  Widget _subtitle(int index) {
    return Text(article_list[index]["zhaiyao"]
        .toString()); //substring(0,i)取字符串的前i个字符.substring(i)去掉字符串的前i个字符.
  }

  Widget _riqi(int index) {
    return Text("日期:" +context.watch<Model1>(). article_list1[index]["updated_at"].toString());
  }

  Widget _zuozhe(int index) {
    return Text("作者:" +context.watch<Model1>(). article_list1[index]["zuozhe"].toString());
  }

  Widget _id(int index) {
    return Text(article_list[index]["id"]);
  }

  Widget _suo_lue_tu(int index) {
    return Image.network(
     context.watch<Model1>(). article_list1[index]["suoluetu"],
      height: 50 * 0.618,
      width: 50,
    );
  }

  void set_zhiding_jinghua(int id, String zhiding, String jinghua) async {
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
      contentType:
          "application/json", //默认json传输.配合'Content-Type':'application/json',
    );
    Dio dio = Dio(options);

    print("文本:${title_control?.text}");
    FormData formData1 = new FormData.fromMap({
      "id": id,
      // "biaoti": title_control?.text,
      // "zuozhe": author_control?.text,
      // "zhaiyao": zhaiyao_control?.text,
      // "suoluetu": thumbnail,
      // "neirong": content_json,

      // "fenleiid": fenlei_id,
      "zhiding": zhiding, //置顶
      "jinghua": jinghua, //精华
    });
    var response = await dio.post(
      map0api["修改文章置顶精华"]!,
      data: formData1,
      queryParameters: {"token": token},
    );
    print("服务器返回数据是:${response.data}");
    if (response.statusCode == 200) {
      if (response.data["data"] == "ok") {
        // list = response.data["data"];
        // print(list["id"]);
        print("上传成功!");
        // setState(() {});
        Get.Get.defaultDialog(
          title: "提示",
          middleText: "设置成功了!",
          barrierDismissible: false, //	是否可以通过点击背景关闭弹窗
          confirm: ElevatedButton(
              onPressed: () {
                print("上传成功!");
                //  streamController[0].add("1");
                Get.Get.back();
                // Get.Get.toNamed(
                //     "/a"); //跳到后台登录页
              },
              child: Text("确定")),
          // // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
        );
      } else {
        // show_dialog(context, "设置失败");
        Get.Get.defaultDialog(
          title: "提示",
          middleText: "设置失败!",
          confirm: ElevatedButton(
              onPressed: () {
                // Get.Get.toNamed(
                //     "/a"); //跳到后台登录页
              },
              child: Text("确定")),
          // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
        );
      }
    }
  }

  void search(int page) async {
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
      if (is_clear) fenlei_id = 0;
      response = await dio.post(map0api["指定条件获取文章"]!, queryParameters: {
        "token": token,
        "Biaoti": (controller.text), //标题
        "Zuozhe": (controller4.text), //作者
        "Riqi1": (controller2.text), //日期
        "Riqi2": (controller3.text), //日期
        "Fenleiid": fenlei_id == 0 ? "" : fenlei_id, //分类id
        "Page": page, //页
      });

      if (response.statusCode == 200) {
        print("返回请求结果是:");
        print(response.data["data"]["res"]);
        if (response.data["code"] == "0") {
          if (response.data["data"]["res"] == null) {

        //     if(is_search&&load==true){  is_search=false;
        //      Get.Get.snackbar("结果", "未查到数据!",
        // snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
             
        //     print('未查到数据');
        //       // Provider.of<Model1>(context, listen: false).get_article([]);
        //          article_list.insertAll(
        //         article_list.length, response.data["data"]["res"]);
        //        Provider.of<Model1>(context, listen: false).get_article(article_list);//此处获取值给article_list2
              
              
        //       }

            load = false;
          } else {
             
            article_list.insertAll(
                article_list.length, response.data["data"]["res"]);
               Provider.of<Model1>(context, listen: false).get_article(article_list);//此处获取值给article_list2
            load = true;
            yinying = List.filled(
                article_list.length, Colors.blue); //填充card组件的阴影默认值为5
            // streamController_zhiding = [];
            // streamController_jinghua = [];
            // for (int i = 0; i < article_list.length; i++) {
            //   streamController_zhiding.add(StreamController());
            //   streamController_jinghua.add(StreamController());
            // }

            //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
          }  

          print("搜索文章:");
          // print(article_list);
          print(article_list.length);

          //   print("article_list结束");
          // return  print(json_result[0]["biao_ti"]);

          setState(() {
            //搜索时候必须刷新页面,否则listview还是显示原有的信息.必须在这里进行刷新.如果在search()结束后返回的函数中进行刷新,就不起作用了
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void get_count() async {
    late Response response;
    int dataCount;
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
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        //  baseUrl: "http://baidu.com/",
      );

      //Dio  dio = new Dio(options);
      //Response response = await dio.get("http://baidu.com/", queryParameters: {"id": 12, "name": "wendu"});
      // print('page:');
      // print(page);
      //此url地址本地可以 ,部署后会发现localhost无法访问,应该写成域名
      //response = await dio.get("http://localhost/index/index/api_getcount/",queryParameters: {});
      response = await dio.get(map0api["获取全部文章数量"]!, queryParameters: {
        "token": token,
      });
      // data_count = int.parse(response.data["data"]["Num"].toString());//类型转换,字符串转整型
      dataCount = response.data["data"]["Num"];
      print("data_count:");
      print(dataCount);

      // print("文章列表");
      // print(response.data["data"]["res"]);
      // article_list = response.data["data"]["res"];
      // print("处理:");
      // print(article_list[0]["id"]);
      // print(article_list[0]["biaoti"]);
      // return  print(json_result[0]["biao_ti"]);

      setState(() {
        //biao_ti= json_result[0]["biao_ti"];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> get_data1(int page2) async {
    //https://blog.csdn.net/u011272795/article/details/83010974
    page = page2; //赋值全局变量
    await Future.delayed(Duration(seconds: 0), () async {
      //延时触发.测试用
      try {
        Dio dio = Dio(); // 使用默认配置

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

        //  print('page:');
        // print(page);
        //response = await dio.get("http://localhost/index/index/api_getdata/",queryParameters: {"page": page});此url地址本地可以 ,部署后会发现localhost无法访问,应该写成域名或者直接/

        response = await dio.get(map0api["获取文章"]!,
            queryParameters: {"page": page2, "token": token});
        // print(response.data["data"]);
        // print("服务器返回数据是:${response.data}");
        if (response.statusCode == 200) {
          if (response.data["code"] == "0") {
            if (response.data["data"] == null) {
              // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
              Get.Get.snackbar("提示窗:", "没有更多数据",
                  snackPosition: SnackPosition.BOTTOM);
              load = false;
              print('加载到最后');
            } else {
              // article_list.clear();


            
              article_list.insertAll(
                  article_list.length, response.data["data"]);
             Provider.of<Model1>(context, listen: false).get_article(article_list);//此处获取值给article_list2
              yinying = List.filled(
                  article_list.length, Colors.blue); //填充card组件的阴影默认值为5
              load = true;
            }

            print("文章个数:");
            print(article_list.length);
            // print(load);

            //   print("article_list结束");
            // return  print(json_result[0]["biao_ti"]);
            //   return true;
            //  setState(() {});
          }
        }
      } catch (e) {
        print(e);
      }
    });
    return true;
  }

//加载更多

  Future _loadMoreData() async {
    print('加载更多');
    Get.Get.snackbar("提示窗:", "加载更多", snackPosition: SnackPosition.BOTTOM);
    await Future.delayed(Duration(seconds: 0), () {
      page = page + 1;
      if (!is_search) {
        get_data1(page).then((value) => setState(
            () {})); //then保障get_data1返回后再执行刷新工作.否则还没有到返回,就已经刷新了界面,就导致没有更新界面
      } else //按条件搜
        search(page);
    });
  }
 
   Future _search_loadMoreData() async {
    print('加载更多');
    Get.Get.snackbar("提示窗:", "加载更多", snackPosition: SnackPosition.BOTTOM);
    await Future.delayed(Duration(seconds: 0), () {
      page = page + 1;
      if (!is_search) {
        get_data1(page).then((value) => setState(
            () {})); //then保障get_data1返回后再执行刷新工作.否则还没有到返回,就已经刷新了界面,就导致没有更新界面
      } else //按条件搜
        search(page);
    });
  }


  DateTime _datetime = DateTime.now();

  Future get_fenlei() async {
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
          await YXHttp().http_get(map0api["获取文章分类"]!,   {"token": token});
      print("返回获取文章分类是:${response}");
     
          // print("成功!");
          List<dynamic> res = response ;
          fenlei_name_id = res;
          // thumbnail = s1;
          //   host_url + s1.substring(1); //从第2个字符开始截取
          // print(fenlei_name_id[0]["id"]);

          for (var i = 0; i < res.length; i++) {
            fenlei.add(res[i]["fenlei_name"]);
            fenlei2.add(res[i]["fenlei_name"]);
          }

          //  var data = await Future.delayed(Duration(seconds: 5), () => {  setState(() {

          //  // print("get_fenlei执行了");
          // })});
 
          setState(() {

            print("get_fenlei执行了");
          }); //没有此句分类按钮不显示分类内容
       
    }
  }

  Future cha_xun_wen_zhang(int index, int id, String str) async {
    try {
      Dio dio = Dio(); // 使用默认配置

      var options = BaseOptions(
       connectTimeout:Duration(seconds: connectTimeout0),
        receiveTimeout:Duration(seconds: connectTimeout0),
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
      response = await dio.post(map0api["指定条件获取文章"]!,
          queryParameters: {"Id": id, "Page": 1, "token": token});
      print(response.data);
      if (response.data["code"] == "0") {
        zhiding = "";
        jinghua = "";
        zhiding = response.data["data"]["res"][0]["zhiding"]; //置顶
        jinghua = response.data["data"]["res"][0]["jinghua"]; //精华
        if (str == "置顶") {
          zhiding = zhiding == "1" ? "0" : "1";
          // streamController_zhiding[index].add(zhiding); //给精华控制器添加数据,使之刷新
        } else if (str == "精华") {
          jinghua = jinghua == "1" ? "0" : "1";
          // streamController_jinghua[index].add(jinghua); //给精华控制器添加数据,使之刷新
        }

        set_zhiding_jinghua(id, zhiding, jinghua);
        print('加载到最后');
        // load = false;
      } else {
        // load = true;
        // article_list.insertAll(article_list.length, response.data["data"]);
        //.BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }

      // print("ffff:${response.data["article"][0]}");
      // json_result = convert.jsonDecode(response.data["article"].toString());
      //   print("json_result:${json_result}");
      //  article_list.addAll(json_result);

      // article_list = response.data["article"];
      // print("article_list开始1");
      // print(article_list);

      // print("article_list开始2");
      // print(article_list);

      //   print("article_list结束");
      // return  print(json_result[0]["biao_ti"]);

      // setState(() {
      //   //biao_ti= json_result[0]["biao_ti"];
      // });
//      print(response.headers);
//      print(response.request);
//      print(response.statusCode);
      // Dio().get("http://www.baidu.com");
      //  print("baidu请求:");//print(response);
    } catch (e) {
      print(e);
    }
  }

  var _yibu;
  @override
  void initState() {
    super.initState();
    print("文章管理initState");
    // _streamController1.sink.add(list_zuozhe.first);
    // dropdownValue = list_zuozhe.first; //下拉按钮默认显示的值
    _streamController2.sink.add(fenlei.first);
    // dropdownValue = fenlei.first; //下拉按钮默认显示的值
    // streamController = List.generate(10, (value) => _streamController2[value + 1]);
    // StreamController<String>
    // List<int> aaa = [];
    // aaa.add(1);
    // streamController = List.filled(10, 1);

    //  get_count();
    get_fenlei();
    _yibu = get_data1(1);

    //监听滚动事件，打印滚动位置
    controller1.addListener(() {
      var pix = controller1.position.pixels;
      var max = controller1.position.maxScrollExtent;
      if (pix == max) {
        //已下拉到底部，调用加载更多方法
//        if(is_search){

//  _search_loadMoreData();

//        }else 
       
       if (load) {
       _loadMoreData();
          
        }


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("文章管理build");
    // dynamic shuaxin_id = Get.Get.arguments;
    // print("shuaxin_id:");
    // print(shuaxin_id);
   Model1 model1=   context.watch<Model1>();
    return Center(
        child: ListView(
            //   controller: controller1,
            children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 5.0, // 主轴(水平)方向间距
                      runSpacing: 4.0, // 纵轴（垂直）方向间距

                      crossAxisAlignment:
                          WrapCrossAlignment.center, //可解决不同组件的中心对齐
                      alignment: WrapAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 30,
                          child: SearchWidget(controller: controller), //sous搜索框
                        ),

                        Text("作者:"),
                        Container(
                            width: 100, //height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextField(
                              controller: controller4,
                            )),
                        // StreamBuilder<dynamic>(
                        //   //局部刷新控件
                        //   stream: _streamController1.stream,
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<dynamic> snapshot) {
                        //     if (snapshot.hasData) {
                        //       dropdownValue = snapshot.data.toString();
                        //       // TODO: do something with the data
                        //       return DropdownButton<String>(
                        //           value: dropdownValue, //下拉框显示的默认文字值
                        //           items: list_zuozhe
                        //               .map<DropdownMenuItem<String>>((String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(value),
                        //             );
                        //           }).toList(),
                        //           onChanged: (String? value) {
                        //             print(value);
                        //             _streamController1.sink
                        //                 .add(value); //g给streambuild添加数据
                        //             // setState(() {
                        //             //   dropdownValue = value!;
                        //             // });
                        //           });
                        //     } else if (snapshot.hasError) {
                        //       // TODO: do something with the error
                        //       return Text(snapshot.error.toString());
                        //     }
                        //     // TODO: the data is not ready, show a loading indicator
                        //     return Center(child: CircularProgressIndicator());
                        //   },
                        // ),

                        Text("分类:"),
                        StreamBuilder<dynamic>(
                          //局部刷新控件.可以避免使用setstate()
                          stream: _streamController2.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              dropdownValue1 = snapshot.data
                                  .toString(); //修改控件显示当前的选项,否则控件显示不更新
                              // print("dropdownValu1e");
                              // print(dropdownValue1);
                              return DropdownButton<String>(
                                  value: dropdownValue1, //下拉框显示的默认文字值
                                  items: fenlei.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ); //数据刷新组件的所有内容项
                                  }).toList(),
                                  onChanged: (String? value) {
                                    is_clear = false;
                                    print(value);
                                    _streamController2.sink.add(
                                        value); //给streambuild添加不重复的数据,重复会报错.可以使局部控件显示当前的选择项2
                                    fenlei_id = 0;
                                    for (var i = 0;
                                        i < fenlei_name_id.length;
                                        i++) {
                                      if (value ==
                                          fenlei_name_id[i]["fenlei_name"]) {
                                        //当选择下拉文本时,获取文本对应的id
                                        print(fenlei_name_id[i]["id"]);
                                        fenlei_id = fenlei_name_id[i]["id"];
                                        break;
                                      }
                                    }
                                  });
                            } else if (snapshot.hasError) {
                              // TODO: do something with the error
                              return Text(snapshot.error.toString());
                            }
                            // TODO: the data is not ready, show a loading indicator
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                        Text("发布日期:"),

                        Container(
                          width: 200, //height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextField(
                              controller: controller2,
                              decoration: InputDecoration(
                                hintText: "选择日期",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                // contentPadding: EdgeInsets.only(bottom:  / 3),
                                border: InputBorder.none,
                                icon: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: IconButton(
                                      splashRadius: 15.0,
                                      icon: const Icon(
                                        Icons.date_range,
                                        size: 17,
                                      ),
                                      onPressed: () async {
                                        // var locale = Locale('zh', 'CN');
                                        //     GetX.Get.updateLocale(locale);
                                        var date = await showDatePicker(
                                          context: context,
                                          initialDate: _datetime,
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(2900),
                                          locale: Locale(
                                              'zh'), //需要在本页的派生的状态根控件上包裹MaterialApp,添加国际化语言支持
                                        );
                                        if (date == null) return;

                                        setState(() {
                                          print(DateFormat("yyyy-MM-dd ")
                                              .format(date)
                                              .toString());
                                          _datetime = date;
                                          controller2.text =
                                              DateFormat("yyyy-MM-dd ")
                                                  .format(date)
                                                  .toString(); //设置编辑框控件内容为日期
                                        });
                                      }),
                                ),
                              ),
                              onEditingComplete: () {
                                //   widget.onEditingComplete?.call(controller.text);
                              }),
                        ),
                        Container(
                          width: 200, //height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextField(
                              controller: controller3,
                              decoration: InputDecoration(
                                hintText: "选择日期",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                // contentPadding: EdgeInsets.only(bottom:  / 3),
                                border: InputBorder.none,
                                icon: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: IconButton(
                                      splashRadius: 15.0,
                                      icon: const Icon(
                                        Icons.date_range,
                                        size: 17,
                                      ),
                                      onPressed: () async {
                                        // var locale = Locale('zh', 'CN');
                                        //     GetX.Get.updateLocale(locale);
                                        var date = await showDatePicker(
                                          context: context,
                                          initialDate: _datetime,
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(2900),
                                          locale: Locale(
                                              'zh'), //需要在本页的派生的状态根控件上包裹MaterialApp,添加国际化语言支持
                                        );
                                        if (date == null) return;

                                        setState(() {
                                          print(DateFormat("yyyy-MM-dd ")
                                              .format(date)
                                              .toString());
                                          _datetime = date;
                                          controller3.text =
                                              DateFormat("yyyy-MM-dd ")
                                                  .format(date)
                                                  .toString(); //设置编辑框控件内容为日期
                                        });
                                      }),
                                ),
                              ),
                              onEditingComplete: () {
                                //   widget.onEditingComplete?.call(controller.text);
                              }),
                        ),
                        Container(
                          width: 150,
                          child: ButtonBar(
                            buttonMinWidth: 5,
                            children: [
                              ElevatedButton(
                                child: const Text('搜索'),
                                onPressed: () async {
                                  article_list = [];
                                  page = 1;
                                  is_search =
                                      true; //启用搜索标记.启用后下拉刷新决定用搜索api还是加载全部文章api
                                  print(controller.text); //标题
                                  print(controller4.text); //作者
                                  print(dropdownValue1); //分类
                                  print(controller2.text); //日期
                                  print(controller3.text); //日期
                                // article_list.clear();  
                                 search(1);
                                  //                 setState(() {//此处刷新不行的.因为搜索api返回的数据有延时,这里刷新的时候,api并未返回数据,因此界面无显示
                                  //    //搜索时候必须刷新页面,否则listview还是显示原有的信息
                                  // });
                                },
                              ),
                              ElevatedButton(
                                child: const Text('清除'),
                                onPressed: () {
                                  page = 1;
                                  controller2.clear();  controller.clear();
                                  controller3.clear();  controller4.clear();

                                  article_list = [];
                                  // fenlei.clear();
                                  is_clear = true; //清除标记为1
                                  _streamController2.sink
                                      .add(fenlei[0]); //影响分类下拉框
                                  is_search = false; //关闭搜索标记
                                 // setState(() {});
                                  get_data1(1);
                                },
                              ),

                                   ElevatedButton(
                                child: const Text('获取pagenum'),
                                onPressed: () {
                            print(    model1.article_list1);
                            // print(   context.watch<Model1>().article_list1);
                             print(    Provider.of<Model1>(context, listen: false).article_list1);//方法2
                    article_list.clear();
                   
                     article_list=        model1.article_list1;
                                  setState(() {});
                           
                                },
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 20,
                color: Color.fromARGB(255, 236, 234, 234),
              ),
              FutureBuilder<bool>(
                  //异步加载dio数据
                  future: _yibu, //get_data1(1),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    // print("snapshot.data");
                    // print(snapshot.data);
                    if (snapshot.data == true) {
                      return Container(
                        alignment: Alignment.center,
                        height: 600,
                        child: ListView.builder(
                          // addAutomaticKeepAlives: false,
                          controller: controller1,
                          itemCount: context.watch<Model1>().article_list1.length, //(page+1)*10,
                          //此处直接给具体数字初始显示时汇报个错: RangeError (index): Index out of range: no indices are valid: 0
                          // itemCount:5,   //列表项构造器
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              //添加触摸动作事件onTap
                              child: Container(
                                  height: 200,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10),
                                  //padding: EdgeInsets.all(10),
                                  //   color: Colors.yellow,
                                  child: Card(
                                    color: Color.fromARGB(
                                        255, 61, 177, 255), // 背景色
                                    shadowColor: Color.fromARGB(
                                        255, 255, 205, 25), // 阴影颜色
                                    elevation: 20, // 阴影高度
                                    borderOnForeground:
                                        false, // 是否在 child 前绘制 border，默认为 true
                                    margin: EdgeInsets.fromLTRB(
                                        0, 10, 0, 10), // 外边距

                                    // 边框
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: Colors.yellow,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 0,
                                            child: Text("序号:${index}")),
                                        Expanded(
                                            flex: 0, child: _suo_lue_tu(index)),
                                        Expanded(
                                            flex: 0,
                                            child: Text(fenlei2[
                                               context.watch<Model1>(). article_list1[index]
                                                        ["fenleiid"] -
                                                    1])),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            // width:MediaQuery.of(context).size.width-800,
                                            alignment: Alignment.center,
                                            child:
                                                //   Row(
                                                // children: <Widget>[
                                                Wrap(
                                                    spacing: 10.0, // 主轴(水平)方向间距
                                                    runSpacing:
                                                        4.0, // 纵轴（垂直）方向间距
                                                    // runAlignment: WrapAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center, //可解决不同组件的中心对齐
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // width: 400,
                                                      child: ListTile(
                                                        leading:
                                                            Transform.rotate(
                                                          //旋转90度
                                                          angle: math.pi / 2,
                                                          child: Icon(
                                                            Icons.touch_app,
                                                            size: 10,
                                                          ),
                                                        ),
                                                        title: _title(index),
                                                        //  subtitle: _subtitle(index),
                                                      )),
                                                ]),
                                            //   ],
                                            // )
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // width:MediaQuery.of(context).size.width-800,
                                            alignment: Alignment.center,
                                            child:
                                                //   Row(
                                                // children: <Widget>[
                                                Wrap(
                                                    spacing: 10.0, // 主轴(水平)方向间距
                                                    runSpacing:
                                                        4.0, // 纵轴（垂直）方向间距
                                                    // runAlignment: WrapAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center, //可解决不同组件的中心对齐
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                  Container(
                                                    // width: 200,
                                                    // height: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: _riqi(index),
                                                  ),
                                                ]),
                                            //   ],
                                            // )
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // width:MediaQuery.of(context).size.width-800,
                                            alignment: Alignment.center,
                                            child:
                                                //   Row(
                                                // children: <Widget>[
                                                Wrap(
                                                    spacing: 10.0, // 主轴(水平)方向间距
                                                    runSpacing:
                                                        4.0, // 纵轴（垂直）方向间距
                                                    // runAlignment: WrapAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center, //可解决不同组件的中心对齐
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                  Container(
                                                    //width: 200,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: _zuozhe(index),
                                                  ),
                                                ]),
                                            //   ],
                                            // )
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Jubu_shuaxin(
                                                key: UniqueKey(),
                                                index:
                                                    index) //UniqueKey唯一key,每次调用都会生成唯一的key
                                            ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // width:MediaQuery.of(context).size.width-800,
                                            alignment: Alignment.center,
                                            child:
                                                //   Row(
                                                // children: <Widget>[
                                                Wrap(
                                                    spacing: 30.0, // 主轴(水平)方向间距
                                                    runSpacing:
                                                        4.0, // 纵轴（垂直）方向间距
                                                    // runAlignment: WrapAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center, //可解决不同组件的中心对齐
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                  // Container(
                                                  //     alignment: Alignment.centerLeft,
                                                  //     width: 400,
                                                  //     child:

                                                  ButtonBar(
                                                    //目前显示的是水平,想一开始就垂直,需要调整expanded的flex的2
                                                    alignment: MainAxisAlignment
                                                        .center,
                                                    overflowButtonSpacing:
                                                        2.0, //按钮的距离
                                                    children: [
                                                      ElevatedButton(
                                                        child: const Text('编辑'),
                                                        onPressed: () async {
                                                          print(article_list[
                                                              index]);
                                                          //result会在页面返回后,再继续往下执行赋值操作
                                                          var result =
                                                              await Get.Get.to(
                                                                  wenzhang_bianji(
                                                            id: article_list[
                                                                index]["id"],
                                                            title: article_list[
                                                                    index]
                                                                ["biaoti"],
                                                            nei_rong:
                                                                article_list[
                                                                        index]
                                                                    ["neirong"],
                                                            zhaiyao:
                                                                article_list[
                                                                        index]
                                                                    ["zhaiyao"],
                                                            suoluetu:
                                                                article_list[
                                                                        index][
                                                                    "suoluetu"],
                                                            fenlei_id:
                                                                article_list[
                                                                        index][
                                                                    "fenleiid"],
                                                            zuo_zhe:
                                                                article_list[
                                                                        index]
                                                                    ["zuozhe"],
                                                          ));
                                                          print(result);
                                                          if (result[
                                                                  "issave"] ==
                                                              1) {
                                                           context.watch<Model1>(). article_list1[index][
                                                                    "fenleiid"] =
                                                                result[
                                                                    "fenlei"];

                                                           context.watch<Model1>(). article_list1[index]
                                                                    ["zuozhe"] =
                                                                result[
                                                                    "zuozhe"];
                                                           context.watch<Model1>(). article_list1[index]
                                                                    ["biaoti"] =
                                                                result[
                                                                    "biaoti"];
                                                           context.watch<Model1>(). article_list1[index][
                                                                    "updated_at"] =
                                                                result["riqi"];

                                                           context.watch<Model1>(). article_list1[index][
                                                                    "suoluetu"] =
                                                                result[
                                                                    "suoluetu"];
                                                            setState(() {});
                                                          }
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        child: const Text('删除'),
                                                        onPressed: () {
                                                          article_list
                                                              .removeAt(index);
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                  // )
                                                ]),
                                            //   ],
                                            // )
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              onTap: () {
                                print('haha');
  //  Get.Get.toNamed("/article_content", parameters: {
  //           "typeid": encryptBase64(
  //              context.watch<Model1>(). article_list1[index]["fenleiid"].toString()),
  //           "id": encryptBase64(article_list[index]["id"].toString()),
  //         }); //等同于Get.Get.toNamed("/article_content?typeid=3&id=111111111111111111111 youxue");//这里参数长度90k多,且浏览器url地址显示各个参数.这里的传统用法是传递一个文章id给文章详情页然后详情页获取这个id.如果考虑文章分页应该再传递一个文章分类的typeid进去.                                                          // Get.Get.to(

                                Get.Get.to(Article_xiang_qing(
                                  //文章详情
source: "0",//0为后台文章管理页面的跳转.1为前台
                                  title: Provider.of<Model1>(context, listen: false). article_list1[index]["biaoti"],
                                  nei_rong: Provider.of<Model1>(context, listen: false). article_list1[index]["neirong"],
                                   id: Provider.of<Model1>(context, listen: false). article_list1[index]["id"],
                                  zuo_zhe: Provider.of<Model1>(context, listen: false). article_list1[index]["zuozhe"],
                                  ri_qi: Provider.of<Model1>(context, listen: false). article_list1[index]["updated_at"],
                                  dianzanshu: Provider.of<Model1>(context, listen: false). article_list1[index]["dianzanshu"],
                                  yuedushu: Provider.of<Model1>(context, listen: false). article_list1[index]["yuedushu"],
                                )); //必须带上参数名,然后是值
                              },
                            );
                          },
                          //分割器构造器
                          //下划线widget预定义以供复用。

                          // separatorBuilder: (BuildContext context, int index) {
                          //   return Divider(thickness: 2.0 * 2); //分割线
                          //   //index % 2 == 0 ? divider1 : divider2;
                          // },
                          //  }
                        ),
                      );
                    } else {
                      return const Text('数据加载中!');
                    }
                  }),
              Pagenum(
                total: 100,
                page: 10,
              )
            ],
          )
        ]));
  }
}

var controller = TextEditingController();

class Jubu_shuaxin extends StatefulWidget {
  int index;
  Jubu_shuaxin({Key? key, required this.index})
      : super(key: key); //key必须传入,否则效果不对
// index=this.index;
  @override
  State<StatefulWidget> createState() => _jubu_shuaxin();
}

List<Color> yinying = [];

class _jubu_shuaxin extends State<Jubu_shuaxin> {
  String zhiding = "";
  String jinghua = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    zhiding = article_list[widget.index]["zhiding"];
    jinghua = article_list[widget.index]["jinghua"];
    print("局部刷新:${widget.index}");
    // print("局部刷新:${article_list}");
    // print("index:${widget.index}");
    // print("zhiding:${zhiding}");
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.zhiding");
    // print(widget.zhiding);
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        // onHover: (event) {
        //   yinying[index] = 10.0;
        //   setState(() {
        //     // print("刷新了");
        //   });
        // },
        onEnter: (event) {
          print("进入");
          setState(() {
            yinying[widget.index] = Colors.cyan;
          });
        },
        onExit: (event) {
          setState(() {
            yinying[widget.index] = Colors.amber;
            // print("刷新了");
          });
        },
        child: Container(
          // width:MediaQuery.of(context).size.width-800,
          color: yinying[widget.index],
          alignment: Alignment.center,
          child:
              //   Row(
              // children: <Widget>[
              Wrap(
                  spacing: 10.0, // 主轴(水平)方向间距
                  runSpacing: 4.0, // 纵轴（垂直）方向间距
                  // runAlignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.center, //可解决不同组件的中心对齐
                  alignment: WrapAlignment.center,
                  children: [
                Column(
                  children: [
                    Row(children: <Widget>[
                      ElevatedButton(
                        child: const Text('置顶'),
                        onPressed: () async {
                          print(11);

                          // setState(() {
                          // zhiding = "1";
                          cha_xun_wen_zhang(widget.index,
                              article_list[widget.index]["id"], "置顶");
                          // });
                        },
                      ),
                      Image.asset(
                        zhiding == "1" ? 'images/zhiding.png' : "images/12.png",
                        //height: 600.0,
                        fit: BoxFit.cover,
                        width: 32,
                      )
                    ]),
                    Row(children: <Widget>[
                      ElevatedButton(
                        child: const Text('精华'),
                        onPressed: () async {
                          // print(11);

                          // setState(() {
                          // zhiding = "1";
                          cha_xun_wen_zhang(widget.index,
                              article_list[widget.index]["id"], "精华");
                          // });
                        },
                      ),
                      Image.asset(
                        jinghua == "1" ? 'images/jinghua.png' : "images/12.png",
                        //height: 600.0,
                        fit: BoxFit.cover,
                        width: 32,
                      )
                    ]),
                  ],
                )
              ]),
          //   ],
          // )
        ));
  }

  Future cha_xun_wen_zhang(int index, int id, String str) async {
    try {
      Dio dio = Dio(); // 使用默认配置

      var options = BaseOptions(
       connectTimeout:Duration(seconds: connectTimeout0),
        receiveTimeout:Duration(seconds: connectTimeout0),
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
      late Response response;
      response = await dio.post(map0api["指定条件获取文章"]!,
          queryParameters: {"Id": id, "Page": 1, "token": token});
      print(response.data);
      if (response.data["code"] == "0") {
        zhiding = response.data["data"]["res"][0]["zhiding"]; //置顶
        jinghua = response.data["data"]["res"][0]["jinghua"]; //精华
        if (str == "置顶") {
          zhiding = zhiding == "1" ? "0" : "1";
          // streamController_zhiding[index].add(zhiding); //给精华控制器添加数据,使之刷新
        } else if (str == "精华") {
          jinghua = jinghua == "1" ? "0" : "1";
          // streamController_jinghua[index].add(jinghua); //给精华控制器添加数据,使之刷新
        }
        article_list[widget.index]["zhiding"] = zhiding;
        article_list[widget.index]["jinghua"] = jinghua;
        setState(() {});
        set_zhiding_jinghua(id, zhiding, jinghua);
        print('加载到最后');
        // load = false;
      } else {
        // load = true;
        // article_list.insertAll(article_list.length, response.data["data"]);
        //.BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }
    } catch (e) {
      print(e);
    }
  }

  void set_zhiding_jinghua(int id, String zhiding, String jinghua) async {
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
      contentType:
          "application/json", //默认json传输.配合'Content-Type':'application/json',
    );
    Dio dio = Dio(options);

    print("文本:${title_control?.text}");
    FormData formData1 = new FormData.fromMap({
      "id": id,
      // "biaoti": title_control?.text,
      // "zuozhe": author_control?.text,
      // "zhaiyao": zhaiyao_control?.text,
      // "suoluetu": thumbnail,
      // "neirong": content_json,

      // "fenleiid": fenlei_id,
      "zhiding": zhiding, //置顶
      "jinghua": jinghua, //精华
    });
    var response = await dio.post(
      map0api["修改文章置顶精华"]!,
      data: formData1,
      queryParameters: {"token": token},
    );
    print("服务器返回数据是:${response.data}");
    if (response.statusCode == 200) {
      if (response.data["data"] == "ok") {
        // list = response.data["data"];
        // print(list["id"]);
        print("上传成功!");
        // setState(() {});
        Get.Get.defaultDialog(
          title: "提示",
          middleText: "设置成功了!",
          barrierDismissible: false, //	是否可以通过点击背景关闭弹窗
          confirm: ElevatedButton(
              onPressed: () {
                print("上传成功!");
                //  streamController[0].add("1");
                Get.Get.back();
                // Get.Get.toNamed(
                //     "/a"); //跳到后台登录页
              },
              child: Text("确定")),
          // // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
        );
      } else {
        // show_dialog(context, "设置失败");
        Get.Get.defaultDialog(
          title: "提示",
          middleText: "设置失败!",
          confirm: ElevatedButton(
              onPressed: () {
                // Get.Get.toNamed(
                //     "/a"); //跳到后台登录页
              },
              child: Text("确定")),
          // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
        );
      }
    }
  }
}
