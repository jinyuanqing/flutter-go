import 'dart:async';
import 'dart:io';
import '/model1.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visual_editor/visual-editor.dart';
import 'package:dio/dio.dart';

// Several handler methods for loading files from disk
class EditorService {
  bool isDesktop() => !kIsWeb && !Platform.isAndroid && !Platform.isIOS;

  Future<String?> openFileSystemPickerForDesktop(BuildContext context) async {
    return await FilesystemPicker.open(
      context: context,
      rootDirectory: await getApplicationDocumentsDirectory(),
      fsType: FilesystemType.file,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );
  }

  // Enables picking images from device.
  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  // If omitted, "image" button only allows adding images from url.
  // Same goes for videos.
  Future<String?> onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    // final appDocDir = await getApplicationDocumentsDirectory();
    // final copiedFile =
    //     await file.copy('${appDocDir.path}/${basename(file.path)}');
    // return copiedFile.path.toString();
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }
    PlatformFile file = result.files.first;

    print(file.name);

    List<int> img = file.bytes!.toList();

    //print(img);
    BaseOptions options = BaseOptions(
      // headers: {
      //   //  'Content-Type': 'application/json',
      //   "Accept":
      //       "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      //   // 'Sec-Fetch-Mode': 'navigate',
      // },
      baseUrl: url1,
      connectTimeout: Duration(seconds: connectTimeout0),
      receiveTimeout:Duration(seconds: connectTimeout0),
      contentType:
          "application/json", //默认json传输.配合'Content-Type':'application/json',
      // contentType: Headers.formUrlEncodedContentType
    );
    Dio dio = Dio(options);
    // dio.options.contentType =
    //     Headers.formUrlEncodedContentType;
    FormData formData = new FormData.fromMap({
      // 支持文件数组上传.此处的pic就是html的表单名,传递给服务器gf的表单字段
      "suffix": "png", "suffix1": "png1", "token": token,
      "file": await MultipartFile.fromBytes(img, filename: file.name),
      //  "pic": await MultipartFile.fromFileSync("./favicon.png", filename: file.name),//web不支持Error: Unsupported operation: MultipartFile is only supported where dart:io is available.
      //是一个流
    });
    var response = await dio.post(
      "/user/uploadfile",
      data: formData,
      // options: Options(
      //   headers: {
      //     Headers.contentLengthHeader: img.length, // 设置content-length
      //   },
      // )
    );
    String pic_url = "";
    if (response.statusCode == 200) {
      print("文章内图片上传成功!");
      print(response.data);
      pic_url = response.data["data"]["pic_url"];
      // title_pic = host_url + s1.substring(1); //从第2个字符开始截取
      print(pic_url);
      // setState(() {});
    }

    // print(result.files.first.bytes);
    return pic_url;
  }

  Future<String?> webImagePickImpl(
    OnImagePickCallback onImagePickCallback,
  ) async {
    // final result = await FilePicker.platform.pickFiles();
    // if (result == null) {
    //   return null;
    // }

    // // Take first, because we don't allow picking multiple files.
    // final fileName = result.files.first.name;
    // final file = File(fileName);

    // return onImagePickCallback(file);
    return onImagePickCallback(File(""));
  }

  // Renders the video picked by imagePicker from local file storage
  // You can also upload the picked video to any server (eg : AWS s3
  // or Firebase) and then return the uploaded video URL.
  Future<String> onVideoPickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  // ignore: unused_element
  Future<MediaPickSettingE?> selectMediaPickSettingE(BuildContext context) =>
      showDialog<MediaPickSettingE>(
        context: context,
        builder: (ctx) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.collections),
                label: const Text('Gallery'),
                onPressed: () => Navigator.pop(ctx, MediaPickSettingE.Gallery),
              ),
              TextButton.icon(
                icon: const Icon(Icons.link),
                label: const Text('Link'),
                onPressed: () => Navigator.pop(ctx, MediaPickSettingE.Link),
              )
            ],
          ),
        ),
      );
}
