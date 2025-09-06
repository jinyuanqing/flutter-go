import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; //网络获取数据
import 'package:flutter_gf_view/model1.dart';
import 'package:flutter_gf_view/widgets/http.dart';
import 'package:get/get.dart' as Get;
import '/common.dart';

class TriggerZhuce extends StatefulWidget {
  const TriggerZhuce({Key? key}) : super(key: key);

  @override
  _TriggerZhuceState createState() => _TriggerZhuceState();
}

class _TriggerZhuceState extends State<TriggerZhuce> {
  String labeltext = '请填写邮箱';
  bool is_ok = false;
  String success_text = '';
  TextEditingController email_controll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("邮箱激活验证,10分钟内登陆邮箱进行验证操作:"),
        TextField(
            onChanged: (String text) {
              print(text);
              success_text = '';
              bool jian = email(text);
              is_ok = jian;
              print(is_ok);
              if (is_ok == true) {
                setState(() {
                  labeltext = '邮箱格式正确';
                  is_ok = true;
                });
              } else {
                setState(() {
                  labeltext = '邮箱格式不正确';
                  is_ok = false;
                });
              }
            },
            controller: email_controll,
            decoration: InputDecoration(
              icon: Icon(Icons.email), //前边的图标

              labelText: "请填写邮箱",
              labelStyle: TextStyle(color: Colors.blueGrey),
              //右侧图标
              suffixIcon: Padding(
                padding: EdgeInsets.all(8),
                child: is_ok == true
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
              ),
            )),
        Text(success_text),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () async {
                  if (is_ok == true) {
                    await send_email();
                    is_ok = false;
                    success_text = "发送成功,请到邮箱查看";
                    email_controll.text = "";
                   
                  }else
                  {

                     success_text = "请填写正确的邮箱";
                  } setState(() {});
                },
                child: Text("确定")),
          ],
        ),
      ],
    );
  }

  Future send_email() async {
    FormData formdata = new FormData.fromMap({
      "Email": email_controll.text,
      // "fenlei": "",
      //  "YingpinzheId": '''{"应聘者":${json_str1}}''',
    });
    var response = await YXHttp().http_post(map0api["获取系统时间并发送邮件"]!, formdata);
    // var response = await dio.post(map0api["获取系统时间"]!, data: formData1);

    // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行
    // reslut.insert(reslut.length ,json_result);
    // print(json_result.runtimeType);
    // reslut.addAll(json_result);

    print("获取时间");
    print(response["Encrypt_time"]);

    // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
    // print(response.data["data"]["Time"]);

    setState(
        () {}); //报错:setState() called after dispose(): Shaixuan1#d85eb(lifecycle state: defunct, not mounted)

    // } else {
    //   return;
    // }
    //   load = true;
  }
}
