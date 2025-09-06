 import 'package:flutter/material.dart';
 
class seo extends StatefulWidget {
  const seo ({Key? key}) : super(key: key);

  @override
  _seoState createState() => _seoState();
}

class _seoState extends State<seo> {

    @override
  void initState() {
    super.initState();
    print("SEO_initState");
   
  }

  @override
  void dispose() {
    super.dispose();
    print("SEO_dispose");
  }

  
  @override
  Widget build(BuildContext context) { print("SEO_build");
    return Container(

child:
Text('seo'),
      
    );
  }
}
