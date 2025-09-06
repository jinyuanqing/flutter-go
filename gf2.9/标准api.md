# 插件中安装markdown插件然后重启就可以看到预览md文件了1

***

# 参考这个 admin/admin_set_article_fenlei

---

# 0 安装go1.21.3.windows-amd64语言包和gf_windows_amd64_2.5.6,在系统变量中配置goproxy全局变量值为https://goproxy.cn 

# 1 数据库创建表,定义字段等.数据库表的字段定义,最好不要用下划线.那样生成的gf中的model中的结构体字段名称的每个单词首字母是驼峰命名大写 .如果不用下划线,则生成的字段都是小写的,这样更方便操作.数据表限制长度为10,那么输入的汉字,字母,数字的长度都是 10个.


# 2 gf gen dao执行数据表生成.数据表的字段可以包含下划线,生成的gf代码后会忽略下划线



# 1.API定义,Fenleiname就是url请求的参数哦.如果定义了参数但是不传递,会有个默认值接收哦.注意这里的json:后的fenleiname,前端接口传递的参数是Fenleiname,但是就到达gf内部会自动转为小写的fenleiname.   
   # 因此工程中就统一,把字段的首字符大写,包括gf端和flutter端和数据库的字段..

```
type Admin_set_article_fenlei_Req struct {
	g.Meta     `path:"/admin_set_article_fenlei" method:"post" tags:"AdminService" summary:"设置文章分类"`
	Fenleiname string `v:"required" json:"fenleiname"` //
}
```

# 2.在model中,新建一个go文件,名为可以参考model-entity中的生成的数据表名.定义控制器或者服务之间要使用的输入输出变量结构体,通常以Input或者Output结尾,这个结构体的定义也可以参考model-entity中的数据表文件.其中的字段可以取舍.如

```
package model
//在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-user.go
type WenzhangfenleiInput struct {
	Id         int    `json:"id"         description:"分类名称对应的id,也作为查询文章分类的表名.分类的表名命名规则wen_zhang_fenlei_id"`
	FenleiName string `json:"fenleiName" description:"文章分类名称"`
}
```

# 3控制器中.利用model.Wenzhangfenlei进行请求参数赋值操作.控制器中定义1个结构体用于控制器的函数返回值绑定.然后定义个结构体示例用在cmd.go中进行路由绑定

```
type cRencaizhaopin struct{}

var Rencaizhaopin = cRencaizhaopin{} //在cmd.go中绑定路由

func (c *cRencaizhaopin) Get_gongsi(ctx context.Context, req *v1.Get_Gongsi_Req) (res *v1.Get_Gongsi_Res, err error) {
	var r = g.RequestFromCtx(ctx)               //从上下文ctx中获取r

	//下方的代码会直接返回给客户端,但由于下方代码2的r.Response.WriteJsonExit代码存在,则不会再次返回了.屏蔽下方代码2就会继续返回给客户端了
	res = &v1.Get_Gongsi_Res{
		GongsiName:  "1",
		GongsiFaRen: "教育",
		GongsiYeWu:  "招生",
	}
	//代码2,返回的信息更灵活
	r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
		"data":    res,
		"message": "查询公司信息成功",
	})
	return
}
```

# 4.logic中书写逻辑代码.这部分就是查询数据库的功能.下方代码是2个方法实现插入数据.do是对应数据表,dao是操作数据表的对象,model是输入输出的数据结构. 最后执行 gf gen service生成相关的服务

```
package 文件名作为包名
type s结构体名 struct{}

func init() {
	service.RegisterRencaizhaopin(New())//这个注册函数需要使用gen dao service进行生成
}

func New() *s结构体名 {
	return &s结构体名{}
}


func (s *sAdmin) Set_fen_lei_name(ctx context.Context, in model.Wenzhangfenlei) (result sql.Result, err error) {
	//2种插入数据的方法

	//方法1
	result, err = dao.Wenzhangfenlei.Ctx(ctx).Data(

		do.Wenzhangfenlei{

			FenleiName: in.FenleiName,
		}).Insert()


	//方法2
	//result, err = dao.Wenzhangfenlei.Ctx(ctx).Insert(
	//
	//	do.Wenzhangfenlei{
	//
	//		FenleiName: in.FenleiName,
	//	})
	//return result, err//此处也可以直接return.因所有参数已经赋值.直接返回即可
return
}
```
