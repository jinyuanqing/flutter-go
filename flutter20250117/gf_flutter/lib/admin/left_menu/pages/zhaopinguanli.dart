import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart'; //调用弹出吐司框
import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import '/widgets/pagenum.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'dart:convert' as convert; //转换dio网络获得的数据
import 'package:flutter_gf_view/model1.dart';
import '/widgets/zhaopin_edit.dart';
import '/widgets/http.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/foundation.dart';
// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; //时间格式化
import 'package:flutter_localizations/flutter_localizations.dart'; //国际化,时间选择需要使用
import 'package:get/get.dart' as Get;
import 'dart:async'; //引入局部刷新组件的控制器StreamController
import '../../../user/zhaopin/zhaopin_xiangqing.dart';
import '../../../widgets/wenzhangbianji.dart';
import '../../../widgets/sou_suo.dart'; //引入搜索组件
import '/model1.dart';

class zhaopinguanli extends StatefulWidget {
  const zhaopinguanli({Key? key}) : super(key: key);

  @override
  _zhaopinguanliState createState() => _zhaopinguanliState();
}

//  var result = [];
List<dynamic> result =
    []; //空的list所以不能使用下标索引要添加add数据才行,等价于  var result = List(1);//1个长度的list

class _zhaopinguanliState extends State<zhaopinguanli>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // List<dynamic> gangwei_fenlei = [
  //   //列表的列表集合.第一个项为分类,其余为岗位.//这里有个问题就是这个列表必须有2个空列表,否则首次渲染时,navigation_rail菜单会有个报错,提示菜单项少于2项
  // ];
  // Map<dynamic, dynamic> gangwei = {}; //id,岗位名
  List<String> gangwei = ["选择岗位"];

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
  var json_pic;
  ScrollController controller1 = new ScrollController();
  var biao_ti;
  int page = 0;
  bool is_clear = false; //清除标记为1
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
  bool baohan = false;
  StreamController _streamController2 = StreamController<dynamic>();
  StreamController _streamController1 = StreamController<dynamic>();
  List<String> list_zhiding = []; //存放置顶的控制器
  List<String> list_jinghua = []; //存放精华的控制器
  // Map<dynamic, dynamic> map_gangwei = {}; //id,岗位名
  String dropdownValue2 = "";
  String gangwei_id = "";
  StreamController<String> streamController3 = StreamController();
  List<List<String>> list_baoxian = [];
  int fenlei_id = 0;
  // List<String> fenlei = ["选择"];
  List<String> fenlei2 = [];
  List<dynamic> fenlei_name_id = [];
  String fenlei1 = "";
  String zhiding = "";
  String jinghua = "";
  var json_obj;
  List<dynamic> list_yingpinzhe_id = [];
  List<dynamic> list_zhaopin_pics = []; //招聘的图片集合
  List<String> quanzhi = [
    "",
    "全职",
    "兼职",
  ];
  String? quanzhi1;
  String? xueli1;
  String? didian1;
  List<String> didian = [
    "",
    "市区",
    "义县",
    "黑山",
    "北镇",
    "凌海",
  ];
  List<String> xueli = [
    "",
    "无要求",
    "本科以上",
    "本科",
    "专科",
    "高中",
    "初中",
    "小学",
  ];
  bool is_search = false; //是搜索还是全部查询
  @override
  void dispose() {
    super.dispose();
    result.clear();
    // for (int i = 0; i < streamController_zhiding.length; i++) {
    //   streamController_zhiding[i].close();
    // }
    // for (int i = 0; i < streamController_jinghua.length; i++) {
    //   streamController_jinghua[i].close();
    // }
    _streamController1.close;
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
      ("id:" + (result[index]["id"]).toString()) +
          "标题:" +
          result[index]["biaoti"],
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 40,
      ),
    ); //json_result[index]["id"]
    //Text((result[index]["id"]).toString());//整形转字符串toString,字符串到int/double:int.parse('1234')
  }

  Widget _subtitle(int index) {
    return Text(result[index]["zhaiyao"]
        .toString()); //substring(0,i)取字符串的前i个字符.substring(i)去掉字符串的前i个字符.
  }

  Widget _riqi(int index) {
    return Text("发布日期:" + result[index]["updated_at"].toString());
  }

  Widget _zuozhe(int index) {
    return Text("作者:" + result[index]["zuozhe"].toString());
  }

  Widget _id(int index) {
    return Text(result[index]["id"]);
  }

  Widget _suo_lue_tu(int index) {
    return Image.network(
      result[index]["suoluetu"],
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
      if (is_clear) gangwei_id = "";
      response = await dio.post(map0api["招聘信息搜索"]!, queryParameters: {
        "token": token,
        "Gongsiming": (controller.text), //公司名
        "Gangwei": gangwei_id, //岗位id
        "Riqi1": (controller2.text), //日期
        "Riqi2": (controller3.text), //日期
        "Xueli": xueli1, //学历
        "Quanzhi": quanzhi1, //全职
        "Dizhi": didian1,
        "Page": page, //页
        "Zuozhe": zuozhe_controller.text, //作者
      });

      if (response.statusCode == 200) {
        print("返回请求结果是:");
        // print(response.data["data"]["res"]);
        if (response.data["code"] == "0") {
          if (response.data["data"]["res"] == null) {
            // BotToast.showText(text: "没有数据了!"); //弹出一个文本框;
            print('加载到最后');
            load = false;
            setState(() {
              //_yibu = true;
              //搜索时候必须刷新页面,否则listview还是显示原有的信息.必须在这里进行刷新.如果在search()结束后返回的函数中进行刷新,就不起作用了
            });
          } else {
            result.insertAll(result.length, response.data["data"]["res"]);
            print("result长度:");
            print(result.length);
            // print(result);
            load = true;
            yinying =
                List.filled(result.length, Colors.blue); //填充card组件的阴影默认值为5
            //对获取的数据库数据进行解析,获取图片和应聘者的json.
            for (int i = (page - 1) * 10; i < result.length; i++) {
              json_obj = convert.jsonDecode(result[i][
                  "yingpinzhe_id"]); //yingpinzhe_id在数据库中存放的json类型数据.此处dio返回的是json对象,而json对象中的["yingpinzhe_id"]的数据库中的存放结果却是json字符串
              //所以这里需要进行转换成json对象.然后使用json的操作
              json_pic = convert.jsonDecode(result[i]["tupian"]); //存放招聘的图片
              var list2 = List.from(json_obj["应聘者"]);
              var list3 = List.from(json_pic["pics"]);
              list_yingpinzhe_id.add(list2); //应聘者id
              list_zhaopin_pics.add(list3); //应聘的图片
              //   print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(","));

              //  print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(",")[0]);
              //            print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(",")[1]);
              list_baoxian.add(result[i]["baoxian"]
                  .toString()
                  .substring(1, result[i]["baoxian"].toString().length - 1)
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
      // result = response.data["data"]["res"];
      // print("处理:");
      // print(result[0]["id"]);
      // print(result[0]["biaoti"]);
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
          "page": page,
          "token": token,
          //  "YingpinzheId": '''{"应聘者":${json_str1}}''',
        });

        var response = await YXHttp().http_post(map0api["获取招聘岗位"]!,  formData1);
       if(response["num"] !=0) {
            print("获取招聘数据");
            // print(response.data["data"]["res"]);

            // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
            result.insertAll(result.length, response["res"]);
//对获取的数据库数据进行解析,获取图片和应聘者的json.
            for (int i = (page - 1) * 10; i < result.length; i++) {
              json_obj = convert.jsonDecode(result[i][
                  "yingpinzhe_id"]); //yingpinzhe_id在数据库中存放的json类型数据.此处dio返回的是json对象,而json对象中的["yingpinzhe_id"]的数据库中的存放结果却是json字符串
              //所以这里需要进行转换成json对象.然后使用json的操作
              json_pic = convert.jsonDecode(result[i]["tupian"]); //存放招聘的图片
              var list2 = List.from(json_obj["应聘者"]);
              var list3 = List.from(json_pic["pics"]);
              list_yingpinzhe_id.add(list2); //应聘者id
              list_zhaopin_pics.add(list3); //应聘的图片
              //   print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(","));

              //  print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(",")[0]);
              //            print(result[i]["baoxian"].toString().substring(1,result[i]["baoxian"].toString().length -1 ).split(",")[1]);
              list_baoxian.add(result[i]["baoxian"]
                  .toString()
                  .substring(1, result[i]["baoxian"].toString().length - 1)
                  .split(","));
              // list_baoxian.insertAll(
              //     list_baoxian.length,
              //     result[i]["baoxian"]
              //         .toString()
              //         .substring(
              //             1, result[i]["baoxian"].toString().length - 1)
              //         .split(","));
            }
            print("list_baoxian:");
            print(list_baoxian);
            print(list_baoxian.length);
            // int num1 = (List.from(json_obj["应聘者"]).length);
            // print(json_obj["应聘者"][num1 - 1]["id"]);

            // print(list_yingpinzhe_id);
            // print("result.length:");
            // print(result.length);
            // print("result");
            // print(result);
            // print(list_yingpinzhe_id[0][0]["id"]);
            // print(result.length);
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
            print('没有了哦');
            load = false;
              Get.Get.snackbar("提示窗:", "没有了哦!", snackPosition: SnackPosition.BOTTOM);
            //BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
          }
        
        //   print("result结束");
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
      {
        print("page:");
        print(page);
        search(page);
      }
    });
  }

  DateTime _datetime = DateTime.now();

  Future get_gangwei_xifen(int page2) async {
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
      // result.insert(result.length ,json_result);
      // print(json_result.runtimeType);
      // result.addAll(json_result);
      if (response.statusCode == 200) {
        if ((response.data["code"] == "0") &
            (response.data["data"]["res"] != null)) {
          print("获取岗位");
          // print(response.data["data"]["res"]);
          var result = [];
          // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
          result.insertAll(result.length, response.data["data"]["res"]);
          gangwei_fenlei = result;

          print("gangwei_fenlei:");
          print(gangwei_fenlei);
          //根据传递过来的岗位id查岗位名称
          for (var ele in response.data["data"]["id_gangwei"]) {
            //json转map.给list<jsonmap>中的项添加一个键值,必须先把其中的jsonmap变成通过json.decode转成map

            Map a1 = json.decode(json.encode(
                ele)); //json.encode(ele)把ele转为map类型的字符串,再经过json.decode把map字符串转为map
            map_gangwei.addAll({a1["id"]: a1["gangwei"]});
            // gangwei.assign(a1["id"], a1["gangwei"]);
          }
          for (int i = 0; i < gangwei_fenlei.length; i++) {
            fenlei.add(gangwei_fenlei[i][0]); //分类的列表

            // for (var ii = 0; ii < gangwei_fenlei[i].length; ii++) {
            //   gangwei.add(gangwei_fenlei[i][ii]);
            // }
          }
          print("fenlei");
          print(fenlei);
          // print("gangwei");
          // print(gangwei);
          _streamController1.sink.add(fenlei[
              0]); //与  _streamController1.add(fenlei[0]);效果同.把提示信息添加到控制器中,实现刷新组件.添加的值必须是fenlei列表中的值,否则报错

          // int num1 = (List.from(json_obj["应聘者"]).length);
          // print(json_obj["应聘者"][num1 - 1]["id"]);

          // print(list_yingpinzhe_id);
          // print("result.length:");
          // print(result.length);
          //    print("result");
          //  print(result);
          // print(list_yingpinzhe_id[0][0]["id"]);
          // print(result.length);
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
      //   print("result结束");
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
        // result.insertAll(result.length, response.data["data"]);
        //.BotToast.showText(text: "新数据加载完成了!"); //弹出一个文本框;
      }

      // print("ffff:${response.data["article"][0]}");
      // json_result = convert.jsonDecode(response.data["article"].toString());
      //   print("json_result:${json_result}");
      //  result.addAll(json_result);

      // result = response.data["article"];
      // print("result开始1");
      // print(result);

      // print("result开始2");
      // print(result);

      //   print("result结束");
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

  var article_list = [];
  var _yibu;
  @override
  void initState() {
    super.initState();
    print("文章管理initState");
    // quanzhi1 = quanzhi[0]; //初始值必须是在下拉框项中
    // xueli1 = xueli[0];
    // _streamController1.sink.add(list_zuozhe.first);
    // dropdownValue = list_zuozhe.first; //下拉按钮默认显示的值
    // _streamController2.sink.add(fenlei.first); //给流控制器添加值
    // dropdownValue = fenlei.first; //下拉按钮默认显示的值
    // streamController = List.generate(10, (value) => _streamController2[value + 1]);
    // StreamController<String>
    // List<int> aaa = [];
    // aaa.add(1);
    // streamController = List.filled(10, 1);

    //  get_count();
    // get_gangwei_xifen(0);
    _yibu = get_data1(1);
    _streamController1.sink.add(fenlei[0]);
    //监听滚动事件，打印滚动位置
    controller1.addListener(() {
      var pix = controller1.position.pixels;
      var max = controller1.position.maxScrollExtent;
      if (pix == max) {
        //已下拉到底部，调用加载更多方法
        if (load) {
          _loadMoreData();
          //  load = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("文章管理build");
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
                        Text("公司:"),
                        Container(
                          width: 150, height: 30,
                          child: SearchWidget(controller: controller), //sous搜索框
                        ),
                        Text("作者:"),
                        Container(
                          width: 150, height: 30,
                          child: SearchWidget(
                              controller: zuozhe_controller), //sous搜索框
                        ),
                        Text("全/兼:"),
                        StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                            builder:
                                (BuildContext context, StateSetter setState) {
                          print("局部刷新了");
                          return DropdownButton<String>(
                            // 提示文本
                            hint: Text('选择全职'),
                            value: quanzhi1, //初始显示内容
                            items: quanzhi.map<DropdownMenuItem<String>>(//各个项
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ); //数据刷新组件的所有内容项
                            }).toList(),
                            onChanged: (String? value) {
                              print(value);
                              quanzhi1 = value!; //下拉项改变时,把当前下拉项给当前显示内容
                              setState(() {});
                            },
                          );
                        }),
                        StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                            builder:
                                (BuildContext context, StateSetter setState) {
                          print("局部刷新了");
                          return DropdownButton<String>(
                              // 提示文本
                              hint: Text('选择地点'),
                              value: didian1,
                              items: didian.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ); //数据刷新组件的所有内容项
                              }).toList(),
                              onChanged: (String? value) {
                                print(value);
                                didian1 = value!;
                                setState(() {});
                              });
                        }),
                        Text("学历:"),
                        StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                            builder:
                                (BuildContext context, StateSetter setState) {
                          print("局部刷新了");
                          return DropdownButton<String>(
                              // 提示文本
                              hint: Text('选择学历'),
                              value: xueli1, //此值必须包括在items中哦,否则报错
                              items: xueli.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ); //数据刷新组件的所有内容项
                              }).toList(),
                              onChanged: (String? value) {
                                print(value);
                                // baohan = false;
                                xueli1 = value!;
                                setState(() {});
                              });
                        }),
                        Text("岗位:"),
                        StreamBuilder<dynamic>(
                          //局部刷新控件.可以避免使用setstate()
                          // initialData: "选择",
                          stream: _streamController1.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if ((snapshot.hasData)) {
                              // _streamController1.add("硬件");可以实现添加新值.如果sanpshot快照有值了,则把值赋给dropdownValue,也就是当前下拉框的显示值.

                              dropdownValue =
                                  snapshot.data.toString(); //可以使局部控件显示当前的选择项1
                              // dropdownValue = "分类";
                              print("dropdownValue1");
                              print(dropdownValue);
                              return DropdownButton<String>(
                                  hint: const Text("选择类别"), //不起作用
                                  value: dropdownValue, //下拉框显示的默认文字值
                                  items: fenlei.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ); //数据刷新组件的所有内容项
                                  }).toList(),
                                  onChanged: (String? value) {
                                    is_clear = false; //清除标记为0
                                    print(value);
                                    baohan = false;
                                    _streamController1.sink.add(
                                        value); //sink槽口添加一个增加数据的事件,给streambuild添加不重复的数据,重复会报错.可以使局部控件显示当前的选择项

                                    for (var i = 0;
                                        i < gangwei_fenlei.length;
                                        i++) {
                                      if (value == gangwei_fenlei[i][0]) {
                                        //当选择下拉文本时,获取文本对应的分类和岗位列表
                                        print(gangwei_fenlei[i]);
                                        gangwei.clear();
                                        for (var ii = 1;
                                            ii < gangwei_fenlei[i].length;
                                            ii++) {
                                          gangwei.add(gangwei_fenlei[i][ii]);
                                        }
                                        _streamController2.sink.add(gangwei[0]);
                                        // print("gangwei");
                                        // print(gangwei);
                                        baohan = true;
                                        break;
                                      }
                                    }
                                    if (!baohan) {
                                      //选择的值不在列表项中时
                                      //当选择第一个项时,使用默认设置
                                      fenlei_id = 0;
                                      print("请选择一个栏目分类");
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
                        StreamBuilder<dynamic>(
                          //局部刷新控件.可以避免使用setstate()
                          // initialData: "选择岗位",
                          stream: _streamController2.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if ((snapshot.hasData)) {
                              // if (snapshot.data.toString == "") {
                              dropdownValue2 =
                                  snapshot.data.toString(); //可以使局部控件显示当前的选择项1
                              // gangwei_text = dropdownValue2;
                              List<dynamic> list_values = map_gangwei.values
                                  .toList(); //把map_gangwei的值变成list

                              List<dynamic> list_keys = map_gangwei.keys
                                  .toList(); //把map_gangwei的键变成list

                              for (int i = 0; i < list_values.length; i++) {
                                print(list_values[i]);
                                if (list_values[i] == dropdownValue2) {
                                  //如果list_values的元素=当前选项的岗位名称,则取list_keys的值,这个值就是岗位_id

                                  gangwei_id = list_keys[i].toString();
                                }
                              }

                              return DropdownButton<String>(
                                  // hint: const Text("选择岗位"),
                                  value: dropdownValue2, //下拉框显示的默认文字值
                                  items: gangwei.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ); //数据刷新组件的所有内容项
                                  }).toList(),
                                  onChanged: (String? value) {
                                    print(value);
                                    // gangwei_text = value!;
                                    print(map_gangwei.values);
                                    print(map_gangwei.values.runtimeType);
                                    List<dynamic> list_values = map_gangwei
                                        .values
                                        .toList(); //把map_gangwei的值变成list

                                    List<dynamic> list_keys = map_gangwei.keys
                                        .toList(); //把map_gangwei的键变成list

                                    for (int i = 0;
                                        i < list_values.length;
                                        i++) {
                                      print(list_values[i]);
                                      if (list_values[i] == value) {
                                        //如果list_values的元素=当前选项的岗位名称,则取list_keys的值,这个值就是岗位_id

                                        gangwei_id = list_keys[i].toString();
                                      }
                                    }
                                    _streamController2.sink.add(
                                        value); //给streambuild添加不重复的数据,重复会报错.可以使局部控件显示当前的选择项2

                                    if (!baohan) {
                                      //选择的值不在列表项中时
                                      //当选择第一个项时,使用默认设置
                                      fenlei_id = 0;
                                      print("请选择一个栏目分类");
                                    }
                                  });
                            } else if (snapshot.hasError) {
                              // TODO: do something with the error
                              return Text(snapshot.error.toString());
                            }
                            // TODO: the data is not ready, show a loading indicator
                            return Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator());
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
                                  result = [];
                                  page = 1;
                                  is_search =
                                      true; //启用搜索标记.启用后下拉刷新决定用搜索api还是加载全部文章api
                                  print(controller.text); //公司名
                                  print(quanzhi1); //全/兼职
                                  print(xueli1); //学历
                                  print(gangwei_id); //岗位id
                                  print(controller2.text); //日期
                                  print(controller3.text); //日期
                                  search(1);
                                  //                 setState(() {//此处刷新不行的.因为搜索api返回的数据有延时,这里刷新的时候,api并未返回数据,因此界面无显示
                                  //    //搜索时候必须刷新页面,否则listview还是显示原有的信息
                                  // });
                                },
                              ),
                              ElevatedButton(
                                child: const Text('清除'),
                                onPressed: () {
                                  is_clear = true; //清除标记为1
                                  page = 1;
                                  result = [];
                                  controller2.clear();
                                  controller3.clear();
                                  quanzhi1 = "";
                                  didian1 = "";
                                  zuozhe_controller.clear();
                                  gangwei.clear(); //影响岗位下拉框
                                  gangwei_id = ""; //岗位id清空
                                  _streamController1.sink
                                      .add(fenlei[0]); //影响分类下拉框
                                  xueli1 = "";
                                  is_search = false; //关闭搜索标记
                                  setState(() {});
                                  // get_data1(1);
                                },
                              ),
                              ElevatedButton(
                                child: const Text('刷新'),
                                onPressed: () {
                                  setState(() {});
                                  // get_data1(1);
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
                    print("snapshot.data");
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        print("result长度:");
                        print(result.length);
                        return Container(
                          alignment: Alignment.center,
                          height: 600,
                          child: ListView.builder(
                            // addAutomaticKeepAlives: false,
                            controller: controller1,
                            itemCount: result.length, //(page+1)*10,
                            //此处直接给具体数字初始显示时汇报个错: RangeError (index): Index out of range: no indices are valid: 0
                            // itemCount:5,   //列表项构造器
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                //添加触摸动作事件onTap
                                child: Container(
                                    height: 100,
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
                                              child: Text("序号:${index}  ")),

                                          Expanded(
                                              child: Text(
                                                  "岗位:${map_gangwei[int.parse(result[index]["gangwei"])]}")),
                                          Expanded(
                                              child: Text(
                                                  "学历:${result[index]["xueli"]}")),
                                          Expanded(
                                              child: Text(
                                                  "薪酬:${result[index]["xinchou"]}")),
                                          Expanded(
                                              child: Text(
                                                  "ID:${result[index]["id"]}")),
                                          Expanded(
                                            child: Text(
                                                "全/兼:${result[index]["quanzhi"]}"),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "公司:${result[index]["gong_si_ming"]}"),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "招聘数:${result[index]["renshu"]}"),
                                            // color: Colors.black12,
                                          ),
                                          Expanded(
                                            child: Text(
                                                "应聘数:${list_yingpinzhe_id[index].length}"),
                                            // color: Colors.black12,
                                          ),
                                          // Expanded(
                                          //     flex: 1,
                                          //     child: Jubu_shuaxin(
                                          //         key: UniqueKey(),
                                          //         index:
                                          //             index) //UniqueKey唯一key,每次调用都会生成唯一的key
                                          //     ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              // height: 60,
                                              // width:MediaQuery.of(context).size.width-800,
                                              alignment: Alignment.center,
                                              child:
                                                  //   Row(
                                                  // children: <Widget>[
                                                  Wrap(
                                                      spacing:
                                                          30.0, // 主轴(水平)方向间距
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
                                                      alignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      overflowButtonSpacing:
                                                          2.0, //按钮的距离
                                                      children: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('编辑'),
                                                          onPressed: () async {
                                                            print(
                                                                result[index]);
                                                            var res = await Get
                                                                    .Get
                                                                .to(Zhaopin_edit(
                                                              //招聘信息编辑
                                                              id: result[index]
                                                                  ["id"],
                                                              gong_si_ming: result[
                                                                      index][
                                                                  "gong_si_ming"],
                                                              gangwei: result[
                                                                      index]
                                                                  ["gangwei"],
                                                              xueli:
                                                                  result[index]
                                                                      ["xueli"],
                                                              renshu: result[
                                                                      index]
                                                                  ["renshu"],
                                                              yaoqiu: result[
                                                                      index]
                                                                  ["yaoqiu"],

                                                              baoxian:
                                                                  list_baoxian[
                                                                      index],
                                                              xinchou: result[
                                                                      index]
                                                                  ["xinchou"],
                                                              lianxifangshi:
                                                                  result[index][
                                                                      "lianxifangshi"],
                                                              liulanshu: result[
                                                                      index]
                                                                  ["liulanshu"],
                                                              created_at: result[
                                                                      index][
                                                                  "created_at"],
                                                              updated_at: result[
                                                                      index][
                                                                  "updated_at"],

                                                              list_yingpinzhe_id:
                                                                  list_yingpinzhe_id[
                                                                      index],
                                                              kaishishijian:
                                                                  result[index][
                                                                      "kaishishijian"],
                                                              jieshushijian:
                                                                  result[index][
                                                                      "jieshushijian"],
                                                              youxiang: result[
                                                                      index]
                                                                  ["youxiang"],
                                                              tupian:
                                                                  list_zhaopin_pics[
                                                                      index],
                                                              qita:
                                                                  result[index]
                                                                      ["qita"],

                                                              quanzhi: result[
                                                                      index]
                                                                  ["quanzhi"],
                                                              dizhi:
                                                                  result[index]
                                                                      ["dizhi"],
                                                              gongzuonianxian:
                                                                  result[index][
                                                                      "gongzuonianxian"],
                                                            ));

                                                            print("res:${res}");
                                                            if (res["issave"] ==
                                                                1) {
                                                              result[index]
                                                                      ["id"] =
                                                                  res["id"];

                                                              result[index][
                                                                      "gangwei"] =
                                                                  res["gangwei"];
                                                              result[index][
                                                                      "xueli"] =
                                                                  res["xueli"];
                                                              result[index][
                                                                      "xinchou"] =
                                                                  res["xinchou"];

                                                              result[index][
                                                                      "gongsiming"] =
                                                                  res["gongsiming"];

                                                              result[index][
                                                                      "renshu"] =
                                                                  res["renshu"];

                                                              result[index][
                                                                      "quanzhi"] =
                                                                  res["quanzhi"];

                                                              setState(() {});
                                                            }
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child:
                                                              const Text('删除'),
                                                          onPressed: () {
                                                            result.removeAt(
                                                                index);
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
                                  // print('haha');
                                  // print(result);

                                  // print(result[index]["id"]);
                                  // print(result[index]["gong_si_ming"]);
                                  // print(result[index]["gangwei"]);
                                  // print(result[index]["xueli"]);
                                  // print(result[index]["renshu"]);
                                  // print(result[index]["yaoqiu"]);

                                  // print(result[index]["baoxian"]);
                                  // print(result[index]["xinchou"]);
                                  // print(result[index]["lianxifangshi"]);
                                  // print(result[index]["liulanshu"]);
                                  // print(result[index]["created_at"]);
                                  // print(result[index]["updated_at"]);

                                  // print(result[index]["yingpinzhe_id"]);
                                  // print(result[index]["kaishishijian"]);
                                  // print(result[index]["jieshushijian"]);
                                  // print(result[index]["youxiang"]);
                                  // print(result[index]["tupian"]);
                                  // print(result[index]["qita"]);

                                  // print(result[index]["quanzhi"]);
                                  // print(result[index]["dizhi"]);
                                  // print(result[index]["gongzuonianxian"]);

                                  Get.Get.to(Zhaopin_xiangqing(
                                    //文章详情
                                    id: result[index]["id"],
                                    gong_si_ming: result[index]["gong_si_ming"],
                                    gangwei: result[index]["gangwei"],
                                    xueli: result[index]["xueli"],
                                    renshu: result[index]["renshu"],
                                    yaoqiu: result[index]["yaoqiu"],

                                    baoxian: list_baoxian[index],
                                    xinchou: result[index]["xinchou"],
                                    lianxifangshi: result[index]
                                        ["lianxifangshi"],
                                    liulanshu: result[index]["liulanshu"],
                                    created_at: result[index]["created_at"],
                                    updated_at: result[index]["updated_at"],

                                    list_yingpinzhe_id:
                                        list_yingpinzhe_id[index],
                                    kaishishijian: result[index]
                                        ["kaishishijian"],
                                    jieshushijian: result[index]
                                        ["jieshushijian"],
                                    youxiang: result[index]["youxiang"],
                                    tupian: list_zhaopin_pics[index],
                                    qita: result[index]["qita"],

                                    quanzhi: result[index]["quanzhi"],
                                    dizhi: result[index]["dizhi"],
                                    gongzuonianxian: result[index]
                                        ["gongzuonianxian"],
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
var zuozhe_controller = TextEditingController();

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
    zhiding = result[widget.index]["zhiding"];
    jinghua = result[widget.index]["jinghua"];
    print("局部刷新:${widget.index}");
    // print("局部刷新:${result}");
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
                          cha_xun_wen_zhang(
                              widget.index, result[widget.index]["id"], "置顶");
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
                          cha_xun_wen_zhang(
                              widget.index, result[widget.index]["id"], "精华");
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
        result[widget.index]["zhiding"] = zhiding;
        result[widget.index]["jinghua"] = jinghua;
        setState(() {});
        set_zhiding_jinghua(id, zhiding, jinghua);
        print('加载到最后');
        // load = false;
      } else {
        // load = true;
        // result.insertAll(result.length, response.data["data"]);
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
