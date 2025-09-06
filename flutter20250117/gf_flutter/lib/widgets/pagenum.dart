import 'package:flutter/material.dart';
import '/widgets/http.dart';
import '/model1.dart';
import 'package:provider/provider.dart';
class Pagenum extends StatefulWidget {
  const Pagenum({Key? key, required this.total, this.page = 10})
      : super(key: key);

  final int total; //总页数
  final int page; //每页的文章数目,默认每页10个文章
  @override
  State<Pagenum> createState() => _Pagenum();
}

class _Pagenum extends State<Pagenum> {
  int _counter = 0;
  // bool is_pressed = false;

  int page = 0;
  bool load = true;
// int page_num=0;//当前点击的页码值
  List<bool> is_pressed = List.filled(9, false); //保存高亮显示的标记
  List<int> a0 = List.filled(9, 0); //保存显示的页码数字,最多显示9个.左右各4个,中间一个,共计9个

  List<int> temp = List.filled(9, 0); //保存初始显示的页码数字
  int current_pagenum = 0; //当前点击的页码
  // @override
  void initState() {
    for (int i = 0; i < a0.length; i++) {
      a0[i] = i + 1; //初始显示的页码数字为1-9
    }
    //print(a0);
  }

  void pagenum(int a, dynamic model) async {
    //点击页码 数字的跳转.
    if ((a >= 1) & (a <= (widget.total / widget.page).ceil())) {
      //传递进来的页码数字范围要>=1,<=总条数/每页的条数(即总页数)
      current_pagenum =
          a; //把传递进来的参数a赋值给当前页码变量current_pagenum,用于确定当前的页码数字,方便上下一页的点击
      // if (a <= ((widget.total / widget.page).ceil()) - 4) {
      temp.fillRange(0, 9, 0); //即将显示的页码数字清零,此处就是一个临时数组,用于存储计算出来的页码
      // }
      is_pressed.fillRange(0, is_pressed.length, false); //选中页码的状态数组清0
      if (a - 4 > 0) {
        //把显示的页码范围放入temp数组中
        if (a <= ((widget.total / widget.page).ceil()) - 4) {
          //显示页码范围数字后5个
          for (int i = 0; i < 9; i++) {
            if (a + i - 4 <= ((widget.total / widget.page).ceil())) {
              temp[i] = a + i - 4;
            } else {
              break;
            }
          }
        } else {
          for (int i = 0; i < 9; i++) {
            //分段处理页码显示1-4
            temp[i] = (widget.total / widget.page).ceil() - 8 + i;
          }
        }

        for (int i = 0; i < a0.length; i++) {
          //当前的选择页码设置高亮标记
          //a0长度9
          a0[i] = temp[i];
          if (a == a0[i]) is_pressed[i] = true; //当前选择的按钮页码数字等于临时数组中的值时,标记为真
        }

        print(temp);
      } else {
        //页码数字<4时为情况2

        for (int i = 0; i < 9; i++) {
          if (i + 1 <= ((widget.total / widget.page).ceil())) {
            //i+1<总的页数时
            temp[i] = i + 1; //直接显示1-9数字
          } else {
            break; //停止循环
          }
        }
        for (int i = 0; i < a0.length; i++) {
          a0[i] = temp[i];
          if (a == a0[i]) is_pressed[i] = true;
        }

        print(temp);
      }
    }
print(current_pagenum);
    
  var response =
   await YXHttp().http_get(map0api["获取文章"]!,  {  "token": token,"page":current_pagenum, "fenleiid": 0}); //发送退出请求
//  print("response"); print(response);
//  Model1 model1 = context.watch<Model1>( ) ; 
 
  model.get_article(response);
    setState(() {});
  }
 
  /// 處理點擊按鈕背景顏色
  /// 設置當前按鈕為不可點擊時，設置onPressed回調為null。
  MaterialStateProperty<Color> createTextBtnBgColor() {
    return MaterialStateProperty.resolveWith((states) {
      if (is_pressed[0]) {
// If the button is pressed, return green, otherwise blue
        if (states.contains(MaterialState.pressed)) {
          return Color.fromARGB(255, 19, 103, 180);
        } else if (states.contains(MaterialState.disabled)) {
          return Color(0x509cf6);
        }
      }
      return Color.fromARGB(255, 255, 255, 255);

      ///擴展String函數
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building");
    print(is_pressed);
    int pagenum_int = (widget.total / widget.page).ceil();
      // Model1 model1 =  Provider.of<Model1>(context);
      Model1 model1 = context.watch<Model1>();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 1, //heroTag随意给值,能区分即可
              onPressed: () {
                pagenum(current_pagenum - 1,model1);
              },
              child: Text("上一页")),
 Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
List.generate(9, (index) {
//  if ((a0[0] <= pagenum_int) & (a0[0] > 0))
         return    TextButton(
                style: is_pressed[index]
                    ? ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                        if (is_pressed[index]) {
// If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return Color.fromARGB(255, 19, 103, 180);
                          } else if (states.contains(MaterialState.disabled)) {
                            return Color(0x509cf6);
                          }
                        }
                        return Color.fromARGB(255, 138, 138, 138);

                        ///擴展String函數
                      }))
                    : null,
                //1
                onPressed: () {
                  //  is_pressed.fillRange(0, is_pressed.length, false);
                  //  is_pressed[0] = true;
                  pagenum(a0[index],model1);
                },
                child: Text(
                  a0[index].toString(),
                ));
 })),

          
//           if ((a0[1] <= pagenum_int) & (a0[1] > 0))
//             TextButton(
//                 //2
//                 style: is_pressed[1]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[1]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   //is_pressed.fillRange(0, is_pressed.length, false);
//                   // is_pressed[1] = true;
//                   pagenum(a0[1]); //is_pressed = true;
//                 },
//                 child: Text(
//                   a0[1].toString(),
//                 )),
//           if ((a0[2] <= pagenum_int) & (a0[2] > 0))
//             TextButton(
//                 //3
//                 style: is_pressed[2]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[2]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   //is_pressed.fillRange(0, is_pressed.length, false);
//                   // is_pressed[2] = true;
//                   pagenum(a0[2]);
//                 },
//                 child: Text(
//                   a0[2].toString(),
//                 )),
//           if ((a0[3] <= pagenum_int) & (a0[3] > 0))
//             TextButton(
//                 //4
//                 style: is_pressed[3]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[3]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   //is_pressed.fillRange(0, is_pressed.length, false);
//                   // is_pressed[3] = true;
//                   pagenum(a0[3]);
//                 },
//                 child: Text(
//                   a0[3].toString(),
//                 )),
//           if ((a0[4] <= pagenum_int) & (a0[4] > 0))
//             TextButton(
//                 //5
//                 style: is_pressed[4]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[4]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   // is_pressed.fillRange(0, is_pressed.length, false);
//                   //is_pressed[4] = true;
//                   pagenum(a0[4]);
//                 },
//                 child: Text(
//                   a0[4].toString(),
//                 )),
//           if ((a0[5] <= pagenum_int) & (a0[5] > 0))
//             TextButton(
//                 //6
//                 style: is_pressed[5]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[5]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   //  is_pressed.fillRange(0, is_pressed.length, false);
//                   //  is_pressed[5] = true;
//                   pagenum(a0[5]);
//                 },
//                 child: Text(
//                   a0[5].toString(),
//                 )),
//           if ((a0[6] <= pagenum_int) & (a0[6] > 0))
//             TextButton(
//                 //7
//                 style: is_pressed[6]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[6]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   // is_pressed.fillRange(0, is_pressed.length, false);
//                   // is_pressed[6] = true;
//                   pagenum(a0[6]);
//                 },
//                 child: Text(
//                   a0[6].toString(),
//                 )),
//           if ((a0[7] <= pagenum_int) & (a0[7] > 0))
//             TextButton(
//                 //8
//                 style: is_pressed[7]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[7]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   // is_pressed.fillRange(0, is_pressed.length, false);
//                   //  is_pressed[7] = true;
//                   pagenum(a0[7]);
//                 },
//                 child: Text(
//                   a0[7].toString(),
//                 )),
//           if ((a0[8] <= pagenum_int) & (a0[8] > 0))
//             TextButton(
//                 //9
//                 style: is_pressed[8]
//                     ? ButtonStyle(backgroundColor:
//                         MaterialStateProperty.resolveWith((states) {
//                         if (is_pressed[8]) {
// // If the button is pressed, return green, otherwise blue
//                           if (states.contains(MaterialState.pressed)) {
//                             return Color.fromARGB(255, 19, 103, 180);
//                           } else if (states.contains(MaterialState.disabled)) {
//                             return Color(0x509cf6);
//                           }
//                         }
//                         return Color.fromARGB(255, 86, 76, 233);

//                         ///擴展String函數
//                       }))
//                     : null,
//                 onPressed: () {
//                   // is_pressed.fillRange(0, is_pressed.length, false);
//                   //  is_pressed[8] = true;
//                   pagenum(a0[8]);
//                 },
//                 child: Text(
//                   a0[8].toString(),
//                 )),
         
         
          FloatingActionButton(
              heroTag: 2,
              onPressed: () {
                pagenum(current_pagenum + 1,model1);
              },
              child: Text("下一页")),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
