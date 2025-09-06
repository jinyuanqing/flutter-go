// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gf_view/widgets/http.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:dio/dio.dart';
import '../../../model1.dart'; //使用根目录的方式引用
import 'dart:convert';
import '../../../widgets/sou_suo.dart'; //引入搜索组件
import 'package:intl/intl.dart'; //时间格式化
import 'package:flutter_localizations/flutter_localizations.dart'; //国际化,时间选择需要使用
import 'package:get/get.dart' as Get;
import 'package:bot_toast/bot_toast.dart';

class yonghuxinxi extends StatefulWidget {
  const yonghuxinxi({Key? key}) : super(key: key);

  @override
  _yonghuxinxiState createState() => _yonghuxinxiState();
}

List<int> delete_id = [];

class User {
  User(this.username, this.email, this.tel, this.password, this.nickname,
      this.created_at, this.updated_at, this.birthday, this.beiyong1,
      {this.selected = false});

  final String username;
  final String email;
  final String tel;
  final String password;
  final String nickname;
  final String created_at;
  final String updated_at;
  final String birthday;
  final String beiyong1;

  bool selected;
}

var dialog1_context, dialog2_context;
List<dynamic> _data = []; //请求到的用户数据集合

class _yonghuxinxiState extends State<yonghuxinxi>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // List<User> _data = [];
  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  var _sortAscending = true;
  int _rowsPerPage = 10;
  int page_all = 0;
  double _pos = 0.0, _end = 0.0;
  int page = 1; //页码数
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    print("用户信息initState");
    _scrollController1 = new ScrollController();
    all_user_num();
    get_user_accordto_page(1); //根据分页获取用户,先获取前10条数据
  }

  @override
  void dispose() {
    super.dispose();
    _data = []; //关闭页面清空这个缓存list
    print("用户信息dispose");
  }

  // ignore: non_constant_identifier_names
  void all_user_num() async {
    print(1);
    var res = await YXHttp().http_post(map0api["获取用户数量"]!, {
      "token": token,
    });
    print("res");
    print(res);
    if (res == null) {
      return;
    } else {
      page_all = res;
      print("用户数page_all");
      print(page_all);
    }
  }

  // ignore: non_constant_identifier_names
  void get_user_accordto_page(int page) async {
    //根据分页获取用户
//api调用获取用户
    //  List.generate(100, (index) {
    //     _data.add(User('老孟$index', index % 50, index % 2 == 0 ? '男' : '女'));
    //   });

    var json_str = {
      "token": token,
      "page": page,
    };

    var response = await YXHttp().http_post(map0api["根据分页获取用户"]!, json_str); //
    // print("根据分页获取用户");
    //给数据源增加select项
    for (var ele in response) {
      //给list<jsonmap>中的项添加一个键值,必须先把其中的jsonmap变成通过json.decode转成map
      // print(ele.toString());
      Map a1 = json.decode(json.encode(
          ele)); //json.encode(ele)把ele转为map类型的字符串,再经过json.decode把map字符串转为map
      a1["selected"] = false;
      _data.add(a1);
    }
//  print("_data"); print(_data);
//  get_all_user_num();
    setState(() {});
  }

  Future<void> get_user_accordto_page2() async {
//api调用获取用户
    //  List.generate(100, (index) {
    //     _data.add(User('老孟$index', index % 50, index % 2 == 0 ? '男' : '女'));
    //   });

    var json_str = {
      "token": token,
      "page": 1, //默认1
    };

    var response = await YXHttp().http_post(map0api["根据分页获取用户"]!, json_str); //
    print("请求了数据库获取全部用户");
    //给数据源增加select项
    for (var ele in response) {
      //给list<jsonmap>中的项添加一个键值,必须先把其中的jsonmap变成通过json.decode转成map
      // print(ele.toString());
      Map a1 = json.decode(json.encode(
          ele)); //json.encode(ele)把ele转为map类型的字符串,再经过json.decode把map字符串转为map
      a1["selected"] = false;
      _data.add(a1);
    }
//  print("_data"); print(_data);
    setState(() {});
    // return ;
  }

  DateTime _datetime = DateTime.now();
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    dialog1_context = context;
    dialog2_context = context;
    // print(MediaQuery.of(context).size.width); //给 Positioned 设置一个宽度即可
    // print(MediaQuery.of(context).size.height - 200);
    print("用户信息build");
    MyDataTableSource aa = MyDataTableSource(_data); //_data是数据
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200, height: 50,
                      child: SearchWidget(controller: controller), //sous搜索框
                    ),

                    Text("作者:"),
                    Container(
                        width: 100, //height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TextField(
                          controller: controller4,
                        )),
                    // StreamBuilder<dynamic>(
                    //   //局部刷新控件
                    //   stream: _streamController1.stream,
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<dynamic> snapshot) {
                    //     if (snapshot.hasData) {
                    //       dropdownValue = snapshot.data.toString();
                    //       // TODO: do something with the data
                    //       return DropdownButton<String>(
                    //           value: dropdownValue, //下拉框显示的默认文字值
                    //           items: list_zuozhe
                    //               .map<DropdownMenuItem<String>>((String value) {
                    //             return DropdownMenuItem<String>(
                    //               value: value,
                    //               child: Text(value),
                    //             );
                    //           }).toList(),
                    //           onChanged: (String? value) {
                    //             print(value);
                    //             _streamController1.sink
                    //                 .add(value); //g给streambuild添加数据
                    //             // setState(() {
                    //             //   dropdownValue = value!;
                    //             // });
                    //           });
                    //     } else if (snapshot.hasError) {
                    //       // TODO: do something with the error
                    //       return Text(snapshot.error.toString());
                    //     }
                    //     // TODO: the data is not ready, show a loading indicator
                    //     return Center(child: CircularProgressIndicator());
                    //   },
                    // ),

                    Text("发布日期:"),

                    Container(
                      width: 200, //height: 30,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextField(
                          controller: controller2,
                          decoration: InputDecoration(
                            hintText: "选择日期",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            // contentPadding: EdgeInsets.only(bottom:  / 3),
                            border: InputBorder.none,
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: IconButton(
                                  splashRadius: 15.0,
                                  icon: const Icon(
                                    Icons.date_range,
                                    size: 17,
                                  ),
                                  onPressed: () async {
                                    // var locale = Locale('zh', 'CN');
                                    //     GetX.Get.updateLocale(locale);
                                    var date = await showDatePicker(
                                      context: context,
                                      initialDate: _datetime,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2900),
                                      locale: Locale(
                                          'zh'), //需要在本页的派生的状态根控件上包裹MaterialApp,添加国际化语言支持
                                    );
                                    if (date == null) return;

                                    setState(() {
                                      print(DateFormat("yyyy-MM-dd ")
                                          .format(date)
                                          .toString());
                                      _datetime = date;
                                      controller2.text =
                                          DateFormat("yyyy-MM-dd ")
                                              .format(date)
                                              .toString(); //设置编辑框控件内容为日期
                                    });
                                  }),
                            ),
                          ),
                          onEditingComplete: () {
                            //   widget.onEditingComplete?.call(controller.text);
                          }),
                    ),
                    Container(
                      width: 200, //height: 30,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextField(
                          controller: controller3,
                          decoration: InputDecoration(
                            hintText: "选择日期",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            // contentPadding: EdgeInsets.only(bottom:  / 3),
                            border: InputBorder.none,
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: IconButton(
                                  splashRadius: 15.0,
                                  icon: const Icon(
                                    Icons.date_range,
                                    size: 17,
                                  ),
                                  onPressed: () async {
                                    // var locale = Locale('zh', 'CN');
                                    //     GetX.Get.updateLocale(locale);
                                    var date = await showDatePicker(
                                      context: context,
                                      initialDate: _datetime,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2900),
                                      locale: Locale(
                                          'zh'), //需要在本页的派生的状态根控件上包裹MaterialApp,添加国际化语言支持
                                    );
                                    if (date == null) return;

                                    setState(() {
                                      print(DateFormat("yyyy-MM-dd ")
                                          .format(date)
                                          .toString());
                                      _datetime = date;
                                      controller3.text =
                                          DateFormat("yyyy-MM-dd ")
                                              .format(date)
                                              .toString(); //设置编辑框控件内容为日期
                                    });
                                  }),
                            ),
                          ),
                          onEditingComplete: () {
                            //   widget.onEditingComplete?.call(controller.text);
                          }),
                    ),

                    ButtonBar(
                      children: [
                        ElevatedButton(
                          child: const Text('搜索'),
                          onPressed: () async {
                            // article_list = [];
                            // page = 1;
                            // is_search = true; //启用搜索标记.启用后下拉刷新决定用搜索api还是加载全部文章api
                            // print(controller.text); //标题
                            // print(dropdownValue); //作者
                            // print(controller2.text); //日期
                            // print(controller3.text); //日期
                            // search(1);

                            // data[index]["username"] = b["value1"];
                          },
                        ),
                        ElevatedButton(
                          child: const Text('清除'),
                          onPressed: () {
                            // page = 1;
                            // article_list = [];
                            // is_search = false; //关闭搜索标记
                            // get_data(1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    // width: MediaQuery.of(context)
                    //     .size
                    //     .width,
                    width: MediaQuery.of(context)
                        .size
                        .width, //有2个宽度..此位置的为宽度1.Scrollbar外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                    height: MediaQuery.of(context).size.height - 48 - 50 - 20,

                    // color: Colors.black,
                    child: GestureDetector(
                        child: Scrollbar(
                            //外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.

                            thumbVisibility:
                                true, //显示滚动条. isAlwaysShown   : true,//废弃了
                            thickness: 15, //滚动条的高度,如果此值为0,滚动条的高度0,就是隐藏了滚动条哦
                            controller: _scrollController,
                            child: SingleChildScrollView(
                                //SingleChildScrollView或者listview外层必须有固定的宽高,否则不显示.

                                //
                                // reverse:false,
                                scrollDirection: Axis.horizontal, //水平滚动
                                controller: _scrollController,
                                child:
                                    // Scrollbar(
                                    //     thumbVisibility: true,
                                    //     child:
                                    SingleChildScrollView(
                                        //嵌套的SingleChildScrollView,里层SingleChildScrollView要屏蔽Scrollbar.否则无法滚动条拖动
                                        // reverse:false,
                                        scrollDirection: Axis.vertical,
                                        controller: _scrollController1, //垂直滚动
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width +
                                              1000, ////注意这里的宽度在页面缩放到110以上时候,会遮挡部分内容.所以这里的处理要随着缩放参数增加而变大.因此,这里可以设置一个较大的宽度,防止用户缩放带来的遮挡.有2个宽度需要注意..此位置的为宽度2.Scrollbar外层的容器宽度一定要小于或等于内层的容器宽度,否则滚动条不显示.与listview一样.
                                          //width: 1600,
                                          //  height: MediaQuery.of(context).size.height - 50,
                                          child: PaginatedDataTable(
                                            sortColumnIndex: 2,
                                            // sortAscending: false,
                                            rowsPerPage: _rowsPerPage, //每页显示行数
                                            header: Text('用户列表'),
                                            actions: <Widget>[
                                              // Row(
                                              //     mainAxisAlignment: MainAxisAlignment.start,
                                              //     crossAxisAlignment: CrossAxisAlignment.start,
                                              //     children: [

                                              //        IconButton(
                                              //   icon: Icon(Icons.search),
                                              //   onPressed: () {
                                              //     _data.forEach((data) {
                                              //       //   print(data.age);
                                              //       // print(data.email);
                                              //     });
                                              //     //    daochu_excel(_data); //导出表格
                                              //   },
                                              // ),
                                              //     ]),
                                              IconButton(
                                                icon: Icon(Icons.chevron_right),
                                                tooltip: "下一页",
                                                onPressed: () {
                                                  print("page");
                                                  print(page);
                                                  int page1 = 0;
                                                  if ((page * 10) > page_all) {
                                                    print("超出数据数,所以不请求");
                                                    return;
                                                  } else {
                                                    //下一页数据量不超出总数,则加1,然后请求

                                                    page = page + 1;
                                                    get_user_accordto_page(
                                                        page);
                                                  }
                                                },
                                              ),
                                              SearchWidget(
                                                controller: controller,
                                                width: 200,
                                                height: 50,
                                              ), //sous搜索框
                                              IconButton(
                                                icon: Icon(Icons.save_sharp),
                                                onPressed: () {
                                                  _data.forEach((data) {
                                                    //   print(data.age);
                                                    // print(data.email);
                                                  });
                                                  //    daochu_excel(_data); //导出表格
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () async {
                                                  print(delete_id);

                                                  var response = await YXHttp()
                                                      .http_post(
                                                          map0api["据用户id删除用户"]!,
                                                          {
                                                        "token": token,
                                                        "Userid": delete_id
                                                      });
                                                  if (response == null) {
                                                    return;
                                                  } else {
                                                    _data = [];

                                                    await get_user_accordto_page2(); //删除后,重新根据分页获取用户
                                                    print("_data");
                                                    print(_data);
                                                    // setState(() {

                                                    // });
                                                  }
                                                },
                                              ),
                                            ],

                                            sortAscending:
                                                _sortAscending, //升序,还是降序
                                            columns: [
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('用户名'))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('昵称'))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('性别'))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text("出生日期"))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('电话'))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('邮箱')),
                                                  onSort:
                                                      (index, sortAscending) {
                                                    setState(() {
                                                      // print(sortAscending);
                                                      _sortAscending =
                                                          sortAscending;
                                                      print(sortAscending);
                                                      if (sortAscending) {
                                                        // print("2");
                                                        _data.sort((a, b) =>
                                                            a.email.compareTo(
                                                                b.email));
                                                      } else {
                                                        // print("1");
                                                        _data.sort((a, b) =>
                                                            b.email.compareTo(
                                                                a.email));
                                                      }
                                                    });
                                                  }),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 3,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('地址'))),
                                              DataColumn(label: Text("身份证号")),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text("积分"))),
                                              // DataColumn(
                                              //     label: Container(
                                              //         width: 30 * 1,
                                              //         alignment: Alignment.center,
                                              //         child: Text("签名"))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text("头像"))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('ip'))),
                                              DataColumn(
                                                  label: Container(
                                                      width: 30 * 1,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('操作'))),
                                            ],
                                            source: aa,
                                            onRowsPerPageChanged: (v) {
                                              print("为选择其中一项后回调");
                                              setState(() {
                                                _rowsPerPage = v!;
                                              });
                                            },
                                            availableRowsPerPage: [
                                              5,
                                              10,
                                              20,
                                              40
                                            ], //分页
                                            onPageChanged: (page) {
                                              print('onPageChanged:$page');

                                              // get_all_user_num();
                                            },
                                          ),
                                        )
                                        // )
                                        ))),
                        //手指按下时会触发此回调
                        onPanDown: (DragDownDetails e) {
                          //打印手指按下的位置(相对于屏幕)
                          print("用户手指按下：${e.globalPosition}");
                        },
                        //手指滑动时会触发此回调
                        onPanUpdate: (DragUpdateDetails e) {
                          //用户手指滑动时，更新偏移，重新构建
                          // print("e");
                          // print(e);
                          setState(() {
                            _pos += e.delta.dx;
                            if (_pos < 0) _pos = 0;
                            if (_pos >
                                _scrollController.position
                                    .maxScrollExtent) //pos的位置>控制器的最大滚动距离.控制器的最小滚动距离为0
                              _pos = _scrollController.position.maxScrollExtent;
                            _end += e.delta.dy;
                            // print(_scrollController.position.maxScrollExtent);
                            //   print(_scrollController.position.minScrollExtent);//
                            // print("_pos");
                            // print(_pos);
                            _scrollController.jumpTo(_pos);
                          });
                        },
                        onPanEnd: (DragEndDetails e) {
                          //打印滑动结束时在x、y轴上的速度
                          // print(e.velocity);
                          // _left = 0;
                        }))
              ],
            )
          ],
        ));
  }
}

class MyDataTableSource extends DataTableSource {
  MyDataTableSource(this.data);

  List<dynamic> data; //传递过来的数据
//定义一个controller
  TextEditingController _unameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _headphotoController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _sexController = TextEditingController();

  TextEditingController _scoreController = TextEditingController();
  TextEditingController _IDController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _signatureController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();

  int groupValue = 0;
  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    return DataRow.byIndex(
      selected: data[index]["selected"],
      index: index,
      onSelectChanged: (selected) {
        data[index]["selected"] = selected!;
        notifyListeners(); //必须有,否则无法选中行.DataTableSource就是changenotifier
        if (selected == true) {
          print("选中的数据行id:");
          print(data[index]["id"]);
          print(data[index]["username"]);

          delete_id.add(data[index]["id"]);
        }
      },
      cells: [
        DataCell(Text('${data[index]["username"]}')),
        DataCell(Text('${data[index]["nickname"]}')),
        DataCell(Text('${data[index]["sex"]}')),
        DataCell(Text('${data[index]["birthday"]}')),
        DataCell(
          Text('${data[index]["tel"]}'),
        ),
        DataCell(Text('${data[index]["email"]}'), showEditIcon: true,
            onTap: () {
          print("触摸了该列");
          // get_user_accordto_page();
          //  print(b);
          // notifyListeners();
        }),
        DataCell(Text('${data[index]["address"]}')),
        DataCell(Text('${data[index]["shenfenzheng"]}')),
        DataCell(Text('${int.parse(data[index]["jifen"].toString())}')),
        // DataCell(Text('${data[index]["qianming"]}')),
        DataCell(Image.network(
          data[index]["touxiang"],
          height: 100 * 0.618,
          width: 100,
        )),
        DataCell(Text('${data[index]["ip"]}')),
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                dynamic? b = await modify_dialog(data[index]);
                get_data(index, data[index]["id"]);

                print('b:');
                print(b);
                // data[index]["username"] = b["value1"];

                //  notifyListeners();
              },
              child: Text(
                "修改",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // dynamic? b = await modify_dialog(data[index]);
                // get_data(index, data[index]["id"]);

                // print('b:');
                // print(b);
                // data[index]["username"] = b["value1"];

                //  notifyListeners();
              },
              child: Text(
                "删除[废]",
              ),
            )
          ],
        )),
      ],
    );
  }

// 弹出对话框
  // final GlobalKey globalKey = GlobalKey(); //globalKey无用,待验证
  Future<dynamic> modify_dialog(Map data) {
    ValueNotifier<int> _valueNotifier = ValueNotifier<int>(
        groupValue); //数据监听器.监控int型一个数据,groupValue是初始值._valueNotifier.value是获取值
    //对话框返回类型是dynamic,接受map类型参数
    _unameController.text = "${data["username"]}"; //对话框刚调用就传值进来
    _telController.text = "${data["tel"]}";
    _emailController.text = "${data["email"]}";
    _valueNotifier.value = int.parse(data["beiyong1"]); //用户是否禁用
    _headphotoController.text = "${data["touxiang"]}";
    _birthController.text = "${data["birthday"]}";
    _sexController.text = "${data["sex"]}";
    _scoreController.text = "${data["jifen"].toString()}";
    _IDController.text = "${data["shenfenzheng"]}";
    _addressController.text = "${data["address"]}";
    _signatureController.text = "${data["qianming"]}";
    _nicknameController.text = "${data["nickname"]}";

    var scrollController1 = ScrollController();

    return showDialog(
      context: dialog1_context, //传递一个context进来.
      builder: (BuildContext context1) {
        final size = MediaQuery.of(context1).size;
        final width = size.width;
        final height = size.height;

        return AlertDialog(
          // key: globalKey, //无用,验证
          title: Text("用户Id:" "${data["id"]}信息修改:"),
          content: Container(
            height: height - 200, width: width, //获取上层控件的宽高

            child: Scrollbar(
                thumbVisibility: true, //始终显示滚动条.listview无法让滚动条始终显示,因此外层加了滚动条控件
                child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    controller: scrollController1,
                    children: [
                      Column(
                        children: <Widget>[
                          Text("头像:" "${data["touxiang"]}"),
                          TextField(
                            controller: _headphotoController,
                            decoration: InputDecoration(
                                labelText: "头像",
                                hintText: "头像",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("禁用:" "${data["beiyong1"]}"),
                          ValueListenableBuilder<int>(
                            //对话框中的刷新可以用StatefulBuilder,或ValueListenableBuilder
                            valueListenable: _valueNotifier, //是驱动源.
                            builder: (BuildContext context, int value1,
                                Widget? child) {
                              return Row(
                                children: [
                                  Text("禁用"),
                                  Radio(
                                    ///此单选框绑定的值 必选参数
                                    value: 0,

                                    ///当前组中这选定的值  必选参数
                                    groupValue:
                                        value1, //value1是_valueNotifier驱动源变化后的数值.来自于  _valueNotifier.value ,groupvalue如果=value则单选组件被选中.

                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      //  setState(() {
                                      _valueNotifier.value =
                                          v!; //value是_valueNotifier驱动源的数值.给它赋值改变后就会触发组件ValueListenableBuilder更新,在Radio组件的groupValue属性中获取

                                      //  });
                                    },
                                  ),
                                  Text("启用"),
                                  Radio(
                                    ///此单选框绑定的值 必选参数
                                    value: 1,

                                    ///当前组中这选定的值  必选参数
                                    groupValue: value1,

                                    ///点击状态改变时的回调 必选参数
                                    onChanged: (v) {
                                      //  setState(() {
                                      _valueNotifier.value = v!;
                                      //  });
                                    },
                                  ),
                                ],
                              );
                            },
                            child: Container(
                              child: Text('用户是否禁用'),
                            ),
                          ),
                          Text("用户名:" "${data["username"]}"),
                          TextField(
                            controller: _unameController,
                            decoration: InputDecoration(
                                labelText: "用户名",
                                hintText: "用户名",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("昵称:" "${data["nickname"]}"),
                          TextField(
                            controller: _nicknameController,
                            decoration: InputDecoration(
                                labelText: "昵称",
                                hintText: "昵称",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("性别:" "${data["sex"]}"),
                          TextField(
                            controller: _sexController,
                            decoration: InputDecoration(
                                labelText: "性别",
                                hintText: "性别",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("出生日期:" "${data["birthday"]}"),
                          TextField(
                            controller: _birthController,
                            decoration: InputDecoration(
                                labelText: "出生日期",
                                hintText: "出生日期",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("电话:" "${data["tel"]}"),
                          TextField(
                            controller: _telController,
                            decoration: InputDecoration(
                                labelText: "电话",
                                hintText: "电话",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("邮箱:" "${data["email"]}"),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: "邮箱",
                                hintText: "邮箱",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("地址:" "${data["address"]}"),
                          TextField(
                            controller: _addressController,
                            decoration: InputDecoration(
                                labelText: "地址",
                                hintText: "地址",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("身份证:" "${data["shenfenzheng"]}"),
                          TextField(
                            controller: _IDController,
                            decoration: InputDecoration(
                                labelText: "身份证",
                                hintText: "身份证",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("积分:" "${data["jifen"].toString()}"),
                          TextField(
                            controller: _scoreController,
                            decoration: InputDecoration(
                                labelText: "积分",
                                hintText: "积分",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                          Text("签名:" "${data["qianming"]}"),
                          TextField(
                            controller: _signatureController,
                            decoration: InputDecoration(
                                labelText: "签名",
                                hintText: "签名",
                                prefixIcon: Icon(Icons.person)),
                            //obscureText: true,
                          ),
                        ],
                      ),
                    ])),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("取消"),
              onPressed: () =>
                  Navigator.of(context1).pop("对话框点击了取消"), // 关闭对话框.返回给上层对话框
            ),
            ElevatedButton(
              child: Text("修改"),
              onPressed: () {
                print(" _valueNotifier.value");
                print(_valueNotifier.value);
                //futrue类似await.执行后使用then.在其中写接下来处理的部分.<String>是返回值

                Future<Map?> a = showDialog(
                  context: context1, //传递一个context进来.并且需要被赋值为上个组件的context否则不弹出
                  builder: (BuildContext dialog2Context) {
                    return AlertDialog(
                      key: Key('myDialog'),
                      title: Text("提示"),
                      content: Text("要保存吗?${_unameController.text}"),
                      actions: <Widget>[
                        ElevatedButton(
                            child: Text("重新编辑"),
                            onPressed: () {
                              Navigator.of(dialog2Context)
                                  .pop(); // 关闭对话框.返回值为null
                            }

                            // Navigator.pop(dialog2Context)
                            ),
                        ElevatedButton(
                          child: Text("保存退出"),
                          onPressed: () async {
                            // Navigator.of(context)
                            //     .pop(jsonEncode(data1)); //点击确认保存按钮后返回的list字符串

                            BaseOptions options = BaseOptions(
                              connectTimeout:
                                  Duration(seconds: connectTimeout0),
                              receiveTimeout: Duration(
                                  seconds:
                                      connectTimeout0), //无数据库链接时的反应时间,超过此时间就执行报错处理 了
                              contentType: Headers.jsonContentType,
                              responseType: ResponseType.json,
                              // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
                              /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
                              /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
                              /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
                              /// 就会自动编码请求体.
                            );

                            Dio dio = Dio(options);

                            //字段名称必须与服务器端一致

                            var json_str = {
                              "token": token,
                              "Id": data["id"].toString(),
                              "Username": _unameController.text,
                              "Address": _addressController.text,
                              "Tel": _telController.text,
                              "Email": _emailController.text,
                              "Nickname": _nicknameController.text,
                              "Qianming": _signatureController.text,
                              "Jifen": _scoreController.text,
                              "Shenfenzheng": _IDController.text,
                              "Sex": _sexController.text,
                              "Birthday": _birthController.text,
                              "Touxiang": _headphotoController.text,
                              "Beiyong1": _valueNotifier.value.toString()
                            };
                            print('data["id"].toString()');
                            print(data["id"].toString());
                            var response = await dio.post(map0api["更新用户信息"]!,
                                data: json_str); //

                            if (response.data['code'] == "0" &&
                                (response.data['message'] == "ok")) {
//  print("保存数据成功!");
                              //2次返回,关闭弹窗
                              Map data1 = {
                                "value1": _unameController.text,
                                "value2": _telController.text,
                                "value3": _emailController.text
                              };
                              Navigator.of(context1).pop(
                                  (data1)); //点击确认保存按钮后返回给对话框的map数据此处无用.对应是 Future<Map?> a =  showDialog
                            }
                          },
                        ),
                      ],
                    );
                  },
                );

                // print("a");
                a.then((json_value) {
                  //对话框接收到返回值后执行,json_value取决于对话框的返回参数dynamic

                  //a是异步返回,所以,使用then.代表a返回后执行的操作

                  // print(jsonDecode(json_value!)); //返回json对象,实际就是map类型
                  //   dynamic json_str = jsonDecode(json_value!);

                  //  print(json_str);
                  //  Navigator.of(context)
                  //                 .pop((json_str)); //点击确认保存按钮后返回的list字符串
                  if (json_value != null) {
                    //需要写数据库
                    Navigator.of(context1)
                        .pop((json_value)); //点击确认保存按钮后返回的json_value的map类型

                    print("保存数据成功!");
                  }
                  //  get_user_accordto_page();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void get_data(int index, int id) async {
//api调用获取用户
    //  List.generate(100, (index) {
    //     _data.add(User('老孟$index', index % 50, index % 2 == 0 ? '男' : '女'));
    //   });

    BaseOptions options = BaseOptions(
      connectTimeout: Duration(seconds: connectTimeout0),
      receiveTimeout:
          Duration(seconds: connectTimeout0), //无数据库链接时的反应时间,超过此时间就执行报错处理 了
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      // "application/json; charset=utf-8", //默认json传输.配合'Content-Type':'application/json',
      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
    );

    Dio dio = Dio(options);

    //字段名称必须与服务器端一致

    var json_str = {
      "token": token,
      "Id": id,
    };

    var response = await dio.post(map0api["获取指定用户信息"]!, data: json_str); //

    if (response.statusCode == 200) {
      //成功登录的请求处理

      print(response.headers);
      print(response.headers["gfsessionid"]);
      // print(response.data['code']);  print(response.data['message']);
      // print(response.statusMessage);
      if (response.data['code'] == "0") {
        //ok
        // response.data['data']返回是list<jsonmap>可以直接赋值给list类型变量
        //      _data = response.data['data'];
        // print(_data);
        //以下为整体获取数据然后更新数据源
        data[index]["username"] = response.data['data']["username"].toString();
        data[index]["email"] = response.data['data']["email"].toString();
        data[index]["address"] = response.data['data']["address"].toString();
        data[index]["nickname"] = response.data['data']["nickname"].toString();
        data[index]["tel"] = response.data['data']["tel"].toString();
        data[index]["birthday"] = response.data['data']["birthday"].toString();
        data[index]["sex"] = response.data['data']["sex"].toString();
        data[index]["qianming"] = response.data['data']["qianming"].toString();
        data[index]["shenfenzheng"] =
            response.data['data']["shenfenzheng"].toString();
        data[index]["touxiang"] = response.data['data']["touxiang"].toString();
        data[index]["jifen"] = response.data['data']["jifen"].toString();
        data[index]["isadmin"] = response.data['data']["isadmin"].toString();

        data[index]["beiyong1"] = response.data['data']["beiyong1"].toString();

        //notifyListeners();//感觉应该需要,更新数据源用.但是没有也不影响.
      }
    }
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return data.length;
  }
}
