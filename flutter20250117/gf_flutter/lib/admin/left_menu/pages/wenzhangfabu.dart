import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

//编辑器
import 'package:visual_editor/visual-editor.dart';
import '/admin/edtor/const/sample-highlights.const.dart';
import '/admin/edtor/services/editor.service.dart';
import '/admin/edtor/widgets/demo-scaffold.dart';
import '/admin/edtor/widgets/loading.dart';

final FocusNode _focusNode = FocusNode();
List<int> img = [];
String thumbnail =
    "thumbnail.png"; //默认的缩略图片 此地址为flutter的http://127.0.0.1:xx/thumbnail.png
//String thumbnail = ""; //默认的缩略图片
double width0 = 800;
TextEditingController? title_control = new TextEditingController();
TextEditingController? author_control = new TextEditingController();
TextEditingController? zhaiyao_control = new TextEditingController();

class wenzhangfabu extends StatefulWidget {
  @override
  _wenzhangfabuState createState() => _wenzhangfabuState();
}

class _wenzhangfabuState extends State<wenzhangfabu>
    with AutomaticKeepAliveClientMixin {
  final _editorService = EditorService();
  int wenzhang_id = 0;
  EditorController? _controller;
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  @override
  bool get wantKeepAlive => true;
  // QuillController? _controller;
  // final FocusNode _focusNode = FocusNode();
  List<String> fenlei = ["分类"];
  List<dynamic> fenlei_name_id = [];

  int fenlei_id = 0;
  bool baohan = false;
  @override
  void initState() {
    super.initState();
    print("文章发布initState");

    _loadDocument();
    get_fenlei();
    _streamController1.sink.add(fenlei.first);
    dropdownValue = fenlei.first; //下拉按钮默认显示的值
  }

  @override
  void dispose() {
    super.dispose();
    print("文章发布dispose");
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
          fenlei_name_id = res;
          // thumbnail = s1;
          //   host_url + s1.substring(1); //从第2个字符开始截取
          // print(fenlei_name_id[0]["id"]);

          for (var i = 0; i < res.length; i++) {
            fenlei.add(res[i]["fenlei_name"]);
          }
          setState(() {});
        }
      }
    }
  }

  Future<void> _loadDocument() async {
    final deltaJson = await rootBundle.loadString(
      'assets/docs/all-styles.json',
    );
    final document = DeltaDocM.fromJson(jsonDecode(deltaJson));

    setState(() {
      _controller = EditorController(
        document: document,
     //   highlights: SAMPLE_HIGHLIGHTS,
      );
    });
  }

  StreamController _streamController1 = StreamController<dynamic>();
  String fenlei_text = "点此查看";
  String dropdownValue = "";
  dynamic list = [];
  @override
  Widget build(BuildContext context) {
    super.build(context); //没有时,初始化1次和build执行2次
    print("文章发布build");
    Model1 model1 = context.watch<Model1>();
    author_control!.text =
        Provider.of<Model1>(context, listen: false).nickname; //作者默认为用户名
    if (_controller == null) {
      return const Scaffold(body: Center(child: Text('Loading...')));
    }

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
          // height:
          //    MediaQuery.of(context).size.height-size_appbar-size_web_menu_height,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("选择分类:"),
                    PopupMenuButton<String>(
                      color: Colors.greenAccent[100],
                      // iconSize: 10.0,
                      //  icon: Icon(Icons.add),

                      child: Text(
                        fenlei_text,
                        style: TextStyle(fontSize: 20),
                      ),
                      onSelected: (value) {
                        print('$value');
                        print(fenlei[int.parse(value)]);
                        fenlei_text = fenlei[int.parse(value)];
                        setState(() {});
                      },
                      itemBuilder: (context) {
                        return List<PopupMenuEntry<String>>.generate(
                            fenlei.length, (int i) {
                          return PopupMenuItem<String>(
                            value: i
                                .toString(), //此处可以设置点击显示索引或者文本值哦.当前显示索引,显示文本请使用fenlei[i]
                            child: Text(fenlei[i]),
                          );
                        });
                      },
                    ),
                    StreamBuilder<dynamic>(
                      //局部刷新控件.可以避免使用setstate()
                      stream: _streamController1.stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          dropdownValue =
                              snapshot.data.toString(); //可以使局部控件显示当前的选择项1
                          print("dropdownValue");
                          print(dropdownValue);
                          return DropdownButton<String>(
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
                                    i < fenlei_name_id.length;
                                    i++) {
                                  if (value ==
                                      fenlei_name_id[i]["fenlei_name"]) {
                                    //当选择下拉文本时,获取文本对应的id
                                    print(fenlei_name_id[i]["id"]);
                                    fenlei_id = fenlei_name_id[i]["id"];

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
                  ]),
              TextField(
                readOnly: true,
                controller: author_control,
                decoration: InputDecoration(
                    labelText: '*作者:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              TextField(
                controller: title_control,
                decoration: InputDecoration(
                    labelText: '*标题:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),

              TextField(
                controller: zhaiyao_control,
                decoration: InputDecoration(
                    labelText: '*摘要:',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      child: Text("文章缩略图:"),
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
              Text('发布文章内容:',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                  )),
              _toolbar(),
              // Container(height: 100,
              //   child: SingleChildScrollView(child: Container(height:400,color:  Colors.blueGrey,
              //     child: Text("data"),
              //   )),
              // ),
              Row(
                children: [
                  _editor(),
                ],
              )

              // Spacer(),
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
                        TextButton.icon(
                          onPressed: () async {},
                          icon: Icon(Icons.arrow_forward, size: 20),
                          label: Text("到底了!"),
                          // color: Colors.greenAccent,
                        ),
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
              if(fenlei_id==0){
                show_dialog(context, "请选择发布的文章分类");

return;
              }

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
                //contentType: "application/json", //默认json传输.配合'Content-Type':'application/json',
              );
              Dio dio = Dio(options);
              // dio.options.contentType =
              //     Headers.formUrlEncodedContentType;

              // FormData formData1 = new FormData.fromMap({
              //   // 支持文件数组上传
              //   "file": await MultipartFile.fromFile("/favicon.png",
              //       filename: "1.png"), //是一个流
              // });
              // String sr = '[{"name":"Jack"},{"name1":"Rose"}]';
              print("文本:${title_control?.text}");
              FormData formData1 = new FormData.fromMap({
                "biaoti": title_control?.text,
                "zuozhe":
                    // context.watch<Model1>().nickname, //author_control?.text,provider6.0.5这句会触发一个报错哦.
                    //大致意思是,这里的按钮事件不是刷新ui界面,因此不用watch监听外部的变化
                    Provider.of<Model1>(context, listen: false)
                        .nickname, //只获取值不监听nickname变化
                "zhaiyao": zhaiyao_control?.text,
                "suoluetu": thumbnail,
                "neirong": content_json,

                "fenleiid": fenlei_id,
                //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
              });
              var response = await dio.post(
                map0api["上传文章"]!,
                data: formData1,
                queryParameters: {"token": token},
                // options: Options(
                //   headers: {
                //     Headers.contentLengthHeader:
                //         img.length, // 设置content-length
                //   }, )
              );
              print("服务器返回数据是:${response.data}");
              if (response.statusCode == 200) {
                if (response.data["message"] == "ok") {
                  list = response.data["data"];
                  print(list["id"]);
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
                // 执行返回操作

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  //返回要跳转的目标页面
                  return Article_xiang_qing(
                    nei_rong: list["neirong"],
                    title: list["biaoti"],
                    zuo_zhe: list["zuozhe"],
                    ri_qi: list["created_at"],
                  );
                }));
              },
              icon: Icon(Icons.save, size: 30),
              label: Text("预览"))
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

  Widget _editor() => Flexible(
        child: Container(
          height: 500,
          color: Colors.white,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: VisualEditor(
            controller: _controller!,
            scrollController: _scrollController,
            focusNode: _focusNode,
            config: EditorConfigM(
              placeholder: 'Enter text',
            ),
          ),
        ),
      );

  Widget _toolbar() => EditorToolbar.basic(
        controller: _controller!,
        onImagePickCallback: _editorService.onImagePickCallback,
        onVideoPickCallback: kIsWeb ? _editorService.onVideoPickCallback : null,
        filePickImpl: _editorService.isDesktop()
            ? _editorService.openFileSystemPickerForDesktop
            : null,
        webImagePickImpl: _editorService.webImagePickImpl,
        // Uncomment to provide a custom "pick from" dialog.
        // mediaPickSettingSelector: _editorService.selectMediaPickSettingE,
        showAlignmentButtons: true,
        multiRowsDisplay: false,
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
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text("返回消息:",style: TextStyle(color: Colors.amber),),
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
                    fontSize: 20,
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
