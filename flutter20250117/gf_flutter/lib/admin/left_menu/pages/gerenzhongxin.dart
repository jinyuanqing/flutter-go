// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gf_view/widgets/http.dart';
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
import 'package:provider/provider.dart';
import '/model1.dart';
import 'package:path_provider/path_provider.dart';
import '/quan_ju.dart';

// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
import '../../../widgets/article_xiang_qing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//编辑器
import 'package:visual_editor/visual-editor.dart';
import '/admin/edtor/const/sample-highlights.const.dart';
import '/admin/edtor/services/editor.service.dart';
import '/admin/edtor/widgets/demo-scaffold.dart';
import '/admin/edtor/widgets/loading.dart';

class Gerenzhongxin extends StatefulWidget {
  final username; //final用来修饰变量 只能被赋值一次
  const Gerenzhongxin({Key? key, @required this.username}) : super(key: key);
  @override
  _GerenzhongxinState createState() => _GerenzhongxinState();
}

List<String> select0 = [
  //薪酬部分的
];
List<bool> flag = [];

//薪酬部分的多选框状态
List<String> select = [
  //薪酬部分的
  "五险一金",
  "单休",
  "双休",
  "带薪休假",
  "包吃",
  "加班补助", "电话补助", "交通补助", "包住"
];

class _GerenzhongxinState extends State<Gerenzhongxin>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FocusNode _focusNode = FocusNode();

  List<int> img = [];
  String thumbnail =
      "thumbnail.png"; //默认的缩略图片 此地址为flutter的http://127.0.0.1:xx/thumbnail.png
//String thumbnail = ""; //默认的缩略图片
  double width0 = 800;
  TextEditingController? title_control = new TextEditingController();
  TextEditingController? yaoqiu_control = new TextEditingController();
  TextEditingController? nicheng_control = new TextEditingController();
  TextEditingController? youxiang_control = new TextEditingController();
  TextEditingController? qianming_control = new TextEditingController();
  TextEditingController? gognzuonianxian_control = new TextEditingController();
  TextEditingController? mima_control = new TextEditingController();
  TextEditingController? dizhi_control = new TextEditingController();
  final _editorService = EditorService();
  int wenzhang_id = 0;
  bool isChecked = false;
  EditorController? _controller;
  final _scrollController = ScrollController();
  // final _focusNode = FocusNode();
  String nickname1 = "昵称";
  // QuillController? _controller;
  // final FocusNode _focusNode = FocusNode();
  List<String> fenlei = ["选择分类"];
  List<String> gangwei = ["选择岗位"];
  String dropdownValue = "";
  String dropdownValue2 = "";
  String nicheng_text = "";
  String qianming_text = "";
  String dizhi_text = "";
  String youxiang_text = "";
  String mima_text = "";
  bool xianshi_mima = false;
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

  String? jingyan1;

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
  int fenlei_id = 0;
  bool baohan = false;
  bool xianshi_qianming = false;
  bool xianshi_dizhi = false;
  bool xianshi_youxiang = false;
  bool xianshi_nicheng = false;

  String? Address; //`v:"required"` // 地址
  String? Tel; //`v:"required"` //Tel
  String Id = ""; //用户id
  late String Password; // `v:"required"` // 密码
  String? Email; // `v:"required"` // 邮箱

  String? Birthday; //`v:"required"` // 出生日期
  String? Beiyong1; // `v:"required"` // 备用
  String? Sex; // `v:"required"` // 性别
  String? Qianming; // `v:"required"` // 签名
  String? Shenfenzheng; //`v:"required"` // 身份证号
  String? Ip; // `v:"required"` // 最后登录ip
  // String? touxiang; // `v:"required"` // 头像
  String? Jifen; // `v:"required"` // 积分

  @override
  void initState() {
    super.initState();
 get_userinfo(username);
    // get_userinfo(widget.username);
    print("个人中心initState,当前用户名是${widget.username}");
    flag = List.filled(select.length, false); //根据select待遇的长度进行初始化列表flag.
  }

  @override
  void dispose() {
    super.dispose();
    print("文章发布dispose");
    _streamController1.close();
  }

  Future get_userinfo(String username) async {
    // print(json_str1);
    FormData formData1 = new FormData.fromMap({
      "token": token,
      "username": username,
    });

    var response = await YXHttp().http_post(map0api["根据用户名获取用户信息"]!, formData1);
    print(response);
    Id = response[0]["id"].toString();
    nickname1 = response[0]["nickname"];

    Address = response[0]["address"];
    Email = response[0]["email"];
    Sex = response[0]["sex"];
    touxiang = response[0][
        "touxiang"]; //==null?thumbnail:response["touxiang"]; //如果没有给出头像的话，则使用thumbnaill。 这
    Tel = response[0]["tel"];

    Qianming = response[0]["qianming"];
     
    Shenfenzheng = response[0]["shenfenzheng"];
    Birthday = response[0]["birthday"];

    Password = response[0]["password"];
    Jifen = response[0]["jifen"].toString();
    Ip = response[0]["ip"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //没有时,初始化1次和build执行2次
    print("个人中心build");
    Model1 model1 = context.watch<Model1>();
     print("Qianming");
    print(Qianming);
if(Qianming!=null)
 { model1.qianming = Qianming!;}
  else
   {model1.qianming = ""; }
    
    if(Qianming!=null)
  {model1.nickname = nickname1;}
  else
    {model1.nickname = ""; }
    


   
    // model1.change_nickname(nickname1);
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
              Text(
                "个人中心",
                style: TextStyle(fontSize: 25),
              ),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("用户名:${username}"),
                  ]),
              Divider(),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("性别:${Sex ??= ""}"),
                  ]),
              Divider(),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("积分:${Jifen ??= ""}"),
                  ]),
              Divider(),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("生日:${Birthday ??= ""}"),
                  ]),
              Divider(),
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("身份证:${Shenfenzheng ??= ""}"),
                  ]),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 70, //* 1.618,
                    height: 70,
                    child: CircleAvatar(
                      //  child: Text("头像"),
                      //头像半径
                      radius: 60,
                      //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                      backgroundImage:
                          NetworkImage(touxiang ??= thumbnail, scale: 1),
                    ),
                  ),
                  TextButton(
                      child: Text("选择头像:"),
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
                            touxiang = s1;

                            //   host_url + s1.subString(1); //从第2个字符开始截取
                            print(touxiang);
                            setState(() {});
                          }
                        }
                      }),
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("当前密码:"),
                        Text(mima_text),
                      ],
                    ),
                    Visibility(
                        child: TextField(
                          obscureText: true,
                          controller: mima_control,
                          decoration: InputDecoration(
                              labelText: '新的密码,长度10:',
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10) //限制长度10
                          ],
                        ),
                        visible: xianshi_mima),
                    ElevatedButton(
                      onPressed: () {
                        xianshi_mima = !xianshi_mima;
                        mima_text = mima_control!.text;
                        setState(() {});
                      },
                      child: Text(
                        xianshi_mima == false ? "修改" : "确认",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("当前签名:"),
                        // Text(Qianming ??= ""),
                        Text(model1.qianming),
                      ],
                    ),
                    Visibility(
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(25) //限制长度10
                          ],
                          controller: qianming_control,
                          decoration: InputDecoration(
                              labelText: '新的签名,长度25:',
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                        ),
                        visible: xianshi_qianming),
                    ElevatedButton(
                      onPressed: () {
                        xianshi_qianming = !xianshi_qianming;
                        if (xianshi_qianming == false) {
                          //显示确认按钮时,处理
                          Qianming = qianming_control!.text;
                          model1.qianming = Qianming!;
                          qianming_control!.clear();
                        }

                        setState(() {});
                      },
                      child: Text(
                        xianshi_qianming == false ? "修改" : "确认",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("当前昵称:"),
                        Text(model1.nickname),
                      ],
                    ),
                    Visibility(
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10) //限制长度10
                          ],
                          controller: nicheng_control,
                          decoration: InputDecoration(
                              labelText: '新的昵称,长度10:',
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                        ),
                        visible: xianshi_nicheng),
                    ElevatedButton(
                      onPressed: () {
                        xianshi_nicheng = !xianshi_nicheng;
                        if (xianshi_nicheng == false) {
                          //显示确认按钮时,处理
                          nickname1 = nicheng_control!.text;
                          model1.nickname = nickname1;
                          nicheng_control!.clear();
                        }

                        setState(() {});
                      },
                      child: Text(
                        xianshi_nicheng == false ? "修改" : "确认",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("当前邮箱:"),
                        Text(Email ??= ""),
                      ],
                    ),
                    Visibility(
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20) //限制长度10
                          ],
                          controller: youxiang_control,
                          decoration: InputDecoration(
                              labelText: '新的邮箱,长度20:',
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                        ),
                        visible: xianshi_youxiang),
                    ElevatedButton(
                      onPressed: () {
                        xianshi_youxiang = !xianshi_youxiang;

                        if (xianshi_youxiang == false) {
                          Email = youxiang_control!.text;
                          youxiang_control!.clear();
                        }
                        setState(() {});
                      },
                      child: Text(
                        xianshi_youxiang == false ? "修改" : "确认",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("当前地址:"),
                        Text(Address ??= ""),
                      ],
                    ),
                    Visibility(
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20) //限制长度10
                          ],
                          controller: dizhi_control,
                          decoration: InputDecoration(
                              labelText: '新的地址,长度20:',
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                        ),
                        visible: xianshi_dizhi),
                    ElevatedButton(
                      onPressed: () {
                        xianshi_dizhi = !xianshi_dizhi;

                        if (xianshi_dizhi == false) {
                          Address = dizhi_control!.text;
                          dizhi_control!.clear();
                        }

                        setState(() {});
                      },
                      child: Text(
                        xianshi_dizhi == false ? "修改" : "确认",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
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
              FormData formData1 =  FormData.fromMap({
                "token": token,
                "id": Id,
                "qianming": Qianming,
                "email": Email,
                "nickname": nickname1,
                "address": Address,
                "password": Password,
                "touxiang": touxiang,
              });
              var response = await YXHttp().http_post(
                map0api["更新用户信息"]!,
                formData1,
              );
              
              model1.change_qianming(Qianming!);
              model1.change_nickname(nickname1);
              // qianming = Qianming!;
            },
            icon: Icon(Icons.save, size: 30),
            label: Text("确定"),
            // color: Colors.greenAccent,
          ),
        ],
      ),
    ]));

    // ),
    // );
    // });
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
