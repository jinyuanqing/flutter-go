// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
// import 'package:flutter/foundation.dart';

// import 'package:flutter/services.dart';
// import 'package:flutter_gf_view/Model1.dart';

// import 'package:flutter_quill/flutter_quill.dart' hide Text;

// import 'package:path/path.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:tuple/tuple.dart';

// import '/admin/left_menu/pages/universal_ui/universal_ui.dart';
// import './widgets/article_xiang_qing.dart';

// String host_url = "http://127.0.0.1:8199";
// final FocusNode _focusNode = FocusNode();
// List<int> img = [];
// String thumbnail =
//     "thumbnail.png"; //默认的缩略图片 此地址为flutter的http://127.0.0.1:xx/thumbnail.png
// //String thumbnail = ""; //默认的缩略图片
// double width0 = 800;
// TextEditingController? title_control = new TextEditingController();
// TextEditingController? author_control = new TextEditingController();
// TextEditingController? zhaiyao_control = new TextEditingController();

// class wenzhangfabu extends StatefulWidget {
//   @override
//   _wenzhangfabuState createState() => _wenzhangfabuState();
// }

// class _wenzhangfabuState extends State<wenzhangfabu>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//   QuillController? _controller;
//   final FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     print("文章发布initState");
//     _loadFromAssets();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     print("文章发布dispose");
//   }

//   Future<void> _loadFromAssets() async {
//     try {
//       final result = await rootBundle.loadString('assets/sample_data.json');
//       final doc = Document.fromJson(jsonDecode(result));
//       setState(() {
//         _controller = QuillController(
//             document: doc, selection: const TextSelection.collapsed(offset: 0));
//       });
//     } catch (error) {
//       final doc = Document()..insert(0, '内容:');
//       setState(() {
//         _controller = QuillController(
//             document: doc, selection: const TextSelection.collapsed(offset: 0));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context); //没有时,初始化1次和build执行2次
//     print("文章发布build");
//     if (_controller == null) {
//       return const Scaffold(body: Center(child: Text('Loading...')));
//     }

//     return LayoutBuilder(//LayoutBuilder其中的子组件可以获取父组件的宽高如constraints.maxwidth
//         builder: (BuildContext context, BoxConstraints constraints) {
//       return Scaffold(
//         body: RawKeyboardListener(
//             focusNode: FocusNode(),
//             onKey: (event) {
//               if (event.data.isControlPressed && event.character == 'b') {
//                 if (_controller!
//                     .getSelectionStyle()
//                     .attributes
//                     .keys
//                     .contains('bold')) {
//                   _controller!
//                       .formatSelection(Attribute.clone(Attribute.bold, null));
//                 } else {
//                   _controller!.formatSelection(Attribute.bold);
//                 }
//               }
//             },
//             child: ListView(
//                 //外层的cloumn不能有,否则不显示listview

//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       //         IntrinsicWidth( // 使用IntrinsicHeight包裹Row组件使其自动推测得到高度
//                       // child:
//                       Container(
//                         width: constraints.maxWidth,
//                         // height: MediaQuery.of(context).size.height,
//                         padding:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                         alignment: Alignment.topRight,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             TextField(
//                               controller: title_control,
//                               decoration: InputDecoration(
//                                   labelText: '*标题:',
//                                   labelStyle:
//                                       TextStyle(color: Colors.blueGrey)),
//                             ),
//                             TextField(
//                               controller: author_control,
//                               decoration: InputDecoration(
//                                   labelText: '*作者:',
//                                   labelStyle:
//                                       TextStyle(color: Colors.blueGrey)),
//                             ),
//                             TextField(
//                               controller: zhaiyao_control,
//                               decoration: InputDecoration(
//                                   labelText: '*摘要:',
//                                   labelStyle:
//                                       TextStyle(color: Colors.blueGrey)),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 TextButton(
//                                     child: Text("文章缩略图:"),
//                                     onPressed: () async {
//                                       // FilePickerResult result = await FilePicker.platform
//                                       //     .pickFiles(type: FileType.image);

//                                       FilePickerResult? result =
//                                           await FilePicker.platform.pickFiles();

//                                       if (result != null) {
//                                         PlatformFile file = result.files.first;

//                                         print(file.name);

//                                         img = file.bytes!.toList();
//                                         print(file.size);
//                                         print(file.extension);
//                                         // print(file.path);//web平台无法使用
//                                         // setState(() {});
// // 或者通过传递一个 `options`来创建dio实例
//                                         BaseOptions options = BaseOptions(
//                                           // headers: {
//                                           //   'Content-Type': 'application/json',
//                                           // "Accept":
//                                           //     "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
//                                           // 'Sec-Fetch-Mode': 'navigate',
//                                           //   },
//                                           baseUrl: host_url,
//                                           connectTimeout: 5000,
//                                           receiveTimeout:Duration(seconds: connectTimeout0),
//                                           contentType:
//                                               "application/json", //默认json传输.配合'Content-Type':'application/json',
//                                         );
//                                         Dio dio = Dio(options);
//                                         // dio.options.contentType =
//                                         //     Headers.formUrlEncodedContentType;
//                                         FormData formData =
//                                             new FormData.fromMap({
//                                           // 支持文件数组上传
//                                           "file": await MultipartFile.fromBytes(
//                                               img,
//                                               filename: file.name), //是一个流
//                                         });
//                                         // FormData formData1 = new FormData.fromMap({
//                                         //   // 支持文件数组上传
//                                         //   "file": await MultipartFile.fromFile("/favicon.png",
//                                         //       filename: "1.png"), //是一个流
//                                         // });
//                                         String sr =
//                                             '[{"name":"Jack"},{"name1":"Rose"}]';

//                                         // Map<String, dynamic>
//                                         var user = json.decode(sr);

//                                         //print(user);
//                                         // var response = await dio.post(
//                                         //     "http://127.0.0.1:1234/upload/",
//                                         //     data: Stream.fromIterable(img.map((e) => [e])), //创建一个Stream<List<int>>,
//                                         //     options: Options(
//                                         //       headers: {
//                                         //         HttpHeaders.contentLengthHeader: img.length, // Set content-length
//                                         //       },
//                                         //     )
//                                         //     );
//                                         FormData formData1 =
//                                             new FormData.fromMap({
//                                           "user_name": "youxue",
//                                           "passwrod": "wendux",
//                                           "file": await MultipartFile.fromBytes(
//                                               img,
//                                               filename: file.name),
//                                           //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
//                                         });
//                                         var response = await dio.post(
//                                           "/user/uploadfile",
//                                           data: formData1,
//                                           // options: Options(
//                                           //   headers: {
//                                           //     Headers.contentLengthHeader:
//                                           //         img.length, // 设置content-length
//                                           //   },
//                                           // )
//                                         );
//                                         print("服务器返回数据是:${response.data}");
//                                         if (response.statusCode == 200) {
//                                           print("图片上传成功!");
//                                           String s1 =
//                                               response.data["data"]["pic_url"];
//                                           thumbnail = s1;
//                                           //   host_url + s1.substring(1); //从第2个字符开始截取
//                                           print(thumbnail);
//                                           setState(() {});
//                                         }
//                                       }
//                                     }),
//                                 Image.network(
//                                   thumbnail,
//                                   // "http://127.0.0.1:8199/upload_file/0b8f968c-6fbb-46f9-8b8c-5f6448753184.jpeg",
//                                   width: 70 * 1.618,
//                                   height: 70,
//                                 ),
//                               ],
//                             ),
//                             Text('发布文章内容:',
//                                 style: TextStyle(
//                                   color: Colors.blueGrey,
//                                   fontSize: 25,
//                                 )),
//                             Column(
//                               children: <Widget>[
//                                 //编辑器工具栏部分
//                                 Container(
//                                   //web端
//                                   // width:constraints.maxWidth,
//                                   width: constraints.maxWidth,
//                                   color: Color.fromARGB(255, 174, 175, 175),
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 0), //水平左右边距为10

//                                   child: //工具栏.去掉了expanded控件
//                                       kIsWeb
//                                           ? Container(
//                                               //web端工具栏
//                                               color: Color.fromARGB(
//                                                   255, 174, 175, 175),
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 10,
//                                                       horizontal: 0),

//                                               child: QuillToolbar.basic(
//                                                 //默认工具栏是warp流式居中布局的
//                                                 controller: _controller!,
//                                                 onImagePickCallback:
//                                                     _onImagePickCallback,
//                                                 webImagePickImpl:
//                                                     _webImagePickImpl,
//                                                 showAlignmentButtons: true,
//                                               ),
//                                             )
//                                           : Container(
//                                               //桌面端工具栏
//                                               child: QuillToolbar.basic(
//                                               controller: _controller!,
//                                               onImagePickCallback:
//                                                   _onImagePickCallback,
//                                               filePickImpl:
//                                                   openFileSystemPickerForDesktop,
//                                               showAlignmentButtons: true,
//                                             )),
//                                 ),
//                                 //编辑器
//                                 Container(
//                                   // width: width0,
//                                   width: constraints.maxWidth,
//                                   height: 300,
//                                   color: Color.fromARGB(
//                                       255, 202, 201, 201), //编辑器背景色
//                                   padding: const EdgeInsets.only(
//                                       left: 16, right: 16),
//                                   child: _buildWelcomeEditor(context),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               color: Colors.lightBlue,
//                               //  margin: EdgeInsets.only(bottom:00), //容器外填充
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   TextButton.icon(
//                                     onPressed: () async {
//                                       var content_json = jsonEncode(_controller
//                                           ?.document
//                                           .toDelta()
//                                           .toJson());
//                                       print(content_json);

//                                       var content_json1 = jsonEncode(_controller
//                                           ?.document
//                                           .toPlainText()
//                                           .toString());
//                                       print(content_json1);
//                                       // 或者通过传递一个 `options`来创建dio实例
//                                       BaseOptions options = BaseOptions(
//                                         headers: {
//                                           //  'Content-Type': 'application/json',
//                                           "Accept":
//                                               "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
//                                           // 'Sec-Fetch-Mode': 'navigate',
//                                         },
//                                         baseUrl: host_url,
//                                         connectTimeout: 5000,
//                                         receiveTimeout:Duration(seconds: connectTimeout0),
//                                         //contentType: "application/json", //默认json传输.配合'Content-Type':'application/json',
//                                       );
//                                       Dio dio = Dio(options);
//                                       // dio.options.contentType =
//                                       //     Headers.formUrlEncodedContentType;

//                                       // FormData formData1 = new FormData.fromMap({
//                                       //   // 支持文件数组上传
//                                       //   "file": await MultipartFile.fromFile("/favicon.png",
//                                       //       filename: "1.png"), //是一个流
//                                       // });
//                                       // String sr = '[{"name":"Jack"},{"name1":"Rose"}]';
//                                       print("文本:${title_control?.text}");
//                                       FormData formData1 =
//                                           new FormData.fromMap({
//                                         "biao8ti": title_control?.text,
//                                         "zuo8zhe": author_control?.text,
//                                         "zhai8yao": zhaiyao_control?.text,
//                                         "suo8lue8tu": thumbnail,
//                                         "nei8rong": content_json,
//                                         //  "pic":Stream.fromIterable(img.map((e) => [e])), //创建
//                                       });
//                                       var response = await dio.post(
//                                         "/admin/upload8article",
//                                         data: formData1,
//                                         queryParameters: {"token": token},
//                                         // options: Options(
//                                         //   headers: {
//                                         //     Headers.contentLengthHeader:
//                                         //         img.length, // 设置content-length
//                                         //   }, )
//                                       );
//                                       print("服务器返回数据是:${response.data}");
//                                       if (response.statusCode == 200) {
//                                         if (response.data["message"] == "ok") {
//                                           print("上传成功!");
//                                           show_dialog(context, "发布成功");
//                                         } else {
//                                           show_dialog(context, "发布失败");
//                                         }
//                                         // String s1 = response.data["pic_url"];
//                                         // thumbnail =
//                                         //     host_url + s1.substring(1); //从第2个字符开始截取
//                                         // print(thumbnail);
//                                         // setState(() {});
//                                       }
//                                     },
//                                     icon: Icon(Icons.save, size: 30),
//                                     label: Text("发布"),
//                                     // color: Colors.greenAccent,
//                                   ),
//                                   SizedBox(width: 50),
//                                   TextButton.icon(
//                                       //  color: Colors.greenAccent,
//                                       onPressed: () {
//                                         // 执行返回操作
//                                         // Navigator.of(context).pop(true);
//                                         // Get.toNamed("/Article_xiang_qing");
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (context) {
//                                           //返回要跳转的目标页面
//                                           return Article_xiang_qing(
//                                               nei_rong:
//                                                   '[{"insert":"内容:1\n2\n"},{"insert":"内容:1\n2\n"},{"insert":"内容:1\n2\n"},{"insert":"内容:1\n2\n"},{"insert":"内容:1\n2\n"},{"insert":"内容:1\n2\n"},{"insert":"内容:1\n2\n"},{"insert":{"image":"http://127.0.0.1:8199/upload_file/8c1a4f8f-e7de-4080-92f1-5bdbf3e55709.png"}},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"},{"insert":"\n3\n"}]',
//                                               title: "1",
//                                               zuo_zhe: "1",
//                                               ri_qi: "1");
//                                         }));
//                                       },
//                                       icon: Icon(Icons.save, size: 30),
//                                       label: Text("返回"))
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )
//                 ])),
//       );
//     });
//   }

//   Widget _buildWelcomeEditor(BuildContext context) {
//     var quillEditor = QuillEditor(
//         controller: _controller!,
//         scrollController: ScrollController(),
//         scrollable: true,
//         focusNode: _focusNode,
//         autoFocus: false,
//         readOnly: false,
//         placeholder: 'Add content',
//         expands: false,
//         padding: EdgeInsets.zero,
//         customStyles: DefaultStyles(
//           h1: DefaultTextBlockStyle(
//               const TextStyle(
//                 fontSize: 32,
//                 color: Colors.black,
//                 height: 1.15,
//                 fontWeight: FontWeight.w300,
//               ),
//               const Tuple2(16, 0),
//               const Tuple2(0, 0),
//               null),
//           sizeSmall: const TextStyle(fontSize: 9),
//         ));
//     if (kIsWeb) {
//       quillEditor = QuillEditor(
//           controller: _controller!,
//           scrollController: ScrollController(),
//           scrollable: true,
//           focusNode: _focusNode,
//           autoFocus: false,
//           readOnly: false,
//           placeholder: 'Add content',
//           expands: false,
//           padding: EdgeInsets.zero,
//           customStyles: DefaultStyles(
//             h1: DefaultTextBlockStyle(
//                 const TextStyle(
//                   fontSize: 32,
//                   color: Colors.black,
//                   height: 1.15,
//                   fontWeight: FontWeight.w300,
//                 ),
//                 const Tuple2(16, 0),
//                 const Tuple2(0, 0),
//                 null),
//             sizeSmall: const TextStyle(fontSize: 9),
//           ),
//           embedBuilder: defaultEmbedBuilderWeb);
//     }
//     var toolbar = QuillToolbar.basic(
//       controller: _controller!,
//       // provide a callback to enable picking images from device.
//       // if omit, "image" button only allows adding images from url.
//       // same goes for videos.
//       onImagePickCallback: _onImagePickCallback,
//       onVideoPickCallback: _onVideoPickCallback,
//       // uncomment to provide a custom "pick from" dialog.
//       // mediaPickSettingSelector: _selectMediaPickSetting,
//       showAlignmentButtons: true,
//     );
//     // if (kIsWeb) {
//     //   print("kIsWeb");
//     //   toolbar = QuillToolbar.basic(
//     //     controller: _controller!,
//     //     onImagePickCallback: _onImagePickCallback,
//     //     webImagePickImpl: _webImagePickImpl,
//     //     showAlignmentButtons: true,
//     //   );
//     // }
//     // if (_isDesktop()) {
//     //   print("_isDesktop");
//     //   toolbar = QuillToolbar.basic(
//     //     controller: _controller!,
//     //     onImagePickCallback: _onImagePickCallback,
//     //     filePickImpl: openFileSystemPickerForDesktop,
//     //     showAlignmentButtons: true,
//     //   );
//     // }

//     return SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Expanded(
//             flex: 15,
//             child: Container(
//               // color: Color.fromARGB(255, 190, 192, 190),
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               child: quillEditor,
//             ),
//           ),
//           // kIsWeb
//           //     ? Expanded(
//           //         child: Container(
//           //         padding:
//           //             const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//           //         child: toolbar,
//           //       ))
//           //     : Container(child: toolbar)
//         ],
//       ),
//     );
//   }

//   bool _isDesktop() => !kIsWeb && !Platform.isAndroid && !Platform.isIOS;

//   Future<String?> openFileSystemPickerForDesktop(BuildContext context) async {
//     return await FilesystemPicker.open(
//       context: context,
//       rootDirectory: await getApplicationDocumentsDirectory(),
//       fsType: FilesystemType.file,
//       fileTileSelectMode: FileTileSelectMode.wholeTile,
//     );
//   }

//   // Renders the image picked by imagePicker from local file storage
//   // You can also upload the picked image to any server (eg : AWS s3
//   // or Firebase) and then return the uploaded image URL.
//   Future<String> _onImagePickCallback(File file0) async {
//     // Copies the picked file from temporary cache to applications directory
//     //  final appDocDir = await getApplicationDocumentsDirectory();
//     // final copiedFile =
//     //   await file.copy('${appDocDir.path}/${basename(file.path)}');
//     //print(basename(file.path));

// //     List<int> 转 Uint8List
// // Uint8List.fromList(rs.data);
//     //  List<int>

//     final result = await FilePicker.platform.pickFiles();
//     if (result == null) {
//       return 'null';
//     }
//     PlatformFile file = result.files.first;

//     print(file.name);

//     List<int> img = file.bytes!.toList();

//     //print(img);
//     BaseOptions options = BaseOptions(
//       // headers: {
//       //   //  'Content-Type': 'application/json',
//       //   "Accept":
//       //       "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
//       //   // 'Sec-Fetch-Mode': 'navigate',
//       // },
//       baseUrl: host_url,
//       connectTimeout: 5000,
//       receiveTimeout:Duration(seconds: connectTimeout0),
//       contentType:
//           "application/json", //默认json传输.配合'Content-Type':'application/json',
//       // contentType: Headers.formUrlEncodedContentType
//     );
//     Dio dio = Dio(options);
//     // dio.options.contentType =
//     //     Headers.formUrlEncodedContentType;
//     FormData formData = new FormData.fromMap({
//       // 支持文件数组上传.此处的pic就是html的表单名,传递给服务器gf的表单字段
//       "suffix": "png", "suffix1": "png1",
//       "file": await MultipartFile.fromBytes(img, filename: file.name),
//       //  "pic": await MultipartFile.fromFileSync("./favicon.png", filename: file.name),//web不支持Error: Unsupported operation: MultipartFile is only supported where dart:io is available.
//       //是一个流
//     });
//     var response = await dio.post(
//       "/user/uploadfile",
//       data: formData,
//       // options: Options(
//       //   headers: {
//       //     Headers.contentLengthHeader: img.length, // 设置content-length
//       //   },
//       // )
//     );
//     String pic_url = "";
//     if (response.statusCode == 200) {
//       print("文章内图片上传成功!");
//       print(response.data);
//       pic_url = response.data["data"]["pic_url"];
//       // title_pic = host_url + s1.substring(1); //从第2个字符开始截取
//       print(pic_url);
//       // setState(() {});
//     }

//     // print(result.files.first.bytes);
//     return pic_url;

//     // final copiedFile = await file.copy('d:/${basename(file.path)}');
//     // print(copiedFile.path.toString());
//     //return "copiedFile.path.toString()";
//   }

//   Future<String?> _webImagePickImpl(
//       OnImagePickCallback onImagePickCallback) async {
//     // final result = await FilePicker.platform.pickFiles();
//     // if (result == null) {
//     //   return null;
//     // }

//     // // Take first, because we don't allow picking multiple files.
//     // final fileName = result.files.first.name;
//     // final file = File(fileName);

//     //return onImagePickCallback(file);
// //以上屏蔽
//     return onImagePickCallback(File("")); //onImagePickCallback!(File (""));
//   }

//   // Renders the video picked by imagePicker from local file storage
//   // You can also upload the picked video to any server (eg : AWS s3
//   // or Firebase) and then return the uploaded video URL.
//   Future<String> _onVideoPickCallback(File file) async {
//     // Copies the picked file from temporary cache to applications directory
//     final appDocDir = await getApplicationDocumentsDirectory();
//     final copiedFile =
//         await file.copy('${appDocDir.path}/${basename(file.path)}');
//     return copiedFile.path.toString();
//   }

//   // ignore: unused_element
//   Future<MediaPickSetting?> _selectMediaPickSetting(BuildContext context) =>
//       showDialog<MediaPickSetting>(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton.icon(
//                 icon: const Icon(Icons.collections),
//                 label: const Text('Gallery'),
//                 onPressed: () => Navigator.pop(ctx, MediaPickSetting.Gallery),
//               ),
//               TextButton.icon(
//                 icon: const Icon(Icons.link),
//                 label: const Text('Link'),
//                 onPressed: () => Navigator.pop(ctx, MediaPickSetting.Link),
//               )
//             ],
//           ),
//         ),
//       );

//   Widget _buildMenuBar(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     const itemStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 18,
//       fontWeight: FontWeight.bold,
//     );
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Divider(
//           thickness: 2,
//           color: Colors.white,
//           indent: size.width * 0.1,
//           endIndent: size.width * 0.1,
//         ),
//         ListTile(
//           title: const Center(child: Text('Read only demo', style: itemStyle)),
//           dense: true,
//           visualDensity: VisualDensity.compact,
//           onTap: _readOnly,
//         ),
//         Divider(
//           thickness: 2,
//           color: Colors.white,
//           indent: size.width * 0.1,
//           endIndent: size.width * 0.1,
//         ),
//       ],
//     );
//   }

//   void _readOnly() {
//     Navigator.push(
//       super.context,
//       MaterialPageRoute(
//         builder: (context) => Text("2"),
//       ),
//     );
//   }

//   Future<void> show_dialog(BuildContext context, String text) async {
//     //弹出上传成功窗口

//     showDialog<bool>(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Container(
//               //  width: 30.0,
//               height: 40.0,
//               // color: Colors.red,
//               child: Stack(alignment: Alignment.center, children: <Widget>[
//                 Positioned(
//                   //右上角关闭按钮
//                   right: 10,
//                   top: MediaQuery.of(context).padding.top,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.close,
//                       size: 30,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//                 Text("返回消息:"),
//               ]),
//             ),
//             content:
//                 // Card(
//                 //   child:

//                 Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               //   // mainAxisSize: MainAxisSize.min,

//               children: <Widget>[
//                 new Text(
//                   text,
//                   textDirection: TextDirection.ltr,
//                   textAlign: TextAlign.center,
//                   style: new TextStyle(
//                     fontSize: 25,
//                     color: Colors.black87,
//                     // backgroundColor: Colors.grey[200]
//                   ),
//                 ),

//                 //Expanded(
//                 //child:
// //                      PhotoView(
// //                        imageProvider:
//                 //   AssetImage("assets/images/an_li1.png"),
// //                      )
//                 //  ),
//               ],
//             ),
//             // ),
//             actions: <Widget>[
//               //对话框底部按钮

//               // ignore: deprecated_member_use
//               TextButton(
//                 child: Text("确认/刷新"),
//                 onPressed: () {
//                   // 执行返回操作
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//             ],
//           );
//         });
//   }
// }

// // class MyImage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     String imageUrl = "https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg";
// //     // https://github.com/flutter/flutter/issues/41563
// //     // ignore: undefined_prefixed_name
// //     ui.platformViewRegistry.registerViewFactory(
// //       imageUrl,
// //           (int _) => ImageElement()..src = imageUrl,
// //     );
// //     return HtmlElementView(
// //       viewType: imageUrl,
// //     );
// //   }
// // }
