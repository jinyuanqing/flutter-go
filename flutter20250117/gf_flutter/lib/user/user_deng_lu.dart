import 'package:flutter/material.dart';
import 'package:flutter_gf_view/model1.dart';
import 'package:flutter_gf_view/user/user_index.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import '../main.dart';
import 'dart:math';
import 'package:dio/dio.dart'; //网络获取数据
import 'package:get/get.dart' as Get;
import 'dart:ui'; //图片过滤器ImageFilter需要引入的包
import '/quan_ju.dart';

class UserDengLu extends StatefulWidget {
  const UserDengLu({Key? key}) : super(key: key);

  @override
  _UserDengLuState createState() => _UserDengLuState();
}

class _UserDengLuState extends State<UserDengLu> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  String mima1 = "", mima2 = ""; //2次密码
  String shou_ji = "",
      yonghu_ming = "",
      you_xiang = "",
      zhuzhi = "",
      xingbie = "",
      shengri = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
          ),
      body:
// AlertDialog
          Container(
              width: 1920,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("/images/0.gif"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                  //widthFactor: 10,
                  // heightFactor:30,
                  //title: Text('我是标题'),
                  //content:
                  child: Stack(alignment: AlignmentDirectional.center,
                      //使用层叠组件，图片和毛玻璃、字体重叠在一起
                      children: <Widget>[
                    ClipRRect(
                        //可裁切的矩形
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: BackdropFilter(
                          //玻璃效果
                          //背景过滤器
                          //引入图片过虑器（blur:模糊设置）
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Opacity(
                            //设置透明度
                            opacity: 0.5, //半透明
                            child: Container(
                              width: 650.0,
                              height: 550.0,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                      255, 136, 216, 236)), //盒子修饰器
                              child: Center(child: Text("")),
                            ),
                          ),
                        )),
                    Container(
                      //color: Color.fromARGB(255, 229, 226, 226),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0xcc, 0xff, 0x66),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            const BoxShadow(
                                color: Color.fromARGB(255, 182, 228, 89),
                                offset: Offset(10.0, 10.0), //阴影xy轴偏移量
                                blurRadius: 5.0, //阴影模糊程度
                                spreadRadius: 1.0 //阴影扩散程度
                                )
                          ]),
                      width: 400,
                      height: 350,

                      child: Form(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //const Text(zhan_dian_ming_cheng),

                              Container(
                                height: 40 * 2,
                                // color: primary,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "用户登录",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      )
                                    ]),
                              ),

                              TextFormField(
                                  style: TextStyle(fontSize: 25),
                                  autofocus: true,
                                  controller: _unameController,
                                  decoration: InputDecoration(
                                      labelText: "用户名",
                                      hintText: "输入用户名",
                                      // hintStyle: TextStyle(color: ),
                                      icon: Icon(
                                        Icons.person,
                                        color: primary,
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
                                  controller: _pwdController,
                                  decoration: InputDecoration(
                                      labelText: "密码",
                                      hintText: "输入密码",
                                      icon: Icon(
                                        Icons.lock,
                                        // color: Color.fromARGB(
                                        //     0xff, 0x66, 0xcc, 0xcc),
                                      )),
                                  obscureText: true,
                                  //校验密码
                                  validator: (v) {
                                    //    return v.trim().length > 5 ? null : "密码不能少于6位";
                                  },
                                  onChanged: (v) {
                                    //当输入改变时调用.获取输入的信息
                                    print("输入密码:$v");
                                    //  mima1 = v;
                                  }),

                              // 登录按钮
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                              height: 50,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color.fromARGB(
                                                                0xff,
                                                                0x66,
                                                                0xcc,
                                                                0xcc))),
                                                // padding: EdgeInsets.all(1.0),
                                                child: const Text("登录",
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                    )),
                                                //   color: Theme.of(context).primaryColor,
                                                //  textColor: Colors.white,
                                                onPressed: () async {
                                                  //在这里不能通过此方式获取FormState，context不对
                                                  //print(Form.of(context));

                                                  // 通过_formKey.currentState 获取FormState后，
                                                  // 调用validate()方法校验用户名密码是否合法，校验
                                                  // 通过后再提交数据。

                                                  // if ((_formKey.currentState as FormState)
                                                  //     .validate())

                                                  //验证通过提交数据
                                                  //   print("校验成功");
                                                  // (_formKey.currentState as FormState)
                                                  //     .save(); //调用表单保存,此方法会回调onsave()
                                                  //验证通过提交数据
                                                  // yonghu_ming1 = yonghu_ming;
                                                  // mi_ma1 = mima1;
                                                  // you_xiang1 = you_xiang;
                                                  // shou_ji1 = shou_ji;
                                                  //把表单内容使用dio库提交给后台

                                                  BaseOptions options =
                                                      BaseOptions(
                                                    // headers: {
                                                    //   // 'Content-Type': 'text/html',
                                                    //   "Accept":
                                                    //       "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                                                    //   // 'Sec-Fetch-Mode': 'navigate',

                                                    // },
                                                    // baseUrl: url1,
                                                    connectTimeout:
                                                        Duration(seconds: connectTimeout0),
                                                   receiveTimeout:Duration(seconds: connectTimeout0), //无数据库链接时的反应时间,超过此时间就执行报错处理 了
                                                    contentType:
                                                        Headers.jsonContentType,
                                                    // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
                                                    /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
                                                    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
                                                    /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
                                                    /// 就会自动编码请求体.
                                                  );

                                                  Dio dio = Dio(options);

                                                  //字段名称必须与服务器端一致

                                                  var json_str = {
                                                    "Username": "youxue",
                                                    "Password": "jinjin1984",
                                                  };

                                                  // var json_str = {
                                                  //   "Username": _unameController.text,
                                                  //   "Password": _pwdController.text,
                                                  // };

                                                  //  var json_data = json.decode(json_str);

                                                  // print(json_data);
                                                  // FormData formData1 = new FormData.fromMap({
                                                  //   //字段名称必须与服务器端一致
                                                  //   "id": '0',
                                                  //   "user_name1": 'yonghu_ming1',
                                                  //   "user_email1": 'mi_ma3',
                                                  //   "user_password1": 'you_xiang1',
                                                  //   "user_sexy1": 'shou_ji1',
                                                  //   "user_address1": 'yonghu_ming1',
                                                  //   "user_area1": 'mi_ma3',
                                                  //   "user_tel1": 'you_xiang1',
                                                  //   "user_nickname1": 'shou_ji1',
                                                  //   "user_birthday1": 'you_xiang1',
                                                  //   "user_profession1": 'shou_ji1',
                                                  // });
                                                  // Response response;//get包和dio包都有此类型,防止冲突
                                                  var response = await dio.post(
                                                      map0api["登录"]!,
                                                      data: json_str);

                                                  if (response.statusCode ==
                                                      200) {
                                                    //成功登录的请求处理

                                                    // print(response.data['code']);  print(response.data['message']);
                                                    // print(response.statusMessage);
                                                    if (response.data['code'] ==
                                                            0 &&
                                                        (response.data['msg'] ==
                                                            "success")) {
                                                      print(response.data);
                                                      username =
                                                          _unameController.text;
                                                      print("username");
                                                      print(username);

                                                      //ok
                                                      //response.data返回的是json字符串

                                                      // print("token:" +
                                                      //     response.data['data']
                                                      //         ["token"]);
                                                      // print("is_admin:" +
                                                      //     response.data['data']
                                                      //         ["is_admin"]);

                                                      var json_str = {
                                                        "token": response
                                                                .data['data']
                                                            ["token"],
                                                        "Username": response
                                                                .data['data'][
                                                            "userKey"] //登陆后返回的userKey作为用户名
                                                      };
                                                      token = response
                                                              .data['data']
                                                          ["token"]; //设置全局token

                                                      islogin = true;
                                                      Get.Get.off(
                                                          User_index()); //跳转后无法使用浏览器返回,防止用户重复进入登陆界面
                                                      //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                      // 	//返回要跳转的目标页面
                                                      //   return Admin_index();
                                                      // }));

                                                    } else {
                                                      //不 Ok
                                                      islogin = false;
                                                      Get.Get.snackbar("结果",
                                                          response.data['msg'],
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
                                                      print(
                                                          response.data['msg']);
                                                    }
                                                    // BotToast.showText(
                                                    //     text: "注册成功,转到登录",
                                                    //     duration:
                                                    //         Duration(seconds: 3)); //弹出一个文本框;
                                                    // int count = 3;

                                                    // var _duration =
                                                    //     new Duration(seconds: 1);
                                                    // new Timer(_duration, () {
                                                    //   // 空等1秒之后再计时
                                                    //  // timer = new Timer.periodic(
                                                    //       const Duration(milliseconds: 1000),
                                                    //       (v) {
                                                    //     count--;
                                                    //     print(count);
                                                    //     if (count == 0) {
                                                    //       // timer.cancel(); //取消停止定时
                                                    //       // //跳转登录界面
                                                    //       // Navigator.push(context,
                                                    //       //     MaterialPageRoute(
                                                    //       //         builder: (context) {
                                                    //       //   return Login();
                                                    //       }));
                                                    // }
                                                    // });
                                                    // });

                                                  }
                                                },
                                              )),
                                        ),
                                      ]))
                            ]),
                      ),
                    )
                  ]))),
    );
  }
}
