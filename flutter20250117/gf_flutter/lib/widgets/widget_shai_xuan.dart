import 'package:flutter/material.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:provider/provider.dart';
import '/widgets/http.dart';
 
import 'package:flutter_gf_view/model1.dart';

class Widget_shai_xuan extends StatefulWidget {
  final List<List<String>> list_text;
  List<List<int>> list_currenttext_index = [];
  List<List<bool>> list_current_isshow = [];
  List<List<String>> list_currenttext = [];
  final List<String> text;
  final String gangwei_id;
  Widget_shai_xuan({
    Key? key,
    required this.gangwei_id,
    required this.list_text, //按钮list的文本,如[[1,2,3],[1,2,3]   ]
    required this.text, //当前选中的按钮list的文本
    // required this.list_currenttext_index, //按钮list的文本, 单独按钮的当前选中文本索引
    // required this.list_current_isshow, //按钮list中, 当前选中的按钮是否显示在筛选行中  默认为[假,假]
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _shai_xuanState();
  }
}

class _shai_xuanState extends State<Widget_shai_xuan> {
  List<List<String>> zhiweiwenben = [[]];
  List<List<bool>> list_current_isshow = [[]];
  List<List<int>> dangqiansuoyin_zhiwei = [[]];
  List<List<String>> dangqianwenben_zhiwei = [[]];
  late List<String> text;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = widget.text;
    // list_current_isshow = widget.list_current_isshow;
    zhiweiwenben = widget.list_text;
    // dangqiansuoyin_zhiwei = widget.list_currenttext_index;
    // widget.list_currenttext_index.add([0]);
    print("widget.list_text.length");
    print(widget.list_text.length);
    for (int i = 0; i < widget.list_text.length; i++) {
      widget.list_currenttext_index.add(([0])); //    .结果[[0],[0],[0]]
    }
    dangqiansuoyin_zhiwei = widget.list_currenttext_index;
    print(dangqiansuoyin_zhiwei);
    // widget.list_currenttext =List .generate( widget.list_text.length,(int index)=>     [ ]  );//生成3个长度的空[],实现二维列表赋值,list_currenttext是list(list)因此内容是空列表.结果[["无限"],["无限"],["无限"]]
    for (int i = 0; i < widget.list_text.length; i++) {
      //方法1给二维列表增加值add方法,下标赋值不行.配合widget.list_currenttext =List .generate( widget.list_text.length,(int index)=>     [ ]  );使用
      // widget.list_currenttext[i].add(    widget.list_text[i][0]  );
      //方法2给二维列表增加值
      widget.list_currenttext.add([widget.list_text[i][0]]);
    }
    dangqianwenben_zhiwei = widget.list_currenttext;
    print(dangqianwenben_zhiwei);

    //  widget.list_current_isshow=List.filled( widget.list_text.length , [false]);// widget.list_current_isshow[[false],[false]]
//方法3,二维列表赋值使用add.这种赋值操作有个问题,filled后,对list的使用add或者[0]=x时,则列表的几个值都会改变.因此这种方法有问题
    widget.list_current_isshow = List.generate(
        widget.list_text.length, (int index) => []); ////生成3个长度的空[],实现二维列表赋值,
    for (int i = 0; i < widget.list_text.length; i++) {
      widget.list_current_isshow[i]
          .add(false); //必须给list_current_isshow赋初值和长度,否则报错
    }
    list_current_isshow = widget.list_current_isshow;
    print(list_current_isshow);
  }

  @override
  Widget build(BuildContext context) {
    Model1 model1 = context.watch<Model1>();
    print("筛选组件build");
    return StatefulBuilder(//局部刷新控件,builder中return返回的组件会刷新

        builder: (BuildContext context, StateSetter setState) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(zhiweiwenben.length, (index) {
                return Row(
                  //职位选择
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      //设定容器的高度之后,自动扩展的控件才会显示出来.
                      child: Container(),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        //  height: 300,
                        //给容器添加下边框宽带1
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 139, 139, 139),
                        ))),
                        //decoration: const BoxDecoration(color:Colors.lightBlueAccent),
                        child: Column(
                          // mainAxisAlignment:
                          //     MainAxisAlignment.center,
                          children: <Widget>[
                            // Text(
                            //   '物尽其用,人尽其才',
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     color: Colors.black87,
                            //     // backgroundColor: Colors.grey[200]
                            //   ),
                            // ),
                            Padding(
                                //左边添加8像素补白
                                padding:
                                    const EdgeInsets.only(top: 3), //距离顶端的高度
                                child: Wrap(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Chip(
                                          avatar: CircleAvatar(
                                           //   backgroundColor: Colors.blue,
                                              child: Text('Z')),
                                          label: Text(
                                            text[index],
                                            // style: TextStyle(
                                            //   fontSize: 15,
                                            //   color: Colors.black,
                                            //   // backgroundColor: Colors.grey[200]
                                            // ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Widget_wenben,//此部件中使用setstatey而不会刷新整个组件树
                                    //Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    // children: <Widget>[
                                    Wrap(
                                        spacing: 30.0, // 主轴(水平)方向间距
                                        runSpacing: 4.0, // 纵轴（垂直）方向间距
                                        // mainAxisSize: MainAxisSize.min,
                                        children: List<Widget>.generate(
                                            zhiweiwenben[index].length,
                                            (int i) {//i=index
                                          // print("index");
                                          // print(index);
                                          // print("i");
                                          // print(i);
                                          return Padding(
                                              //左边添加8像素补白
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        dangqiansuoyin_zhiwei[
                                                                        index]
                                                                    [0] ==
                                                                i
                                                            ? height_light
                                                            : primary)), //如果当前dangqiansuoyin_zhiwei索引=i,那么把这个按钮的颜色变浅色primary[300]
                                                child: Text(zhiweiwenben[index]
                                                    [i]), //软件
                                                //  color: color_zhiweiwenben[i],
                                                onPressed: () {
                                                
                                                  // print("当前按钮的是否显示的标记");
                                                  // print(list_current_isshow);
  
                                                  if (i != 0) {
                                                    list_current_isshow[index]
                                                        [0] = true;
                                                  } //显示筛选的控件
                                                  else {
                                                    list_current_isshow[index]
                                                        [0] = false;
                                                  }
                                                  // print("当前按钮的是否显示的标记");
                                                  // print(list_current_isshow);
                                                  dangqiansuoyin_zhiwei[index]
                                                      [0] = i;
                                                  dangqianwenben_zhiwei[index]
                                                          [0] =
                                                      zhiweiwenben[index][i];
                                                  // print("当前按钮的文本");
                                                  // print(dangqianwenben_zhiwei[
                                                  //     index][0]);
                                                  setState(() {});
                                                },
                                              ));
                                        })),
                                    //]),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                  ],
                );
              }),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      //筛选条件
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          //设定容器的高度之后,自动扩展的控件才会显示出来.
                          child: Container(
                              // height: 100, //
                              // decoration: const BoxDecoration(color: Colors.red),
                              ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              // height: 100,
                              //给容器添加下边框宽带1
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 139, 139, 139),
                              ))),
                              //decoration: const BoxDecoration(color:Colors.lightBlueAccent),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        //左边添加8像素补白
                                        padding: const EdgeInsets.only(top: 00),
                                        child: Wrap(children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Chip(
                                                avatar: new CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    child: Text('S')),
                                                label: new Text(
                                                  '筛选条件:',
                                                  style: new TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    // backgroundColor: Colors.grey[200]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                              //筛选条件
                                              spacing: 0.0, // 主轴(水平)方向间距
                                              runSpacing: 4.0, // 纵轴（垂直）方向间距
                                              children: List.generate(
                                                  zhiweiwenben.length, (index) {
                                                return Visibility(
                                                    //不显示时候,占用空间
                                                    // maintainAnimation: true,
                                                    // maintainSize: true,
                                                    // maintainState: true,
                                                    visible:
                                                        list_current_isshow[
                                                            index][0],
                                                    child: Padding(
                                                      //左边添加8像素补白
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0),
                                                      child:

                                                       Chip(backgroundColor: primary,
                          onDeleted: (){
                                setState(() {
                                                            list_current_isshow[
                                                                    index][0] =
                                                                false; //隐藏筛选的控件

                                                            dangqiansuoyin_zhiwei[
                                                                index][0] = 0;
                                                          });

                          },
                          deleteIcon: Icon(Icons.delete),
                        // avatar: CircleAvatar(
                        //     //   backgroundColor: Colors.blue,
                        //     child: Icon(Icons.add)),
                        label: TextButton(
                          child: Text(
                            dangqianwenben_zhiwei[ index][0],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              // backgroundColor: Colors.grey[200]
                            ),
                          ),
                          style: ButtonStyle(),
                          onPressed: () {
                            print("ist_fenlei[i]");
                            // 立即跳转到索引为 1 的页面

                          },
                        )),
                                                      //     ElevatedButton.icon(
                                                      //   // height: height_button,
                                                      //   label: Text(
                                                      //       dangqianwenben_zhiwei[
                                                      //           index][0]
                                                      //       // dangqianwenben_zhiwei[
                                                      //       //         index][
                                                      //       //     dangqiansuoyin_zhiwei[
                                                      //       //         index][0]]

                                                      //       ),
                                                      //   icon: Icon(Icons.close,
                                                      //       size: 15),
                                                      //   // color: color_didianwenben[
                                                      //   //     dangqiansuoyin_didian],
                                                      //   onPressed: () {
                                                      //     setState(() {
                                                      //       list_current_isshow[
                                                      //               index][0] =
                                                      //           false; //隐藏筛选的控件

                                                      //       dangqiansuoyin_zhiwei[
                                                      //           index][0] = 0;
                                                      //     });
                                                      //   },
                                                      // ),
                                                    ));
                                              })),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: IconButton(
                                                  // height: height_button,
                                                  //label: Text("筛选"),
                                              color: Colors.amber,
                                                  icon:
                                                      Icon(Icons.search_sharp),
                                                  // style: ButtonStyle(
                                                  //     backgroundColor:
                                                  //         MaterialStateProperty
                                                  //             .all(const Color.fromARGB(255, 233, 120, 112))),
                                                  onPressed: () async {
                                                    Map<String, String>
                                                        condition = {};
                                                    List<String> condition1 = [
                                                      "dizhi",
                                                      "xueli",
                                                      "quanzhi"
                                                    ];
                                                    for (var i = 0;
                                                        i < zhiweiwenben.length;
                                                        i++) {
                                                      if (list_current_isshow[i]
                                                              [0] ==
                                                          true) {
                                                        //如果当前按钮显示了,则当前的文本就是要筛选的条件

                                                        condition.addAll({
                                                          condition1[i]:
                                                              dangqianwenben_zhiwei[
                                                                  i][0]
                                                        });
                                                      }
                                                    }
                                                    print(condition);

                                                    var res = await YXHttp().http_post(
                                                        map0api["招聘信息搜索"]!, {
                                                      "token": token,
                                                      "gangwei":
                                                          widget.gangwei_id,
                                                      "dizhi":
                                                          condition["dizhi"],
                                                      "xueli":
                                                          condition["xueli"],
                                                      "quanzhi":
                                                          condition["quanzhi"],
                                                    });
                                                    print(res["num"]);
                                                    print(res["res"]);
                                                    if (res["res"] == null) {
                                                      //如果返回为空,说明未返回数据,所以此时要设置要给空list放入provider
                                                      model1.shaixuan([]);
                                                    } else
                                                      model1
                                                          .shaixuan(res["res"]);
                                                  })),
                                        ]))
                                  ])),
                          flex: 8,
                        ),
                        Expanded(
                          child: Container(
                              // height: 100,
                              // decoration: const BoxDecoration(color: Colors.blue),
                              ),
                          flex: 1,
                        ),
                      ])
                ])
          ]);
    });
  }
}
