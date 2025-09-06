import 'package:flutter/material.dart';
import '../../../widgets/bing_tu.dart';
// PieChartSample2

class ShouYe extends StatefulWidget {
  const ShouYe({ Key? key }) : super(key: key);

  @override
  _ShouYeState createState() => _ShouYeState();
}

class _ShouYeState extends State<ShouYe> {
  @override
  Widget build(BuildContext context) {
    return Container(child:
     PieChart1()//饼图1
    );
  }
}