import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; //转换dio网络获得的数据
import 'dart:io';
import 'package:get/get.dart' as Get;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:flutter_gf_view/model1.dart';

// import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '/quan_ju.dart';

// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import '../../../widgets/article_xiang_qing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/article_xiang_qing.dart';
//编辑器
import 'package:visual_editor/visual-editor.dart';
import '/admin/edtor/const/sample-highlights.const.dart';
import '/admin/edtor/services/editor.service.dart';
import '/admin/edtor/widgets/demo-scaffold.dart';
import '/admin/edtor/widgets/loading.dart';

class zhaopinfabu extends StatefulWidget {
  const zhaopinfabu({Key? key}) : super(key: key);
  @override
  _zhaopinfabuState createState() => _zhaopinfabuState();
}

List<String> select0 = [
  //薪酬部分的
];
List<bool> flag = [];

//薪酬部分的多选框状态
List<String> select = [
  //薪酬部分的
  "五险一金", "单休", "双休", "带薪休假", "包吃", "加班补助", "电话补助", "交通补助", "包住"
];

class _zhaopinfabuState extends State<zhaopinfabu>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FocusNode _focusNode = FocusNode();
  List<int> img = [];
  String thumbnail1 = "thumbnail.png";
  String thumbnail2 = "thumbnail.png";
  String thumbnail =
      "thumbnail.png"; //默认的缩略图片 此地址为flutter的http://127.0.0.1:xx/thumbnail.png
//String thumbnail = ""; //默认的缩略图片
  double width0 = 800;
  //  List<dynamic> json_tupian = [];//json类型的替代
  TextEditingController? title_control = new TextEditingController();
  TextEditingController? yaoqiu_control = new TextEditingController();
  TextEditingController? author_control = new TextEditingController();
  TextEditingController? youxiang_control = new TextEditingController();
  TextEditingController? zuozhe_control = new TextEditingController();
  TextEditingController? shouji_control = new TextEditingController();
  TextEditingController? gognzuonianxian_control = new TextEditingController();
  TextEditingController? gongsi_control = new TextEditingController();
  TextEditingController? dizhi_control = new TextEditingController();
  final _editorService = EditorService();
  int wenzhang_id = 0;
  bool isChecked = false;
  EditorController? _controller;
  final _scrollController = ScrollController();
  // final _focusNode = FocusNode();

  // QuillController? _controller;
  // final FocusNode _focusNode = FocusNode();
  List<String> fenlei = ["选择分类"];
  List<String> gangwei = ["选择岗位"];
  String dropdownValue = "";
  String dropdownValue2 = "";
  String gangwei_text = "";
  String gangwei_id = "";
  StreamController _streamController1 = StreamController<dynamic>();
  StreamController _streamController2 = StreamController<dynamic>();
  String fenlei_text = "点此查看";

  dynamic list = [];
  List<String> xueli = [
    "无要求",
    "本科以上",
    "本科",
    "专科",
    "高中",
    "初中",
    "小学",
  ];
  List<String> xinchou = [
    "0-1000",
    "1000-2000",
    "2000-3000",
    "3000-4000",
    "4000-5000",
    "5000-6000",
    "6000-7000",
    "7000-8000",
    "8000-9000",
    "9000-10000",
  ];
  List<String> quanzhi = [
    "全职",
    "兼职",
  ];

  String? quanzhi1;

  List<String> jingyan = [
    "无要求",
    "1-2年",
    "3-4年",
    "5-6年",
    "7-8年",
    "9-10年",
  ];
  List<String> didian = [
    "市区",
    "义县",
    "黑山",
    "北镇",
    "凌海",
  ];
  String? jingyan1;
  String? didian1;
  String? xinchou1; //注意如果有值,必须在下拉列表项范围内,否则报错"0-1000";
  String? xueli1; //= "无要求";
  String? renshu1; // = "1";
  List<dynamic> fenlei_name_id = [];

  List<String> baoxian1 = [
    //福利待遇部分的
  ];
  List<dynamic> reslut =
      []; //空的list所以不能使用下标索引要添加add数据才行,等价于  var reslut = List(1);//1个长度的list
  List<dynamic> gangwei_fenlei = [
    //列表的列表集合.第一个项为分类,其余为岗位.//这里有个问题就是这个列表必须有2个空列表,否则首次渲染时,navigation_rail菜单会有个报错,提示菜单项少于2项
  ];
  Map<dynamic, dynamic> map_gangwei = {}; //id,岗位名
  int fenlei_id = 0;
  bool baohan = false;
  @override
  void initState() {
    super.initState();

    print("招聘发布initState");

    // print("select:${select.toString().replaceAll(" ", "")}");

    // print("select[1]:${select[1]}");
    flag = List.filled(select.length, false); //根据select待遇的长度进行初始化列表flag.
    // _loadDocument();
    get_gangwei_xifen(0);
  }

  @override
  void dispose() {
    super.dispose();
    print("文章发布dispose");
    _streamController1.close();
  }

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
          gangwei_fenlei = reslut;

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
          // print("reslut.length:");
          // print(reslut.length);
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
    super.build(context); //没有时,初始化1次和build执行2次
    print("招聘发布build");
    Model1 model1 = context.watch<Model1>();
    zuozhe_control!.text =
        Provider.of<Model1>(context, listen: false).nickname; //作者默认为用户名;
    return
        // LayoutBuilder(//LayoutBuilder其中的子组件可以获取父组件的宽高如constraints.maxwidth
        //     builder: (BuildContext context, BoxConstraints constraints) {
        //   return

        Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
            child:
                // ListView(
                //     //外层的cloumn不能有,否则不显示listview

                //     children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     //         IntrinsicWidth( // 使用IntrinsicHeight包裹Row组件使其自动推测得到高度
                //     // child:
                Container(
          // width: 1500, //constraints.maxWidth,
          // height: 600, //MediaQuery.of(context).size.height,//-size_appbar-size_web_menu_height,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("招聘分类:"),
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

                          print("dropdownValue1");
                          print(dropdownValue);
                          return DropdownButton<String>(
                              // hint: const Text("选择类别"),
                              value: dropdownValue, //下拉框显示的默认文字值
                              items: fenlei.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ); //数据刷新组件的所有内容项
                              }).toList(),
                              onChanged: (String? value) {
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

                          List<dynamic> list_keys =
                              map_gangwei.keys.toList(); //把map_gangwei的键变成list

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
                                List<dynamic> list_values = map_gangwei.values
                                    .toList(); //把map_gangwei的值变成list

                                List<dynamic> list_keys = map_gangwei.keys
                                    .toList(); //把map_gangwei的键变成list

                                for (int i = 0; i < list_values.length; i++) {
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
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ]),
              TextField(
                controller: shouji_control,
                decoration: InputDecoration(
                    labelText: '*联系方式(电话):',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              TextField(
                controller: zuozhe_control,
                decoration: InputDecoration(
                    labelText: '作者:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              TextField(
                controller: youxiang_control,
                decoration: InputDecoration(
                    labelText: '*简历接收邮箱:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              TextField(
                controller: dizhi_control,
                decoration: InputDecoration(
                    labelText: '*工作地址:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              TextField(
                controller: gongsi_control,
                maxLength: 15, //字符长度
                decoration: InputDecoration(
                    labelText: '*联系人或公司名[15字]:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              TextField(
                controller: yaoqiu_control,
                maxLines: 10, //行数
                maxLength: 100, //字符长度
                decoration: InputDecoration(
                    labelText: '*招聘要求[100字]:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              Row(
                children: [
                  Text('选择人数'),
                  StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                    return DropdownButton<String>(
                        // 提示文本
                        hint: Text('选择人数'),
                        value: renshu1,
                        items: List.generate(50, (index) {
                          return DropdownMenuItem<String>(
                            value: "${index + 1}",
                            child: Text("${index + 1}"),
                          ); //数据刷新组件的所有内容项
                        }),
                        onChanged: (String? value) {
                          print(value);
                          renshu1 = value!;
                          setState(() {});
                        });
                  }),
                  Text("学历:"),
                  StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                    return DropdownButton<String>(
                        // 提示文本
                        hint: Text('选择学历'),
                        value: xueli1, //此值必须包括在items中哦,否则报错
                        items:
                            xueli.map<DropdownMenuItem<String>>((String value) {
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
                  Text("待遇:"),
                  TextButton.icon(
                    icon: Text(
                      "福利待遇",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1,
                      ),
                    ),
                    onPressed: () {
                      Future<List<String>?> select2 = Get.Get.defaultDialog(
                        //select2作为then语句调用
                        title: "待遇,可多选:",
                        barrierDismissible: false, //	是否可以通过点击背景关闭弹窗
                        content: Zhaopinfabu_dialog(),
                        // middleText: "处理完成!", //content与middleText写一个
                        titlePadding: EdgeInsets.all(10),
                        titleStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                        middleTextStyle:
                            TextStyle(color: Colors.blue, fontSize: 20),
                        confirm: ElevatedButton(
                            onPressed: () {
                              print(select0);
                              Get.Get.back(result: select0);
                            },
                            child: Text("确定")),
                        // cancel: ElevatedButton(
                        //     onPressed: () {
                        //       Get.Get.back(result: []);
                        //     },
                        //     child: Text("取消"))
                      );

                      select2.then((value) {
                        baoxian1 = value!;
                        print("baoxian1");
                        print(baoxian1);
                      });
                    },
                    label: Icon(Icons.arrow_drop_down),
                  ),
                  Text("薪酬:"),
                  StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                    return DropdownButton<String>(
                        // 提示文本
                        hint: Text('薪酬范围'),
                        value: xinchou1,
                        items: xinchou
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ); //数据刷新组件的所有内容项
                        }).toList(),
                        onChanged: (String? value) {
                          print(value);
                          xinchou1 = value!;
                          setState(() {});
                        });
                  }),
                  Text("全/兼职:"),
                  StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                    return DropdownButton<String>(
                        // 提示文本
                        hint: Text('选择全职'),
                        value: quanzhi1,
                        items: quanzhi
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ); //数据刷新组件的所有内容项
                        }).toList(),
                        onChanged: (String? value) {
                          print(value);
                          quanzhi1 = value!;
                          setState(() {});
                        });
                  }),
                  Text("工作经验:"),
                  StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                    return DropdownButton<String>(
                        // 提示文本
                        hint: Text('选择经验'),
                        value: jingyan1,
                        items: jingyan
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ); //数据刷新组件的所有内容项
                        }).toList(),
                        onChanged: (String? value) {
                          print(value);
                          jingyan1 = value!;
                          setState(() {});
                        });
                  }),
                  Text("工作地点:"),
                  StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                      builder: (BuildContext context, StateSetter setState) {
                    print("局部刷新了");
                    return DropdownButton<String>(
                        // 提示文本
                        hint: Text('选择地点'),
                        value: didian1,
                        items: didian
                            .map<DropdownMenuItem<String>>((String value) {
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      child: Text("图1:"),
                      onPressed: () async {
                        // FilePickerResult result = await FilePicker.platform
                        //     .pickFiles(type: FileType.image);

                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          PlatformFile file = result.files.first;

                          print(file.name);

                          img = file.bytes!.toList();
                          print(file.size);
                          print(file.extension);
                          // print(file.path);//web平台无法使用
                          // setState(() {});
// 或者通过传递一个 `options`来创建dio实例
                          BaseOptions options = BaseOptions(
                            // headers: {
                            //   'Content-Type': 'application/json',
                            // "Accept":
                            //     "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                            // 'Sec-Fetch-Mode': 'navigate',
                            //   },
                            baseUrl: url1,
                            connectTimeout: Duration(seconds: connectTimeout0),
                            receiveTimeout:Duration(seconds: connectTimeout0),
                            contentType:
                                "application/json", //默认json传输.配合'Content-Type':'application/json',
                          );
                          Dio dio = Dio(options);
                          // dio.options.contentType =
                          //     Headers.formUrlEncodedContentType;
                          FormData formData = new FormData.fromMap({
                            // 支持文件数组上传
                            "file": await MultipartFile.fromBytes(img,
                                filename: file.name), //是一个流
                          });
                          // FormData formData1 = new FormData.fromMap({
                          //   // 支持文件数组上传
                          //   "file": await MultipartFile.fromFile("/favicon.png",
                          //       filename: "1.png"), //是一个流
                          // });
                          String sr = '[{"name":"Jack"},{"name1":"Rose"}]';

                          // Map<String, dynamic>
                          var user = json.decode(sr);

                          //print(user);
                          // var response = await dio.post(
                          //     "http://127.0.0.1:1234/upload/",
                          //     data: Stream.fromIterable(img.map((e) => [e])), //创建一个Stream<List<int>>,
                          //     options: Options(
                          //       headers: {
                          //         HttpHeaders.contentLengthHeader: img.length, // Set content-length
                          //       },
                          //     )
                          //     );
                          FormData formData1 = new FormData.fromMap({
                            "user_name": "youxue",
                            "passwrod": "wendux", "token": token,
                            "file": await MultipartFile.fromBytes(img,
                                filename: file.name),
                            //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
                          });
                          var response = await dio.post(
                            "/user/uploadfile",
                            data: formData1,
                            // options: Options(
                            //   headers: {
                            //     Headers.contentLengthHeader:
                            //         img.length, // 设置content-length
                            //   },
                            // )
                          );
                          print("服务器返回数据是:${response.data}");
                          if (response.statusCode == 200) {
                            print("图片上传成功!");
                            String s1 = response.data["data"]["pic_url"];
                            thumbnail = s1;
                            //   host_url + s1.substring(1); //从第2个字符开始截取
                            print(thumbnail);
                            setState(() {});
                          }
                        }
                      }),
                  Image.network(
                    thumbnail,
                    // "http://127.0.0.1:8199/upload_file/0b8f968c-6fbb-46f9-8b8c-5f6448753184.jpeg",
                    width: 70 * 1.618,
                    height: 70,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      child: Text("图2:"),
                      onPressed: () async {
                        // FilePickerResult result = await FilePicker.platform
                        //     .pickFiles(type: FileType.image);

                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          PlatformFile file = result.files.first;

                          print(file.name);

                          img = file.bytes!.toList();
                          print(file.size);
                          print(file.extension);
                          // print(file.path);//web平台无法使用
                          // setState(() {});
// 或者通过传递一个 `options`来创建dio实例
                          BaseOptions options = BaseOptions(
                            // headers: {
                            //   'Content-Type': 'application/json',
                            // "Accept":
                            //     "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                            // 'Sec-Fetch-Mode': 'navigate',
                            //   },
                            baseUrl: url1,
                            connectTimeout: Duration(seconds: connectTimeout0),
                            receiveTimeout:Duration(seconds: connectTimeout0),
                            contentType:
                                "application/json", //默认json传输.配合'Content-Type':'application/json',
                          );
                          Dio dio = Dio(options);
                          // dio.options.contentType =
                          //     Headers.formUrlEncodedContentType;
                          FormData formData = new FormData.fromMap({
                            // 支持文件数组上传
                            "file": await MultipartFile.fromBytes(img,
                                filename: file.name), //是一个流
                          });
                          // FormData formData1 = new FormData.fromMap({
                          //   // 支持文件数组上传
                          //   "file": await MultipartFile.fromFile("/favicon.png",
                          //       filename: "1.png"), //是一个流
                          // });
                          String sr = '[{"name":"Jack"},{"name1":"Rose"}]';

                          // Map<String, dynamic>
                          var user = json.decode(sr);

                          //print(user);
                          // var response = await dio.post(
                          //     "http://127.0.0.1:1234/upload/",
                          //     data: Stream.fromIterable(img.map((e) => [e])), //创建一个Stream<List<int>>,
                          //     options: Options(
                          //       headers: {
                          //         HttpHeaders.contentLengthHeader: img.length, // Set content-length
                          //       },
                          //     )
                          //     );
                          FormData formData1 = new FormData.fromMap({
                            "user_name": "youxue",
                            "passwrod": "wendux", "token": token,
                            "file": await MultipartFile.fromBytes(img,
                                filename: file.name),
                            //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
                          });
                          var response = await dio.post(
                            "/user/uploadfile",
                            data: formData1,
                            // options: Options(
                            //   headers: {
                            //     Headers.contentLengthHeader:
                            //         img.length, // 设置content-length
                            //   },
                            // )
                          );
                          print("服务器返回数据是:${response.data}");
                          if (response.statusCode == 200) {
                            print("图片上传成功!");
                            String s1 = response.data["data"]["pic_url"];
                            thumbnail1 = s1;
                            //   host_url + s1.substring(1); //从第2个字符开始截取
                            print(thumbnail1);
                            setState(() {});
                          }
                        }
                      }),
                  Image.network(
                    thumbnail1,
                    // "http://127.0.0.1:8199/upload_file/0b8f968c-6fbb-46f9-8b8c-5f6448753184.jpeg",
                    width: 70 * 1.618,
                    height: 70,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      child: Text("图3:"),
                      onPressed: () async {
                        // FilePickerResult result = await FilePicker.platform
                        //     .pickFiles(type: FileType.image);

                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          PlatformFile file = result.files.first;

                          print(file.name);

                          img = file.bytes!.toList();
                          print(file.size);
                          print(file.extension);
                          // print(file.path);//web平台无法使用
                          // setState(() {});
// 或者通过传递一个 `options`来创建dio实例
                          BaseOptions options = BaseOptions(
                            // headers: {
                            //   'Content-Type': 'application/json',
                            // "Accept":
                            //     "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                            // 'Sec-Fetch-Mode': 'navigate',
                            //   },
                            baseUrl: url1,
                            connectTimeout: Duration(seconds: connectTimeout0),
                            receiveTimeout:Duration(seconds: connectTimeout0),
                            contentType:
                                "application/json", //默认json传输.配合'Content-Type':'application/json',
                          );
                          Dio dio = Dio(options);
                          // dio.options.contentType =
                          //     Headers.formUrlEncodedContentType;
                          FormData formData = new FormData.fromMap({
                            // 支持文件数组上传
                            "file": await MultipartFile.fromBytes(img,
                                filename: file.name), //是一个流
                          });
                          // FormData formData1 = new FormData.fromMap({
                          //   // 支持文件数组上传
                          //   "file": await MultipartFile.fromFile("/favicon.png",
                          //       filename: "1.png"), //是一个流
                          // });
                          String sr = '[{"name":"Jack"},{"name1":"Rose"}]';

                          // Map<String, dynamic>
                          var user = json.decode(sr);

                          //print(user);
                          // var response = await dio.post(
                          //     "http://127.0.0.1:1234/upload/",
                          //     data: Stream.fromIterable(img.map((e) => [e])), //创建一个Stream<List<int>>,
                          //     options: Options(
                          //       headers: {
                          //         HttpHeaders.contentLengthHeader: img.length, // Set content-length
                          //       },
                          //     )
                          //     );
                          FormData formData1 = new FormData.fromMap({
                            "user_name": "youxue",
                            "passwrod": "wendux", "token": token,
                            "file": await MultipartFile.fromBytes(img,
                                filename: file.name),
                            //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
                          });
                          var response = await dio.post(
                            "/user/uploadfile",
                            data: formData1,
                            // options: Options(
                            //   headers: {
                            //     Headers.contentLengthHeader:
                            //         img.length, // 设置content-length
                            //   },
                            // )
                          );
                          print("服务器返回数据是:${response.data}");
                          if (response.statusCode == 200) {
                            print("图片上传成功!");
                            String s1 = response.data["data"]["pic_url"];
                            thumbnail2 = s1;
                            //   host_url + s1.substring(1); //从第2个字符开始截取
                            print(thumbnail2);
                            setState(() {});
                          }
                        }
                      }),
                  Image.network(
                    thumbnail2,
                    // "http://127.0.0.1:8199/upload_file/0b8f968c-6fbb-46f9-8b8c-5f6448753184.jpeg",
                    width: 70 * 1.618,
                    height: 70,
                  ),
                ],
              ),
            ],
          ),
          //     )
          //   ],
        )
            // ]),
            ),
        SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Container(
                    color: Color.fromARGB(255, 228, 228, 228),
                    //  margin: EdgeInsets.only(bottom:00), //容器外填充
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("!!!到底了!!!"),
                        // color: Colors.greenAccent,
                      ],
                    ),
                  ),
                )))
      ])),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton.icon(
            onPressed: () async {
              // json_tupian=;
              var content_json =
                  jsonEncode(_controller?.document.delta.toJson());
              print(content_json);

              // var content_json1 =
              //     jsonEncode(_controller?.document.toPlainText().toString());
              // print(content_json1);
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

              Map<String, List<Map<String, String>>> a1 = {
                "pics": [
                  {"id": "1", "picurl": thumbnail},
                  {"id": "2", "picurl": thumbnail1},
                ]
              }; //输出的map值不带双引号{id:1,name:jin},传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

              a1["pics"]!.add({"id": "3", "picurl": thumbnail2});
              String json_tupian = jsonEncode(
                  a1); //传给formdata后传给gf后台,处理时候不认为是json字符串.因此经过jsonEncode处理转为json字符串就会带双引号

              FormData formData1 = new FormData.fromMap({
                "token": token,
                "gangwei": gangwei_id,
                "gongsiming": gongsi_control!.text,
                "qita": "", //备用
                "tupian": json_tupian, //图片,不用传
                "liulanshu": 0, //浏览数
                "lianxifangshi": shouji_control!.text,
                "youxiang": youxiang_control!.text,
                "dizhi": didian1,
                "yaoqiu": yaoqiu_control?.text,
                "renshu": renshu1,
                "xueli": xueli1,
                "xinchou": xinchou1,
                "kaishishijian": "2018.02.09 20:46:17",
                "jieshushijian": "2018.02.09 20:46:17",
                "baoxian": baoxian1.toString().replaceAll(" ",
                    ""), //去除所有list转字符串的空格.如[五险一金, 单休],其中的单休前边有个空格哦.这个空格要去除才行
                "quanzhi": quanzhi1,
                "gongzuonianxian": jingyan1,
                "zuozhe": Provider.of<Model1>(context, listen: false)
                    .nickname, //context.watch<Model1>().nickname,这里的按钮事件不刷新ui,因此不用watch监听
                // "zhiding": "0",
                // "jinghua": "0",
              });
              var response = await dio.post(
                map0api["招聘信息发布"]!,
                data: formData1,
                //   queryParameters: {"token": token},
                // options: Options(
                //   headers: {
                //     Headers.contentLengthHeader:
                //         img.length, // 设置content-length
                //   }, )
              );
              print("服务器返回数据是:${response.data}");
              if (response.statusCode == 200) {
                if (response.data["code"] == "0") {
                  list = response.data["data"];
                  print(list);
                  print("上传成功!");

                  show_dialog(context, "发布成功");
                } else {
                  show_dialog(context, "发布失败");
                }
                // String s1 = response.data["pic_url"];
                // thumbnail =
                //     host_url + s1.substring(1); //从第2个字符开始截取
                // print(thumbnail);
                // setState(() {});
              }
            },
            icon: Icon(Icons.save, size: 30),
            label: Text("发布"),
            // color: Colors.greenAccent,
          ),
          SizedBox(width: 50),
          TextButton.icon(
              //  color: Colors.greenAccent,
              onPressed: () {
                print(yaoqiu_control!.text);
                // 执行返回操作

                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   //返回要跳转的目标页面
                //   return Article_xiang_qing(
                //     nei_rong: list["neirong"],
                //     title: list["biaoti"],
                //     zuo_zhe: list["zuozhe"],
                //     ri_qi: list["created_at"],
                //   );
                // }));
              },
              icon: Icon(Icons.save, size: 30),
              label: Text("预览"))
        ],
      ),
    ]));
  }

  Widget _scaffold({required List<Widget> children}) => DemoScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );

  Future<void> show_dialog(BuildContext context, String text) async {
    //弹出上传成功窗口

    showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              //  width: 30.0,
              height: 40.0,
              // color: Colors.red,
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Positioned(
                  //右上角关闭按钮
                  right: 10,
                  top: MediaQuery.of(context).padding.top,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text("返回消息:"),
              ]),
            ),
            content:
                // Card(
                //   child:

                Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //   // mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                new Text(
                  text,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 25,
                    color: Colors.black87,
                    // backgroundColor: Colors.grey[200]
                  ),
                ),

                //Expanded(
                //child:
//                      PhotoView(
//                        imageProvider:
                //   AssetImage("assets/images/an_li1.png"),
//                      )
                //  ),
              ],
            ),
            // ),
            actions: <Widget>[
              //对话框底部按钮

              // ignore: deprecated_member_use
              TextButton(
                child: Text("确认/刷新"),
                onPressed: () {
                  // 执行返回操作
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}

class Zhaopinfabu_dialog extends StatefulWidget {
  const Zhaopinfabu_dialog({Key? key}) : super(key: key);

  @override
  _ZhaopinfabuState createState() => _ZhaopinfabuState();
}

class _ZhaopinfabuState extends State<Zhaopinfabu_dialog> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    print("对话框init ");
    //  flag.fillRange(0, select.length, false);
  }

  @override
  Widget build(BuildContext context) {
    print("dialog build");
    return Container(
        width: 500,
        height: 500,
        child: SingleChildScrollView(
            child: Row(
          children: <Widget>[
            Flexible(
              child: Column(children: <Widget>[
                CheckboxListTile(
                  //必须加到flexible中,才能以row形式显示哦
                  value: isChecked,
                  /*设置主标题组件*/
                  title: Text(
                    '全选',
                    style: TextStyle(color: Colors.red),
                  ),
                  /*设置副标题组件*/
                  subtitle: Text('全选'),
                  /*设置显示的小组件,与□所在位置相反*/
                  secondary: Icon(Icons.flag),
                  /*调整复选框和图标的位置*/
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    isChecked = value!;
                    setState(() {
                      if (value) {
                        //全选则添加,否则就清除
                        select0.clear();
                        for (int i = 0; i < flag.length; i++) {
                          flag[i] = value;
                          select0.add(select[i]);
                        }
                      } else {
                        flag.fillRange(0, flag.length, false);
                        select0.clear();
                      }
                    });
                  },
                ),
                ...List.generate(select.length, (index) {
                  //...表示添加项
                  return CheckboxListTile(
                      title: Text(select[index]),
                      subtitle: Text(select[index]),
                      secondary: Icon(Icons.info),
                      /*调整复选框和图标的位置*/
                      controlAffinity: ListTileControlAffinity.leading,
                      value: flag[index],
                      onChanged: (value) {
                        setState(() {
                          flag[index] = value!;
                          if (value) {
                            select0.add(select[index]);
                            // print("select0:${select0}");
                          } else {
                            select0.remove(select[index]);
                          }
                        });
                      });
                }).toList(),
              ]),
            )
          ],
        )));
  }
}
