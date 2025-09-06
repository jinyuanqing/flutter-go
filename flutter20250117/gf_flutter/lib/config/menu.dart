import 'package:flutter/material.dart';
import 'package:flutter_gf_view/admin/left_menu/pages/zhandianmingcheng.dart';
import 'package:get/get.dart';

import '../admin/admin_index.dart';
import '../admin/left_menu/pages/gerenzhongxin.dart';
import '../admin/left_menu/pages/quanxianguanli.dart';
import '../admin/left_menu/pages/seo.dart';
import '../admin/left_menu/pages/wenzhangfabu.dart';
import '../admin/left_menu/pages/wenzhangguanli.dart';
import '../admin/left_menu/pages/yonghuxinxi.dart';
import '../admin/left_menu/pages/zhaopinfabu.dart';
import '../admin/left_menu/pages/zhaopinguanli.dart';
import '../admin/left_menu/pages/文件存储.dart';
import '../main.dart';
import '../user/fabuzhe/center_user.dart';
import '../user/user_index.dart';
import '../user/zhuce/zhuce.dart';
import '../widgets/RouteMiddle.dart';
import '../widgets/article_xiang_qing.dart';
import '../widgets/message.dart';
import '/admin/left_menu/pages/gongnengshezhi.dart';
import '/admin/left_menu/pages/zhandianyuming.dart';
import '/model1.dart';



//<菜单名,菜单页面类对象>
//这里添加菜单后,在admin/left_mentu/pages/目录中创建对应的页面类,然后再此import 引入.

Map<String, Widget> menu_admin_class = {

  //用户登录后,会读取菜单表获取后台有权限的菜单名和菜单url.把菜单url进行用户权限表进行验证哪些菜单名可以访问,
//然后查询url对应的菜单名,保存菜单名.然后菜单名查询此menu_admin_class获得菜单对应的页面.
  "站点域名": zhandianyuming(),
  "站点名称": zhandianmingcheng(),
  "功能设置": shangchuanshezhi(),
  "文件存储": wenjiancunchu(),
  "用户信息": yonghuxinxi(),
  "文章发布": wenzhangfabu(),
  "文章管理": wenzhanguanli(),
  "招聘发布": zhaopinfabu(),
  "招聘管理": zhaopinguanli(),
   "权限管理": quanxianguanli(),
  "seo": seo(),
  "个人中心": Gerenzhongxin(username: username),
};

List<GetPage<dynamic>>? page_route=
 [
          //使用     Get.Get.toNamed("zhuce");进行页面跳转
          GetPage(name: '/a', page: () => const MyApp()), //后台登录页
           GetPage(name: '/m', page: () => const Message()), //
          GetPage(
              name: '/admin/yhzx',//用户中心
              page: () => Center_user(
                    zuozhe: "youxue",
                  )), //

          GetPage(name: '/u', page: () => User_index()),
          GetPage(
              name: '/admin_index', //后台管理页
              page: () =>
                  const Admin_index()), //http://localhost:65344/#/admin_index

          GetPage(
              name: '/user_index', //前台首页
              page: () =>
                  const User_index()), //http://localhost:65344/#/user_index

          GetPage(
              name: '/admin/zdmc', //站点名称
              page: () => const zhandianmingcheng()),

          GetPage(
              name: '/admin/wzgl', //文章管理//因为token问题导致无法单独访问
              page: () => const wenzhanguanli()),
          GetPage(
              name: '/zhuce', //注册
              page: () => const zhu_ce()),
          GetPage(
            name:
                '/article_content', //文章内容 触发url=http://localhost:10087/#/article_content?typeid=3&id=2
            page: () => const Article_xiang_qing(//参数是可选参数,所以写不写都行.这里不能写.因为参数只能通过路由url传递,而无法通过代码给定
                //     id: 1,
                //     title: "123",
                //     nei_rong: "123",
                //     zuo_zhe: "123",
                // dianzanshu: 123,
                //     yuedushu: 12,
                //     ri_qi: "2021",
                // typeid: 2
                  // id:1  ,
     
                //     ri_qi: "2"
                ),
            middlewares: [MiddlePageVC()],//路由中间件只针对这个路由的
          ),
  ] ;