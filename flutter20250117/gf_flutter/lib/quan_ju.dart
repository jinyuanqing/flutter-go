import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
//前台菜单的图标
   List<  IconData?> font_menu_icon =[Icons.api,Icons.anchor,
   Icons.ballot,Icons.bathroom,Icons.bedroom_baby,Icons.blinds];  

const String zhan_dian_ming_cheng = "公司名称"; //公司名称

const String websitename = "资讯管理系统后台"; //站点名称

int screen_size = 1000;
double size_appbar = 100.0;
double size_web_menu_height =
    50.0; //web浏览器的菜单栏地址栏的高度.后台获取高度后要减去地址栏高度和flutter的菜单栏高度
MaterialColor primary =   Colors.blue;
// MaterialColor primary =   Colors.lightBlue; //后台主题色 ,必须是Colors.引用且返回为materialcolor的颜色才行
MaterialColor user_color = Colors.red; //前台主题
Color yemian_beijingse = Color.fromARGB(255, 204, 204, 204);
 Color table_col_header_color= Color.fromARGB(224, 232, 230, 230);
MaterialColor height_light =   Colors.red;//前台招聘筛选部件高亮用
class Global {
  // 单例
  static Global instance = Global();
  // 屏幕信息
 
  static double screenWidth = 500;
  

  

}