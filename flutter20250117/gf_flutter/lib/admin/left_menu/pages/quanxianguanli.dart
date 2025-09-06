import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gf_view/global.dart';
import 'package:flutter_gf_view/model1.dart';
import 'package:dio/dio.dart';
import "package:flutter_gf_view/quan_ju.dart";
import 'dart:html' as webFile;
import 'package:get/get.dart' as Get;
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:flutter_gf_view/widgets/http.dart';

var dialog1_context;
List<String> user_authority =
    []; // Set<String> set;集合类型的元素不可重复用于存放读取的角色权限集合, 改动此值
List<String> user_authority0 =
    []; // Set<String> set;集合类型的元素不可重复.用于存放读取的角色权限集合,不改动此值
List<dynamic> _datamenu = []; //请求到的菜单数据集合
List<List<String>> caidan_admin_1_2 = []; //含有一级二级菜单名称

class quanxianguanli extends StatefulWidget {
  const quanxianguanli({Key? key}) : super(key: key);

  @override
  _quanxianguanliState createState() => _quanxianguanliState();
}

double col_header_width = 100;
List<Map<String, dynamic>> caidan_admin_2 = []; //点击一级菜单时获取的子菜单信息.包含一级菜单和二级
bool bool1 = false;

class _quanxianguanliState extends State<quanxianguanli> {
  TextEditingController? control_text1 = new TextEditingController();
  TextEditingController? control_text3 = new TextEditingController();
  TextEditingController? control_text2 = new TextEditingController();
  double _pos = 0.0, _end = 0.0;

  late ScrollController _scrollController;
  late ScrollController _scrollController1;

  TextEditingController? Controller_menuurl = TextEditingController();
  int _rowsPerPage = 30;
  TextEditingController? Controller_menuname = TextEditingController();
  List fenlei = [];
  int menu_id_1 = 0; //一级菜单的id
  String caidan_text = "一级菜单";
  List<String> caidan_admin_1 = []; //一级菜单名称
  Map<String, int> caidan_id_1 = {}; //一级菜单id
  bool is_select = true;
  var _sortAscending = true;
  List gang0wei0text = [
    //列表的列表集合.第一个项为分类,其余为岗位.//这里有个问题就是这个列表必须有2个空列表,否则首次渲染时,navigation_rail菜单会有个报错,提示菜单项少于2项
    ["", ""], ["", ""],
  ];
  List<dynamic> reslut =
      []; //空的list所以不能使用下标索引要添加add数据才行,等价于  var reslut = List(1);//1个长度的list

  @override
  void initState() {
    // TODO: implement initState
    print("功能设置init");
    super.initState();
    // print(caidan_admin_1_2);

    get_fenlei(); //此中的setstate不能使用,因为build未执行,界面元素没有挂载
    get_gangwei_xifen(); //获取岗位分类

    _scrollController = new ScrollController();
    _scrollController1 = new ScrollController();
    get_user_authority(); //获取角色user权限

    // print("caidan_admin_2");
    // print(caidan_admin_2);
  }

  //获取角色user权限
  void get_user_authority() async {
    var res = await YXHttp().http_post(
        map0api["获取角色user的权限"]!, {"token": token, "rolename": "user"});
//  out(res);

    for (var element in res) {
      user_authority.add(element["v1"]);
    }
    user_authority0 = List.from(
        user_authority); //user_authority0= (user_authority)此种方式,是引用传递,因此user_authority改变,user_authority0也会跟着变.改进方法用 List.from创建新的list

    print("user_authority");
    print(user_authority);
    get_all_menu();
  }

  void get_all_menu() async {
    caidan_admin_1_2 = [];
    caidan_admin_1 = [];
    Map<String, dynamic> a1 = {};
    var result = await YXHttp().http_post(
        map0api["获取后台所有菜单不分权限"]!, {"username": username, "token": token});
    // print(result);
    for (var i = 0; i < result.length; i++) {
      isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
      List<String> list0 = [];
      if (result[i]["ParentId"] == 0) {
        //父id=0就是一级菜单.
        caidan_id_1[result[i]["MenuName"]] = result[i]["Id"];
      }

      if (result[i]["Children"] != null) {
        list0.add(result[i]["MenuName"]);
        if (result[i]["Children"].length > 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < result[i]["Children"].length; i1++) {
            list0.add(result[i]["Children"][i1]["MenuName"]);
          }
          caidan_admin_1_2.add(list0);
        }
      } else {
        list0.add(result[i]["MenuName"]);
        caidan_admin_1_2.add(list0);
      }
    }
    print("caidan_id_1");
    print(caidan_id_1);
    menu_id_1 = caidan_id_1.values.first;
    print("menu_id_1");
    print(menu_id_1);
    print("caidan_admin_1_2");
    print(caidan_admin_1_2);

    caidan_admin_2 = []; //这里必须清空存储的数据表菜单的所有项.否则再次打开会累积

    for (var element in result) {
      // print("一级菜单:");
      a1 = {};

      a1["fold"] = "false"; //是否折叠.0不折叠
      a1["fuhao"] = "+";

      a1["Id"] = element["Id"].toString();
      a1["MenuName"] = element["MenuName"];
      a1["MenuUrl"] = element["MenuUrl"];
      a1["ParentId"] = element["ParentId"].toString();
      a1["Icon"] = element["Icon"].toString();
      a1["Isshow"] = element["Isshow"].toString();
      a1["UpdatedAt"] = element["UpdatedAt"];
      a1["Sort"] = element["Sort"].toString();
      a1["selected"] = false; //判断是否选中行的标记
      if (user_authority.contains(a1["MenuUrl"])) {
        //检查菜单url是否包含在user权限表中.包含,则check标记选中状态

        a1["check"] = true; //判断是否单击了复选框
      } else {
        a1["check"] = false; //判断是否单击了复选框
      }

      // print(a1);
      caidan_admin_2.add(a1);
      //  print(caidan_admin_2);
      if (element["Children"] != null) {
        //有子菜单时执行
        if (element["Children"].length > 0) {
          //有子菜单
          //print("有子菜单:");    print(element["Children"]);  print(element["Children"].length);

          for (var element1 in element["Children"]) {
            // print("element1");  print(element1);
            a1 = {};
            a1["fold"] = "false"; //是否折叠.0不折叠
            a1["fuhao"] = "-";
            a1["Id"] = element1["Id"].toString();
            a1["MenuName"] = element1["MenuName"];
            a1["MenuUrl"] = element1["MenuUrl"];
            a1["ParentId"] = element1["ParentId"].toString();
            a1["Icon"] = element1["Icon"].toString();
            a1["Isshow"] = element1["Isshow"].toString();
            a1["UpdatedAt"] = element1["UpdatedAt"];
            a1["Sort"] = element1["Sort"].toString();
            a1["selected"] = false; //判断是否选中行的标记
            if (user_authority.contains(a1["MenuUrl"])) {
              a1["check"] = true; //判断是否单击了复选框
            } else {
              a1["check"] = false; //判断是否单击了复选框
            }
            caidan_admin_2.add(a1);
          }
        }
      }
    }

    print("caidan_admin_2");
    // print(caidan_admin_2);
    for (int i = 0; i < caidan_admin_1_2.length; i++) {
      caidan_admin_1.add(caidan_admin_1_2[i][0]);
    }

    caidan_text = caidan_admin_1[0];

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _datamenu = [];
    caidan_admin_2 = [];
    user_authority = [];
    print("功能设置dispose");
  }

  Future get_gangwei_xifen({int page2 = 0}) async {
    try {
      // 配置dio实例
      // dio.options.baseUrl = "https://www.xx.com/api";
      //   dio.options.connectTimeout = 5000; //5s
      // dio.options.receiveTimeout = 3000;
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      var options = BaseOptions(
        connectTimeout: Duration(seconds: connectTimeout0),
        receiveTimeout: Duration(seconds: connectTimeout0),
        responseType: ResponseType.json,
        // validateStatus: (status) {
        //   // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        //   return true;
        // },
        //baseUrl: "http://baidu.com/",
      );
      Dio dio = Dio(options); // 使用默认配置
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

  void get_fenlei() async {
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
      print("服务器返回数据是:${response.data}");
      if (response.statusCode == 200) {
        if (response.data["code"] == "0") {
          // print("成功!");
          List<dynamic> res = response.data["data"];
          // thumbnail = s1;
          //   host_url + s1.substring(1); //从第2个字符开始截取
          print(res);
          for (var i = 0; i < res.length; i++) {
            fenlei.add(res[i]["fenlei_name"]);
          }
          // setState(() {});
        }
      }
    }
  }

  void create_usermenu_class_map(String path, String filename) async {
    // Create a new directory, recursively creating non-existent directories.
    //Directory(path).createSync(recursive: true); //创建路径
    File(path + filename).createSync(); //创建文件
    //  print(PinyinHelper.getPinyin(filename, separator: ''));
    var file = File(path + filename);
    print(file.path);

//包文件导入
    file.writeAsStringSync('''
import 'package:flutter/material.dart';

''', mode: FileMode.write); //覆盖写入文件

    for (var i = 0; i < menuuser.length; i++) {
      file.writeAsStringSync(
          '''
import '  ''' +
              menuuser[i]["userMenuUrl"] +
              '''.dart';

''',
          mode: FileMode.append); //追加写入文件
    }

    //写入变量menu_user_class0
    file.writeAsStringSync('''
 Map<String,Widget>menu_user_class0={
''', mode: FileMode.append); //追加写入

    for (var i = 0; i < menuuser.length; i++) {
      String classname = menuuser[i]["userMenuUrl"]
          .toString()
          .split("/")
          .last; //取出url中的最后一个部分,作为类名
      print(classname);
      if (menuuser[i]["Children"] != null) {
        //有子菜单时候,一级菜单写入.

        file.writeAsStringSync('''
"${menuuser[i]["userMenuName"]}":${classname}(),
''', mode: FileMode.append); //追加写入导入的文件

        if (menuuser[i]["Children"].length >= 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < menuuser[i]["Children"].length; i1++) {
            //二级菜单写入map

            String classname = menuuser[i][i1]["userMenuUrl"]
                .toString()
                .split("/")
                .last; //取出url中的最后一个部分,作为类名
            print(classname);

            file.writeAsStringSync('''
"${menuuser[i][i1]["userMenuName"]}":${classname}(),
''', mode: FileMode.append); //追加写入导入的文件
          }
        }
      } else {
        //无子菜单直接写入

        file.writeAsStringSync('''
"${menuuser[i]["userMenuName"]}":${classname}(),
''', mode: FileMode.append); //追加写入导入的文件
      }
    }

    //写入变量menu_admin_class结束
    file.writeAsStringSync('''
    };
''', mode: FileMode.append); //追加写入}:
    print("leftmenu变量写入完毕");
  }

  var value1 = 0;
// 弹出修改对话框
  // final GlobalKey globalKey = GlobalKey(); //globalKey无用,待验证
  Future<dynamic> Modify_dialog(BuildContext context) {
    var scrollController1 = ScrollController();

    return showDialog(
      context: context, //传递一个context进来.
      builder: (BuildContext context1) {
        final size = MediaQuery.of(context1).size;
        final width = size.width;
        final height = size.height;

        return AlertDialog(
          // key: globalKey, //无用,验证
          title: Text("增加菜单"),
          content: Container(
            height: height - 200, width: width, //获取上层控件的宽高

            child: Scrollbar(
                thumbVisibility: true, //始终显示滚动条.listview无法让滚动条始终显示,因此外层加了滚动条控件
                child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    controller: scrollController1,
                    children: [
                      Column(
                        children: <Widget>[
                          StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(children: [
                              Row(
                                children: [
                                  Text("创建类型: "),
                                  SizedBox(width: 100),
                                  // Text("一级菜单"),
                                  Expanded(
                                      child: RadioListTile(
                                    title: const Text("一级菜单"),

                                    ///此单选框绑定的值 必选参数
                                    value: 0, activeColor: Colors.red,
// selected:true,//文字,前边选中框颜色都是红
                                    ///当前组中这选定的值  必选参数
                                    groupValue:
                                        value1, //value1是_valueNotifier驱动源变化后的数值.来自于  _valueNotifier.value ,groupvalue如果=value则单选组件被选中.

                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      print(v);
                                      setState(() {
                                        value1 =
                                            v!; //value是_valueNotifier驱动源的数值.给它赋值改变后就会触发组件ValueListenableBuilder更新,在Radio组件的groupValue属性中获取
                                      });
                                    },
                                  )),
                                  const SizedBox(width: 100),
                                  Expanded(
                                      child: RadioListTile(
                                    title: const Text("二级菜单"),

                                    ///此单选框绑定的值 必选参数
                                    value: 1, activeColor: Colors.red,
// selected:true,
                                    ///当前组中这选定的值  必选参数
                                    groupValue: value1,

                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      print(v);
                                      setState(() {
                                        value1 = v!;
                                      });
                                    },
                                  )),
                                ],
                              ),
                              Divider(height: 4, thickness: 4),
                              if (value1 == 0) //一级菜单
                                Column(children: [
                                  PopupMenuButton<String>(
                                    elevation: 20,
                                    offset: Offset(20, 30),
                                    tooltip: "插入菜单位置",
                                    color: const Color.fromARGB(
                                        255, 225, 226, 225),

                                    //   iconSize: 10.0,
                                    //  icon: Icon(Icons.add),
                                    shadowColor: Colors.greenAccent,
                                    child: //与icon只能设置其一
                                        Container(
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 30,
                                      child: Text(
                                        caidan_text,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),

                                    onSelected: (value) {
                                      print('$value');
                                      print(caidan_admin_1[int.parse(value)]);
                                      caidan_text =
                                          caidan_admin_1[int.parse(value)];
                                      setState(() {});
                                    },
                                    itemBuilder: (context) {
                                      return List<
                                              PopupMenuEntry<String>>.generate(
                                          caidan_admin_1.length, (int i) {
                                        return PopupMenuItem<String>(
                                          value: i
                                              .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                          child: Text(caidan_admin_1[i]),
                                        );
                                      });
                                    },
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("插入位置:"), //InkWell(child:

                                      DropdownButton<String>(
                                          underline: Container(
                                              height: 2,
                                              color: Colors.green
                                                  .withOpacity(0.7)),
                                          value: caidan_text, //下拉框显示的默认文字值
                                          items: caidan_admin_1
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ); //数据刷新组件的所有内容项
                                          }).toList(),
                                          onChanged: (String? value) {
                                            print(value);

                                            caidan_text = (value!);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                  TextFormField(
                                      style: TextStyle(fontSize: 25),
                                      autofocus: true,
                                      controller: Controller_menuname,
                                      decoration: InputDecoration(
                                          labelText: "菜单名称",
                                          hintText: "输入菜单名称",
                                          // hintStyle: TextStyle(color: ),
                                          icon: Icon(
                                            Icons.person,
                                            // color: primary,
                                          )),
                                      onChanged: (v) {
                                        //   yonghu_ming = v;
                                      },
                                      // 校验用户名
                                      validator: (v) {
                                        //   return v.trim().length > 0 ? null : "用户名不能为空";
                                      }),
                                  TextFormField(
                                      style: TextStyle(fontSize: 25),
                                      autofocus: true,
                                      controller: Controller_menuurl,
                                      decoration: InputDecoration(
                                          labelText: "菜单路由路径",
                                          hintText: "输入菜单路由路径URL",
                                          // hintStyle: TextStyle(color: ),
                                          icon: Icon(
                                            Icons.person,
                                            // color: primary,
                                          )),
                                      onChanged: (v) {
                                        //   yonghu_ming = v;
                                      },
                                      // 校验用户名
                                      validator: (v) {
                                        //   return v.trim().length > 0 ? null : "用户名不能为空";
                                      }),
                                  StatefulBuilder(
                                      //对话框中的刷新可以用StatefulBuilder,或ValueListenableBuilder.局部刷新控件,builder中return返回的组件会刷新

                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                    print("局部刷新了");
                                    return SwitchListTile(
                                        title: Text(is_select == true
                                            ? "菜单显示"
                                            : "菜单隐藏"),
                                        value: is_select,
                                        activeTrackColor:
                                            Color.fromARGB(255, 255, 3, 3),
                                        inactiveTrackColor:
                                            const Color.fromARGB(
                                                255, 250, 250, 250),
                                        onChanged: (bool canshu1) {
                                          print(canshu1);
                                          setState(() {
                                            is_select = canshu1;
                                          });
                                        });
                                  }),
                                  ElevatedButton(
                                    onPressed: () async {
                                      print(Controller_menuurl?.text);
                                      print(Controller_menuname?.text);
                                      print(is_select);

//api,插入顶级菜单
// insert_menu/
                                      Map<String, dynamic> parameter = {
                                        "MenuName": Controller_menuname?.text,
                                        "MenuUrl": Controller_menuurl?.text,
                                        "Isshow": is_select,
                                        "Sort": 1,
                                        "token": token,
                                        "ParentId": 0, //一级菜单必须是0
                                      };
                                      var response = await YXHttp().http_post(
                                          map0api["插入后台菜单"]!, parameter);

// print(response);

                                      get_all_menu();
                                    },
                                    child: Text(
                                      "保存一级菜单",
                                    ),
                                  ),
                                ]),
                              if (value1 == 1) //二级菜单
                                Column(children: [
                                  PopupMenuButton<String>(
                                    elevation: 20,
                                    offset: Offset(20, 30),
                                    tooltip: "点击选择顶级菜单",
                                    color: const Color.fromARGB(
                                        255, 225, 226, 225),

                                    //   iconSize: 10.0,
                                    //  icon: Icon(Icons.add),
                                    shadowColor: Colors.greenAccent,
                                    child: //与icon只能设置其一
                                        Container(
                                      alignment: Alignment.center,
                                      width: 150, height: 30,
                                      child: Text(
                                        caidan_text,
                                        style: TextStyle(fontSize: 15),
                                      ),

//  decoration: BoxDecoration(
//     color: Color.fromARGB(255, 84, 165, 251),
//     borderRadius: BorderRadius.circular(50.0), // 设置圆角的大小
//   ),
                                    ),

                                    onSelected: (value) {
                                      print('$value');
                                      print(caidan_admin_1[int.parse(value)]);
                                      caidan_text =
                                          caidan_admin_1[int.parse(value)];
                                      setState(() {});
                                    },
                                    itemBuilder: (context) {
                                      return List<
                                              PopupMenuEntry<String>>.generate(
                                          caidan_admin_1.length, (int i) {
                                        return PopupMenuItem<String>(
                                          value: i
                                              .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                          child: Text(caidan_admin_1[i]),
                                        );
                                      });
                                    },
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("选择一级菜单:"), //InkWell(child:

                                      DropdownButton<String>(
                                          underline: Container(
                                              height: 2,
                                              color: Colors.green
                                                  .withOpacity(0.7)),
                                          value: caidan_text, //下拉框显示的默认文字值
                                          items: caidan_admin_1
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ); //数据刷新组件的所有内容项
                                          }).toList(),
                                          onChanged: (String? value) {
                                            print(value);
                                            menu_id_1 = caidan_id_1[value]!;
                                            print(menu_id_1);
                                            caidan_text = (value!);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                  TextFormField(
                                      style: TextStyle(fontSize: 25),
                                      autofocus: true,
                                      controller: Controller_menuname,
                                      decoration: InputDecoration(
                                          labelText: "菜单名称",
                                          hintText: "输入菜单名称",
                                          // hintStyle: TextStyle(color: ),
                                          icon: Icon(
                                            Icons.person,
                                            // color: primary,
                                          )),
                                      onChanged: (v) {
                                        //   yonghu_ming = v;
                                      },
                                      // 校验用户名
                                      validator: (v) {
                                        //   return v.trim().length > 0 ? null : "用户名不能为空";
                                      }),
                                  TextFormField(
                                      style: TextStyle(fontSize: 25),
                                      autofocus: true,
                                      controller: Controller_menuurl,
                                      decoration: InputDecoration(
                                          labelText: "菜单路由路径",
                                          hintText: "输入菜单路由路径URL",
                                          // hintStyle: TextStyle(color: ),
                                          icon: Icon(
                                            Icons.person,
                                            // color: primary,
                                          )),
                                      onChanged: (v) {
                                        //   yonghu_ming = v;
                                      },
                                      // 校验用户名
                                      validator: (v) {
                                        //   return v.trim().length > 0 ? null : "用户名不能为空";
                                      }),
                                  StatefulBuilder(
                                      //对话框中的刷新可以用StatefulBuilder,或ValueListenableBuilder.局部刷新控件,builder中return返回的组件会刷新

                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                    print("局部刷新了");
                                    return SwitchListTile(
                                        title: Text(is_select == true
                                            ? "菜单显示"
                                            : "菜单隐藏"),
                                        value: is_select,
                                        activeTrackColor:
                                            Color.fromARGB(255, 255, 3, 3),
                                        inactiveTrackColor:
                                            const Color.fromARGB(
                                                255, 250, 250, 250),
                                        onChanged: (bool canshu1) {
                                          print(canshu1);
                                          setState(() {
                                            is_select = canshu1;
                                          });
                                        });
                                  }),
                                  ElevatedButton(
                                    onPressed: () async {
                                      print(Controller_menuurl?.text);
                                      print(Controller_menuname?.text);
                                      Map<String, dynamic> parameter = {
                                        "MenuName": Controller_menuname?.text,
                                        "MenuUrl": Controller_menuurl?.text,
                                        "Isshow": is_select,
                                        "Sort": 1,
                                        "token": token,
                                        "ParentId": menu_id_1, //一级菜单的id
                                      };
                                      var response = await YXHttp().http_post(
                                          map0api["插入后台菜单"]!, parameter);

                                      get_all_menu();
                                    },
                                    child: Text(
                                      "保存二级菜单",
                                    ),
                                  ),
                                ])
                            ]);
                          }),
                        ],
                      ),
                    ])),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("关闭"),
              onPressed: () =>
                  Navigator.of(context1).pop("对话框点击了取消"), // 关闭对话框.返回给上层对话框
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("caidan_admin");
    // print(caidan_admin);
    dialog1_context = context;
    return LayoutBuilder(
        //LayoutBuilder其中的子组件可以获取父组件的宽高如constraints.maxwidth////
        builder: (BuildContext context, BoxConstraints constraints) {
      print('constraints.maxWidth,这是除去侧边栏剩余的tab选项卡页面的宽度');
      print(constraints.maxWidth);
      MyDataTableSource aa = MyDataTableSource(
          caidan_admin_2,
          constraints.maxWidth *
              0.8); //_datamenu作为数据传递给MyDataTableSource构建表格的数据源
      col_header_width = constraints.maxWidth * 0.8 / 6;
      return Container(
          color: Colors.grey[200],
          //  width: constraints.maxWidth,
          // height: 600,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          alignment: Alignment.topRight,
          child: ListView(
              //外层的cloumn不能有,否则不显示listview.外层的container可以不要

              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     //         IntrinsicWidth( // 使用IntrinsicHeight包裹Row组件使其自动推测得到高度
                //     // child:
                Container(
                  // color: const Color.fromARGB(255, 253, 29, 29),
                  // width: constraints.maxWidth,
                  // height: 600,
                  //height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  alignment: Alignment.topRight,
                  child: Column(
                    //列>行-expanded自动扩展-wrap流式布局组件-container(给定宽)-行>expanded>wrap>多个子container(给定宽),可实现行内排列的流式布局
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("用户权限管理页面"),
                      Container(
                          // color: Color.fromARGB(255, 156, 107, 107),
                          // padding: EdgeInsets.all(2),
                          width: constraints
                              .maxWidth, //有2个宽度..此位置的为宽度1.Scrollbar外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                          height: MediaQuery.of(context).size.height,
//  color: Colors.black,
                          child: GestureDetector(
                              child: Scrollbar(
                                  //外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.

                                  thumbVisibility:
                                      true, //显示滚动条. isAlwaysShown   : true,//废弃了
                                  thickness:
                                      15, //滚动条的高度,如果此值为0,滚动条的高度0,就是隐藏了滚动条哦
                                  controller: _scrollController,
                                  child: SingleChildScrollView(
                                      //SingleChildScrollView或者listview外层必须有固定的宽高,否则不显示.

                                      //
                                      // reverse:false,
                                      scrollDirection: Axis.horizontal, //水平滚动
                                      controller: _scrollController,
                                      child:
                                          // Scrollbar(
                                          //     thumbVisibility: true,
                                          //     child:

                                          SingleChildScrollView(
                                              //外层如何套一个scrollbar则,SingleChildScrollView无法使用滚动条下拉拖动了
                                              // reverse:false,
                                              scrollDirection: Axis.vertical,
                                              controller:
                                                  _scrollController1, //垂直滚动
                                              child: Container(
                                                  width: constraints
                                                      .maxWidth, //左侧菜单占用20%比例宽度.在admin_index.dart中的flex参数指定的2. 注意这里的宽度在页面缩放到110以上时候,会遮挡部分内容.所以这里的处理要随着缩放参数增加而变大.因此,这里可以设置一个较大的宽度,防止用户缩放带来的遮挡.有2个宽度需要注意..此位置的为宽度2.Scrollbar外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                                                  //
                                                  child: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        // DataTable 行分隔线的颜色
                                                        dividerColor:
                                                            Colors.red,
                                                      ),
                                                      child: DataTableTheme(
                                                        data: DataTableTheme.of(
                                                                context)
                                                            .copyWith(
                                                          // 表头背景色
                                                          headingRowColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (Set<MaterialState>
                                                                          states) {
                                                            return table_col_header_color; //Theme.of(context).primaryColorDark; //
                                                          }),
                                                          // 表头文字样式（颜色等）
                                                          headingTextStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .orangeAccent),
                                                          dataRowColor:
                                                              MaterialStateProperty
                                                                  .resolveWith<
                                                                      Color?>((Set<
                                                                          MaterialState>
                                                                      states) {
                                                            // 点击、获得焦点、选中时的状态
                                                            const Set<
                                                                    MaterialState>
                                                                stateA =
                                                                <MaterialState>{
                                                              MaterialState
                                                                  .pressed,
                                                              MaterialState
                                                                  .focused,
                                                              MaterialState
                                                                  .selected,
                                                            };
                                                            // 点击、获得焦点、选中时的颜色
                                                            if (states.any(stateA
                                                                .contains)) {
                                                              return Colors
                                                                  .lightBlue;
                                                            }

                                                            // 鼠标经过时的状态
                                                            const Set<
                                                                    MaterialState>
                                                                stateB =
                                                                <MaterialState>{
                                                              MaterialState
                                                                  .hovered,
                                                            };
                                                            // 鼠标经过时的颜色
                                                            if (states.any(stateB
                                                                .contains)) {
                                                              return Colors
                                                                  .cyan;
                                                            }

                                                            // 数据行的颜色，这里如果设置颜色的话，上面的鼠标经过则不起作用。
                                                            return Colors
                                                                .transparent;
                                                          }),
                                                        ),
                                                        child:
                                                            PaginatedDataTable(
                                                          //列宽取决于外层的容器container宽度.越宽则列宽越大.
                                                          dataRowMaxHeight: 50,
                                                          dataRowMinHeight: 20,
                                                          horizontalMargin: 0.0,
                                                          columnSpacing: 10.0,
                                                          headingRowHeight:
                                                              30, //列头的高度
                                                          sortColumnIndex: 0,
                                                          showCheckboxColumn:
                                                              false,

                                                          // sortAscending: false,
                                                          rowsPerPage:
                                                              _rowsPerPage, //每页显示行数.此数字要包含在availableRowsPerPage参数中
                                                          header: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                "*此处设置只会影响用户角色,涉及的表为casbin_rule",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  // color:
                                                                  //     Colors.red
                                                                ),
                                                              ),
                                                              Text(
                                                                "*只有一级菜单和二级菜单同时选中时,才会生效. ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  // color:
                                                                  //     Colors.red
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                //

                                                                print('index:');
                                                                // print(index);
                                                                print(
                                                                    "user_authority");
                                                                print(
                                                                    user_authority);
                                                                print(
                                                                    "user_authority0");
                                                                print(
                                                                    user_authority0);
                                                                // 找出增加的数据
                                                                Set<String>
                                                                    added =
                                                                    user_authority
                                                                        .toSet()
                                                                        .difference(
                                                                            user_authority0.toSet())
                                                                        .toList()
                                                                        .toSet();

                                                                // 找出减少的数据
                                                                Set<String>
                                                                    removed =
                                                                    user_authority0
                                                                        .toSet()
                                                                        .difference(
                                                                            user_authority.toSet())
                                                                        .toList()
                                                                        .toSet();

                                                                print(
                                                                    '增加的数据: $added');
                                                                print(
                                                                    '减少的数据: $removed');

                                                                var res =
                                                                    await YXHttp().http_post(
                                                                        map0api[
                                                                            "增加或减少角色权限"]!,
                                                                        {
                                                                      "token":
                                                                          token,
                                                                      "Add_authorrity":
                                                                          added
                                                                              .toList(),
                                                                      "Del_authorrity":
                                                                          removed
                                                                              .toList(),
                                                                      "Rolename":
                                                                          "user",
                                                                    });
                                                              },
                                                              child: Text(
                                                                "保存",
                                                              ),
                                                            ),
                                                            TextButton.icon(
                                                              label:
                                                                  Text("增加菜单"),
                                                              icon: Icon(
                                                                  Icons.add),
                                                              onPressed: () {
                                                                Modify_dialog(
                                                                    context);
                                                              },
                                                            ),
                                                            IconButton(
                                                              icon: Icon(Icons
                                                                  .refresh),
                                                              tooltip: ("刷新"),
                                                              onPressed: () {
                                                                get_all_menu();
                                                              },
                                                            ),
                                                          ],

                                                          sortAscending:
                                                              _sortAscending, //升序,还是降序
                                                          columns: [
                                                            DataColumn(
                                                                label: Container(
                                                                    // color:
                                                                    //     table_col_header_color,
                                                                    width: col_header_width,
                                                                    alignment: Alignment.center,
                                                                    child: Text('菜单名'))),
                                                            DataColumn(
                                                                label: Container(
                                                                    // color:
                                                                    //     table_col_header_color,
                                                                    alignment: Alignment.center,
                                                                    width: col_header_width, //这里的宽度只能决定列的头部文字的显示完整与否,也影响列宽
                                                                    child: Text('菜单Id'))),
                                                            DataColumn(
                                                                label: Container(
                                                                    // color:
                                                                    //     table_col_header_color,
                                                                    width: col_header_width,
                                                                    alignment: Alignment.center,
                                                                    child: Text('菜单路由'))),
                                                            DataColumn(
                                                                label: Container(
                                                                    // color:
                                                                    //     table_col_header_color,
                                                                    width: col_header_width,
                                                                    alignment: Alignment.center,
                                                                    child: Text("可见"))),
                                                            DataColumn(
                                                              label: Container(
                                                                  // color:
                                                                  //     table_col_header_color,
                                                                  width:
                                                                      col_header_width,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                      '创建时间')),
                                                              // onSort: (index,
                                                              //     sortAscending) {
                                                              //   setState(() {
                                                              //     // print(sortAscending);
                                                              //     _sortAscending =
                                                              //         sortAscending;
                                                              //     print(
                                                              //         sortAscending);
                                                              //     if (sortAscending) {
                                                              //       // print("2");
                                                              //       _datamenu.sort(
                                                              //           (a, b) => a
                                                              //               .email
                                                              //               .compareTo(
                                                              //                   b.email));
                                                              //     } else {
                                                              //       // print("1");
                                                              //       _datamenu.sort(
                                                              //           (a, b) => b
                                                              //               .email
                                                              //               .compareTo(
                                                              //                   a.email));
                                                              //     }
                                                              //   });
                                                              // }
                                                            ),
                                                            DataColumn(
                                                                label: Container(
                                                                    color:
                                                                        table_col_header_color,
                                                                    width:
                                                                        col_header_width,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        '操作'))),
                                                          ],
                                                          source: aa,
                                                          onRowsPerPageChanged:
                                                              (v) {
                                                            setState(() {
                                                              _rowsPerPage = v!;
                                                            });
                                                          },
                                                          availableRowsPerPage: [
                                                            10,
                                                            20,
                                                            40,
                                                            _rowsPerPage
                                                          ], //分页
                                                          //)
                                                        ),
                                                      )))))
                                  // )
                                  ),
                              //手指按下时会触发此回调
                              onPanDown: (DragDownDetails e) {
                                //打印手指按下的位置(相对于屏幕)
                                print("用户手指按下：${e.globalPosition}");
                              },
                              //手指滑动时会触发此回调
                              onPanUpdate: (DragUpdateDetails e) {
                                //用户手指滑动时，更新偏移，重新构建
                                print("e");
                                print(e);
                                setState(() {
                                  _pos += e.delta.dx;
                                  if (_pos < 0) _pos = 0;
                                  if (_pos >
                                      _scrollController.position
                                          .maxScrollExtent) //pos的位置>控制器的最大滚动距离.控制器的最小滚动距离为0
                                    _pos = _scrollController
                                        .position.maxScrollExtent;
                                  _end += e.delta.dy;
                                  // print(_scrollController.position.maxScrollExtent);
                                  //   print(_scrollController.position.minScrollExtent);//
                                  print("_pos");
                                  print(_pos);
                                  _scrollController.jumpTo(_pos);
                                });
                              },
                              onPanEnd: (DragEndDetails e) {
                                //打印滑动结束时在x、y轴上的速度
                                // print(e.velocity);
                                // _left = 0;
                              })),
                      Icon(IconData(int.parse("0xe237"),
                          fontFamily: 'MaterialIcons')),
                      Text(
                        " \uE237",
                        style: TextStyle(
                          fontFamily: "MaterialIcons",
                          fontSize: 24.0,
                          color: Colors.green,
                        ),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.person_add),
                        label: Text("生成前台菜单类变量"),
                        onPressed: () async {
                          // create_usermenu_class_map(
                          //     "./lib/generate/", "usermenuclass.dart");

                          List<String> str = [];

                          str.insert(0, '''
 /* 这时系统生成的前台菜单与widget类之间对应关系的文件.存放在map中.使用时把此文件内容覆盖到文件/lib/generate/usermenuclass.dart中. 
增加前台菜单时的步骤:
1.项目源码中建立目录和菜单类.目录名统一为菜单文件的类名,2者保持一致.
2.数据库user_menu表中user_menu_url参数为目录名.如/user/UserGather,此目录名作为生成文件的import包路径,同时user_menu_url参数用斜杠/分割的最后一部分就是菜单页面对应的类名.
3.生成的代码中不区分一级菜单还是二级菜单.虽然数据库中有菜单的层级关系,但是生成的代码未作处理. 
 
 */
'''); //覆盖写入文件

//import插入第一个
                          str.insert(str.length, '''
import 'package:flutter/material.dart';
'''); //覆盖写入文件

//import插入
                          for (var i = 0; i < menuuser.length; i++) {
                            if (menuuser[i]["Children"] != null) {
                              ////有子时,判断子的长度后插入import

                              str.insert(
                                  str.length,
                                  "import '" +
                                      menuuser[i]["userMenuUrl"] +
                                      '''
.dart';
  ''');

                              if (menuuser[i]["Children"].length > 0) {
                                // caidan.add(json0[i]["MenuName"]);
                                for (var i1 = 0;
                                    i1 < menuuser[i]["Children"].length;
                                    i1++) {
                                  str.insert(
                                      str.length,
                                      "import '" +
                                          menuuser[i]["Children"][i1]
                                              ["userMenuUrl"] +
                                          '''
.dart';
  ''');
                                }
                              }
                            } else {
                              //无子时,插入导入import

                              str.insert(
                                  str.length,
                                  "import '" +
                                      menuuser[i]["userMenuUrl"] +
                                      '''
.dart';
  ''');
                            }
                          }

                          //写入变量menu_user_class0
                          str.insert(str.length, '''
 Map<String,Widget>menu_user_class={
''');

                          for (var i = 0; i < menuuser.length; i++) {
                            String classname = menuuser[i]["userMenuUrl"]
                                .toString()
                                .split("/")
                                .last; //取出url中的最后一个部分,作为类名
                            print(classname);
                            if (menuuser[i]["Children"] != null) {
                              //有子菜单时候,一级菜单写入.

                              str.insert(str.length, '''
"${menuuser[i]["userMenuName"]}":${classname}(),
'''); //追加写入导入的文件

                              if (menuuser[i]["Children"].length > 0) {
                                // caidan.add(json0[i]["MenuName"]);
                                for (var i1 = 0;
                                    i1 < menuuser[i]["Children"].length;
                                    i1++) {
                                  //二级菜单写入map
                                  print(menuuser[i]["Children"][i1]
                                      ["userMenuUrl"]);
                                  String classname = menuuser[i]["Children"][i1]
                                          ["userMenuUrl"]
                                      .toString()
                                      .split("/")
                                      .last; //取出url中的最后一个部分,作为类名
                                  print(classname);

                                  str.insert(str.length, '''
"${menuuser[i]["Children"][i1]["userMenuName"]}":${classname}(),
'''); //追加写入导入的文件
                                }
                              }
                            } else {
                              //无子菜单直接写入

                              str.insert(str.length, '''
"${menuuser[i]["userMenuName"]}":${classname}(),
''');
                            }
                          }

                          //写入变量menu_admin_class结束
                          str.insert(str.length, '''
    };
'''); //追加写入}:

// if (kIsWeb)
                          {
                            //原生下载文件
                            var blob =
                                webFile.Blob(str, 'text/plain', 'native');

                            var anchorElement = webFile.AnchorElement(
                              href: webFile.Url.createObjectUrlFromBlob(blob)
                                  .toString(),
                            )
                              ..setAttribute("download", "usermenuclass.dart")
                              ..click();
                          }
                        },
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.person_add),
                        label: Text("生成菜单"),
                        onPressed: () async {
                          // create_left_menu_map("./lib/admin/","left_menu_test.dart");
// print(caidan_admin_1_2);
                          // for (var i = 0; i < caidan_admin_1_2.length; i++) {
                          //   for (var i1 = 0; i1 < caidan_admin_1_2[i].length - 1; i1++) {
                          //     // print(caidan_admin_1_2[i][i1+1]);
                          //     var name = caidan_admin_1_2[i][i1 + 1];
                          //     createFileRecursively("./lib/admin/left_menu/pages/",
                          //         '${name}.dart'); //递归创建路径和文件

                          //   }
                          // }
                        },
                      ),
                      Text("设置文章分类/招聘岗位:"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Wrap(
                            children: [
                              Container(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Wrap(children: [
                                          Container(
                                              width: 100,
                                              height: 50,
                                              child: TextField(
                                                controller: control_text1,
                                                decoration: InputDecoration(
                                                    labelText: '*文章分类名称:',
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.blueGrey)),
                                              )),
                                          Container(
                                              width: 50,
                                              height: 50,
                                              child: TextButton(
                                                  child: Text("添加"),
                                                  onPressed: () async {
                                                    print(control_text1!.text);

// // 或者通过传递一个 `options`来创建dio实例
                                                    BaseOptions options =
                                                        BaseOptions(
                                                      // baseUrl: url1,
                                                      connectTimeout:
                                                          Duration(seconds: connectTimeout0),
                                                      receiveTimeout:
                                                          Duration(seconds: connectTimeout0),
                                                      contentType:
                                                          "application/json", //默认json传输.配合'Content-Type':'application/json',
                                                    );
                                                    Dio dio = Dio(options);

                                                    FormData formData1 =
                                                        new FormData.fromMap({
                                                      "token": token,
                                                      "fenleiname":
                                                          control_text1!.text,
                                                    });
                                                    var response =
                                                        await dio.post(
                                                      map0api["设置文章分类"]!,
                                                      data: formData1,
                                                    );
                                                    print(
                                                        "服务器返回数据是:${response.data}");
                                                    if (response.statusCode ==
                                                        200) {
                                                      if (response
                                                              .data["code"] ==
                                                          "0") {
                                                        // print("成功!");
                                                        List<dynamic> res =
                                                            response
                                                                .data["data"];
                                                        // thumbnail = s1;
                                                        //   host_url + s1.substring(1); //从第2个字符开始截取
                                                        print(res);
                                                        for (var i = 0;
                                                            i < res.length;
                                                            i++) {
                                                          fenlei.add(res[i]
                                                              ["fenlei_name"]);
                                                        }
                                                        setState(() {});
                                                      }
                                                    }
                                                  })),
                                          Container(
                                              width: 150,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: PopupMenuButton<String>(
                                                color: Colors.greenAccent[100],
                                                // iconSize: 10.0,
                                                //  icon: Icon(Icons.add),

                                                child: Text(
                                                  "查询",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                onSelected: (value) {
                                                  print('$value');
                                                },
                                                itemBuilder: (context) {
                                                  return List<
                                                          PopupMenuEntry<
                                                              String>>.generate(
                                                      fenlei.length, (int i) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: i
                                                          .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                                      child: Text(fenlei[i]),
                                                    );
                                                  });
                                                },
                                              )),
                                        ]),
                                      )
                                    ],
                                  )),
                              Container(
                                  width: 450,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 100,
                                          height: 50,
                                          child: TextField(
                                            controller: control_text2,
                                            decoration: InputDecoration(
                                                labelText: '*招聘分类:',
                                                labelStyle: TextStyle(
                                                    color: Colors.blueGrey)),
                                          )),
                                      Container(
                                          width: 150,
                                          height: 50,
                                          child: TextField(
                                            // 校验用户名

                                            controller: control_text3,
                                            decoration: InputDecoration(
                                                labelText: '*招聘岗位,逗号分隔,如a,b:',
                                                labelStyle: TextStyle(
                                                    color: Colors.blueGrey)),
                                          )),
                                      TextButton(
                                          child: Text("添加"), //招聘分类添加
                                          onPressed: () async {
                                            print(control_text2!.text);
                                            print(control_text3!.text);
                                            print(control_text3!.text
                                                .split(",")
                                                .toList()
                                                .toString());
                                            if ((control_text2!.text
                                                    .contains(" ")) ||
                                                (control_text3!.text
                                                    .contains(" ")) ||
                                                (control_text2!.text == "") ||
                                                (control_text3!.text == "")) {
                                              print("包含了空格或未填写");
                                            } else {
// // 或者通过传递一个 `options`来创建dio实例
                                              BaseOptions options = BaseOptions(
                                                // baseUrl: url1,
                                                connectTimeout:Duration(seconds: connectTimeout0),
                                                receiveTimeout:Duration(seconds: connectTimeout0),
                                                contentType:
                                                    "application/json", //默认json传输.配合'Content-Type':'application/json',
                                              );
                                              Dio dio = Dio(options);

                                              FormData formData1 =
                                                  new FormData.fromMap({
                                                "token": token,
                                                "fenlei": control_text2!.text,
                                                "gangwei": control_text3!.text
                                                    .split(",")
                                                    .toList()
                                                    .toString()
                                                    .replaceAll(" ",
                                                        ""), //去除所有list转字符串的空格.如[五险一金, 单休],其中的单休前边有个空格哦.这个空格要去除才行, //传入岗位值必须是[]列表
                                              });
                                              var response = await dio.post(
                                                map0api["设置岗位分类和岗位细分"]!,
                                                data: formData1,
                                              );
                                              print(
                                                  "服务器返回数据是:${response.data}");
                                              if (response.statusCode == 200) {
                                                if (response.data["code"] ==
                                                    "0") {
                                                  // print("成功!");
                                                  List<dynamic> res =
                                                      response.data["data"];
                                                  // thumbnail = s1;
                                                  //   host_url + s1.substring(1); //从第2个字符开始截取
                                                  print(res);
                                                  // for (var i = 0; i < res.length; i++) {
                                                  //   fenlei.add(res[i]["fenlei_name"]);
                                                  // }
                                                  //    setState(() {});
                                                }
                                              }
                                            }
                                          }),
                                      PopupMenuButton<String>(
                                        color: Colors.greenAccent[100],
                                        // iconSize: 10.0,
                                        //  icon: Icon(Icons.add),

                                        child: Text(
                                          "查询",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onSelected: (value) {
                                          print('$value');
                                        },
                                        itemBuilder: (context) {
                                          return List<
                                                  PopupMenuEntry<
                                                      String>>.generate(
                                              gang0wei0text.length, (int i) {
                                            int index1 = gang0wei0text[i]
                                                .toString()
                                                .indexOf(",");
                                            int len = gang0wei0text[i]
                                                .toString()
                                                .length;

                                            return PopupMenuItem<String>(
                                              value: i
                                                  .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                              child: Text(
                                                  "分类:${gang0wei0text[i].toString().substring(1, index1)},岗位:${gang0wei0text[i].toString().substring(index1 + 1, len - 1)}"),
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                            ],
                          ))
                        ],
                      ),
                      Text("设置菜单:"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Wrap(
                            children: [
                              Container(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Wrap(children: [
                                          Container(
                                              width: 100,
                                              height: 50,
                                              child: TextField(
                                                controller: control_text1,
                                                decoration: InputDecoration(
                                                    labelText: '*一级菜单名称:',
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.blueGrey)),
                                              )),
                                          Container(
                                              width: 50,
                                              height: 50,
                                              child: TextButton(
                                                  child: Text("添加"),
                                                  onPressed: () async {
                                                    print(control_text1!.text);

// // 或者通过传递一个 `options`来创建dio实例
                                                    BaseOptions options =
                                                        BaseOptions(
                                                      // baseUrl: url1,
                                                      connectTimeout:
                                                          Duration(seconds: connectTimeout0),
                                                      receiveTimeout:
                                                          Duration(seconds: connectTimeout0),
                                                      contentType:
                                                          "application/json", //默认json传输.配合'Content-Type':'application/json',
                                                    );
                                                    Dio dio = Dio(options);

                                                    FormData formData1 =
                                                        new FormData.fromMap({
                                                      "token": token,
                                                      "fenleiname":
                                                          control_text1!.text,
                                                    });
                                                    var response =
                                                        await dio.post(
                                                      map0api["设置文章分类"]!,
                                                      data: formData1,
                                                    );
                                                    print(
                                                        "服务器返回数据是:${response.data}");
                                                    if (response.statusCode ==
                                                        200) {
                                                      if (response
                                                              .data["code"] ==
                                                          "0") {
                                                        // print("成功!");
                                                        List<dynamic> res =
                                                            response
                                                                .data["data"];
                                                        // thumbnail = s1;
                                                        //   host_url + s1.substring(1); //从第2个字符开始截取
                                                        print(res);
                                                        for (var i = 0;
                                                            i < res.length;
                                                            i++) {
                                                          fenlei.add(res[i]
                                                              ["fenlei_name"]);
                                                        }
                                                        setState(() {});
                                                      }
                                                    }
                                                  })),
                                          Container(
                                              alignment: Alignment.center,
                                              width: 150,
                                              height: 50,
                                              child: PopupMenuButton<String>(
                                                color: Colors.greenAccent[100],
                                                // iconSize: 10.0,
                                                //  icon: Icon(Icons.add),

                                                child: Text(
                                                  "查询",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                onSelected: (value) {
                                                  print('$value');
                                                },
                                                itemBuilder: (context) {
                                                  return List<
                                                          PopupMenuEntry<
                                                              String>>.generate(
                                                      fenlei.length, (int i) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: i
                                                          .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                                      child: Text(fenlei[i]),
                                                    );
                                                  });
                                                },
                                              )),
                                        ]),
                                      )
                                    ],
                                  )),
                              Container(
                                  width: 450,
                                  child: Row(
                                    children: [
                                      PopupMenuButton<String>(
                                        color: Colors.greenAccent[100],
                                        // iconSize: 10.0,
                                        //  icon: Icon(Icons.add),

                                        child: Text(
                                          "选择一级菜单",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onSelected: (value) {
                                          print('$value');
                                        },
                                        itemBuilder: (context) {
                                          return List<
                                                  PopupMenuEntry<
                                                      String>>.generate(
                                              gang0wei0text.length, (int i) {
                                            int index1 = gang0wei0text[i]
                                                .toString()
                                                .indexOf(",");
                                            int len = gang0wei0text[i]
                                                .toString()
                                                .length;

                                            return PopupMenuItem<String>(
                                              value: i
                                                  .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                              child: Text(
                                                  "分类:${gang0wei0text[i].toString().substring(1, index1)},岗位:${gang0wei0text[i].toString().substring(index1 + 1, len - 1)}"),
                                            );
                                          });
                                        },
                                      ),
                                      Container(
                                          width: 100,
                                          height: 50,
                                          child: TextField(
                                            controller: control_text2,
                                            decoration: InputDecoration(
                                                labelText: '*填写二级菜单:',
                                                labelStyle: TextStyle(
                                                    color: Colors.blueGrey)),
                                          )),
                                      Container(
                                          width: 130,
                                          height: 50,
                                          child: TextField(
                                            controller: control_text2,
                                            decoration: InputDecoration(
                                                labelText:
                                                    '*填写菜单地址:如/admin/zlxg',
                                                labelStyle: TextStyle(
                                                    color: Colors.blueGrey)),
                                          )),
                                      TextButton(
                                          child: Text("添加"), //招聘分类添加
                                          onPressed: () async {
                                            print(control_text2!.text);
                                            print(control_text3!.text);
                                            print(control_text3!.text
                                                .split(",")
                                                .toList()
                                                .toString());
                                            if ((control_text2!.text
                                                    .contains(" ")) ||
                                                (control_text3!.text
                                                    .contains(" ")) ||
                                                (control_text2!.text == "") ||
                                                (control_text3!.text == "")) {
                                              print("包含了空格或未填写");
                                            } else {
// // 或者通过传递一个 `options`来创建dio实例
                                              BaseOptions options = BaseOptions(
                                                // baseUrl: url1,
                                                connectTimeout:Duration(seconds: connectTimeout0),
                                                receiveTimeout:Duration(seconds: connectTimeout0),
                                                contentType:
                                                    "application/json", //默认json传输.配合'Content-Type':'application/json',
                                              );
                                              Dio dio = Dio(options);

                                              FormData formData1 =
                                                  new FormData.fromMap({
                                                "token": token,
                                                "fenlei": control_text2!.text,
                                                "gangwei": control_text3!.text
                                                    .split(",")
                                                    .toList()
                                                    .toString()
                                                    .replaceAll(" ",
                                                        ""), //去除所有list转字符串的空格.如[五险一金, 单休],其中的单休前边有个空格哦.这个空格要去除才行, //传入岗位值必须是[]列表
                                              });
                                              var response = await dio.post(
                                                map0api["设置岗位分类和岗位细分"]!,
                                                data: formData1,
                                              );
                                              print(
                                                  "服务器返回数据是:${response.data}");
                                              if (response.statusCode == 200) {
                                                if (response.data["code"] ==
                                                    "0") {
                                                  // print("成功!");
                                                  List<dynamic> res =
                                                      response.data["data"];
                                                  // thumbnail = s1;
                                                  //   host_url + s1.substring(1); //从第2个字符开始截取
                                                  print(res);
                                                  // for (var i = 0; i < res.length; i++) {
                                                  //   fenlei.add(res[i]["fenlei_name"]);
                                                  // }
                                                  //    setState(() {});
                                                }
                                              }
                                            }
                                          }),
                                      PopupMenuButton<String>(
                                        color: Colors.greenAccent[100],
                                        // iconSize: 10.0,
                                        //  icon: Icon(Icons.add),

                                        child: Text(
                                          "查询",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onSelected: (value) {
                                          print('$value');
                                        },
                                        itemBuilder: (context) {
                                          return List<
                                                  PopupMenuEntry<
                                                      String>>.generate(
                                              gang0wei0text.length, (int i) {
                                            int index1 = gang0wei0text[i]
                                                .toString()
                                                .indexOf(",");
                                            int len = gang0wei0text[i]
                                                .toString()
                                                .length;

                                            return PopupMenuItem<String>(
                                              value: i
                                                  .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                                              child: Text(
                                                  "分类:${gang0wei0text[i].toString().substring(1, index1)},岗位:${gang0wei0text[i].toString().substring(index1 + 1, len - 1)}"),
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                  //     )
                  //   ],
                )
              ]));
      // );

      // ),
      // );
    });
  }
}

Map<String, int> c = {};

class MyDataTableSource extends DataTableSource {
  MyDataTableSource(this.data, this.width);
  double width;
  List<dynamic> data; //传递过来的数据
  // bool check1=false;
//定义一个controller
  TextEditingController _unameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _headphotoController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _sexController = TextEditingController();

  TextEditingController _scoreController = TextEditingController();
  TextEditingController _IDController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _signatureController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();

  int groupValue = 0;
  bool once = true;
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      once = false;
      return null;
    }
    if (once) {
      c[caidan_admin_2[index]["MenuName"]!] =
          index; //首次存放一级目录和索引.因为更新数据源时候索引会变化.所以这里要保存索引值.
    }

// print("c");
// print(c);
    return DataRow.byIndex(
      selected: data[index]["selected"],
      index: index,
      onSelectChanged: (selected) {
        data[index]["selected"] = selected!;
        notifyListeners();
        if (selected == true) {
          print("选中的数据行id:");
          // print(data[index]["id"]);
          // print(data[index]["username"]);
        }
      },
      cells: [
        DataCell(
            Container(
                width: col_header_width,
                alignment: Alignment.center,
                // color: Colors.grey[300],
                child: Row(children: [
                  //根据fuhao来判断一级菜单的显示形式
                  data[index]["fuhao"] == "+"
                      ? Row(children: [
                          Icon(Icons.arrow_drop_down_outlined),
                          Text(
                            '${data[index]["MenuName"]} ',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          )
                        ])
                      : Row(children: [
                          SizedBox(width: 10 * 2),
                          Icon(Icons.arrow_left_outlined),
                          Text('${data[index]["MenuName"]}')
                        ]),
                ])),

//         }),
            onTap: () {
          print("index");
          print(index);

          List<Map<String, dynamic>> caidan_admin_3 =
              []; //点击一级菜单时获取的子菜单信息.包含一级菜单和
          List<Map<String, String>> caidan_admin_4 = [];
          Map<String, dynamic> a1 = {};

          bool1 = !bool1;
          print(data[index]["MenuName"]);
          int index0 = c[data[index]["MenuName"]]!;
          print("当前菜单的index0");
          print(index0);
          // caidan_admin_2[index]["fold"] = (bool1).toString();
          String? current_Id = caidan_admin_2[index0]
              ["Id"]; //这里绝对不能用data[index]["Id"],因为后边有对data数据源赋值,造成这里的取值变化
          // print(caidan_admin_2);
//判断当前点击的一级菜单的展开状态.如果是折叠则调用展开,反之亦然.
          if (caidan_admin_2[index0]["fold"] == "false") {
            //菜单折叠
            print("折叠,true");
            caidan_admin_2[index0]["fold"] = "true"; //点击后,则一级菜单加入fold=true标记
            //默认所有caidan_admin_2的fold项都为false. 点击后,则一级菜单和下所属的二级菜单都加入fold=true标记
            for (var element in caidan_admin_2) {
              // print('element ');
              //           print(element );
              a1 = {}; //清空一次
              if ((element["ParentId"] == current_Id)) {
                element['fold'] = "true"; //点击的一级菜单和下的二级菜单都加入fold=true标记
              }
              //菜单折叠,就是减少数据
              //点击一级菜单之后,则所属的二级菜单不加入caidan_admin_3.
              //((element["ParentId"] != current_Id) &&(element["fold"] == "false"))//这个是判断是当前点击和未点击折叠的一级菜单和二级菜单
              // //  ((element["ParentId"] == "0") && (element["fold"] == "true"))判断之前折叠过的一级和二级菜单

              if (((element["ParentId"] != current_Id) &&
                      (element["fold"] == "false")) ||
                  ((element["ParentId"] == "0") &&
                      (element["fold"] == "true"))) {
                a1["fuhao"] = element['fuhao']!;
                a1["fold"] = element['fold']!;
                a1["Id"] = element["Id"].toString();
                a1["MenuName"] = element["MenuName"]!;
                a1["MenuUrl"] = element["MenuUrl"]!;
                a1["ParentId"] = element["ParentId"].toString();
                a1["Icon"] = element["Icon"].toString();
                a1["Isshow"] = element["Isshow"].toString();
                a1["UpdatedAt"] = element["UpdatedAt"]!;
                a1["Sort"] = element["Sort"].toString();
                a1["selected"] = false;
                // print(a1);
                caidan_admin_3.add(a1);
              }
            }
          } else {
            //展开
            print("展开,false");
            caidan_admin_2[index0]["fold"] = "false"; //把当前点击的一级菜单的fold标记为false.
            for (var element in caidan_admin_2) {
              a1 = {};
              if ((element["ParentId"] == current_Id)) {
                element['fold'] = "false"; // 把当前点击的一级菜单,下属的二级菜单fold标记为false
              }

              //菜单展开,就是添加数据.
              //((element["ParentId"] != current_Id) && (element["fold"] == "false")) //判断非当前点击的一级菜单和二级菜单加入caidan_admin_3

//   ((element["ParentId"] == "0") && (element["fold"] == "true")) //把折叠的一级菜单加入caidan_admin_3
              //  ((element["ParentId"] == current_Id)   &&(element["fold"] == "false")//判断当前点击的一级菜单下属的,二级菜单加入caidan_admin_3
              if (((element["ParentId"] != current_Id) &&
                      (element["fold"] == "false")) ||
                  ((element["ParentId"] == "0") &&
                      (element["fold"] == "true")) ||
                  ((element["ParentId"] == current_Id) &&
                      (element["fold"] == "false"))) {
                a1["fuhao"] = element['fuhao']!;
                a1["fold"] = element['fold']!;
                a1["Id"] = element["Id"].toString();
                a1["MenuName"] = element["MenuName"]!;
                a1["MenuUrl"] = element["MenuUrl"]!;
                a1["ParentId"] = element["ParentId"].toString();
                a1["Icon"] = element["Icon"].toString();
                a1["Isshow"] = element["Isshow"].toString();
                a1["UpdatedAt"] = element["UpdatedAt"]!;
                a1["Sort"] = element["Sort"].toString();
                a1["selected"] = false;
                caidan_admin_3.add(a1);
              }
            }
          }

          print("caidan_admin_3");
          // print(caidan_admin_3);
          data = caidan_admin_3; //把处理后的菜单数据给源
          notifyListeners();
        }),

        DataCell(Container(
            // color: Colors.grey[300],
            width: col_header_width,
            alignment: Alignment.center,
            child: Text('${data[index]["Id"]}'))),

        DataCell(Container(
            // color: Colors.grey[300],
            width: col_header_width,
            alignment: Alignment.center,
            child: Text('${data[index]["MenuUrl"]}'))),

        DataCell(Row(children: [
          Expanded(
              child: Container(
                  // color: Colors.grey[300],
                  width: col_header_width,
                  alignment: Alignment.center,
                  // color: table_col_header_color,
                  child:
                      Text('${data[index]["Isshow"]}'))), //showEditIcon: true,
        ])
            //     onTap: () {
            //   print("触摸了该列");

            //   notifyListeners();
            // }
            ),
        // DataCell(Text('${data[index]["Sort"]}')),
        DataCell(Container(
            // color: Colors.grey[300],
            width: col_header_width,
            alignment: Alignment.center,
            child: Text('${data[index]["UpdatedAt"]}'))),
        DataCell(Container(
            color: Colors.grey[300],
            width: col_header_width,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     //
// print(data[index]["ParentId"]);
//                    // notifyListeners();因为数据源的数据未发生改变因此这个通知不用了
//                   },
//                   child: Text(
//                     "test ",
//                   ),
//                 ),

  data[index]["ParentId"]=="0"?Text( data[index]["MenuName"] ):Checkbox(
                    activeColor: Colors.black,
                    value: data[index]["check"],
                    onChanged: (value) {
                      // print("index"); print(index);
                      //  print("value"); print(value);
                      data[index]["check"] = value!;
                      //  print( data[index] );
//  print( data[index]["MenuUrl"]);

                      if (value == true) {
                        //如果勾选复选框,则判断user_authority角色菜单如果未包含该菜单路由,则加入.
                        if (user_authority.contains(data[index]["MenuUrl"]) ==
                            false) {
                          user_authority.add(data[index]["MenuUrl"]);
                          print("caidan_admin");
                          // print(caidan_admin);
                          //如果选中二级菜单,则要把一级菜单添加进来.这样后台登录时才会显示二级菜单和一级菜单..如果不加入一级菜单,则二级菜单不会显示
                          //如果二级菜单都不选择,则user_authority保留一级菜单.这样不会影响登陆显示
                          for (int i = 0; i < caidan_admin.length; i++) {
                            //  caidan_admin_1_2[i][0];//一级菜单名称.根据名称查menuurl
                            for (int i1 = 0;
                                i1 < (caidan_admin[i]["Children"]).length;
                                i1++) {
                              print("caidan_admin[i][Children][i1][MenuName]");
                              //   print(caidan_admin[i]["Children"][i1]["MenuName"]);

                              if (caidan_admin[i]["Children"][i1]["MenuName"] ==
                                  data[index]["MenuName"]) {
                                print("一级菜单");
                                print(caidan_admin[i]["MenuUrl"]); 
                                 if (user_authority.contains(caidan_admin[i]["MenuUrl"]) ==
                            false) {//不包含一级菜单则添加
                                   user_authority.add(caidan_admin[i]["MenuUrl"]);}
                                print(caidan_admin[i]["MenuName"]);
                                // notifyListeners();
                                break;
                              }
                            }
                          }
                        }
                      } else {
                        if (user_authority.contains(data[index]["MenuUrl"]) ==
                            true) {
                          user_authority.remove(data[index]["MenuUrl"]);
                         
                        }
                      }
                      print("user_authority");
                      print(user_authority);

                      notifyListeners();
                    }),
              ],
            ))),
      ],
    );
  }

// 弹出修改对话框
  // final GlobalKey globalKey = GlobalKey(); //globalKey无用,待验证
  Future<dynamic> modify_dialog(Map data) {
    ValueNotifier<int> _valueNotifier = ValueNotifier<int>(
        groupValue); //数据监听器.监控int型一个数据,groupValue是初始值._valueNotifier.value是获取值
    //对话框返回类型是dynamic,接受map类型参数
    _unameController.text = "${data["fuhao"]}"; //对话框刚调用就传值进来
    _telController.text = "${data["fold"].toString()}";
    _emailController.text = "${data["Id"]}";
    int b1 = data["Isshow"] == "true" ? 1 : 0;
    _valueNotifier.value = (b1);
    _headphotoController.text = "${data["MenuUrl"]}";
    _birthController.text = "${data["ParentId"]}";
    _sexController.text = "${data["Icon"]}";
    _scoreController.text = "${data["Isshow"].toString()}";
    _IDController.text = "${data["Sort"]}";
    _addressController.text = "${data["UpdatedAt"]}";
    _signatureController.text = "${data["MenuName"]}";
    // _nicknameController.text = "${data["nickname"]} ";

    var scrollController1 = ScrollController();

    return showDialog(
      context: dialog1_context, //传递一个context进来.
      builder: (BuildContext context1) {
        final size = MediaQuery.of(context1).size;
        final width = size.width;
        final height = size.height;

        return AlertDialog(
          // key: globalKey, //无用,验证
          title: Text("用户Id:" "${data["id"]}信息修改:"),
          content: Container(
            height: height - 200, width: width, //获取上层控件的宽高

            child: Scrollbar(
                thumbVisibility: true, //始终显示滚动条.listview无法让滚动条始终显示,因此外层加了滚动条控件
                child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    controller: scrollController1,
                    children: [
                      Column(
                        children: <Widget>[
                          Text("父id:" "${data["ParentId"]}"),
                          TextField(
                            controller: _birthController,
                            decoration: InputDecoration(
                                labelText: "父id",
                                hintText: "父id",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),

                          Text("菜单id:" "${data["Id"]}"),
                          TextField(
                            readOnly: true,
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: "菜单id",
                                hintText: "菜单id",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),

                          Text("菜单名:" "${data["MenuName"]}"),
                          TextField(
                            controller: _signatureController,
                            decoration: InputDecoration(
                                labelText: "菜单名",
                                hintText: "菜单名",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("图标:" "${data["Icon"]}"),
                          TextField(
                            controller: _sexController,
                            decoration: InputDecoration(
                                labelText: "图标",
                                hintText: "图标",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),

                          Text("菜单Url:" "${data["MenuUrl"]}"),
                          TextField(
                            controller: _headphotoController,
                            decoration: InputDecoration(
                                labelText: "菜单Url",
                                hintText: "Url",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          // Text("禁用:" "${data["beiyong1"]}"),

                          Text("更新时间:" "${data["UpdatedAt"]}"),
                          TextField(
                            controller: _addressController,
                            decoration: InputDecoration(
                                labelText: "更新时间",
                                hintText: "更新时间",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("排序:" "${data["Sort"]}"),
                          TextField(
                            controller: _IDController,
                            decoration: InputDecoration(
                                labelText: "排序",
                                hintText: "排序",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("是否显示:" "${data["Isshow"]}"),
                          ValueListenableBuilder<int>(
                            //对话框中的刷新可以用StatefulBuilder,或ValueListenableBuilder
                            valueListenable: _valueNotifier, //是驱动源.
                            builder: (BuildContext context, int value1,
                                Widget? child) {
                              return Row(
                                children: [
                                  Text("隐藏"),
                                  Radio(
                                    ///此单选框绑定的值 必选参数
                                    value: 0,

                                    ///当前组中这选定的值  必选参数
                                    groupValue:
                                        value1, //value1是_valueNotifier驱动源变化后的数值.来自于  _valueNotifier.value ,groupvalue如果=value则单选组件被选中.

                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      //  setState(() {
                                      _valueNotifier.value =
                                          v!; //value是_valueNotifier驱动源的数值.给它赋值改变后就会触发组件ValueListenableBuilder更新,在Radio组件的groupValue属性中获取

                                      //  });
                                    },
                                  ),
                                  Text("显示"),
                                  Radio(
                                    ///此单选框绑定的值 必选参数
                                    value: 1,

                                    ///当前组中这选定的值  必选参数
                                    groupValue: value1,

                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      //  setState(() {
                                      _valueNotifier.value = v!;
                                      //  });
                                    },
                                  ),
                                ],
                              );
                            },
                            child: Container(
                              child: Text('用户是否禁用'),
                            ),
                          ),
                          // TextField(
                          //   controller: _scoreController,
                          //   decoration: InputDecoration(
                          //       labelText: "是否显示",
                          //       hintText: "是否显示",
                          //       prefixIcon: Icon(Icons.person)),
                          //   //obscureText: true,
                          // ),
                        ],
                      ),
                    ])),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("取消"),
              onPressed: () =>
                  Navigator.of(context1).pop("对话框点击了取消"), // 关闭对话框.返回给上层对话框
            ),
            ElevatedButton(
              child: Text("保存"),
              onPressed: () {
                print(" _valueNotifier.value");
                // print(_valueNotifier.value);
                //futrue类似await.执行后使用then.在其中写接下来处理的部分.<String>是返回值

                Future<Map?> a = showDialog(
                  context: context1, //传递一个context进来.并且需要被赋值为上个组件的context否则不弹出
                  builder: (BuildContext dialog2Context) {
                    return AlertDialog(
                      key: Key('myDialog'),
                      title: Text("提示"),
                      content: Text("要保存吗?"),
                      actions: <Widget>[
                        ElevatedButton(
                            child: Text("重新编辑"),
                            onPressed: () {
                              Navigator.of(dialog2Context)
                                  .pop(); // 关闭对话框.返回值为null
                            }

                            // Navigator.pop(dialog2Context)
                            ),
                        ElevatedButton(
                          child: Text("保存退出"),
                          onPressed: () async {
                            // Navigator.of(context)
                            //     .pop(jsonEncode(data1)); //点击确认保存按钮后返回的list字符串

                            BaseOptions options = BaseOptions(
                              connectTimeout:Duration(seconds: connectTimeout0),
                              receiveTimeout:
                                  Duration(seconds: connectTimeout0), //无数据库链接时的反应时间,超过此时间就执行报错处理 了
                              contentType: Headers.jsonContentType,
                              responseType: ResponseType.json,
                              // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
                              /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
                              /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
                              /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
                              /// 就会自动编码请求体.
                            );

                            Dio dio = Dio(options);

                            //字段名称必须与服务器端一致

                            var json_str = {
                              "token": token,
                              "Id": _emailController.text, //菜单id不能修改
                              "MenuName": _signatureController.text,
                              "Icon": _sexController.text,
                              "MenuUrl": _headphotoController.text,
                              "Sort": _IDController.text,
                              "Isshow": _valueNotifier.value,

                              "ParentId": _birthController.text,
                            };
// print(_emailController.text);print(_emailController.text);
                            var response = await YXHttp().http_post(
                                map0api["修改后台菜单"]!, json_str); //

//                             if (response.data['code'] == "0" &&
//                                 (response.data['message'] == "ok")) {
// //  print("保存数据成功!");
                            //2次返回,关闭弹窗
                            Map data1 = {
                              "Id": _emailController.text, //菜单id不能修改
                              "MenuName": _signatureController.text,
                              "Icon": _sexController.text,
                              "MenuUrl": _headphotoController.text,
                              "Sort": _IDController.text,
                              "Isshow": _valueNotifier.value,

                              "ParentId": _birthController.text,
                            };
                            Navigator.of(context1).pop(
                                (data1)); //点击确认保存按钮后返回给对话框的map数据此处无用.对应是 Future<Map?> a =  showDialog
                          },
                        ),
                      ],
                    );
                  },
                );

                // print("a");
                a.then((json_value) {
                  //对话框接收到返回值后执行,json_value取决于对话框的返回参数dynamic

                  //a是异步返回,所以,使用then.代表a返回后执行的操作

                  // print(jsonDecode(json_value!)); //返回json对象,实际就是map类型
                  //   dynamic json_str = jsonDecode(json_value!);

                  //  print(json_str);
                  //  Navigator.of(context)
                  //                 .pop((json_str)); //点击确认保存按钮后返回的list字符串
                  if (json_value != null) {
                    //需要写数据库
                    Navigator.of(context1)
                        .pop((json_value)); //点击确认保存按钮后返回的json_value的map类型

                    print("保存数据成功!");
                  }
                  //  get_api();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void delete_data(int index, String menuid) async {
    var json_str = {
      "token": token,
      "Id_menu": menuid, //菜单id
    };

    var response =
        await YXHttp().http_post(map0api["删除指定id后台菜单"]!, json_str); //返回的是数组.但只有一条数据
    print("response");
    print(response);

    notifyListeners(); //刷新数据源,刷新数据表格
  }

  void get_data(int index, String id) async {
    var json_str = {
      "token": token,
      "Id_menu": id, //菜单id
    };

    var response =
        await YXHttp().http_post(map0api["获取指定id后台菜单"]!, json_str); //返回的是数组.但只有一条数据
    print("response");
    print(response);

    //以下为整体获取数据然后更新数据源
    data[index]["Id"] = response[0]["id"].toString(); // response["Id"];
    data[index]["MenuName"] = response[0]["menu_name"].toString();
    data[index]["Icon"] = response[0]["icon"].toString();
    data[index]["MenuUrl"] = response[0]["menu_url"].toString();
    data[index]["Sort"] = response[0]["sort"].toString();
    //  bool aa=response[0]["isshow"].toString()
    print(response[0]["isshow"]);
    data[index]["Isshow"] = response[0]["isshow"] == 1 ? "true" : "false";
    data[index]["ParentId"] = response[0]["parent_id"].toString();
    // data[index]["fold"] = response["fold"].toString();
    // data[index]["selected"] =
    //     response["selected"].toString();

    notifyListeners(); //刷新数据源,刷新数据表格
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return data.length;
  }
}
