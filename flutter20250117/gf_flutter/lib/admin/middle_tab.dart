import 'package:flutter/material.dart';
import 'package:flutter_gf_view/admin/left_menu/pages/wenzhangfabu.dart';

import '../model1.dart';
import 'package:provider/provider.dart';
import '/quan_ju.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  // Tab1(this. tab11);
  // final TabController tab11;

  @override
  _tabsname_admintate createState() => _tabsname_admintate();
}

late TabController tabController1;//在left_menu中进行了设置.
PageController pageController = PageController();

class _tabsname_admintate extends State<Tab1>
    with TickerProviderStateMixin //, AutomaticKeepAliveClientMixin
{
  ////状态保持1
  // TextEditingController? control1 = TextEditingController();

  // @override
  // bool get wantKeepAlive => true; //状态保持2
  @override
  void initState() {
    super.initState();
    print('tab初始化了');
    // // 创建Controller,需要类后添加 with TickerProviderStateMixin
    //  tabController1 = TabController(
    //     length: context.read<Model1>().tabsname_admin.length, vsync:ScrollableState()); //vsync: ScrollableState()

    tabController1 = TabController(
        length: context.read<Model1>().tabsname_admin.length,
        vsync: this); //vsync: ScrollableState()

    // tabController1.index = 0; //设置默认菜单索引
    tabController1.index = context.read<Model1>().tabsname_admin.length - 1; //设置默认菜单索引
    // tabController1.addListener(() {
    //   //给控制器增加菜单的切换监听事件
    //   //print("菜单按下了${tabController1.index}");
    //   switch (tabController1.index) {
    //     case 0:
    //       tabController1.index = 0;
    //       print(0);
    //       break;

    //     case 1:
    //       print(1);
    //       tabController1.index = 1;
    //       break;
    //     case 2:
    //       print(2);
    //       tabController1.index = 2;
    //       break;
    //   }
    // });
  }

  // @override
  // void didChangeDependencies() {
  //   print("didChangeDependencies");
  // }

  @override
  void dispose() {
    super.dispose();
    tabController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    // print(MediaQuery.of(context).size.width);
    Model1 model = context.watch<Model1>();
    print("选项卡刷新了");
    // tabController1 =
    //     TabController(initialIndex: context.read<Model1>().tabsname_admin.length>1? 1:0 ,length: context.read<Model1>().tabsname_admin.length, vsync: this);
    // tabController1.index = context.read<Model1>().tabsname_admin.length - 1; //设置默认菜单索引
    // // tabController1.animateTo(0);
    // tabController1.animateTo(tabController1.index);
    // print(model.tabsname_admin);

    return MaterialApp(
        //专门用于日期选择器的显示,否则会报错,开始
        localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //此处
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
        ),
        home: Scaffold(
            body: ////专门用于日期选择器的显示,否则会报错.结束

                Container(
                    child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Consumer<Model1>(builder: (context, model1, child) {
            //   return
            Column(children: <Widget>[
              TabBar(
                // key: Key("2"),
                //生成Tab菜单
                controller: tabController1,
                //  tabsname_admin: context.read<Model1>().tabsname_admin,//错误的写法,直接赋给list<widget>是不对的
                onTap: (index) {
                  // print("tab切换");
                  // print(index);
                  pageController.jumpToPage(index);
                },
                tabs: model.tabsname_admin
                    .map((e) => Tab(
                          child: //e为tabsname_admin的map每一个项

                              Row(
                            children: <Widget>[
                              Text(e),
                              //如果e==首页是不能删除操作,用contrain占位
                              e == "首页"
                                  ? Container()
                                  : IconButton(
                                      splashRadius: 9, //决定了图标按钮悬浮的阴影面积半径
                                      iconSize: 30,
                                      padding:
                                          const EdgeInsets.only(right: 0.0),
                                      onPressed: () {
                                        //  print(e);
                                        print("maps0caidan0index");

                                        model.delete_tab_caidan_admin(
                                            model.tabsname_admin.indexOf(e));
                                        tabController1 = TabController(
                                            length: model.tabsname_admin.length,
                                            vsync:
                                                this); //点击关闭tab标签后,要重新建立tab控制器,否则不显示tab控件了
                                        maps0caidan0index.remove(
                                            e); //tab的相关菜单和视图处理完抽,才能在菜单索引map中移除相应的键值 //vsync: ScrollableState()
                                        //maps0caidan0index经过删除后,其中的菜单名称,菜单索引,会出现不按递增顺序排列的情况.所以需要把其中的索引值改成0-9递增
                                        for (int i = 0;
                                            i < maps0caidan0index.length;
                                            i++) {
                                          maps0caidan0index[maps0caidan0index
                                                  .keys
                                                  .toList()[i]] =
                                              i; //maps0caidan0index.keys.toList() [i]为map的所有key的list.
                                        }

                                        pageController.jumpToPage(
                                            model.tabsname_admin.length); //pageview视图跳转
                                        tabController1.index =
                                            model.tabsname_admin.length - 1; //tabbar的索引调整
                                      },
                                      
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    )
                              // ),
                            ],
                          ),
                        ))
                    .toList(),
                isScrollable: true,
                labelColor: Colors.white, //选中的颜色
                indicatorColor: Colors.black, //指示器颜色,下划线色
                unselectedLabelColor: Colors.blue, //未选中颜色
                unselectedLabelStyle: new TextStyle(
                  //未选中的颜色
                  fontSize: 25,
                  // color: Colors.white,//与属性一致unselectedLabelColor
                  //  backgroundColor: Colors.grey[200]
                ),
                labelStyle: new TextStyle(
                  //选中的颜色
                  fontSize: 20,
                  color: Colors.green, //与属性一致unselectedLabelColor
                  backgroundColor: Colors.black,
                ),
                // indicatorSize:TabBarIndicatorSize.tab,
              ),
              Container(
                  // width: 使用了flex比例布局,占比为8/9,但是不设置宽度就会自适应了.
                  // width: MediaQuery.of(context).size.width*8/9,
                  height: MediaQuery.of(context).size.height - size_appbar - 50,
                  child: // Text("12")
                      //     TabBarView(
                      //   controller: tabController1, //_pageController,
                      //   children: List<Widget>.generate(
                      //       context.read<Model1>().tabsname_admin.length, (int i) {
                      //       print("i");  print(i);
                      //     return //KeyedSubtree
                      //         (
                      //             // child:
                      //             context.read<Model1>().tabs_admin_page[i] //,
                      //         // key: Key('${i}')
                      //         );
                      //   }),
                      // )
                      PageView(
                    // onPageChanged: (index) {
                    // print("onPageChanged");   print(index);
                    //   tabController1.animateTo(index);
                    // },
                    controller: pageController,
                    children: List<Widget>.generate(model.tabsname_admin.length, (int i) {
                      return //KeyedSubtree(
                          // child:
                          model.tabs_admin_page[i]; //,
                      //key: Key('${i}'));
                    }),
                  ))
            ])
            //}),
          ],
        ))));
  }

  // addPostFrameCallback(Null Function(dynamic timeStamp) param0) {}
}

int count = 0;
int count1 = 0;

class ChinesePage extends StatefulWidget {
  List list;
  ChinesePage(this.list);
  @override
  _ChinesePageState createState() => _ChinesePageState();
}

class _ChinesePageState extends State<ChinesePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (build, index) {
              return Container(
                  padding: EdgeInsets.only(top: 150),
                  child: Text("${widget.list[index]} ----- $index"));
            }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class EnglisthPage extends StatefulWidget {
  @override
  _EnglisthPageState createState() => _EnglisthPageState();
}

class _EnglisthPageState extends State<EnglisthPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemBuilder: (build, index) {
      return Text("en --- $index");
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MathPage extends StatefulWidget {
//  String title;
//  MathPage(this.title);
  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemBuilder: (build, index) {
      return Text("math --- $index");
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
