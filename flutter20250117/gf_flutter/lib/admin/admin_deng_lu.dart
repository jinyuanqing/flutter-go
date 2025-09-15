import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_gf_view/model1.dart';
import 'package:flutter_gf_view/user/user_index.dart';
import 'package:flutter_gf_view/user/zhuce/trigger_zhuce.dart';
import 'package:flutter_gf_view/user/zhuce/zhuce.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'dart:math';
import 'package:reflectable/reflectable.dart';
// import 'package:mirrors/mirrors.dart';//导入就报错
import 'package:dio/dio.dart'; //网络获取数据
import 'package:get/get.dart' as Get;
import 'dart:ui'; //图片过滤器ImageFilter需要引入的包
import '/quan_ju.dart';
import '/admin/admin_index.dart';
import '/model1.dart';
import '/widgets/http.dart';
import 'dart:convert';
import '/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdminDengLu extends StatefulWidget {
  const AdminDengLu({Key? key}) : super(key: key);

  @override
  _AdminDengLuState createState() => _AdminDengLuState();
}

class _AdminDengLuState extends State<AdminDengLu> {
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
  bool is_ok = false;
 
bool isshow=false;


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
      // result.insert(result.length ,json_result);
      // print(json_result.runtimeType);
      // result.addAll(json_result);
      if (response.statusCode == 200) {
        if ((response.data["code"] == "0") &
            (response.data["data"]["res"] != null)) {
          print("获取岗位");
          // print(response.data["data"]["res"]);
          var result = [];
          // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
          result.insertAll(result.length, response.data["data"]["res"]);
          gangwei_fenlei = result;

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
          //与  _streamController1.add(fenlei[0]);效果同.把提示信息添加到控制器中,实现刷新组件.添加的值必须是fenlei列表中的值,否则报错

          // int num1 = (List.from(json_obj["应聘者"]).length);
          // print(json_obj["应聘者"][num1 - 1]["id"]);

          // print(list_yingpinzhe_id);
          // print("result.length:");
          // print(result.length);
          //    print("result");
          //  print(result);
          // print(list_yingpinzhe_id[0][0]["id"]);
          // print(result.length);
          //  print(response.data["data"]["num"]);
          // print(response.data["data"]["res"][response.data["data"]["num"]-1]["yingpinzhe_id"]);
          // print(response.data["data"]["res"][0]["yingpinzhe_id"] [0]);

          //   print(response.data["data"]["res"][0]["yingpinzhe_id"]["应聘者"][0]["name"]);
          //   String json_str2 = convert.jsonEncode(response.data["data"]);
          //   print(json_str2);
          // if (mounted) {
          // setState(
          //     () {}); //报错:setState() called after dispose(): Shaixuan1#d85eb(lifecycle state: defunct, not mounted)

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
      //   print("result结束");
      // return  print(json_result[0]["biao_ti"]);

      // setState(() {});//报错:setState() called after dispose(): Shaixuan1#d85eb(lifecycle state: defunct, not mounted)
//      print(response.headers);
//      print(response.request);
//      print(response.statusCode);
      // Dio().get("http://www.baidu.com");
      //  print("baidu请求:");//print(response);
    } catch (e) {
      print(e);
    }
  }

 late final SharedPreferences prefs ;
void initshared() async{
   prefs = await SharedPreferences.getInstance();
   print("prefs"); print(prefs);
   //读取username和token 
// // Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? uname = prefs.getString('username');
final String? utoken = prefs.getString('token');
 print(uname);print(utoken);

 if( ((utoken !=null)||(uname !=null))){//用户名和token读取不为空时,发送验证请求判断token和用户名是否一致
   var response = await YXHttp().http_post(map0api["用户token是否存在"]!, {"username":uname,"token":utoken});
    print("response"); 
 
    print(response);//=1

 if (response==null){return;}//返回值为null,说明发生错误,因此返回.
  if( (response=="1")){
 
print("本地持久化用户名和token失败,直接显示登陆ui");
isshow=false;

}else if(response=="0")
  //存放浏览器的本地存储信息正常验证通过,可直接登录
  {
print("读取本地持久化username和token成功");
isshow=true;
token=utoken!;
//token验证是否存在与服务器端
username=uname!;
  
}

 }
else{//用户名和token读取为空时

 
print("本地持久化用户名和token失败,直接登陆ui");
isshow=false;


}



 

setState(() {
  
});
}
  @override
  void initState()  { 
    super.initState();
test_user_token();



  }
void test_user_token()async{


  
    initshared();

}


  void _denglu(Model1 model1) async {
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

    // Dio dio = Dio(options);

    //字段名称必须与服务器端一致

    var json_str = {
      "Username": "youxue",
      "Password": "jinjin1984",
    };

    var json_str111 = {
      "Username": _unameController.text,
      "Password": _pwdController.text,
    };

     

    var response = await YXHttp().http_post(map0api["登录"]!, json_str);
if (response==null){return;}
    //response.data返回的是json字符串
    //成功登录的请求处理
    username = _unameController.text;
    //用户昵称
    model1.change_nickname(response["nickname"]);
    model1.change_qianming(response["qianming"]);
    touxiang = response["touxiang"]; //头像
    // print("nickname:$nickname");
    // print("qianming:$qianming");
    print("touxiang:$touxiang");
    //         ["token"])
    // print("token:" +
    //     response['data']
    //         ["token"]);
    // print("is_admin:" +
    //     response['data']
    //         ["is_admin"]);
//本地持久化的token和username无法读取时也就是是null执行登录
  await prefs.setString('username', response["userKey"]  );
  await prefs.setString('token',  response["token"] );
username= response["userKey"] ;
token=response["token"] ;


    
 var json_str1 = {
      "token": token,//response["token"],
      "username":username,// response["userKey"] //登陆后返回的userKey作为用户名
    };
    // var json0 = jsonDecode(
    //     jsonEncode(response.data));//此处多余,可以在dio中设置响应的数据类型为json, responseType: ResponseType.json,
 response = await YXHttp().http_post(map0api["获取后台有权限的菜单"]!, json_str1);

    var json0 = (response);
    // ignore: avoid_print
    print(json0.length);
    // print(json0["data"][0]["Id"]);
    // print(json0["data"][1]["Id"]);
    // print(json0["data"][2]["Id"]);
     caidan_admin=[];
    caidan_admin=json0;
    caidan_admin_1_2 = [];
    for (var i = 0; i < json0.length; i++) {
      isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
      List<String> list0 = [];

      if (json0[i]["Children"] != null) {
        list0.add(json0[i]["MenuName"]);
        if (json0[i]["Children"].length > 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < json0[i]["Children"].length; i1++) {
            list0.add(json0[i]["Children"][i1]["MenuName"]);
          }
          caidan_admin_1_2.add(list0);
        }
      } else {
        list0.add(json0[i]["MenuName"]);
        caidan_admin_1_2.add(list0);
      }
    }
    print(caidan_admin_1_2);



  
    // var json0 = jsonDecode(
    //     jsonEncode(response.data));//此处多余,可以在dio中设置响应的数据类型为json, responseType: ResponseType.json,
 response = await YXHttp().http_post(map0api["获取前台菜单"]!, json_str1);

    var json01 = (response);    menuuser=response;//用于变量生成
    // ignore: avoid_print
    print(json01.length); 
  print(response[1]["id"]);
    // print(json0["data"][1]["Id"]);
    // print(json0["data"][2]["Id"]);
    caidan_user_1_2 = [];
    for (var i = 0; i < json01.length; i++) {
      // isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
      List<String> list0 = [];

      if (json01[i]["Children"] != null) {//有子项时候
        list0.add(json01[i]["userMenuName"]);
        if (json01[i]["Children"].length >= 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < json01[i]["Children"].length; i1++) {
            list0.add(json01[i]["Children"][i1]["userMenuName"]);
          }
          caidan_user_1_2.add(list0);
        }
      } else {
        list0.add(json01[i]["userMenuName"]);
        caidan_user_1_2.add(list0);
      }
    }
     print("前台菜单:");
    print(caidan_user_1_2);




    islogin = true;

    get_gangwei_xifen(0);
    Get.Get.off(const Admin_index()); //跳转后无法使用浏览器返回,防止用户重复进入登陆界面
    //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    // 	//返回要跳转的目标页面
    //   return Admin_index();
    // }));
  }


  @override
  Widget build(BuildContext context) {
    Model1 model1 = context.watch<Model1>();





  
 

    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(websitename),
      // ),
      body:
// AlertDialog
          Container(
              width: 1920,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("/images/0.jpg"),
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
                      // decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 124, 123, 119),
                      //     borderRadius: BorderRadius.circular(20.0),
                      //     boxShadow: [
                      //      const BoxShadow(
                      //           color: Color.fromARGB(255, 26, 25, 25),
                      //           offset: Offset(10.0, 10.0), //阴影xy轴偏移量
                      //           blurRadius: 5.0, //阴影模糊程度
                      //           spreadRadius: 1.0 //阴影扩散程度
                      //           )
                      //     ]),
                      width: 400,
                      height: 350,

                      child: Form(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //const Text(zhan_dian_ming_cheng),
                       
if(isshow==false) ...[//条件if集合
                              Container( //width: 800,
                                height: 40 * 2,
                                //color: primary,
                                 decoration: BoxDecoration(
                         // color: Color.fromARGB(255, 124, 123, 119),
                         border: Border(bottom: BorderSide(color: Color.fromARGB(255, 247, 211, 67) ,width: 5)),
                          // borderRadius: BorderRadius.circular(20.0),
                         ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "管理员后台",
                                        style: TextStyle(
                                            fontSize: 40, color: Colors.white),
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
                                  onFieldSubmitted: (v) {
                                    //按下回车触发
                                    print(v);
                                    _denglu(model1);
                                  },
                                  style: TextStyle(fontSize: 25),
                                  controller: _pwdController,
                                  decoration: InputDecoration(
                                      labelText: "密码",
                                      hintText: "输入密码",
                                      icon: Icon(
                                        Icons.lock,
                                        color: primary,
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
                                                // padding: EdgeInsets.all(1.0),
                                                child: const Text("登录",
                                                    style: TextStyle(
                                                        fontSize: 25)),
                                                //   color: Theme.of(context).primaryColor,
                                                //  textColor: Colors.white,
                                                onPressed: () =>
                                                    (_denglu(model1)),
                                              )),
                                        ),
                                      ])),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              height: 50,
                                              child: TextButton(
                                                  // padding: EdgeInsets.all(1.0),
                                                  child: Text("点这里注册",
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  //   color: Theme.of(context).primaryColor,
                                                  //  textColor: Colors.white,
                                                  onPressed: () {
                                                   Get.Get.defaultDialog(
                                                      title: "提示",
                                                      middleText: "设置成功了!",
                                                      content: StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                        
                                                        return TriggerZhuce();


  }),
                                                      barrierDismissible:
                                                          true, //	是否可以通过点击背景关闭弹窗

                                                      // cancel: ElevatedButton(onPressed: (){}, child: Text("取消"))
                                                    );

                                                          })),
                                        ),
                                      ])),  

] else ...[

Center(
    child: Column(
      children: [
         Image.asset( "/images/shouye1.png",
      fit: BoxFit.fill,
    ),
Text("您可直接登录!",textAlign:TextAlign.center  ,style:TextStyle(
 fontSize: 25,
  color:Colors.black54
)),
SizedBox(height: 100,width:200,child:
        ElevatedButton( child: Text(
            "登录",style:TextStyle(

 fontSize: 25,
)
          ),
          onPressed: ()async {

 var json_str1 = {
      "token": token,//response["token"],
      "username":username,// response["userKey"] //登陆后返回的userKey作为用户名
    };
    // token = response["token"]; //设置全局token
 
    var response1 = await YXHttp().http_post(map0api["根据用户名获取用户信息"]!, json_str1);//response1是空,则说明token或者用户名有问题.
   print(12);
    print(response1);
if (response1 == null) {
  //如果等于空,说明token或者用户名有问题,此时应该返回输入账号密码页面.
isshow=false;//此变量为控制页面的显示控制
setState(() {
  
});

}

print(12);
touxiang=response1[0]["touxiang"];

  //用户昵称
    model1.change_nickname(response1[0]["nickname"]);



    //把tokne和用户名回发给服务器,作为权限控制菜单的显示
   var  response = await YXHttp().http_post(map0api["获取后台有权限的菜单"]!, json_str1);

    var json0 = (response);

    // var json0 = jsonDecode(
    //     jsonEncode(response.data));//此处多余,可以在dio中设置响应的数据类型为json, responseType: ResponseType.json,

    // ignore: avoid_print
    print(json0.length);
    // print(json0["data"][0]["Id"]);
    // print(json0["data"][1]["Id"]);
    // print(json0["data"][2]["Id"]);
    caidan_admin_1_2 = [];
     caidan_admin=[];
  caidan_admin=json0;
  //  print("caidan_admin");
  //   print(caidan_admin);
  // print(caidan_admin[0]["Id"]);
    for (var i = 0; i < json0.length; i++) {
      isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
      List<String> list0 = [];//临时菜单名
       List<String> list2= [];//临时菜单类名
  List<String> list1 = [];//存放临时菜单url
      if (json0[i]["Children"] != null) {
        list0.add(json0[i]["MenuName"]); 
        list1.add(json0[i]["MenuUrl"]);
        list2.add(json0[i]["MenuClass"]);
        if (json0[i]["Children"].length > 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < json0[i]["Children"].length; i1++) {
            list0.add(json0[i]["Children"][i1]["MenuName"]);
             list1.add(json0[i]["Children"][i1]["MenuUrl"]);
                list2.add(json0[i]["Children"][i1]["MenuClass"]);
          }
          caidan_admin_1_2.add(list0);
          caidan_url_admin_1_2.add(list1);
           caidan_class_admin_1_2.add(list2);
        }
      } else {
        list0.add(json0[i]["MenuName"]);
        caidan_admin_1_2.add(list0);
         list1.add(json0[i]["MenuUrl"]);
        caidan_url_admin_1_2.add(list1);
        list2.add(json0[i]["MenuClass"]);
          caidan_class_admin_1_2.add(list2);

      }
    }
     print("菜单名");
    print(caidan_admin_1_2); 
    
    print("菜单URL:caidan_url_admin_1_2:");
    print(caidan_url_admin_1_2);
    
     print("菜单calss:caidan_class_admin_1_2:");
    print(caidan_class_admin_1_2);
    print(caidan_class_admin_1_2[5][1]);


  response = await YXHttp().http_post(map0api["获取前台菜单"]!, json_str1);

    var json01 = (response); menuuser=response;//用于变量生成
    // ignore: avoid_print
    print(json01.length);
    // print(json0["data"][0]["Id"]);
    // print(json0["data"][1]["Id"]);
    // print(json0["data"][2]["Id"]);
    caidan_user_1_2 = [];
    for (var i = 0; i < json01.length; i++) {
      // isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
      List<String> list0 = [];

      if (json01[i]["Children"] != null) {
        list0.add(json01[i]["userMenuName"]);
        if (json01[i]["Children"].length >= 0) {
          // caidan.add(json0[i]["MenuName"]);
          for (var i1 = 0; i1 < json01[i]["Children"].length; i1++) {
            list0.add(json01[i]["Children"][i1]["userMenuName"]);
          }
          caidan_user_1_2.add(list0);
        }
      } else {
        list0.add(json01[i]["userMenuName"]);
        caidan_user_1_2.add(list0);
      }
    }
     print("前台菜单:");
    print(caidan_user_1_2);

    islogin = true;




    get_gangwei_xifen(0);
    Get.Get.offNamed("/admin_index?device=phone&id=354&name=Enzo");


          },
        )
        ),
          
       
      ],
    ),
  ),

]
   ]),
                      ),
                    )

                    // actions:<Widget>[

                    // ],
                    // backgroundColor:Colors.yellowAccent,
                    // elevation: 20,
                    // semanticLabel:'哈哈哈哈',
                    // // 设置成 圆角
                    // shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ]))),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
         


//          // Obtain shared preferences.
// // final SharedPreferences prefs = await SharedPreferences.getInstance();

// // 


 


// // // Try reading data from the 'items' key. If it doesn't exist, returns null.
// // final List<String>? items = prefs.getStringList('items');

// // print(counter);print(repeat);print(decimal);print(action);print(items);

//     var json_str = {
//       "Username": "youxue",
//       "Password": "jinjin1984",
//     };

//     // var json_str = {
//     //   "Username": _unameController.text,
//     //   "Password": _pwdController.text,
//     // };

//     //  var json_data = json.decode(json_str);

//     // print(json_data);
//     // FormData formData1 = new FormData.fromMap({
//     //   //字段名称必须与服务器端一致
//     //   "id": '0',
//     //   "user_name1": 'yonghu_ming1',
//     //   "user_email1": 'mi_ma3',
//     //   "user_password1": 'you_xiang1',
//     //   "user_sexy1": 'shou_ji1',
//     //   "user_address1": 'yonghu_ming1',
//     //   "user_area1": 'mi_ma3',
//     //   "user_tel1": 'you_xiang1',
//     //   "user_nickname1": 'shou_ji1',
//     //   "user_birthday1": 'you_xiang1',
//     //   "user_profession1": 'shou_ji1',
//     // });
//     // Response response;//get包和dio包都有此类型,防止冲突
//     var response;
// //


//       response = await YXHttp().http_post(map0api["登录"]!, json_str);
// if(response != null){//登陆成功

// //本地持久化的token和username无法读取时也就是是null执行登录
//   await prefs.setString('username', response["userKey"]  );
//   await prefs.setString('token',  response["token"] );
// username= response["userKey"] ;
// token=response["token"] ;


//     //response.data返回的是json字符串
//     //成功登录的请求处理
//     // username =json_str["Username"].toString();
//     //用户昵称
//     model1.change_nickname(response["nickname"]);
//     model1.change_qianming(response["qianming"]);
//     touxiang = response["touxiang"]; //头像
//     // print("nickname:$nickname");
//     // print("qianming:$qianming");
//     print("touxiang:$touxiang");
//     //         ["token"])
//     // print("token:" +
//     //     response['data']
//     //         ["token"]);
//     // print("is_admin:" +
//     //     response['data']
//     //         ["is_admin"]);

//     var json_str1 = {
//       "token": token,//response["token"],
//       "Username":username,// response["userKey"] //登陆后返回的userKey作为用户名
//     };
//     // token = response["token"]; //设置全局token

//     //把tokne和用户名回发给服务器,作为权限控制菜单的显示
//     response = await YXHttp().http_post(map0api["获取后台有权限的菜单"]!, json_str1);

//     var json0 = (response);

//     // var json0 = jsonDecode(
//     //     jsonEncode(response.data));//此处多余,可以在dio中设置响应的数据类型为json, responseType: ResponseType.json,

//     // ignore: avoid_print
//     print(json0.length);
//     // print(json0["data"][0]["Id"]);
//     // print(json0["data"][1]["Id"]);
//     // print(json0["data"][2]["Id"]);
//     caidan_admin_1_2 = [];
//     for (var i = 0; i < json0.length; i++) {
//       isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
//       List<String> list0 = [];

//       if (json0[i]["Children"] != null) {
//         list0.add(json0[i]["MenuName"]);
//         if (json0[i]["Children"].length > 0) {
//           // caidan.add(json0[i]["MenuName"]);
//           for (var i1 = 0; i1 < json0[i]["Children"].length; i1++) {
//             list0.add(json0[i]["Children"][i1]["MenuName"]);
//           }
//           caidan_admin_1_2.add(list0);
//         }
//       } else {
//         list0.add(json0[i]["MenuName"]);
//         caidan_admin_1_2.add(list0);
//       }
//     }
//     print(caidan_admin_1_2);
//  response = await YXHttp().http_post(map0api["获取前台菜单"]!, json_str1);

//     var json01 = (response);
//     menuuser=response;//用于变量生成
//     // ignore: avoid_print
//     print(json01.length);
//     // print(json0["data"][0]["Id"]);
//     // print(json0["data"][1]["Id"]);
//     // print(json0["data"][2]["Id"]);
//     caidan_user_1_2 = [];
//     for (var i = 0; i < json01.length; i++) {
//       // isexpand.add(false); //给一级菜单-伸缩菜单添加控制元素
//       List<String> list0 = [];

//       if (json01[i]["Children"] != null) {
//         list0.add(json01[i]["userMenuName"]);
//         if (json01[i]["Children"].length >= 0) {
//           // caidan.add(json0[i]["MenuName"]);
//           for (var i1 = 0; i1 < json01[i]["Children"].length; i1++) {
//             list0.add(json01[i]["Children"][i1]["userMenuName"]);
//           }
//           caidan_user_1_2.add(list0);
//         }
//       } else {
//         list0.add(json01[i]["userMenuName"]);
//         caidan_user_1_2.add(list0);
//       String classname=  json01[i]["userMenuUrl"].toString().split("/").last;//取出url中的最后一个部分,作为类名
// print(classname);
// // initializeReflectable(); // Set up reflection support.
//   // ClassMirror classSymbol =reflector. (classname);


// // menu_user_class[json01[i]["userMenuName"]]=<Widget>classSymbol;

//       }
//     }
//      print("前台菜单:");
//     print(caidan_user_1_2);
// //动态生成menu_user_class.
// // menu_user_class.









//     islogin = true;

//     get_gangwei_xifen(0);
//     Get.Get.offNamed("/admin_index?device=phone&id=354&name=Enzo");
//     //Get.Get.off(const Admin_index()); //跳转后无法使用浏览器返回,防止用户重复进入登陆界面
// }
//         },
//         tooltip: '登录',
//         child: const Icon(Icons.login),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
    
    );
  

 

 

}
}