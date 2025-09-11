import 'package:flutter/material.dart';

class AppConfig {
  // 应用配置
  static String appTitle = '自适应卡片网格';
  static String appBarTitle = '自适应卡片网格 (最小宽度150)';
  static Color primaryColor = Colors.orange;
  static CardThemeData cardTheme = CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // 动画效果参数
  static double deviationRatio = 0.9; // 轨迹的偏移比例
  static int particleCount = 30; // 粒子数量
  static List<double> shadow = [20.2]; // 阴影参数
 
  // 文章数据
  static const List<Map<String, dynamic>> articleList = [
    {
      "biaoti": "今日起这将是一个崭新的篇章佛挡杀佛四大分卫四大分卫二位!",
      "suoluetu": "https://picsum.photos/400/300",
      "id": 1,
      "content": "我是内容",
      "updated_at": "2024-01-01",
      "zuozhe": "游学",
      "dianzanshu": 9999,
      "yuedushu": 9999,
      "zhaiyao": "轨迹的偏移比例,是轨迹更圆一些,还是更扁一些.轨迹的偏移比例,是轨迹更圆一些,还是更扁一些",
    }
  ];

  // 文本内容
  static String welcomeText = '欢迎来到游学社区,这里是一个专注于交流的社区,让您不再发愁推广宣传!!';
  static String domainText = '记住我们域名yxzhw.cn,bps.wang,yay.wang';
  static String latestText = '最新';
  static String entryText = '入驻';
  static String latestEntryText = '最新入驻';
  static String todayText = '今日';
  static String openServerText = '开区';
  static String serverInfoText = '文字卡片,区服名称,开服时间';
  static String promotionText = '让您不再发愁推广宣传!!';
  static String excellentText = '优秀';
  static String recommendText = '推荐';
  static String publishText = '发布';
  static String stationText = '站内';
  static String selectedText = '精选';
  static String allText = '全部';
  static String serverText = '区服';

  // 图片资源
  static String bannerImage = 'https://picsum.photos/1920/600';
  static List<String> bannerImages = [
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
    'https://picsum.photos/400/300',
  ];
  static String exampleImage = 'https://picsum.photos/420/400';

  // 从后台更新配置的方法
  static void updateConfig(Map<String, dynamic> newConfig) {
    // 更新应用配置
    if (newConfig.containsKey('appTitle')) appTitle = newConfig['appTitle'];
    if (newConfig.containsKey('appBarTitle')) appBarTitle = newConfig['appBarTitle'];
    if (newConfig.containsKey('primaryColor')) {
      primaryColor = Color(int.parse(newConfig['primaryColor'].replaceAll('#', '0xFF')));
    }

    // 更新动画效果参数
    if (newConfig.containsKey('deviationRatio')) deviationRatio = newConfig['deviationRatio'];
    if (newConfig.containsKey('particleCount')) particleCount = newConfig['particleCount'];
    if (newConfig.containsKey('shadow')) shadow = List<double>.from(newConfig['shadow']);

    // 更新文章数据
// 移除 articleList 变量的 const 修饰符后，以下代码可正常运行
// 需先在类定义处将 static const List<Map<String, dynamic>> articleList 修改为 static List<Map<String, dynamic>> articleList
   // if (newConfig.containsKey('articleList')) articleList = List<Map<String, dynamic>>.from(newConfig['articleList']);

    // 更新文本内容
    if (newConfig.containsKey('welcomeText')) welcomeText = newConfig['welcomeText'];
    if (newConfig.containsKey('domainText')) domainText = newConfig['domainText'];
    if (newConfig.containsKey('latestText')) latestText = newConfig['latestText'];
    if (newConfig.containsKey('entryText')) entryText = newConfig['entryText'];
    if (newConfig.containsKey('latestEntryText')) latestEntryText = newConfig['latestEntryText'];
    if (newConfig.containsKey('todayText')) todayText = newConfig['todayText'];
    if (newConfig.containsKey('openServerText')) openServerText = newConfig['openServerText'];
    if (newConfig.containsKey('serverInfoText')) serverInfoText = newConfig['serverInfoText'];
    if (newConfig.containsKey('promotionText')) promotionText = newConfig['promotionText'];
    if (newConfig.containsKey('excellentText')) excellentText = newConfig['excellentText'];
    if (newConfig.containsKey('recommendText')) recommendText = newConfig['recommendText'];
    if (newConfig.containsKey('publishText')) publishText = newConfig['publishText'];
    if (newConfig.containsKey('stationText')) stationText = newConfig['stationText'];
    if (newConfig.containsKey('selectedText')) selectedText = newConfig['selectedText'];
    if (newConfig.containsKey('allText')) allText = newConfig['allText'];
    if (newConfig.containsKey('serverText')) serverText = newConfig['serverText'];

    // 更新图片资源
    if (newConfig.containsKey('bannerImage')) bannerImage = newConfig['bannerImage'];
    if (newConfig.containsKey('bannerImages')) bannerImages = List<String>.from(newConfig['bannerImages']);
    if (newConfig.containsKey('exampleImage')) exampleImage = newConfig['exampleImage'];
  }
}