// import 'package:flutter/foundation.dart'; //引入平台判别
import 'package:flutter/material.dart';
import 'package:flutter_gf_view/widgets/http.dart';
// import 'package:http/http.dart' as http;
// import 'package:photo_view/photo_view.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
// import 'package:flutter_quill/widgets/controller.dart';
// import 'package:flutter_quill/widgets/editor.dart';
// import 'Zhan_shi.dart';
// import 'dart:math';
import 'dart:convert' as convert; //转换dio网络获得的数据
// import '../universal_ui/universal_ui.dart';
// import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import '/global.dart';
import 'package:get/get.dart' as Get;
//编辑器
import 'package:flutter/services.dart';
import 'package:flutter_gf_view/model1.dart';
import 'package:flutter_gf_view/quan_ju.dart';
import 'package:visual_editor/visual-editor.dart';
// import '/admin/edtor/const/sample-highlights.const.dart';
// import '/admin/edtor/services/editor.service.dart';
import '/admin/edtor/widgets/demo-scaffold.dart';
// import '/admin/edtor/widgets/loading.dart';

// 文章详情页
// ignore: camel_case_types
class Company extends StatefulWidget {
  final id;
  final gong_si_ming;
  // final gangwei;
  // final xueli;
  // final renshu;
  // final yaoqiu;
  // final baoxian;
  // final xinchou;
  // final lianxifangshi;
  // final liulanshu;
  // final created_at;
  // final updated_at;
  // final list_yingpinzhe_id;
  // final kaishishijian;
  // final jieshushijian;
  // final youxiang;
  final tupian;
  // final qita;
  // final quanzhi;
  // final dizhi;
  // final gongzuonianxian;
  const Company({
    Key? key,
    @required this.id,
    @required this.gong_si_ming,
    // @required this.gangwei,
    // @required this.xueli,
    // @required this.renshu,
    // @required this.yaoqiu,
    // @required this.baoxian,
    // @required this.xinchou,
    // @required this.lianxifangshi,
    // @required this.liulanshu,
    // @required this.created_at,
    // @required this.updated_at,
    // @required this.list_yingpinzhe_id,
    // @required this.kaishishijian,
    // @required this.jieshushijian,
    // @required this.youxiang,
    @required this.tupian,
    // @required this.qita,
    // @required this.quanzhi,
    // @required this.dizhi,
    // @required this.gongzuonianxian,
  }) : super(key: key); //注意这是需要参数的类的定义,继承自StatelessWidget

  @override
  State<StatefulWidget> createState() => new _Company();
}

// ignore: camel_case_types
class _Company extends State<Company> {
  //class _Company extends StatelessWidget{
  //final title;final nei_rong; final id;final zuo_zhe;final ri_qi;
  // _Company({Key key, @required this.title,@required this.nei_rong,@required this.id,@required this.zuo_zhe,@required this.ri_qi}): super(key: key);//注意这是需要参数的类的定义,继承自StatelessWidget
  final FocusNode _focusNode = FocusNode();
  List<dynamic> list_yingpinzhe_id =
      []; ////json类型的替代.如{"应聘者": [{"id": "1", "name": "jin"}, {"id": "59", "name": "yuan"}, {"id": "11", "name": "qing"}, {"id": "99", "name": "a"}]}
  String gong_si_ming = "";
  String gongsi_name = "";
  String gangwei = "";
  String xueli = "";
  int renshu = 0;
  String yaoqiu = "";
  List<String> baoxian = [];
  String xinchou = "";
  String lianxifangshi = "";
  int liulanshu = 0;
  String created_at = "";
  String updated_at = "";
  String yingpinzhe_id = "";
  String kaishishijian = "";
  String jieshushijian = "";
  String youxiang = "";

  List<dynamic> tupian = [];
  String qita = "";
  String quanzhi = "";
  String dizhi = "";
  String gongzuonianxian = "";
  var scrollController0 = ScrollController(); //编辑器用
  var _scrollController1 = ScrollController(); //窗口右侧的listview用
  var _scrollController2 = ScrollController(); //窗口右侧的listview用
  var _showBackTop = false;
  List<dynamic> list_companypic = []; // List<_JsonMap>
  int a1 = 25;
  int id = 0;
  List<List<String>> list_baoxian = [];
  ScrollController _arrowsController = ScrollController();
  double _alignmentY = 0.0;
  //  final _editorService = EditorService();

  EditorController? _controller;

  @override
  void dispose() {
    super.dispose();
  }

  Future getcompany(String name) async {
    var response = await YXHttp().http_post(map0api["获取公司信息"]!, {
      "Gongsiming": name,
      "token": token,
    });
    print(response);
    print(response[0]["gongsi_pic"]);
    var json_gongsi_pic = convert.jsonDecode(response[0]["gongsi_pic"]);
    print(json_gongsi_pic["pics"]);
    list_companypic = List.from(json_gongsi_pic["pics"]);
    print(list_companypic);
  }

  @override
  void initState() {
    super.initState();
    print("招聘信息页详情init");
    id = widget.id;
    gong_si_ming = widget.gong_si_ming;
    // gangwei = widget.gangwei;
    // xueli = widget.xueli;
    // renshu = widget.renshu;
    // yaoqiu = widget.yaoqiu;

    // baoxian = widget.baoxian;
    // xinchou = widget.xinchou;
    // lianxifangshi = widget.lianxifangshi;
    // liulanshu = widget.liulanshu;
    // created_at = widget.created_at;

    // updated_at = widget.updated_at;
    // list_yingpinzhe_id = widget.list_yingpinzhe_id;
    // kaishishijian = widget.kaishishijian;
    // jieshushijian = widget.jieshushijian;
    // youxiang = widget.youxiang;

    tupian = widget.tupian;
    // qita = widget.qita;
    // quanzhi = widget.quanzhi;
    // dizhi = widget.dizhi;
    // gongzuonianxian = widget.gongzuonianxian;

    // _loadDocument();

    _scrollController1.addListener(() {
      setState(() => _showBackTop = _scrollController1.position.pixels >= 100);
      // print(_scrollController1.position.maxScrollExtent);
      // print(_scrollController1.position.pixels);
      //  print(MediaQuery.of(context).size.height);
      if (_scrollController1.position.pixels >=
          (_scrollController1.position.maxScrollExtent)) //当前滚动条位置=最大滚动距离则
      {
        print("到底部了");

        // _scrollController1.jumpTo(10);
        // print(_scrollController1.position.pixels);

      }

      // _scrollController.position.pixels 获取当前滚动部件滚动的距离
      // 当滚动距离大于 100 之后，显示回到顶部按钮
      // setState(() => _showBackTop = _scrollController.position.pixels >= 100);
    });
    // getcompany(gong_si_ming);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('滚动组件最大滚动距离:${metrics.maxScrollExtent}');
    print('当前滚动位置:${metrics.pixels}');
    _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
    return true;
  }

  Widget _scaffold({required List<Widget> children}) => DemoScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _showBackTop // 当需要显示的时候展示按钮，不需要的时候隐藏，设置 null
            ? FloatingActionButton(
                onPressed: () {
                  // scrollController 通过 animateTo 方法滚动到某个具体高度
                  // duration 表示动画的时长，curve 表示动画的运行方式，flutter 在 Curves 提供了许多方式
                  _scrollController1.animateTo(0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: Icon(Icons.vertical_align_top),
              )
            : null,
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Icons.navigate_before,
              //     size: 30,
              //     color: Colors.redAccent,
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              Expanded(
                flex: 10,
                child: Container(
                  //height: 30.0,
                  // color: Colors.red,
                  child: Text(
                    '招聘信息详情:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 22, 21, 21),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 6,
              //   child: Container(
              //     height: 30.0,
              //     color: Color.fromARGB(255, 230, 235, 230),
              //   ),
              // ),
            ],
          ),
        ),
        body: //Scrollbar
// ScrollConfiguration(//隐藏listview自带的滚动条,使用自定义的滚动条.仿佛只针对一个listview控件
//     behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//     child:
            //   DraggableScrollbar.arrows(//自定义滚动条
            // heightScrollThumb: 96,//滚动条高度
            // alwaysVisibleScrollThumb: true,
            // backgroundColor: Color.fromARGB(255, 3, 193, 241),
            // padding: EdgeInsets.only(right: 4.0),
            // controller: _arrowsController,
            // Expanded(flex: 1,
            //   child:
            // Center(
            //     child:
            ListView(
                //shrinkWrap: true,//解决Listview 无限高度
//  itemCount: 1,
                //外层的cloumn不能有,否则不显示listview
                controller: _scrollController1, //_arrowsController,
                // itemBuilder: (BuildContext context, int index) {
                children: <Widget>[
              Column(children: <Widget>[
                Text("发布日期:${updated_at}"),
                Padding(
                  padding: EdgeInsets.only(
                      top: 50, bottom: 100, left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: LayoutBuilder(builder: (context, constraints) {
                            print(constraints);
                            return Container(
                                // width: constraints.maxWidth,
                                //height: 800,
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "id:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${id}"),

                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Divider(),
                                    Text(
                                      "公司/联系人:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${gong_si_ming}"),
                                    Divider(),

                                    Text(
                                      "招聘职位:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${gangwei}"), Divider(),
                                    Text(
                                      "学历要求:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${xueli}"), Divider(),
                                    Text(
                                      "招聘人数:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${renshu}"), Divider(),
                                    Text(
                                      "招聘要求:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${yaoqiu}"), Divider(),
                                    Text(
                                      "招聘待遇:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    Wrap(
                                        children: List<Widget>.generate(
                                            baoxian.length, (index1) {
                                      return Text("${baoxian[index1]},");
                                    })),
                                    Divider(),
                                    Text(
                                      "招聘薪酬:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${xinchou}"), Divider(),
                                    Text(
                                      "联系方式:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${lianxifangshi}"), Divider(),
                                    Text(
                                      "浏览数:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${liulanshu}"), Divider(),
                                    Text(
                                      "创建时间:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${created_at}"), Divider(),
                                    Text(
                                      "更新时间:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${updated_at}"), Divider(),
                                    Text(
                                      "应聘者信息:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    Wrap(
                                        children: List<Widget>.generate(
                                            list_yingpinzhe_id.length,
                                            (index1) {
                                      return Text(
                                          "应聘者id:${list_yingpinzhe_id[index1]["id"]},");
                                    })),
                                    Wrap(
                                        children: List<Widget>.generate(
                                            list_yingpinzhe_id.length,
                                            (index2) {
                                      return Text(
                                          "应聘者name:${list_yingpinzhe_id[index2]["name"]},");
                                    })),
                                    Divider(),
                                    Text(
                                      "开始时间:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${kaishishijian}"), Divider(),
                                    Text(
                                      "结束时间:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${jieshushijian}"), Divider(),
                                    Text(
                                      "联系邮箱:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${youxiang}"), Divider(),
                                    Text(
                                      "图片:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Wrap(
                                        children: List<Widget>.generate(
                                            tupian.length, (index1) {
                                      return Image.network(
                                        tupian[index1]["picurl"],
                                        height: 400 * 0.618,
                                        width: 400,
                                      );
                                    })),
                                    Divider(),
                                    Text(
                                      "其他:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${qita}"), Divider(),
                                    Text(
                                      "全职/兼职:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${quanzhi}"), Divider(),
                                    Text(
                                      "工作地址:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${dizhi}"), Divider(),
                                    Text(
                                      "工作经验:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${gongzuonianxian}"), Divider(),
                                  ],
                                ));
                          })),
                      Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 00,
                                      left: 50,
                                      bottom: 50,
                                      right: 10), //边距
                                  padding: EdgeInsets.only(
                                    top: 50,
                                    bottom: 50,
                                  ),
                                  color: Colors.grey[200],
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 1,
                                                //  height: 200,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        "公司名:${gong_si_ming}",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      onTap: () {
                                                        // Get.Get.to(page);
                                                      },
                                                    ),

                                                    AspectRatio(
                                                      aspectRatio: 1 / 0.618,
                                                      child: Image.network(
                                                        'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),

                                                    Container(
                                                        color: Color.fromARGB(
                                                            183, 180, 243, 33),
                                                        // width: 300,
                                                        // height: 200,
                                                        child: Column(
                                                            //列中文本可以自动换行
                                                            // mainAxisAlignment: MainAxisAlignment.start,
                                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                // alignment: Alignment.,
                                                                // width: 200,
                                                                // height: 200,
                                                                child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis, //溢出后显示省略号
                                                                  maxLines: 4,
                                                                  style: TextStyle(
                                                                      // color: Colors.grey[500],
                                                                      fontSize: 15),
                                                                  "中华人民共和国（the People's Republic of China），简称“中国”，成立于1949年10月1日 [1] ，位于亚洲东部，太平洋西岸 [2] ，是工人阶级领导的、以工农联盟为基础的人民民主专政的社会主义国家 [3] ，以五星红旗为国旗 [4] 、《义勇军进行曲》为国歌 [5] ，国徽中间是五星照耀下的天安门，周围是谷穗和齿轮 [6] [171] ，通用语言文字是普通话和规范汉字 [7] ，首都北京 [8] ，是一个以汉族为主体、56个民族共同组成的统一的多民族国家。",
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                              )
                                                            ])),
                                                    // ),

                                                    // Flexible(
                                                    //     flex: 2,
                                                    //     child: ConstrainedBox(
                                                    //         constraints: const BoxConstraints(
                                                    //             // minWidth: 550,
                                                    //             // minHeight: 250,
                                                    //             // maxHeight: 300,
                                                    //             // maxWidth: 550,
                                                    //             ),
                                                    //         child: SizedBox(
                                                    //             // height: 100,
                                                    //             // width: 550,
                                                    //             // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                                                    //             child: ElevatedButton(
                                                    //           child: const Text(
                                                    //             '这一个按钮11',
                                                    //             style: TextStyle(fontSize: 36.0 * 1),
                                                    //           ),
                                                    //           onPressed: () {},
                                                    //         )))),
                                                    // Flexible(
                                                    //     flex: 2,
                                                    //     child: SizedBox(
                                                    //         // height: SizeConfig.blockSizeVertical * 20,
                                                    //         // width: 250,
                                                    //         // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                                                    //         child: ElevatedButton(
                                                    //       child: const Text(
                                                    //         '这一个按钮2',
                                                    //         style: TextStyle(fontSize: 36.0 * 1),
                                                    //       ),
                                                    //       onPressed: () {},
                                                    //     ))),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   children: [
                                        Wrap(
                                          spacing: 30.0, // 主轴(水平)方向间距
                                          runSpacing: 10.0, // 纵轴（垂直）方向间距

                                          crossAxisAlignment: WrapCrossAlignment
                                              .center, //可解决不同组件的中心对齐
                                          alignment: WrapAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              icon: Icon(Icons.article),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primary)),
                                              label: Text("文章:35"),
                                              // color: Colors.black12,
                                              onPressed: () {},
                                            ),
                                            // Container(
                                            //     height: 20,
                                            //     child: VerticalDivider(
                                            //       thickness: 2.0,
                                            //       color: Colors.grey[500],
                                            //      // width: 100,
                                            //     )), //垂//垂直分割线
                                            ElevatedButton.icon(
                                              icon: Icon(
                                                  Icons.format_align_center),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primary)),
                                              label: Text("关注他"),
                                              // color: Colors.black12,
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                        //   ],
                                        // )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 00,
                                      left: 50,
                                      bottom: 50,
                                      right: 10), //边距
                                  padding: EdgeInsets.only(
                                    top: 50,
                                    bottom: 50,
                                  ),
                                  color: Colors.grey[200],
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 1,
                                                //  height: 200,
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.center,
                                                  children: [
                                                    // Container(
                                                    //   width: 100,
                                                    //   height: 100,
                                                    //   child: // 水平/垂直方向平铺组件
                                                    // Flexible(
                                                    //   // fit: FlexFit.tight,
                                                    //   flex: 2,
                                                    //   // 设置宽度充满父容器
                                                    //   // widthFactor: 1, heightFactor: 1,
                                                    //   // 要设置的水平 / 垂直方向的平铺操作的组件
                                                    //   child:
                                                    CircleAvatar(
                                                      //  child: Text("头像"),
                                                      //头像半径
                                                      radius: 60,
                                                      //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                                                      backgroundImage: NetworkImage(
                                                          'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
                                                    ),
                                                    // ),

                                                    // Flexible(
                                                    //     flex: 2,
                                                    //     fit: FlexFit.tight,
                                                    //     // fit: FlexFit.loose,
                                                    //     // flex: 100,
                                                    //     // 设置宽度充满父容器
                                                    //     // widthFactor: 1, heightFactor: 1,
                                                    //     // 要设置的水平 / 垂直方向的平铺操作的组件
                                                    //     child:

                                                    Container(
                                                        color: Colors.blue,
                                                        width: 300,
                                                        // height: 200,
                                                        child: Column(
                                                            //列中文本可以自动换行
                                                            // mainAxisAlignment: MainAxisAlignment.start,
                                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                username,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              Container(
                                                                // alignment: Alignment.center,
                                                                // width: 200,
                                                                // height: 200,
                                                                child: Text(
                                                                  maxLines: 4,
                                                                  style: TextStyle(
                                                                      // color: Colors.grey[500],
                                                                      fontSize: 15),
                                                                  "签名1签名2签名3签名4签名5签名6签名7签名8签名9签名1签名2签名3签名4签名5签名6签名7签名8签名9签名1签名2签名3签名4签名5签名6签名7签名8签名9签名1签名2签名3签名4签名5签名6签名7签名8签名9签名1签名2签名3签名4签名5签名6签名7签名8签名9签签名签名签345678名签名23456789签名签签名签123123名签123456789123456780",
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                              )
                                                            ])),
                                                    // ),

                                                    // Flexible(
                                                    //     flex: 2,
                                                    //     child: ConstrainedBox(
                                                    //         constraints: const BoxConstraints(
                                                    //             // minWidth: 550,
                                                    //             // minHeight: 250,
                                                    //             // maxHeight: 300,
                                                    //             // maxWidth: 550,
                                                    //             ),
                                                    //         child: SizedBox(
                                                    //             // height: 100,
                                                    //             // width: 550,
                                                    //             // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                                                    //             child: ElevatedButton(
                                                    //           child: const Text(
                                                    //             '这一个按钮11',
                                                    //             style: TextStyle(fontSize: 36.0 * 1),
                                                    //           ),
                                                    //           onPressed: () {},
                                                    //         )))),
                                                    // Flexible(
                                                    //     flex: 2,
                                                    //     child: SizedBox(
                                                    //         // height: SizeConfig.blockSizeVertical * 20,
                                                    //         // width: 250,
                                                    //         // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                                                    //         child: ElevatedButton(
                                                    //       child: const Text(
                                                    //         '这一个按钮2',
                                                    //         style: TextStyle(fontSize: 36.0 * 1),
                                                    //       ),
                                                    //       onPressed: () {},
                                                    //     ))),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   children: [
                                        Wrap(
                                          spacing: 30.0, // 主轴(水平)方向间距
                                          runSpacing: 10.0, // 纵轴（垂直）方向间距

                                          crossAxisAlignment: WrapCrossAlignment
                                              .center, //可解决不同组件的中心对齐
                                          alignment: WrapAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              icon: Icon(Icons.article),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primary)),
                                              label: Text("文章:35"),
                                              // color: Colors.black12,
                                              onPressed: () {},
                                            ),
                                            // Container(
                                            //     height: 20,
                                            //     child: VerticalDivider(
                                            //       thickness: 2.0,
                                            //       color: Colors.grey[500],
                                            //      // width: 100,
                                            //     )), //垂//垂直分割线
                                            ElevatedButton.icon(
                                              icon: Icon(
                                                  Icons.format_align_center),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primary)),
                                              label: Text("关注他"),
                                              // color: Colors.black12,
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                        //   ],
                                        // )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10,
                                      left: 50,
                                      bottom: 50,
                                      right: 10), //边距
                                  padding: EdgeInsets.only(
                                    top: 50,
                                    bottom: 50,
                                  ),
                                  color: Colors.grey[200],
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(children: [
                                          Expanded(
                                              //可以实现外层row->exp-列->中文字换行
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children:

                                                      // List.generate(20, (index) {
                                                      //   return Text("$index");
                                                      // }),
                                                      [
                                                Text(
                                                  "公司介绍",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                ListView.builder(
                                                    shrinkWrap:
                                                        true, //解决Listview 无限高度.没有此句不显示列表哦.因为高度没有给定
                                                    controller:
                                                        _scrollController2,
                                                    itemCount:
                                                        15, //给定了数值,就要用shrinkWrap=true
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return TextButton(
                                                          onPressed: () {},
                                                          child:
                                                              Text("文章$index"));
                                                    })
                                              ])),
                                        ]),
                                      ]),
                                ),
                              ])),
                    ],
                  ),
                )
              ])
            ])

        // )

        );
  }
}
