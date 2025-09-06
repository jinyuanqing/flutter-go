
import 'dart:convert';
import 'dart:typed_data';


//全局的函数方法
bool email(String input) {
  //验证邮箱

  if (input == null || input.isEmpty) return false;
  // 邮箱正则

  String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  return RegExp(regexEmail).hasMatch(input);
}




String encryptBase64(String str) {
    print("Base64加密前文本：" + str);
    var content = utf8.encode(str);
    var digest = base64Encode(content);
  var  base64String = digest.toString();
    print("Base64加密后文本：" + base64String);
    return base64String;
}

String decryptBase64(String base64String0) {
    print("Base64解密前文本：" + base64String0);
//  var    base64String1 = String.fromCharCodes(base64Decode(base64String0));
Uint8List a1= base64Decode(base64String0);
// print(a1);
 var  base64String = utf8.decode(a1);
    print("Base64解密后文本：" + base64String);
     return base64String;
}

 