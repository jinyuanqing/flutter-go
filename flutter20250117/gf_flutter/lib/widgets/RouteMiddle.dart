import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
//中间件(GetPage):可以做一些权限的判断.例如用户在跳转到支付页面,这个时候用户没有登录,就可以使用中间件的方式进行判断,先让用户跳转到中间件页面.具体使用详情如下:

class MiddlePageVC extends GetMiddleware {
  //需要继承GetMiddleware

  Future<void> await_time()   async { Get.to(Text("data"));
    await Future.delayed(Duration(seconds: 3), () {
     
    });
  }

  @override
//需要实现系统的该方法
  RouteSettings? redirect(String? route) {
    // return null;表示跳转到以前的路由
    //根据条件进行判断,满足条件进行跳转,否则不进行跳转
    var a1 = Get.parameters['id'];
    var typeid = Get.parameters['typeid'];
    if ((typeid != null) & (typeid!= null)) {//验证通过
      print(a1);
      print(typeid);

      //   // 延时1s执行返回

      // EasyLoading.showError('Failed with Error',
      //     duration: Duration(seconds: 3));

      //  Get.rawSnackbar(title: '登录', message: '登录失效，重新登录');
//  sleep(Duration(seconds: 13));
   
         return null;//返回空为去除路由设置,直接返回原本的路由哦

    }else{//验证不通过,跳到处理需要登陆或其他权限的路由
return RouteSettings(name: "/m", arguments: {}); //


    }
  }
}
