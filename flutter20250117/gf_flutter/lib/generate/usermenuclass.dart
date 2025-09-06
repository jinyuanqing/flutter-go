 /* 这时系统生成的前台菜单与widget类之间对应关系的文件.存放在map中.使用时把此文件内容覆盖到文件/lib/generate/usermenuclass.dart中. 
增加前台菜单时的步骤:
1.项目源码中建立目录和菜单类.目录名统一为菜单文件的类名,2者保持一致.
2.数据库user_menu表中user_menu_url参数为目录名.如/user/UserGather,此目录名作为生成文件的import包路径,同时user_menu_url参数用斜杠/分割的最后一部分就是菜单页面对应的类名.
3.生成的代码中不区分一级菜单还是二级菜单.虽然数据库中有菜单的层级关系,但是生成的代码未作处理. 
 
 */
import 'package:flutter/material.dart';
import '/user/UserGather.dart';
  import '/user/wenzhang/Wenzhangfenlei.dart';
  // import '/user/zixun.dart';
  // import '/user/jishu.dart';
  import '/user/zhaopin/Zhaopingangwei.dart';
  import '/user/gongsijianjie/Jianjie.dart';
  // import '/user/tupian.dart';
  // import '/user/chanpin.dart';
   Map<String,Widget>menu_user_class={
"首页":UserGather(),
"文章":Wenzhangfenlei(),
// "资讯":zixun(),
// "技术":jishu(),
"招聘":Zhaopingangwei(),
"关于":Jianjie(),
// "图片":tupian(),
// "产品":chanpin(),
    };