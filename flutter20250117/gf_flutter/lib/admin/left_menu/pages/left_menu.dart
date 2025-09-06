import 'package:flutter/material.dart';

// import 'package:flutter_gf_view/admin/网站信息.dart';
import '../../middle_tab.dart'; //引用tabcontroll1
import '../../../model1.dart';
import 'package:provider/provider.dart';

import "package:flutter_gf_view/quan_ju.dart"; //或者import '../quan_ju.dart';
import 'package:lpinyin/lpinyin.dart';
import '/config/menu.dart';

//抽屉窗口
class zuo_ce_cai_dan extends StatefulWidget {
  ////
  @override
  _zuo_ce_cai_danState createState() => _zuo_ce_cai_danState();
}

class _zuo_ce_cai_danState extends State<zuo_ce_cai_dan>
    with TickerProviderStateMixin {
  // bool _isExpanded = false;
  @override
  void initstate() {
    super.initState();
    print("left菜单初始化");
  }

  @override
  Widget build(BuildContext context) {
    Model1 model = context.watch<Model1>();
    print("左侧菜单刷新了");
    // print("caidan_admin_1_2");
    // print(caidan_admin_1_2);

    // print("model.tabsname_admin");
    // print(model.tabsname_admin);
 print(isexpand);
    return Container(
      // color: primary,
      width: 300,
 
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(caidan_admin_1_2.length, (int i) {
          //一级菜单
          return ExpansionPanelList(
            //系统设置
            // 点击折叠按钮实现面板的伸缩
            expansionCallback: (int panelIndex, bool isExpanded) {
                 
        
            // print(isexpand); 
            setState(() {
               isexpand[i] = isExpanded;
                 
            
              });

     
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    // alignment: Alignment.center,//加上后文本按钮会在中间，而非铺满空间
                    color: Color(0xfff0f0f0),
                    padding: EdgeInsets.all(0.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isexpand[i] = !isExpanded;
                        });
                      },
                      child: Text(
                        caidan_admin_1_2[i][0],
                        //style: Theme.of(context).textTheme.bodyText1,
                        style: new TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          //  backgroundColor: Colors.grey[200]
                        ),
                      ),
                    ),
                  );
                },
                body: Container(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.all(6.0),
                    width: double.infinity,
                    child: Column(
                        children: List<Widget>.generate(caidan_admin_1_2[i].length - 1,
                            (int i1) {
                      //二级菜单
                      return TextButton(
                        onPressed: () {
                          print("左侧菜单按下");

                          print(menu_admin_class);
                          if (!maps0caidan0index.keys
                              .contains(caidan_admin_1_2[i][i1 + 1])) {
                            //当前菜单不存在时,添加tab中显示
                            maps0caidan0index[caidan_admin_1_2[i][i1 + 1]] =
                                model.tabsname_admin.length;

                            model.change_caidan_admin(
                                caidan_admin_1_2[i][i1 + 1],
                                menu_admin_class[caidan_admin_1_2[i]
                                   [i1 + 1]]!
                                    //caidan_class_admin_1_2[5][1]
                                    ); //参数为(caidan_admin_1_2)菜单名称,菜单类
                            tabController1.dispose();

                            tabController1 = TabController(
                                length: model.tabsname_admin.length, vsync: this);
                            pageController.jumpToPage(model.tabsname_admin.length - 1);
                            tabController1.index = model.tabsname_admin.length -
                                1; //设置默认tab菜单索引,默认新打开的最后一个tab菜单高亮,关联的tab页也同时显示出来
                            //    print(   tabController1.index);//设置默认菜单索引

                            //   Future.delayed(Duration(milliseconds: 0), () {//延时处理ms
                            //    // print(   tabController1.index);

                            //      pageController.jumpToPage(
                            //        model.tabsname_admin.length - 1
                            //        );
                            //      tabController1.index =
                            //        model.tabsname_admin.length - 1;
                            //       print(   tabController1.index);//设置默认菜单索引

                            //  });
                          } else {
                            //已经存在了的菜单,则以点击菜单的名字[caidan_admin_1_2]为maps0caidan0index的参数获取后台有权限的菜单的索引
                            tabController1.index = maps0caidan0index[caidan_admin_1_2[i]
                                [i1 + 1]]!; //maps0caidan0index为菜单名字,菜单位置索引的map
                            pageController.jumpToPage(tabController1.index);
                          }
                        },
                        child: Text(caidan_admin_1_2[i][i1 + 1]),
                      );
                    }))),
                isExpanded: isexpand[i], // 设置面板的状态，true展开，false折叠
              ),
            ],
          );
        }),
      ),
    );
  }
}
