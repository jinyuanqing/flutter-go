

#  分页查询的page(1,10)从第一条记录开始,返回10条.
# 存放json的数据格式
[
{"youxue":{"createTime":1714743293255,"data":{"Userinfo":{"id":1,"username":"youxue","password":"jinjin1984","email":"76115345@qq.com       ","address":"辽宁锦州义县       ","nickname":"幽雪1","createAt":"2023-06-09 10:57:59","updateAt":"2024-04-07 11:17:09","tel":"15174065551","birthday":"19840318   ","beiyong1":"0","sex":"男 ","qianming":"新签名       ","shenfenzheng":"21072719840318123       ","ip":"192.168.2.3","touxiang":"http://127.0.0.1:8199/upload_file/a2b11184-d327-4488-a597-56ffde27e7aa.jpg       ","jifen":100,"isadmin":true,"apinum":10,"isused":true,"apiused":1},"C1":"经营权","Casbin1":{}},"refreshTime":1716039293255,"userKey":"youxue","uuid":"12147caf50cfa3f87d916553897d7ed6"}},
{"youxue":{"createTime":1714743293255,"data":{"Userinfo":{"id":1,"username":"youxue","password":"jinjin1984","email":"76115345@qq.com       ","address":"辽宁锦州义县       ","nickname":"幽雪1","createAt":"2023-06-09 10:57:59","updateAt":"2024-04-07 11:17:09","tel":"15174065551","birthday":"19840318   ","beiyong1":"0","sex":"男 ","qianming":"新签名       ","shenfenzheng":"21072719840318123       ","ip":"192.168.2.3","touxiang":"http://127.0.0.1:8199/upload_file/a2b11184-d327-4488-a597-56ffde27e7aa.jpg       ","jifen":100,"isadmin":true,"apinum":10,"isused":true,"apiused":1},"C1":"经营权","Casbin1":{}},"refreshTime":1716039293255,"userKey":"youxue","uuid":"12147caf50cfa3f87d916553897d7ed6"}}
]

# 	str := g.Ctx(r.Context()).Value("ctx_username").(string) // 类型断言：将 any 类型转换为 string 类型.g.Ctx(r.Context()).Value("ctx_username")的类型是any,所以进行转换

20240318克隆
20240317首次克隆
# 数据库自动断开 ->127.0.0.1:3 306: wsarecv: An established connection was aborted by the software in your host machine. gf与mysql连接是非交互的,因此mysql.ini中调高wait_timeout=28800(8小时)参数
# 数据库bit(1)为go的bool,数据库中json类型,则 gf gen dao -n 可以生成gf的gjson类型的字段模型
# 项目启动前要运行redis
# 执行gf gen dao一定要备份212
 # 使用 go mod vendor 可以将依赖包复制到当前目录的 vendor 目录下。防止包的源码被破坏
 # 中间件的执行先执行gf的,然后执行gtoken的中间件D:\PRO\go20221208\gf2\vendor\github.com\goflyfox\gtoken\gtoken的gtoken.go的authMiddleware     .中间件的执行先后顺序与代码书写顺序有关哦,
# api中的tag 标签的json属性只针对res输出有作用,对于用户输入的前端参数没有作用应该去掉

# 用户登录成功后gtoken包会保存到C:\Users\Administrator\AppData\Local\Temp一个gtoken.dat文件,保存用户生成的token信息等


# 插入数据后可以直接返回插入的数据id,例如招聘信息的Fabu函数,使用了InsertAndGetId

int和int64一样都是占用8字节.
# str_jiami := hex.EncodeToString(jiami) //把字节数组按照元素进行字符串相连接[02,03]变成""0203"
```
切片的删除元素
b := []int{1, 2, 3, 4, 5}
	var i = 0                     //要删除的切片元素索引.
	b = append(b[:i], b[i+1:]...) //:i从0开始到i,不含i.开始元素索引都包括,结束不包括
```

# 数据库的canbin_rule内容,把管理员和用户角色写进去,把顶层菜单权限给2个角色.然后再写别的顶层下的别的菜单.实际使用时,只需要写入用户和用户角色即可.

# 获取上下文 变量2钟方式:利用r请求 r := g.RequestFromCtx(ctx) err3 := r.GetCtxVar("ctx_casbin").Structs(&e1) .2利用ctx哦ctx.Value("ctx_user")
#  token的data属性可以存储类似session的变量信息.token和session获取变量相当于全局变量,任意请求函数方法中都可以使用.2者都要设置有效期,超过有效期变量值失效.gtoken把token变量传递给客户端,gsession把sessionid传递给客户端
# session的存放位置C:\Users\游学\AppData\Local\Temp\gsessions\default
# token可以代替auth的授权功能.C:\Users\游学\go\pkg\mod\github.com\goflyfox\gtoken@v1.5.7\gtoken\gtoken_conts.go设置gtoken的授权生成密钥.
server {
        listen       1984;
        # server_name  localhost;
       resolver      114.114.114.114            
        location / {
        #    proxy_pass http://127.0.0.1:80;
         proxy_pass http://api.ip.sb/ip;
 proxy_set_header Host $host;
        }


        
# []byte(),string()数据类型可以强制转换
# 直接使用v1api中的结构体进行返回
```
 res = &v1.Get_time_Res{//api的结构体
Time: gtime.Datetime(),//Time是api的参数
} 
 ```

# 类型转换
  gconv.Interfaces,把接口类型转为实际的类型.例如把数组接口,转为数组.

# 获取变量的数据类型
 fmt.Printf("变量类型为:%T ", 变量)
# 验证数组得浅拷贝,修改源数组数据会影响拷贝后得数组数据
``` 
a := []int{1, 2, 3}
	b := a //地址的拷贝，浅拷贝
	fmt.Println(a, b)

	a[0] = 1000
	fmt.Println(a, b)

	b[2] = 4000
	fmt.Println(a, b)
```

# go类型
```
//go类型:数组=切片=其他语言的列表
s :=[] int {1,2,3 } //切片
    var balance = [5]float32{1000.0, 2.0, 3.4, 7.0, 50.0}//数组
        fmt.Println(balance) //[1000 2 3.4 7 50]
          fmt.Println(s)//[1 2 3]

  var aa map[string]string /*创建map集合 */
    aa = make(map[string]string)
    /* map插入key - value对,各个国家对应的首都 */
    aa [ "France" ] = "巴黎"
    aa [ "Italy" ] = "罗马"
    aa [ "Japan" ] = "东京"
    aa [ "India" ] = "新德里"
  fmt.Println(aa)      
    //map[France:巴黎 India:新德里 Italy:罗马 Japan:东京]
```
 


# api定义中写表中的所有字段,然后控制器中引入api的定义的结构体.logi中引入model中创建的模型表文件中的结构体字段
---

# .api结构体的参数首字母大写.其中的类型会自动转换哦
---
控制器中调用其他控制器.直接使用Admin.Admin_api_menu(). 其中Admin是被调用控制器的结构体对象

```
这是一段代码块3个tab上方的标记反逗号
分割线---
标题#
换行2个空格+回车
```

*api中的结构体必须req,res成对出现
*gtoken的常量设置C:\Users\Administrator\go\pkg\mod\github.com\goflyfox\gtoken@v1.5.6\gtoken\gtoken_conts.go
<!-- *服务中调其他服务的方法.Rbac().Rbac_add()这里的Rbac()服务中的第一个方法返回服务指针.Rbac_add() 此条在gf cli2.0版本中有效.因为没有生成logic目录.新的工具不行-->
*服务中调其他服务的方法:

  引用 "gf2/internal/logic/user"
   user.New().Huo_qu_fen_lei(ctx)
*结构体的字段使用符合. 进行获取.map类型使用下标字段[""]
*控制器中调用服务. service.Rbac().Rbac_add(),其中Rbac()返回服务的指针
*cmd.go中调用控制器方法.  定义一个控制器api中需要的结构体,然后赋值的变量req通过gconv.Struct(req,&vv)转成结构体.再使用 controller.Admin.Admin_api_menu()其中Admin为控制器的实例,Admin_api_menu()为控制器方法.代码示例如下
	var vv *v1.Admin_api_adminmenu_Req //构建api中的结构体Admin_api_adminmenu_Req,然后使用控制的方法进行传送
     req:=g.Map {
"Username":gconv.Map(respData.Data)["userKey"],
	}
	gconv.Struct(req,&vv)
	 controller.Admin.Admin_api_menu(r.Context(),vv)

*服务中设置上下文.	Context().Get(ctx).Data= g.Map{"b":2,"a":Context().Get(ctx).Data["a"]}//设置上下文
*数据库字段xx_xx.这样gf中就转成了Xx_Xx

1.添加新的包
在go.mod中修改go的版本,然后执行go mod tidy.然后在go.mod中添加require github.com/goflyfox/gtoken v1.5.6

gf run main.go运行程序,可以生成exe
数据库配置信息在mainifest->config->config.yaml
新建一个路由组的步骤:
**新添加数据表后,使用gf gen dao命令生成数据表相关文件的步骤:**

**数据库建立数据表,然后 hack\config.yaml中的tables写入要生成模型的表,link输入数据库的账号密码,**

**然后修改manifest->config-config.yaml配置好数据库的账号密码,然后执行gf gen dao,会自动生成.生成内容与数据表数量有关哦**

**gf的流程:控制器中调用service中调用model目录中的各个模型变量.所以**

0.internal\service\internal\do\wenzhang.go添加一个结构体,来源于internal\model\do\admin_menu.go直接复制就行.此变量在service中被do.使用哦

**1需要在model目录中的admin.go文件加入数据表的模型字段定义,该模型字段来自于自动生成的internal-model->entity->表名.go.**

2.service中不错错误处理,只返回err就行,直接在控制器中做判断处理.

经过以上2步就可以在控制器的service中使用添加的数据表各个字段了.

**然后把数据库导出到manifest->config->sql之中,用于备份**

数据表生成的id字段默认是uint64,但是会报错,需要把internal\model\entity\user.go中的id字段类型改成uint即可

1.以下目录都要新建x.go文件,目录有:api,internal-service,internal->controller,internal->model,
2.internal->cmd.go中添加新的路由分组
			s.Group("/", func(group *ghttp.RouterGroup) {
				// Group middlewares.
				group.Middleware(
					service.Middleware().Ctx,
					ghttp.MiddlewareCORS,
				)
				// Register route handlers.
				group.Bind(
					controller.X,
				)

    })
3.控制器中的方法名首字母必须大写

4.运行新的项目例如gtoken时,要把其中的例子文件夹复制出来,然后把项目的go.mod,go.sum复制到例子文件夹中.修改go.mod的内容改成如下,然后f5即可
//module github.com/goflyfox/gtoken
module ga

require (
	github.com/goflyfox/gtoken v1.5.6 //新添加的
	github.com/gogf/gf/v2 v2.0.3
)

go 1.18

1. r.Context()`方法获取上下文对象ctx,r为cmd.go中的http方法中的参数*ghttp.Request**
2. var r = g.RequestFromCtx(ctx)//从上下文ctx中获取r
3. 在service中获取r*ghttp.Request请求对象.需要在service-context.go的init中

> // Init initializes and injects custom business context object into request context.

> func(s *sContext)Init(r *ghttp.Request, customCtx *model.Context){

```
  r.SetCtxVar(consts.ContextKey, customCtx)  
  r1=r}
```

其中var  r1*ghttp.Requestr ,在service-user.go中定义.在init中进行了赋值,获取了当前的r请求对象.然后就可以使用r.resposn

r1.Response.WriteJsonExit(g.Map{"code":"2000",

    "data":"",

    "message":"用户名已存在",

    })代替gerror.newf了

# *vscode配置go
```
{

    "version": "0.2.0",

    "configurations": [

    {

    "name": "Launch Package",

    "type": "go",

    "request": "launch",

    "mode": "auto",

    **"program": "main.go"**

    }

    ]

}
```
# *gtoken使用时,注意login路由一定不要与现在有的api路由一样.

C:\Users\Administrator\go\bin删除gf.exe即可重新安装gf命令行
*中间件都放入了internal-service-middleware中了
*V1-API文件中的参数必须首字母大写,否则post请求不显示请求的参数


github.com/go-sql-driver/mysql是carsbin的驱动

# 删除操作:map的删除delete(map1, "token")         //map1钟删除token字段