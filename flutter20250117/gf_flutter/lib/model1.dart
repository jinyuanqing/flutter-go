import 'package:flutter/material.dart';
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
// import 'package:flutter_gf_view/admin/%E7%BD%91%E7%AB%99%E4%BF%A1%E6%81%AF.dart';
// import './left_menu/pages/站点域名.dart';
// import './left_menu/pages/站点名称.dart';
// import './left_menu/pages/上传设置.dart';

// import './left_menu/pages/文件存储.dart';
// import './left_menu/pages/用户信息.dart';
import '/admin/left_menu/pages/shou_ye.dart';
// import '中间tab.dart';
// import '网站信息.dart';
import 'admin/left_menu/pages/zhandianyuming.dart';
import '/admin/left_menu/pages/zhandianmingcheng.dart';
import '/admin/left_menu/pages/gongnengshezhi.dart';
import '/admin/left_menu/pages/文件存储.dart';
import '/admin/left_menu/pages/yonghuxinxi.dart';
import '/admin/left_menu/pages/wenzhangfabu.dart';
import '/admin/left_menu/pages/zhaopinfabu.dart';
import '/admin/left_menu/pages/wenzhangguanli.dart';
import '/admin/left_menu/pages/seo.dart';
import '/admin/left_menu/pages/zhaopinguanli.dart';
import '/admin/left_menu/pages/gerenzhongxin.dart';

import 'user/UserGather.dart';
import 'user/gongsijianjie/Jianjie.dart';
import 'user/zhaopin/zhaopingangwei.dart';
import 'user/wenzhang/Wenzhangfenlei.dart';
import '/admin/left_menu/pages/quanxianguanli.dart';

int connectTimeout0 = 10000;
List<List<String>> caidan_class_admin_1_2=[];//后台有权限的菜单类名
List<List<String>> caidan_url_admin_1_2 =
    [];//存放后台有权限菜单的url.与caidan_admin_1_2有权限的菜单名相对应
List<List<String>> caidan_admin_1_2 =
    []; //后台登陆时获取,只包含数据库菜单的名称,显示在左侧1级菜单和2级菜单的列表.第一个元素是一级菜单名,后边的是二级菜单名 [[网站信息,  站点名称], [系统设置, 上传设置, 文件存储], [用户管理, 用户信息], [后台设置, 后台设置1]],,如果是三级菜单实例[   [A1,[A2],[A2,A3],]], ]
List<dynamic> caidan_admin =[]; //后台登陆时获取.包含数据库菜单的所有项
//前台菜单的涉及的2个重要变量.用户后台登录之后通过api获取前台菜单名放入caidan_user_1_2中,形如[[网站信息,  站点名称], [系统设置, 上传设置, 文件存储]]与存放的后台菜单一样.其中第0个索引为一级菜单,其余为二级菜单.
//接着根据菜单名称,通过变量menu_user_class来获取页面对象.这里的menu_user_class需要提前进行定义好.
List<List<String>> caidan_user_1_2 =
    []; //后台登陆时获取,包含左侧1级菜单和2级菜单的列表.第一个元素是一级菜单名,后边的是二级菜单名 [[网站信息,  站点名称], [系统设置, 上传设置, 文件存储], [用户管理, 用户信息], [后台设置, 后台设置1]],,如果是三级菜单实例[   [A1,[A2],[A2,A3],]], ]
// Map<String, Widget> menu_user_class = {
//   //<菜单名,菜单页面对象>
//   //用户登录后,会读取菜单表获取后台有权限的菜单名和菜单url.把菜单url进行用户权限表进行验证哪些菜单名可以访问,
// //然后查询url对应的菜单名,保存菜单名.然后菜单名查询此menu_admin_class获得菜单对应的页面.
// "首页": UserGather(),
//   "文章": Wenzhangfenlei(),
//   "招聘": Zhaopingangwei(),
//   "关于": Jianjie(),
// };

dynamic menuuser;

List<bool> isexpand = []; //控制左侧的菜单伸缩,方便对各个控件使用的变量进行一个变量名管理.长度为0,使用add进行添加元素
String token = ""; //存放token
String url1 = 'http://127.0.0.1:8199/'; //服务器后台地址
bool islogin = false;
String username = "未登录"; //用户名
String current_menu_user = "首页"; //当前的前台点击的菜单.用于根据不同菜单做出不同的处理
String touxiang = ""; //头像
Map<dynamic, dynamic> map_gangwei = {}; //{id,岗位名}
List<String> fenlei = ["选择"]; //招聘分类{软件,硬件}
List<dynamic> article_fenlei_name_id = [];
List<dynamic> gangwei_fenlei = [
  //列表的列表集合.第一个项为分类,其余为岗位.//这里有个问题就是这个列表必须有2个空列表,否则首次渲染时,navigation_rail菜单会有个报错,提示菜单项少于2项
]; //{[软件,c开发],[硬件,plc]}




Map<String, int> maps0caidan0index = {"首页": 0}; //保存生成tab菜单和索引的map键值对
Map<String, String> map0api = {
  //api接口列表.后台修改了接口这里也要跟着变化
  "登录": url1 + "admin/admin_api_signin",
  "退出": url1 + "admin/admin_api_logout",
  "获取文章": url1 + "admin/admin_get_article", //根据分类id或者页数,获取文章
  "获取后台有权限的菜单": url1 + "admin/admin_menu", 
   "获取后台所有菜单不分权限": url1 + "admin/admin_all_menu", 
  "获取前台菜单": url1 + "user/get_user_menu",
  "修改后台菜单": url1 + "admin/admin_modify_menu",
"获取角色user的权限":url1 + "admin/get_user_authority",
"增加或减少角色权限":url1 + "admin/set_user_authority",

 "删除指定id后台菜单": url1 + "admin/admin_delete_menu_according_to_id",
  "获取指定id后台菜单": url1 + "admin/admin_get_menu_according_to_id",
  "根据分页获取用户": url1 + "user/get_user_accordto_page",
    "获取用户数量": url1 + "user/get_alluser_num",
  "更新用户信息": url1 + "admin/admin_update_user",
  "获取指定用户信息": url1 + "admin/admin_get_user",
  "根据用户名获取用户信息": url1 + "admin/admin_get_userinfo",
  "获取全部文章数量": url1 + "admin/admin_get_article_num",
  "获取所有文章含数量": url1 + "admin/admin_get_all_article",
  "设置文章分类": url1 + "admin/admin_set_article_fenlei",
  "上传文章": url1 + "admin/upload8article",
  "获取文章分类": url1 + "user/user_huo_qu_fen_lei",
  "据条件获取文章": url1 + "user/user_get_article",
  "指定条件获取文章":url1 + "admin/admin_query_article", //用于预览(根据文章id,分类,用户名)或者搜素.无token也可以浏览
  "用户注册": url1 + "user/zhuce",
  "更新修改文章": url1 + "admin/update_article", //
  "修改文章置顶精华": url1 + "admin/update_article_zhiding_jinghua",
  "招聘信息发布": url1 + "rencaizhaopin/fa_bu",
  "招聘信息搜索": url1 + "rencaizhaopin/query_job", //搜素招聘信息
  "招聘信息更改": url1 + "rencaizhaopin/zhaopin_update",
  "获取招聘岗位": url1 + "rencaizhaopin/get_gangwei",
  "获取岗位分类和岗位细分": url1 + "rencaizhaopin/get_fenlei_gangweixifen",
  "设置岗位分类和岗位细分": url1 + "rencaizhaopin/set_fenlei_gangweixifen",
  "获取系统时间并发送邮件": url1 + "xitong/get_time",
  "注册链接是否超时": url1 + "xitong/compare_tijiao",
  "更新文章阅读数": url1 + "admin/update_article_yuedushu",
  "更新文章点赞数": url1 + "admin/update_article_dianzanshu",
  "获取公司信息": url1 + "rencaizhaopin/get_gongsi",
  "用户token是否存在": url1 +"xitong/test_user_token",
    "插入后台菜单": url1 +"admin/admin_insert_menu",
     "据用户id删除用户": url1 +"admin/admin_delete_user",
}; //保存生成tab菜单和索引的map键值对

// List tabsname_admin = [//前台用户菜单
// "首页",
// "技术分享",
// "产品展示",
// "人才招聘",
// "公司简介",
// "联系我们",
// "人才招聘",
// "图片",

// ];

//调用方式:3
//  调用函数,在build中定义 Model1 model1 = context.watch<Model1>();然后在需要的位置写  model1.change_qianming("签名"));要引入provider
//读取变量时,context.watch<Model1>().qianming

//在初始化initstate中或者在组件的事件中使用provider的context.watch报错的解决: Provider.of<Model1>(context, listen: false).shaixuan(article_list);
class Model1 with ChangeNotifier, DiagnosticableTreeMixin {
  String qianming = ""; //签名
  String nickname = ""; //昵称
 
  List tabsname_user = [//暂时无用,动态添加菜单时可能有用
    //前台用户菜单
    "首页1",
 
  ];

  List<Widget> tabs_user_page = [//暂时无用,动态添加菜单时可能有用
    //前端菜单对应的页面
    //后台首页进入后,显示的tab菜单内容.退出后admin_index中清空所有变量里进行了重新清空操作
    // User_index(),

    Zhaopingangwei(),
    Wenzhangfenlei(),
    Jianjie(),
 
  ];

  List<String> tabsname_admin = [
    //后台首页进入后,显示的tab组件的菜单名称.应该称为tab_name

    "首页",
  ];

  List<Widget> tabs_admin_page = [
    //后台首页进入后,显示的tab组件菜单内容.退出后admin_index中清空所有变量里进行了重新清空操作
    ShouYe(),
  ];

  int a1 = 0;
  int get a2 => a1;
  bool isloginon = false;

  List<dynamic> article_list = [];

List<dynamic>   article_list1= [];
  void get_article(List<dynamic> article_list2) {
    //修改签名
    //  调用函数,在build中定义 Model1 model1 = context.watch<Model1>();然后在需要的位置写  model1.change_qianming("签名"));要引入provider
    //读取变量时,context.watch<Model1>().qianming
    article_list1 = article_list2;

    notifyListeners();

     
  }


  void shaixuan(List<dynamic> article_list1) {
    //修改签名
    //  调用函数,在build中定义 Model1 model1 = context.watch<Model1>();然后在需要的位置写  model1.change_qianming("签名"));要引入provider
    //读取变量时,context.watch<Model1>().qianming
    article_list = article_list1;

    notifyListeners();

    //print(a1);//
  }

  void change_qianming(String qianming1) {
  
    qianming = qianming1;

    notifyListeners();

    //print(a1);//
  }

  void change_nickname(String nickname1) {
  
    nickname = nickname1;

    notifyListeners();

    //print(a1);//
  }

  void change_isloginon(bool bool1) {
    // if (!tabsname_admin.contains(value)) //包含value则返回真,不包含的情况下添加
    isloginon = bool1;

    notifyListeners();

    //print(a1);//
  }

  void change_caidan_admin(String caidan0name, Widget page) {
    //增加一个后台tab组件的选项卡为当前点击的菜单
    // if (!tabsname_admin.contains(value)) //包含value则返回真,不包含的情况下添加
    {
      tabsname_admin.add(caidan0name); //tab控件头部数组
      print("change_caidan_admin");
      // a1 = a1 + 1;
      tabs_admin_page.add(page);
      notifyListeners();
    }
    //print(a1);//
  }

  void delete_tab_caidan_admin(int tabindex) {
    //为当前点击tab选项卡时,删除一个后台tab组件的选项卡
    //移除tab项
    // if (!tabsname_admin.contains(tabname)) //包含value则返回真,不包含的情况下添加
    // {
    //   for (var i = 0; i < tabsname_admin.length - 1; i++) {
    //     if (tabsname_admin[i] == tabname) {
    //       print(tabsname_admin[i]);
    print("delete_tab_caidan_admin");
    tabsname_admin.removeAt(tabindex); //tab控件头部数组
    tabs_admin_page.removeAt(tabindex);
    //   }
    // }

    notifyListeners();
  }

  List get_tabsname_admin() {
    //H获取后台tabs当前打开的选项卡
    // tabsname_admin.add(value);
    //  notifyListeners();
    return tabsname_admin;
  }

  void change_caidan_user(String caidan0name, Widget page) {
    //增加前台菜单
    // if (!tabsname_admin.contains(value)) //包含value则返回真,不包含的情况下添加
    {
      tabsname_user.add(caidan0name); //tab控件头部数组
      print("change_caidan_admin");
      //  a1 =  a1 + 1;
      tabs_user_page.add(page);
      notifyListeners();
    }
    //print(a1);//
  }

  void delete_tabsname_user(int tabindex) {
    //前台菜单删除
    //移除tab项
    // if (!tabsname_admin.contains(tabname)) //包含value则返回真,不包含的情况下添加
    // {
    //   for (var i = 0; i < tabsname_admin.length - 1; i++) {
    //     if (tabsname_admin[i] == tabname) {
    //       print(tabsname_admin[i]);
    print("删除用户菜单");
    tabsname_user.removeAt(tabindex); //tab控件头部数组
    tabs_user_page.removeAt(tabindex);
    //   }
    // }

    notifyListeners();
  }

  List get_usermenu() {
    //获取前端tabs菜单

    return tabsname_user;
  }

  void change_caidan_admin_page(Widget value) {
    tabs_admin_page.add(value);
    print(change_caidan_admin_page);
    notifyListeners();
  }
}
