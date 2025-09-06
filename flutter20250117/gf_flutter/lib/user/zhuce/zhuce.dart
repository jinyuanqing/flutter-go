import 'package:flutter/material.dart';
import 'package:flutter_gf_view/model1.dart';
import 'package:flutter_gf_view/widgets/http.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import '../../main.dart';
import 'dart:math';
import 'package:dio/dio.dart'; //网络获取数据
import 'package:get/get.dart' as Get;

class zhu_ce extends StatelessWidget {
  const zhu_ce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: new AppBar(
          //顶部导航
//标题居中
          centerTitle: true,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("新用户注册页面"),

          //AppBar标题文字后面放置图标

          actions: <Widget>[],
        ),
        preferredSize: Size.fromHeight(100.0), //设置appbar高度
      ),
      body: Container(
          color: Colors.white70, //设置整个页面的背景色.只有container能设置颜色.行列都不行
// height: 800,
          child: zhuce1()),
    );
  }
}

// // 产品展示
// class Deng_lu extends StatefulWidget {
//   // final title;
//   // final nei_rong;
//   // final id;
//   // final zuo_zhe;
//   // final ri_qi;
//   Deng_lu(
//       {Key key,
//       })
//       : super(key: key); //注意这是需要参数的类的定义,继承自StatelessWidget

//   @override
//   State<StatefulWidget> createState() => new Deng_lu1();
// }
class zhuce1 extends StatefulWidget {
  @override
  zhuce2 createState() => new zhuce2();
}

class zhuce2 extends State<zhuce1> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  String mima1 = "", mima2 = ""; //2次密码
  String shou_ji = "",
      yonghu_ming = "",
      you_xiang = "",
      zhuzhi = "",
      xingbie = "",
      shengri = "",
      shibie = "",
      nickname = "";

  @override
  void initState() {
    super.initState();

    var url = Uri.base.toString();
    var uri = Uri.parse(url.replaceFirst('#/', ''));
    var jiami_str = uri.queryParameters['j'];
    print(jiami_str);

    shibie = jiami_str!;

    var response = YXHttp().http_get(url1+"/xitong/Compare_tijiao",
        {"Str_jiami": jiami_str});
    print("response");
    print(response);

    if (response == "false") {
      print("无法打开注册页面,跳转到首页");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    // padding: EdgeInsets.all(1.0),
                    child: Text("注册"),
                    // color: Theme.of(context).primaryColor,
                    // textColor: Colors.white,
                    onPressed: () async {
                      // Get.Get.toNamed("/a"); //跳到后台登录页
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));

                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。

                      if ((_formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                        print("校验成功");
                        (_formKey.currentState as FormState)
                            .save(); //调用表单保存,此方法会回调onsave()

                        //把表单内容使用dio库提交给后台
                        Response response;
                        BaseOptions options1 = BaseOptions(
                          connectTimeout:Duration(seconds: connectTimeout0), //嵌套的dio请求这里要给0
                          receiveTimeout:Duration(seconds: connectTimeout0),
                          contentType: Headers.jsonContentType,
                          // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
                          /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
                          /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
                          /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
                          /// 就会自动编码请求体.
                        );
                        Dio dio = Dio(options1);
                        response = await dio.post(map0api["用户注册"]!, data: {
                          "Username": yonghu_ming,
                          "Password": mima1,
                          "Email": you_xiang,
                          "Tel": shou_ji,
                          "Isadmin": 0, //0为普通用户,1管理
                          "Nickname": nickname,

                          "shibie":
                              shibie, //识别符.就是url的j参数.时间加密文本.10分钟以内都可以注册,否则不行
                        });

                        if ((response.statusCode == 200) &
                            (response.data["code"] == "0")) {
                          print(response.data);
                          // print(
                          //     "$yonghu_ming1, $mi_ma3, $you_xiang1, $shou_ji1");

                          print(response.statusCode);
                          print(response.statusMessage);
                          Get.Get.defaultDialog(
                            title: "提示",
                            middleText: "您注册成功了!",
                            confirm: ElevatedButton(
                                onPressed: () {
                                  //
                                  Get.Get.toNamed("/a"); //跳到后台登录页
                                },
                                child: Text("确定")),
                            // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
                          );
                          print("注册成功");
                        } else {
                          Get.Get.defaultDialog(
                              title: "提示",
                              middleText: response.data["message"],
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.Get.back();
                                  },
                                  child: Text("确定")),
                              cancel: ElevatedButton(
                                  onPressed: () {
                                    Get.Get.back();
                                  },
                                  child: Text("取消")));
                          print("注册失败");
                        }
                      }
                    },
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  child: ElevatedButton(
                    // padding: EdgeInsets.all(1.0),
                    child: Text("清空"),
                    // color: Theme.of(context).primaryColor,
                    // textColor: Colors.white,
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));

                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      (_formKey.currentState as FormState).reset(); //清空表单
                    },
                  ),
                ),
              ],
            ),
          )
        ],
        title: Container(
          width: 30.0,
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
                  color: Color.fromARGB(255, 82, 80, 80),
                ),
                onPressed: () {
                  // Navigator.of(context).pop();
                },
              ),
            ),
            Text("注册信息:"),
          ]),
        ),
        content: Card(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Form(
                  key: _formKey, //设置globalKey，用于后面获取FormState
                  //   autovalidate: true, //开启自动校验
                  child: SizedBox(
                      height: 800, // constraints.maxHeight, //- size_appbar,
                      width: 400,
                      child: ListView(children: [
                        Column(
                          children: <Widget>[
                            TextFormField(
                                autofocus: true,
                                // controller: _unameController,
                                decoration: InputDecoration(
                                    labelText: "用户名*",
                                    hintText: "用户名6-16字符",
                                    icon: Icon(Icons.person)),
                                onChanged: (v) {
                                  yonghu_ming = v;
                                },
                                // 校验用户名
                                validator: (v) {
                                  return v!.trim().length > 0
                                      ? v!.trim().length > 16
                                          ? "不能超过16个字"
                                          : null
                                      : "用户名不能为空";
                                }),
                            TextFormField(
                                decoration: InputDecoration(
                                    labelText: "昵称",
                                    hintText: "16个字以内",
                                    icon: Icon(Icons.person)),
                                onChanged: (v) {
                                  nickname = v;
                                },
                                // 校验
                                validator: (v) {
                                  return v!.trim().length > 0
                                      ? v!.trim().length > 16
                                          ? "不能超过16个字"
                                          : null
                                      : "昵称不能为空";
                                }),
                            TextFormField(
                                //controller: _pwdController,
                                decoration: InputDecoration(
                                    labelText: "密码*",
                                    hintText: "您的登录密码6-16",
                                    icon: Icon(Icons.lock)),
                                obscureText: true,
                                //校验密码
                                validator: (v) {
                                  return v!.trim().length > 5
                                      ? null
                                      : "密码不能少于6位";
                                },
                                onChanged: (v) {
                                  //当输入改变时调用.获取输入的信息
                                  print("输入密码:$v");
                                  mima1 = v;
                                }),
                            TextFormField(
                                //controller: _pwdController,
                                decoration: InputDecoration(
                                    labelText: "确认密码*",
                                    hintText: "再次输入登录密码",
                                    icon: Icon(Icons.lock)),
                                obscureText: true,
                                //校验密码
                                validator: (v) {
                                  // return v
                                  //     .trim()
                                  //     .length > 5 ? null : "密码不能少于6位";

                                  if (mima1 != mima2) //2次密码不同则显示信息

                                    return ("两次密码不一致");
                                },
                                onChanged: (v) {
                                  //当输入改变时调用.获取输入的信息
                                  print("输入确认密码:$v");
                                  mima2 = v;
                                  print("输入确认密码:$mima1,$mima2");
                                  if (mima1 == mima2)
                                    return print("ok");
                                  else
                                    return print("两次密码不一致");
                                }),
                            TextFormField(
                              //controller: _pwdController,
                              decoration: InputDecoration(
                                  labelText: "邮箱*",
                                  hintText: "您的邮箱",
                                  icon: Icon(Icons.lock)),
                              // obscureText: true,
                              //校验邮箱地址
                              validator: (v) {
                                return RegExp(
                                            r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
                                        .hasMatch(v!)
                                    ? null
                                    : "包含@和.,形如xx@xx.x";
                              },

                              onChanged: (V) {
                                you_xiang = V;
                                if (mima1 == mima2)
                                  print("ok");
                                else
                                  print("两次密码不一致");
                              },
                            ),
                            // TextFormField(
                            //     //住址
                            //     // autofocus: true,
                            //     // controller: _unameController,
                            //     decoration: InputDecoration(
                            //         labelText: "住址",
                            //         hintText: "住址",
                            //         icon: Icon(Icons.person)),
                            //     onChanged: (v) {
                            //       zhuzhi = v;
                            //     },
                            //     // 校验
                            //     validator: (v) {
                            //       return v!.trim().length > 0 ? null : "住址不能为空";
                            //     }),
                            TextFormField(
                              //controller: _pwdController,
                              decoration: InputDecoration(
                                  labelText: "手机",
                                  hintText: "您的手机号",
                                  icon: Icon(Icons.lock)),
                              obscureText: false, //不隐藏输入
                              //校验手机
                              validator: (v) {
                                return v!.trim().length == 11 ? null : "11位手机号";
                              },
                              onSaved: (val) {
                                shou_ji = val!;
                                //print("手机号_$shou_ji");
                              },
                            ),
                            // TextFormField(
                            //     //生日
                            //     // autofocus: true,
                            //     // controller: _unameController,
                            //     decoration: InputDecoration(
                            //         labelText: "生日",
                            //         hintText: "生日",
                            //         icon: Icon(Icons.person)),
                            //     onChanged: (v) {
                            //       shengri = v;
                            //     },
                            //     // 校验
                            //     validator: (v) {
                            //       return v!.trim().length > 0 ? null : "生日不能为空";
                            //     }),

                            // Padding(
                            //   padding: const EdgeInsets.only(top: 28.0),
                            //   child: Row(
                            //     children: <Widget>[
                            //       Expanded(
                            //         child: ElevatedButton(
                            //           // padding: EdgeInsets.all(1.0),
                            //           child: Text("注册"),
                            //           // color: Theme.of(context).primaryColor,
                            //           // textColor: Colors.white,
                            //           onPressed: () async {
                            //             //在这里不能通过此方式获取FormState，context不对
                            //             //print(Form.of(context));

                            //             // 通过_formKey.currentState 获取FormState后，
                            //             // 调用validate()方法校验用户名密码是否合法，校验
                            //             // 通过后再提交数据。

                            //             if ((_formKey.currentState as FormState)
                            //                 .validate()) {
                            //               //验证通过提交数据
                            //               print("校验成功");
                            //               (_formKey.currentState as FormState)
                            //                   .save(); //调用表单保存,此方法会回调onsave()

                            //               //把表单内容使用dio库提交给后台
                            //               Response response;
                            //               BaseOptions options1 = BaseOptions(
                            //                 // baseUrl: url1,
                            //                 connectTimeout:
                            //                     connectTimeout, //嵌套的dio请求这里要给0
                            //                 receiveTimeout:Duration(seconds: connectTimeout0),
                            //                 contentType:
                            //                     Headers.jsonContentType,
                            //                 // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
                            //                 /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
                            //                 /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
                            //                 /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
                            //                 /// 就会自动编码请求体.
                            //               );
                            //               Dio dio = Dio(options1);
                            //               response = await dio
                            //                   .post(map0api["用户注册"]!, data: {
                            //                 "Username": yonghu_ming,
                            //                 "Password": mima1,
                            //                 "Email": you_xiang,
                            //                 "Tel": shou_ji,
                            //                 "Sex": xingbie,
                            //                 "Birthday": shengri,
                            //                 "Address": zhuzhi,
                            //               });

                            //               if ((response.statusCode == 200) &
                            //                   (response.data["code"] == "0")) {
                            //                 print(response.data);
                            //                 // print(
                            //                 //     "$yonghu_ming1, $mi_ma3, $you_xiang1, $shou_ji1");

                            //                 print(response.statusCode);
                            //                 print(response.statusMessage);
                            //                 Get.Get.defaultDialog(
                            //                   title: "提示",
                            //                   middleText: "您注册成功了!",
                            //                   confirm: ElevatedButton(
                            //                       onPressed: () {
                            //                         Get.Get.toNamed(
                            //                             "/"); //跳到后台登录页
                            //                       },
                            //                       child: Text("确定")),
                            //                   // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
                            //                 );
                            //                 print("注册成功");
                            //               } else {
                            //                 Get.Get.defaultDialog(
                            //                     title: "提示",
                            //                     middleText:
                            //                         response.data["message"],
                            //                     confirm: ElevatedButton(
                            //                         onPressed: () {},
                            //                         child: Text("确定")),
                            //                     cancel: ElevatedButton(
                            //                         onPressed: () {},
                            //                         child: Text("取消")));
                            //                 print("注册失败");
                            //               }
                            //             }
                            //           },
                            //         ),
                            //       ),
                            //       Spacer(
                            //         flex: 1,
                            //       ),
                            //       Expanded(
                            //         child: ElevatedButton(
                            //           // padding: EdgeInsets.all(1.0),
                            //           child: Text("清空"),
                            //           // color: Theme.of(context).primaryColor,
                            //           // textColor: Colors.white,
                            //           onPressed: () {
                            //             //在这里不能通过此方式获取FormState，context不对
                            //             //print(Form.of(context));

                            //             // 通过_formKey.currentState 获取FormState后，
                            //             // 调用validate()方法校验用户名密码是否合法，校验
                            //             // 通过后再提交数据。
                            //             (_formKey.currentState as FormState)
                            //                 .reset(); //清空表单
                            //           },
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ])),
                ))));
  }
}
