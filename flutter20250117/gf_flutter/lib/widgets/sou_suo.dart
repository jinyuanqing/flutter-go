import 'package:flutter/material.dart';

//搜索框
class SearchWidget extends StatefulWidget {
  final double? height; // 高度
  final double? width; // 宽度.类型后面跟操作符 ? 表示当前变量可为null;操作符！表示当前变量不为null,
  final String? hintText; // 输入提示
  final ValueChanged<String>? onEditingComplete; // 编辑完成的事件回调
  final TextEditingController controller; //需要传递进来一个编辑框控制器,用于可输入的编辑内容
  const SearchWidget({
    Key? key,
    required this.controller,
    this.height,
    this.width,
    this.hintText,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  void initState() {
    super.initState();
  }

  /// 清除查询关键词
  clearKeywords() {
    widget.controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      var width = widget.width ?? constrains.maxWidth / 1; // 父级宽度
      var height = widget.height ?? constrains.maxHeight / 1.0;
      return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.0)),
        child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
                // contentPadding: EdgeInsets.zero,
                isDense: true, //(用于编辑框对齐),
                // isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                // contentPadding: EdgeInsets.symmetric(
                //     horizontal: 15, vertical: 10), //内容内边距，垂直vertical影响高度
                contentPadding: EdgeInsets.zero,
                hintText: widget.hintText ?? "请输入搜索词",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                // contentPadding: EdgeInsets.all(2.0),
                // border: InputBorder.none,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                icon: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 1),
                    child: Icon(
                      Icons.search,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    )),
                suffixIcon:
                    // Padding(
                    //     padding: EdgeInsets.all(5),
                    //     child:
                    IconButton(
                  splashRadius: 18.0,
                  icon: Icon(
                    Icons.close,
                    size: 18,
                  ),
                  onPressed: clearKeywords,
                  splashColor: Theme.of(context).primaryColor,
                )
                // )
                ),
            onEditingComplete: () {
              widget.onEditingComplete?.call(widget.controller.text);
            }),
      );
    });
  }
}
