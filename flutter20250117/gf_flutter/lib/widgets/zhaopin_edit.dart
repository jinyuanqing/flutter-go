// import 'package:flutter/foundation.dart'; //引入平台判别

import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:photo_view/photo_view.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
// import 'package:flutter_quill/widgets/controller.dart';
// import 'package:flutter_quill/widgets/editor.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
// import '../universal_ui/universal_ui.dart';
// import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:get/get.dart' as Get;

//编辑器
import 'package:flutter/services.dart';
import 'package:flutter_gf_view/model1.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:visual_editor/visual-editor.dart';
// import '/admin/edtor/const/sample-highlights.const.dart';
// import '/admin/edtor/services/editor.service.dart';
import '/admin/edtor/widgets/demo-scaffold.dart';
// import '/admin/edtor/widgets/loading.dart';

List<bool> flag = [];
List<String> baoxian0 = [
  //薪酬部分的
];
List<String> baoxian = [
  //薪酬部分的
  "五险一金",
  "单休",
  "双休",
  "带薪休假",
  "包吃",
  "加班补助", "电话补助", "交通补助", "包住"
];

// 文章详情页
// ignore: camel_case_types
class Zhaopin_edit extends StatefulWidget {
  final id;
  final gong_si_ming;
  final gangwei;
  final xueli;
  final renshu;
  final yaoqiu;
  final baoxian;
  final xinchou;
  final lianxifangshi;
  final liulanshu;
  final created_at;
  final updated_at;
  final list_yingpinzhe_id;
  final kaishishijian;
  final jieshushijian;
  final youxiang;
  final tupian;
  final qita;
  final quanzhi;
  final dizhi;
  final gongzuonianxian;
  const Zhaopin_edit({
    Key? key,
    @required this.id,
    @required this.gong_si_ming,
    @required this.gangwei,
    @required this.xueli,
    @required this.renshu,
    @required this.yaoqiu,
    @required this.baoxian,
    @required this.xinchou,
    @required this.lianxifangshi,
    @required this.liulanshu,
    @required this.created_at,
    @required this.updated_at,
    @required this.list_yingpinzhe_id,
    @required this.kaishishijian,
    @required this.jieshushijian,
    @required this.youxiang,
    @required this.tupian,
    @required this.qita,
    @required this.quanzhi,
    @required this.dizhi,
    @required this.gongzuonianxian,
  }) : super(key: key); //注意这是需要参数的类的定义,继承自StatelessWidget

  @override
  State<StatefulWidget> createState() => new _Zhaopin_edit();
}

// ignore: camel_case_types
class _Zhaopin_edit extends State<Zhaopin_edit>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<dynamic> reslut =
      []; //空的list所以不能使用下标索引要添加add数据才行,等价于  var reslut = List(1);//1个长度的list
  final FocusNode _focusNode = FocusNode();
  TextEditingController? title_control = new TextEditingController();
  TextEditingController? yaoqiu_control = new TextEditingController();
  TextEditingController? author_control = new TextEditingController();
  TextEditingController? youxiang_control = new TextEditingController();
  TextEditingController? lianxifangshi_control = new TextEditingController();
  TextEditingController? gognzuonianxian_control = new TextEditingController();
  TextEditingController? gongsi_control = new TextEditingController();
  TextEditingController? dizhi_control = new TextEditingController();
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
  String thumbnail1 = "thumbnail.png";
  String thumbnail2 = "thumbnail.png";
  String thumbnail = "thumbnail.png";
  List<String> gongzuonianxian = [
    "无要求",
    "1-2年",
    "3-4年",
    "5-6年",
    "7-8年",
    "9-10年",
  ];
  List<dynamic> list_yingpinzhe_id =
      []; ////json类型的替代.如{"应聘者": [{"id": "1", "name": "jin"}, {"id": "59", "name": "yuan"}, {"id": "11", "name": "qing"}, {"id": "99", "name": "a"}]}
  String gong_si_ming = "";
  String gangwei0 = "";
  String xueli0 = "";
  bool baohan = false;
  int renshu = 0;
  String yaoqiu = "";
  // List<String> baoxian0 = [];
  String xinchou0 = "";
  String lianxifangshi = "";
  int liulanshu = 0;
  String created_at = "";
  String updated_at = "";
  String yingpinzhe_id = "";
  String kaishishijian = "";
  String jieshushijian = "";
  String youxiang = "";
  List<int> img = [];
  List<dynamic> tupian = [];
  String qita = "";
  String quanzhi0 = "";
  String dizhi = "";
  String gongzuonianxian0 = "";
  var scrollController0 = ScrollController(); //编辑器用
  var _scrollController1 = ScrollController(); //窗口右侧的listview用
  var _scrollController2 = ScrollController(); //窗口右侧的listview用
  var _showBackTop = false;
  int a1 = 25;
  List<String> fenlei = ["选择分类"];
  List<String> gangwei = ["选择岗位"];
  Map<dynamic, dynamic> map_gangwei = {}; //id,岗位名
  int id = 0;
  List<List<String>> list_baoxian = [];
  ScrollController _arrowsController = ScrollController();
  double _alignmentY = 0.0;
  //  final _editorService = EditorService();
  int fenlei_id = 0;
  EditorController? _controller;
  String dropdownValue = "";
  String dropdownValue2 = "";
  StreamController _streamController1 = StreamController<dynamic>();
  StreamController _streamController2 = StreamController<dynamic>();
  List<dynamic> gangwei_fenlei = [
    //列表的列表集合.第一个项为分类,其余为岗位.//这里有个问题就是这个列表必须有2个空列表,否则首次渲染时,navigation_rail菜单会有个报错,提示菜单项少于2项
  ];

  String gangwei_id = "";
  String gangwei_name = "";

  String? gongzuonianxian1;

  String? xinchou1; //注意如果有值,必须在下拉列表项范围内,否则报错"0-1000";
  String? xueli1; //= "无要求";
  String? renshu1; // = "1";

  // List<bool> flag = [];

  List<String> baoxian1 = [
    //福利待遇部分的
  ];

  @override
  void dispose() {
    super.dispose();
  }

  int is_save = 0;
  @override
  void initState() {
    super.initState();
    print("招聘信息页详情init");
    flag = List.filled(baoxian.length, false); //根据baoxian待遇的长度进行初始化列表flag.

    id = widget.id;
    gong_si_ming = widget.gong_si_ming;
    gongsi_control!.text = gong_si_ming; //公司编辑框赋值
    gangwei0 = widget.gangwei;
    gangwei_id = gangwei0; //给下拉框设置默认显示值
    xueli0 = widget.xueli;
    xueli1 = xueli0;
    renshu = widget.renshu;
    renshu1 = renshu.toString();
    yaoqiu = widget.yaoqiu;
    yaoqiu_control!.text = yaoqiu; //要求编辑框赋值
    baoxian0 = widget.baoxian;
    baoxian1 = baoxian0;
    for (var element in baoxian0) {
      //取baoxian0的每个元素.
      int index = baoxian.indexOf(element); //根据元素获取索引位置.
      flag[index] = true;
    }

    print(flag);
    xinchou0 = widget.xinchou;
    xinchou1 = xinchou0; //薪酬
    lianxifangshi = widget.lianxifangshi;
    lianxifangshi_control!.text = lianxifangshi; //联系方式编辑框赋值
    liulanshu = widget.liulanshu;
    created_at = widget.created_at;

    updated_at = widget.updated_at;
    list_yingpinzhe_id = widget.list_yingpinzhe_id;
    kaishishijian = widget.kaishishijian;
    jieshushijian = widget.jieshushijian;
    youxiang = widget.youxiang;
    youxiang_control!.text = youxiang; //邮箱编辑框赋值
    tupian = widget.tupian;
    qita = widget.qita;
    quanzhi1 = widget.quanzhi; //是否全职/兼职

    dizhi = widget.dizhi;
    dizhi_control!.text = dizhi; //地址编辑框赋值
    gongzuonianxian0 = widget.gongzuonianxian;
    gongzuonianxian1 = gongzuonianxian0; //工作年限
    get_gangwei_xifen(0);
    _scrollController1.addListener(() {
      setState(() => _showBackTop = _scrollController1.position.pixels >= 100);
      // print(_scrollController1.position.maxScrollExtent);
      // print(_scrollController1.position.pixels);
      //  print(MediaQuery.of(context).size.height);
      if (_scrollController1.position.pixels >=
          (_scrollController1.position.maxScrollExtent)) //当前滚动条位置=最大滚动距离则
      {
        print("到底部了");

        // _scrollController1.jumpTo(10);
        // print(_scrollController1.position.pixels);

      }

      // _scrollController.position.pixels 获取当前滚动部件滚动的距离
      // 当滚动距离大于 100 之后，显示回到顶部按钮
      // setState(() => _showBackTop = _scrollController.position.pixels >= 100);
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('滚动组件最大滚动距离:${metrics.maxScrollExtent}');
    print('当前滚动位置:${metrics.pixels}');
    _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    return true;
  }

  Widget _scaffold({required List<Widget> children}) => DemoScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            tooltip: '返回上一页',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.Get.back(result: {
                "issave": is_save,
                "gangwei": gangwei_id,
                "xueli": xueli1,
                "xinchou": xinchou1,
                "gongsiming": gongsi_control!.text,
                "renshu": renshu1, //招聘人数
                "quanzhi": quanzhi1,
                "id": id,
              }); //没有时,初始化1次和build执行2次,但是页面加载不到result中的值。
              // Navigator.of(context).pop();
              is_save = 0;
            },
          ),

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Container(
                  //height: 30.0,
                  // color: Colors.red,
                  child: Text(
                    '招聘修改',
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
        body: Center(
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
                                        value); //给streambuild添加不重复的数据,重复会报错.可以使局部控件显示当前的选择项2

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
                                        _streamController2.sink
                                            .add(gangwei[0]); //二级下拉框增加项
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
                              // gangwei_id = dropdownValue2;
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

                              // }
                              // print("dropdownValue1");
                              // print(dropdownValue);
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
                                    print("map_gangwei.values");
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

                                    //  gangwei_id = value!;
                                    // baohan = false;
                                    _streamController2.sink.add(
                                        value); //给streambuild下拉框添加不重复的数据,重复会报错.可以使局部控件显示当前的选择项2

                                    // for (var i = 0;
                                    //     i < fenlei_name_id.length;
                                    //     i++) {
                                    // if (value ==
                                    //     gangwei_name_id[i]["fenlei_name"]) {
                                    //当选择下拉文本时,获取文本对应的id
                                    //     print(gangwei_name_id[i]["id"]);
                                    //  gangwei_id = fenlei_name_id[i]["id"];

                                    //   baohan = true;
                                    //   break;
                                    // }
                                    // }
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
                    controller: lianxifangshi_control,
                    decoration: InputDecoration(
                        labelText: '*联系方式(电话):',
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

                          builder:
                              (BuildContext context, StateSetter setState) {
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

                          builder:
                              (BuildContext context, StateSetter setState) {
                        print("局部刷新了");
                        return DropdownButton<String>(
                            // 提示文本
                            hint: Text('选择学历'),
                            value: xueli1, //此值必须包括在items中哦,否则报错
                            items: xueli
                                .map<DropdownMenuItem<String>>((String value) {
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
                          Future<List<String>?> baoxian2 =
                              Get.Get.defaultDialog(
                            //baoxian2作为then语句调用
                            title: "待遇,可多选:",
                            barrierDismissible: true, //	是否可以通过点击背景关闭弹窗
                            content: Fuli_widget(),
                            // middleText: "处理完成!", //content与middleText写一个
                            titlePadding: EdgeInsets.all(10),
                            titleStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                            middleTextStyle:
                                TextStyle(color: Colors.blue, fontSize: 20),
                            confirm: ElevatedButton(
                                onPressed: () {
                                  print(baoxian0);
                                  Get.Get.back(
                                      result: baoxian0); //关闭对话框后传递给baoxian2
                                },
                                child: Text("确定")),
                            // cancel: ElevatedButton(
                            //     onPressed: () {
                            //       Get.Get.back(result: []);
                            //     },
                            //     child: Text("取消"))
                          );

                          baoxian2.then((value) {
                            baoxian1 = value!;
                            //  setState(() {});
                            print("baoxian1");
                            print(baoxian1);
                          });
                        },
                        label: Icon(Icons.arrow_drop_down),
                      ),
                      Text("薪酬:"),
                      StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

                          builder:
                              (BuildContext context, StateSetter setState) {
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

                          builder:
                              (BuildContext context, StateSetter setState) {
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

                          builder:
                              (BuildContext context, StateSetter setState) {
                        print("局部刷新了");
                        return DropdownButton<String>(
                            // 提示文本
                            hint: Text('工作年限'),
                            value: gongzuonianxian1,
                            items: gongzuonianxian
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ); //数据刷新组件的所有内容项
                            }).toList(),
                            onChanged: (String? value) {
                              print(value);
                              gongzuonianxian1 = value!;
                              setState(() {});
                            });
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          child: Text("图1,图片限制为3张:"),
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
                                receiveTimeout: Duration(seconds: connectTimeout0),
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

                  // var content_json1 = jsonEncode(
                  //     _controller?.document.toPlainText().toString());
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

// widget.list_yingpinzhe_id
                  var a10 = json.encode(widget.list_yingpinzhe_id);
                  print(a10);
                  var a11 = json.encode(
                      '''{"应聘者":${a10}}'''); //返回a11结果是"{\"应聘者\":[{\"id\":\"1\",\"name\":\"jin\"},{\"id\":\"2\",\"name\":\"yuan\"},{\"id\":\"3\",\"name\":\"qing\"},{\"id\":\"4\",\"name\":\"a\"}]}"
                  print(a11);
                  String a12 =
                      a11.replaceAll("\\", ""); //去掉json中含有的\,这里的\\是转义字符,代表单\.
                  print(a12);

                  String a13 = a12.substring(
                      1, a12.length - 1); //从start到end-1的字符串中截断,不包括end-;
                  print(a13);
                  FormData formData1 = new FormData.fromMap({
                    "token": token,
                    "id": widget.id,
                    "yingpinzhe_id": a13,

                    "gangwei": gangwei_id,
                    "gongsiming": gongsi_control!.text,
                    "qita": "", //备用
                    "tupian": json_tupian, //图片限制为3张
                    "liulanshu": widget.liulanshu, //浏览数
                    "lianxifangshi": lianxifangshi_control!.text,
                    "youxiang": youxiang_control!.text,
                    "dizhi": dizhi_control!.text,
                    "yaoqiu": yaoqiu_control?.text,
                    "renshu": renshu1,
                    "xueli": xueli1,
                    "xinchou": xinchou1,
                    "kaishishijian": "2018.02.09 20:46:17",
                    "jieshushijian": "2018.02.09 20:46:17",
                    "baoxian": baoxian1.toString().replaceAll(" ",
                        ""), //去除所有list转字符串的空格.如[五险一金, 单休],其中的单休前边有个空格哦.这个空格要去除才行,
                    "quanzhi": quanzhi1,
                    "gongzuonianxian": gongzuonianxian1,
                  });
                  var response = await dio.post(
                    map0api["招聘信息更改"]!,
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
                      Get.Get.snackbar("结果", "操作成功!",
                          snackPosition: SnackPosition.BOTTOM);
                      is_save = 1; //保存成功的标记置为1
                      // show_dialog(context, "发布成功");
                    } else {
                      is_save = 0; //保存成功的标记置为1
                      Get.Get.snackbar("结果", "操作失败!",
                          snackPosition: SnackPosition.BOTTOM);
                      // show_dialog(context, "发布失败");
                    }
                    // String s1 = response.data["pic_url"];
                    // thumbnail =
                    //     host_url + s1.substring(1); //从第2个字符开始截取
                    // print(thumbnail);
                    setState(() {});
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
        ])));
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
          String fenlei1 = "选择分类";
          //根据传递过来的岗位id查岗位名称
          for (var ele in response.data["data"]["id_gangwei"]) {
            //json转map.给list<jsonmap>中的项添加一个键值,必须先把其中的jsonmap变成通过json.decode转成map

            Map a1 = json.decode(json.encode(
                ele)); //json.encode(ele)把ele转为map类型的字符串,再经过json.decode把map字符串转为map
            map_gangwei.addAll({a1["id"]: a1["gangwei"]});
            // gangwei.assign(a1["id"], a1["gangwei"]);
          }

          for (int i = 0; i < gangwei_fenlei.length; i++) {
            //根据岗位id获取岗位所在的分类
            fenlei.add(gangwei_fenlei[i][0]); //分类的列表
            int i1 = gangwei_fenlei[i].indexOf(map_gangwei[
                int.parse(gangwei_id)]); //根据岗位id获得岗位名称,所在的gangwei_fenlei的索引位置i1
            if (i1 > 0) {
              //找不到为-1,找到了,此时第0个索引就是分类
              fenlei1 = gangwei_fenlei[i][0]; //把分类赋给fenlei1,用于下拉框分类的显示
            }
          }

          print("当前岗位id对应的岗位名称是:  ");
          print(map_gangwei[int.parse(gangwei_id)]);

          print("fenlei");
          print(fenlei);
          gangwei[0] = map_gangwei[
              int.parse(gangwei_id)]; //需要把根据岗位id获得的岗位名,给当前岗位下拉框的map值.
          // print("gangwei");
          // print(gangwei);
          // _streamController1
          //     .add(fenlei[0]); //把提示信息添加到控制器中,实现刷新组件.提示信息
          _streamController1.sink
              .add(fenlei1); //分类下拉框添加当前显示值,必须是fenlei列表中的值,否则报错.所以需要提前给fenlei赋值哦
          _streamController2.sink.add(
              map_gangwei[int.parse(gangwei_id)]); //岗位下拉框添加当前显示值,必须提前给gangwei赋值

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
}

class Fuli_widget extends StatefulWidget {
  const Fuli_widget({Key? key}) : super(key: key);

  @override
  _Fuli_widget createState() => _Fuli_widget();
}

class _Fuli_widget extends State<Fuli_widget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    print("对话框init ");
    //  flag.fillRange(0, baoxian.length, false);
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
                //首个复选框的标题,图标不同了
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
                        baoxian0.clear();
                        for (int i = 0; i < flag.length; i++) {
                          flag[i] = value;
                          baoxian0.add(baoxian[i]);
                        }
                      } else {
                        flag.fillRange(0, flag.length, false);
                        baoxian0.clear();
                      }
                    });
                  },
                ),
                //其余复选框的标题,图标不同了
                ...List.generate(baoxian.length, (index) {
                  //...表示添加项
                  print("baoxian.length:${baoxian.length}");
                  return CheckboxListTile(
                      title: Text(baoxian[index]),
                      subtitle: Text(baoxian[index]),
                      secondary: Icon(Icons.info),
                      /*调整复选框和图标的位置*/
                      controlAffinity: ListTileControlAffinity.leading,
                      value: flag[index],
                      onChanged: (value) {
                        setState(() {
                          flag[index] = value!;
                          if (value) {
                            baoxian0.add(baoxian[index]);
                          } else {
                            baoxian0.remove(baoxian[index]);
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
