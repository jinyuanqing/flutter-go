package cmd

import (
	"context"
	"fmt"
	"gf2/internal/router"

	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/text/gstr"

	"gf2/internal/model/entity"
	"reflect"
	"strings"

	xormadapter "github.com/casbin/xorm-adapter/v3"

	"gf2/internal/consts"
	"gf2/internal/controller"

	"github.com/casbin/casbin/v2"

	"gf2/internal/model"
	"gf2/internal/service"

	_ "github.com/gogf/gf/contrib/drivers/mysql/v2" //gf的数据库驱动

	// "github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gcmd"

	// "github.com/gogf/gf/v2/os/glog"
	// "github.com/gogf/gf/v2/protocol/goai"
	"github.com/gogf/gf/v2/net/goai"
	"github.com/gogf/gf/v2/util/gconv"

	"github.com/goflyfox/gtoken/gtoken"
	"github.com/gogf/gf/v2/os/glog"
	//"gf2.0/utility/response"
	// "github.com/gogf/gf/v2/os/gtime"
	"time"
	// "github.com/casbin/casbin/v2"                   //casbin
	// xormadapter "github.com/casbin/xorm-adapter/v3" //casbin
)

var is_admin string
var Nickname string
var gfToken *gtoken.GfToken
var Qianming string
var Touxiang string
var e1 *casbin.Enforcer
var apinum int
var apiused int
var isused bool

//var gfToken1 *gtoken.GfToken
//var gfAdminToken *gtoken.GfToken

// var e1 *casbin.Enforcer
func beforeServeHook(r *ghttp.Request) { //静态文件的跨域访问
	glog.Debugf(r.GetCtx(), "beforeServeHook [is file:%v] URI:%s", r.IsFileRequest(), r.RequestURI)
	r.Response.CORSDefault()
}

var (
	Main = gcmd.Command{
		Name:  "main",
		Usage: "main",
		Brief: "start http server of simple goframe demos",
		Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {
			//代理访问.需要配合nginx做配置
			//client := g.Client()
			//client.SetProxy("http://192.168.1.5:801") //nginx配置了监听801端口
			//client.SetTimeout(50 * time.Second)
			////response, err := client.Get(ctx, "http://api.ip.sb/ip")//访问这个报错
			////response, err := client.Get(ctx, "http://www.baidu.com")
			//response, err := client.Get(ctx, "http://192.168.1.5:801/so") //nginx配置了/so的路径,返回360搜索的页面
			//if err != nil {
			//	fmt.Println(err)
			//}
			//response.RawDump()//输出代理访问的结果
			s := g.Server()
			router.Init(ctx, s) //调用其他目录的路由
			s.SetConfigWithMap(g.Map{
				"SessionMaxAge": time.Minute * 60 * 24 * 30, //30天
			})
			s.AddStaticPath("/upload_file", "./upload_file") //设置访问目录的别名upload_file,访问路径为    http://localhost:8888/upload_file/1.jpg
			s.AddStaticPath("/js", "./resource/public/js")   //设置访问目录的别名upload_file,访问路径为    http://localhost:8888/upload_file/1.jpg

			s.AddStaticPath("/chunk", "./resource/public/chunk")            //设置访问目录的别名upload_file,访问路径为    http://localhost:8888/upload_file/1.jpg
			s.BindHookHandler("/*", ghttp.HookBeforeServe, beforeServeHook) // 利用hook注入实现上传文件的跨域访问

			MultiLogin, err := g.Cfg().Get(ctx, "gToken.MultiLogin") //读取配置文件中的gtokne配置

			fmt.Println("MultiLogin.Bool()", MultiLogin.Bool())
			if err != nil {
				panic(err)
			}

			loginFunc := befor_user_login // admin登录验证
			//启动gtoken.默认参数位置C:\Users\Administrator\go\pkg\mod\github.com\goflyfox\gtoken@v1.5.7\gtoken\gtoken_conts.go
			gfToken = &gtoken.GfToken{ //注意路径的/哦
				LoginPath:       "/admin_api_signin",             //登录的api路径url,没有实际作用,只是显示
				LoginBeforeFunc: loginFunc,                       //登录验证用户名密码的函数,登陆前的执行的函数.返回token和其他的增加的值
				LoginAfterFunc:  fan_hui,                         //登陆后LoginBeforeFunc函数完毕后,执行的函数.根据上个函数增加的值,查该用户的其他信息和权限等
				LogoutPath:      "/admin_api_logout",             //退出登录的函数.gftoken内置的,只需提供函数名即可
				AuthPaths:       g.SliceStr{"/admin_api_logout"}, // 这里是按照前缀拦截，拦截/user /user/list /user/add ...
				AuthExcludePaths: g.SliceStr{"/user/sign-in", "/admin/admin_api_signin", "/user/get_user_menu", "/user/zhuce", "/xitong/compare_tijiao", "/xitong/compare", "/xitong/get_time",
					"/admin/admin_query_article", "/admin/Update_article_yuedushu", "/admin/Update_article_dianzanshu"}, // /rencaizhaopin/*不拦截所有rencaizhaopin开头得url.不拦截路径管理员登录url,如用户登录不能拦截,增加文章浏览数的api
				MultiLogin:       true,                                                                                  //支持多端登录
				LogoutBeforeFunc: Admin_api_logout,                                                                      //用户退出api
				AuthAfterFunc:    authAfterFunc,                                                                         //LoginAfterFunc执行完毕后再执行其他api时执行.用于把用户信息放入上下文中.
				GlobalMiddleware: false,                                                                                 // 开启全局拦截，默认关闭  开启后加入如下代码  //err = gfToken.Start()
				//if err != nil {
				//	panic(err)
				//}
				EncryptKey: []byte("jinyuanqing_yxzhwcn#*_1234567890"), //  Token加密key生成key時,參與加密的字符串.不能少于11位
				//CacheKey:   "gtoken",//这里修改后,根据token获取的 uuid与gtoken.go的uuid不一致.有待验证
				Timeout: 30 * 24 * 60 * 60 * 1000, //缓存超时时间30天 .刷新时间为此处的一半,在此期间内用户登录则redis服务器中的"gtoken:用户名"键数据会保持不变,否则数据过期消失.用户获取的token值也保持不变的,
				// 缓存模式 1 gcache 2 gredis 3文件,默认1
				CacheMode: 2, //3文件在有效期内写入服务器的临时目录,C:\Users\Administrator\AppData\Local\Temp\gtoken.dat文件名gtoken.dat.服务器重启后不用重新登录.其他模式都不行   .
			}
			//验证token是否合法.此功能在中间件中已经实现,所以不用单独验证了1
			res11 := gfToken.DecryptToken(ctx, "AAjXdNQ1yWAY8cJhF2K70HsOLvyRyG3kjNhpYhrOZUMVWvOYegzga5IRgzEXv0ZZ")
			fmt.Println(res11)
			// gfToken0=gfToken
			//print(gfToken)
			//loginFunc1 := User0yan0zheng ////前台用户登录验证
			////启动gtoken
			//gfToken1 := &gtoken.GfToken{ //注意路径的/哦
			//	LoginPath:        "/user/sign-in",
			//	LoginBeforeFunc:  loginFunc1,
			//	LoginAfterFunc:   fan_hui,
			//	LogoutPath:       "/logout_user",
			//	AuthPaths:        g.SliceStr{"/admin1", "/user1"},                                        // 这里是按照前缀拦截，拦截/user /user/list /user/add ...
			//	AuthExcludePaths: g.SliceStr{"/user/sign-in", "/user/sign-up", "/user/admin_api_signin"}, // 不拦截路径管理员登录url,用户登录
			//	MultiLogin:       true,                                                                   //支持多端登录
			//
			//}
			//print(gfToken1)
			err = gfToken.Start()
			if err != nil {
				panic(err)
			}

			//err = gfToken.Start() //不写不行.缓存模式只有在start后才执行
			//if err != nil {
			//	panic(err)
			//}
			//s.GetOpenApi().Config.CommonResponse=response.JsonRes{}

			s.Use(ghttp.MiddlewareHandlerResponse) //默认的错误处理中间件,调用错误时候的返回码
			// s.Group("/upload_file/", func(group *ghttp.RouterGroup) {
			// 	// Group middlewares.
			// 	group.Middleware(service.Middleware().CORS,
			// 	 service.Middleware().Ctx,
			// 		 ghttp.MiddlewareCORS,MiddlewareCORS1,
			// 	)

			// })

			// s.BindHandler("/", func(r *ghttp.Request) { //url的路由绑定.这是直接生成一个一级url地址.
			// 	r.Response.WriteTpl("index.html", g.Map{"name": "youxue"}) //渲染指定模板,传参使用g.map{}
			// })

			s.BindStatusHandler(404, func(r *ghttp.Request) { //404状态的自定义处理
				r.Response.ClearBuffer() //将清空页面当前显示的错误信息,也就是404时候清楚默认的错误输出转而显示我们自定义的输出内容
				//r.Response.Writeln("亲爱的用户,对不起您访问的页面不存在哦!请确认后访问")
				var error_message string = "亲爱的用户,对不起您访问的页面不存在哦!"
				//r.Response.WriteTpl("404.html", g.Map{"error_message": error_message})//渲染模板输出
				//api模式返回
				r.Response.WriteJsonExit(g.Map{
					"code":    404,
					"message": error_message,
					"data":    "",
				})
			})
			//hello路由绑定
			s.Group("/", func(group *ghttp.RouterGroup) {
				//先执行gtoken,后执行gf的分组中间件.与书写顺序有关.先从token获取用户名或这用户id,然后用于在gf的中间件rbac中验证url是否有权限访问.
				gfToken.Middleware(ctx, group)
				//user路由使用token,必须有,否则就没有gtoken的登录函数api了	// Group middlewares.
				group.Middleware(
					service.Middleware().Ctx,
					ghttp.MiddlewareCORS,
					service.Middleware().Rbac,
				)

				// Register route handlers.
				group.Bind(
					controller.Hello,
				)

			})

			//user路由绑定
			s.Group("/", func(group *ghttp.RouterGroup) {
				//先执行gtoken,后执行gf的分组中间件.与书写顺序有关.先从token获取用户名或这用户id,然后用于在gf的中间件rbac中验证url是否有权限访问.
				gfToken.Middleware(ctx, group)
				//user路由使用token,必须有,否则就没有gtoken的登录函数api了	// Group middlewares.
				group.Middleware(
					service.Middleware().Ctx,
					ghttp.MiddlewareCORS,
					service.Middleware().Rbac,
				)

				// Register route handlers.
				group.Bind(
					controller.User,
				)
				// Special handler that needs authentication.
				//group.Group("/", func(group *ghttp.RouterGroup) {
				//	group.Middleware(service.Middleware().Auth)
				//	group.ALLMap(g.Map{
				//		"/user/profile": controller.User.Profile,
				//	})
				//})
			})
			//rbac认证测试
			s.Group("/rbac", func(group *ghttp.RouterGroup) {

				group.Middleware(
					//service.Middleware().Ctx,
					service.Middleware().Rbac,
					//ghttp.MiddlewareCORS,
				)
				// // 调试路由
				// group.ALL("/rbac_test", func(r *ghttp.Request) {

				// 	r.Response.WriteJsonExit("这是rbac测试,已成功")
				// })

				// // 调试路由
				// group.ALL("/rbac_add", func(r *ghttp.Request) {

				// 	r.Response.WriteJsonExit(g.Map{
				// 		"code":    200,
				// 		"message":"插入rbac成功",
				// 		"data":    "ok",
				// 	})

				// })

				group.Bind(
					controller.Rbac,
				)
			})
			//绑定新的路由/admin
			s.Group("/admin", func(group *ghttp.RouterGroup) { //文档中显示的api路径名称
				//分组中单独绑定一个url.即分组admin+单独绑定路径/test1.这里无需进行token验证
				group.ALL("/test1", func(r *ghttp.Request) {
					r.Response.WriteTpl("index.html", g.Map{"name": "youxue"}) //渲染指定模板,传参使用g.map{}
				})
				//在token中间件之上的都没有token验证.以下的有.
				gfToken.Middleware(ctx, group) //admin路由使用token,必须有,否则就没有gtoken的登录函数api了
				group.Middleware(
					service.Middleware().Ctx,
					ghttp.MiddlewareCORS,
					service.Middleware().Rbac,
				)

				// Register route handlers.
				// 绑定路由必须在中间件的后边,否则报错
				group.Bind(
					controller.Admin, //使用此句则gtokne的路由没有前缀admin了,r如果去掉,直接在分组/处加上admin,则gf的api文件夹v1的路由没有admin
				)

			})
			//绑定新的路由人才招聘.
			s.Group("/rencaizhaopin", func(group *ghttp.RouterGroup) { //文档中显示的api路径名称
				gfToken.Middleware(ctx, group) //admin路由使用token,必须有,否则就没有gtoken的登录函数api了

				group.Middleware(
					service.Middleware().Ctx,
					ghttp.MiddlewareCORS,
					service.Middleware().Rbac,
				)

				group.Bind(
					controller.Rencaizhaopin, //使用此句则gtokne的路由没有前缀admin了,r如果去掉,直接在分组/处加上admin,则gf的api文件夹v1的路由没有admin
				)

			})

			//绑定新的路由系统功能.
			s.Group("/xitong", func(group *ghttp.RouterGroup) { //文档中显示的api路径名称
				gfToken.Middleware(ctx, group) //admin路由使用token,必须有,否则就没有gtoken的登录函数api了

				group.Middleware(
					service.Middleware().Ctx, //其中含有casbin验证
					ghttp.MiddlewareCORS, service.Middleware().Rbac,
				)

				group.Bind(
					controller.Xitong, //使用此句则gtokne的路由没有前缀xitong了,r如果去掉,直接在分组/处加上admin,则gf的api文件夹v1的路由没有admin
				)

			})

			// Custom enhance API document.
			enhanceOpenAPIDoc(s)
			// Just run the server.
			s.Run()
			return nil
		},
	}
)

func enhanceOpenAPIDoc(s *ghttp.Server) {
	openapi := s.GetOpenApi()
	openapi.Config.CommonResponse = ghttp.DefaultHandlerResponse{}
	openapi.Config.CommonResponseDataField = `Data`

	// API description.
	openapi.Info = goai.Info{
		Title:       consts.OpenAPITitle,
		Description: consts.OpenAPIDescription,
		Contact: &goai.Contact{
			Name: "GoFrame",
			URL:  "https://goframe.org",
		},
	}
}
func User0yan0zheng(r *ghttp.Request) (string, interface{}) { //前台用户登录验证
	//r = service.R1
	username := r.Get("Username").String() //获取url的参数
	passwd := r.Get("Password").String()

	if username == "" || passwd == "" {
		r.Response.WriteJsonExit(gtoken.Fail("账号或密码错误."))
		r.ExitAll()
	}
	// 查询数据库验证账号密码

	// fmt.Println(r.Context())
	// var	err = service.User().SignIn(r.Context(), model.UserSignInInput{
	// 		Username: username,
	// 		Password: passwd,
	// 	})
	// if r0, err :=g.Client().Post(r.Context(), "http://localhost:8199/user/sign-in", g.Map{"Username": username,
	// "Password": passwd}); err != nil {
	// 	panic(err)
	// } else {
	// 	defer r0.Close()

	// 	fmt.Println(r0.ReadAllString()[0])

	// 		type mess struct {

	// 			code   string `json:"code"`
	// 			message   string `json:"message"`
	// 			data   string `json:"data"`
	// 		}
	// var mess1 *mess

	//a:=gconv.Struct(g.Map(r0.ReadAllString()),&mess1)
	///fmt.Println(mess1)
	// }
	userinfo, err := service.User().SignIn(r.GetCtx(), model.UserSignInInput{
		Username: username,
		Password: passwd,
	})
	fmt.Println(err)
	// a1,err:=controller.User.SignIn(r.Context(),&v1.UserSignInReq{

	// 	Username: username,
	// 		Password: passwd,
	// })
	// fmt.Println(a1)
	if err != nil {
		//r.Response.WriteJsonExit(gerror.New("粗无了"))
		r.Response.WriteJsonExit(gtoken.Fail("账号或密码错误"))
		r.ExitAll()

	} else { //r如果查询成功
		//is_admin = "false"

	}
	return username, userinfo
}

// 所有用户登录接口
func befor_user_login(r *ghttp.Request) (string, interface{}) { //登录,验证用户名和密码
	username := r.Get("Username").String()
	passwd := r.Get("Password").String()

	if username == "" || passwd == "" {
		//r.Response.WriteJsonExit(gtoken.Fail("账号或密码错误."))
		r.Response.WriteJsonExit(g.Map{
			"code":    "1",
			"data":    "",
			"message": "用户名或密码错误,请输入字符",
		})
		r.ExitAll()
	}

	if strings.Contains(username, " ") || strings.Contains(passwd, " ") { //用户名密码都不能包含空格

		r.Response.WriteJsonExit(g.Map{
			"code":    "1",
			"data":    "",
			"message": "用户名或密码错误,包含空",
		})
		r.ExitAll()
	}
	//连接casbin
	mysqluserpasswd, _ := g.Cfg().Get(r.Context(), "database.default.link")
	fmt.Println(gstr.StrEx(mysqluserpasswd.String(), ":"))                                     // gstr.Split(mysqluserpasswd.String()":")[1]
	a, err := xormadapter.NewAdapter("mysql", gstr.StrEx(mysqluserpasswd.String(), ":"), true) //会自动创建一个casbin_csv策略表

	if err != nil {
		r.Response.WriteJsonExit(g.Map{
			"code":    "404",
			"message": "casbin数据库连接出错",
			"data":    "",
		})
		r.ExitAll()
	} else {
		//var f,err1=os.Open("./config/rbac/rbac.conf" )
		//if err1 != nil {
		//	fmt.Println("文件错误",f)
		//}

		e1, err = casbin.NewEnforcer("./manifest/config/rbac/rbac_model.conf", a) //从本地文件夹加载rbac.conf配置文件 .此处与当前项目打开的目录有关系

		if err != nil {

			r.Response.WriteJsonExit(g.Map{
				"code":    "1",
				"message": "中间件权限错误",
				"data":    "",
			})
			//r.ExitAll()
		}
	}

	// 查询数据库验证账号密码
	//ctx := context.TODO()
	//r.SetCtxVar("Username", "user.Username")
	//fmt.Println(r.GetCtxVar("Username"))

	userinfo, err := service.User().SignIn(r.Context(), model.UserSignInInput{ //验证用户名密码,然后登录
		//var err = service.Admin().SignIn(r.Context(), model.UserSignInInput{
		//id:	res.Id,
		Username: username,
		Password: passwd,
	})
	//println(gerror.Code(err).Code())
	if err != nil {
		r.Response.WriteJsonExit(g.Map{
			"code":    gconv.String(gerror.Code(err).Code()), //gerror.Code(err).Message(),
			"message": err.Error(),
			"data":    "",
		}) //此处直接输出错误了,非json格式输出因此不用
		//r.Response.WriteJsonExit(gtoken.Fail(gconv.String(err)))
		//r.ExitAll()

	}

	Nickname = userinfo.Nickname
	Qianming = userinfo.Qianming
	Touxiang = userinfo.Touxiang

	apinum = int(userinfo.Apinum)
	apiused = userinfo.Apiused
	isused = bool(userinfo.Isused)

	if userinfo.Isadmin == true { //判断user表中的用户角色.1为管理员,0为普通用户.这里也可以进行扩展.例如2代表次级管理员等

		is_admin = "admin"

	} else if userinfo.Isadmin == false {

		is_admin = "user"
	}

	// gtoken是文件缓存时候    Token_data1中不要有指针,一旦有指针存放到file后,下次启动内容会变化.另外指针无法存放到file中
	type Token_data1 struct {
		Userinfo *entity.User
		C1       string
		Casbin1  casbin.Enforcer
	}
	User_data := Token_data1{
		C1: "经营权", Casbin1: *e1, Userinfo: userinfo,
	}
	//username一定要唯一标识也就是respose.data中的["userkey"].最佳是用id,User_data是附加的其他信息.再authAfterFunc中设置到上下文中.
	//User_data用于加密生成token的额外信息,另外可以通过fan_hui方法返回给前台
	return username, User_data

}

// 返回给客户端的数据,可以自增数据.返回的数据respData默认只提供3个数据"token","userKey"	,"uuid",然后添加后会在此基础上扩充数据
func fan_hui(r *ghttp.Request, respData gtoken.Resp) {
	g.Dump(respData) //  只包括3个值, "token","userKey"	,"uuid",不含有User_data

	//a := (gconv.Map(respData.Data)["data"])
	//	g.Dump(gfToken.GetTokenData(r)) //这里会输出一个      Code: -401, Msg:  "token is empty",Data: "",

	//var userInfo entity.User

	//err := gconv.Struct((gconv.Map(a)["Userinfo"]), &userInfo) //获得befor_user_login方法中的返回登录用户其他信息User_data

	//println(err)
	//覆盖设置gftoken的返回值
	// respData.Data=g.Map{
	// 	"is_admin": is_admin,
	// 	// "token": respData.Data,
	// }
	//resdata中已经带有token和uuid2个返回值了
	//增加设置gftoken的返回值
	gconv.Map(respData.Data)["is_admin"] = is_admin //角色
	gconv.Map(respData.Data)["nickname"] = Nickname //昵称
	gconv.Map(respData.Data)["qianming"] = Qianming //签名
	gconv.Map(respData.Data)["touxiang"] = Touxiang //头像
	gconv.Map(respData.Data)["apinum"] = apinum     //api调用次数上限
	gconv.Map(respData.Data)["isused"] = isused     //用户是否启用.数据库是0读取过来是false
	gconv.Map(respData.Data)["apiused"] = apiused   //api调用的已用次数.默认0
	gconv.Map(respData.Data)["gfsessionid"], _ = r.Session.Id()

	//fmt.Println(gconv.Map(respData.Data))
	//fmt.Println(gconv.Map(respData.Data)["userKey"])
	//写入redis

	//l := glist.New()
	//
	//// Push//从后面插入值
	//l.PushBack(1)
	//l.PushBack((g.Map{gconv.String(gconv.Map(respData.Data)["userKey"]): gconv.Map(respData.Data)})) //从后面插入值
	//usertoken := l
	//println(gconv.String(usertoken))
	//_, err := g.Redis().Set(r.Context(), "gf_user_token", usertoken)
	//if err != nil {
	//	g.Log().Fatal(r.Context(), err)
	//}

	//return respData

	//   a1:=gfToken.GetTokenData(r)//获取登录信息
	//   fmt.Println(a1)

	// 测试用
	//if respData.Msg == "success" { //返回token成功后执行
	//
	//	req := g.Map{
	//		"Username": gconv.Map(respData.Data)["userKey"],
	//	}
	//	var vv *v1.Admin_api_adminmenu_Req //构建api中的结构体Admin_api_adminmenu_Req,然后使用控制的方法进行传送
	//	gconv.Struct(req, &vv)
	//
	//	//   controller.Admin.Admin_api_menu(r.Context(),vv)
	//}
	r.Response.WriteJsonExit(respData) //客户端输入用户名密码登录后,返回给客户端的值.包括token和别的信息.用户的信息可以通过api获取,可以通过authAfterFunc函数传递用户信息到上下文,然后再别的获取用户信息接口返回
	// 	  r.Response.WriteJsonExit(g.Map{
	// 	"code": 0,
	// 	"msg": "success",
	// 	"data":  g.Map{

	//				"gfsessionid": "ttfp6001687c9bcshmjv34m48010085e",
	//				"is_admin": "true",
	//				"is_admin1": "is_admin1",
	//				"token": "+wIMVe/qUEgz6W98pOjMvyjDG4wx4xRqgtyfrbQVFUeRkd4FMm8fgqFih7zNYmXf",
	//				"userKey": "youxue",
	//				"uuid": "ed138775a34fd129f8b829fc5ac7f7ba",
	//			},
	//	 })
}

// 认证返回方法	AuthAfterFunc	拦截认证完成后调用的中间件. 所有使用gtoken中间件的url都会执行这里.可在此处获取LoginBeforeFunc登录函数befor_user_login  添加的user_data用户数据.并把数据放入上下文中.
// 所有的上下文设置变量都写在这里.
func authAfterFunc(r *ghttp.Request, res gtoken.Resp) {

	//print(res.Json())
	//g.Dump(gfToken.GetTokenData(r)) //这里会输出一个结构体如:
	//{
	//Code: 0,
	//	Msg:  "success",
	//	Data: {
	//	"createTime":  1.714743293255e+12,
	//		"data":        {
	//		"Userinfo": {
	//			"email":        "76115345@qq.com       ",
	//				"createAt":     "2023-06-09 10:57:59",
	//				"touxiang":     "http://127.0.0.1:8199/upload_file/a2b11184-d327-4488-a597-56ffde27e7aa.jpg       ",
	//				"isadmin":      true,
	//				"apinum":       10,
	//				"username":     "youxue",
	//				"birthday":     "19840318   ",
	//				"beiyong1":     "0",
	//				"qianming":     "新签名       ",
	//				"ip":           "192.168.2.3",
	//				"jifen":        100,
	//				"tel":          "15174065551",
	//				"shenfenzheng": "21072719840318123       ",
	//				"apiused":      1,
	//				"nickname":     "幽雪1",
	//				"password":     "jinjin1984",
	//				"address":      "辽宁锦州义县       ",
	//				"updateAt":     "2024-04-07 11:17:09",
	//				"sex":          "男 ",
	//				"isused":       true,
	//				"id":           1,
	//		},
	//		"C1":       "经营权",
	//			"Casbin1":  {},
	//	},
	//	"refreshTime": 1.716039293255e+12,
	//		"userKey":     "youxue",
	//		"uuid":        "12147caf50cfa3f87d916553897d7ed6",
	//},
	//}

	if res.Code != 0 { //则token中有问题:token为空或者乱写
		r.Response.WriteJsonExit(g.Map{
			"code":    "1",
			"data":    "",
			"message": res.Msg,
		})
		//r.ExitAll()
	}
	a := (gconv.Map(res.Data)["data"]) //获得befor_user_login方法中的返回登录用户其他信息User_data

	var userInfo entity.User
	var casbin2 casbin.Enforcer
	err2 := gconv.Struct((gconv.Map(a)["Casbin1"]), &casbin2)  //User_data的内容1
	err := gconv.Struct((gconv.Map(a)["Userinfo"]), &userInfo) //User_data的内容2
	//err := gconv.Struct(res.GetString("data")["Userinfo"], &userInfo)

	if strings.Contains(userInfo.Username, " ") { //没用了

		r.Response.WriteJsonExit(g.Map{
			"code":    "1",
			"data":    "",
			"message": "用户名错误,包含空",
		})
		r.ExitAll()
	}
	if userInfo.Username != gconv.Map(res.Data)["userKey"] {
		r.Response.WriteJsonExit(g.Map{
			"code":    "1",
			"data":    "",
			"message": "从gtoken中获取数据失败了,重新登录",
		})
		r.ExitAll()

	}
	if err != nil || err2 != nil {
		//从gtoken中获取数据失败了
		r.Response.WriteJsonExit(g.Map{
			"code":    "1",
			"data":    "",
			"message": "从gtoken中获取数据失败了,重新登录",
		})
		r.ExitAll()
	}
	//todo 这里可以写账号前置校验、是否被拉黑、有无权限等逻辑
	r.SetCtxVar("ctx_gftoken", gfToken)
	r.SetCtxVar("ctx_username", userInfo.Username)           //用户名放入上下文
	aa1 := g.Ctx(r.Context()).Value("ctx_username").(string) // 类型断言：将 any 类型转换为 string 类型

	println(aa1)

	userinfo1 := gconv.Map(a)["Userinfo"]
	print("isadmin")
	fmt.Println(reflect.TypeOf(gconv.Map(userinfo1)["isadmin"]))
	print(gconv.Int(gconv.Map(userinfo1)["isadmin"]))
	if (gconv.Int(gconv.Map(userinfo1)["isadmin"])) == 1 {
		is_admin = "admin"
	} else {

		is_admin = "user"
	}

	r.SetCtxVar("ctx_role", is_admin) //把isadmin放入上下文,代表角色
	r.SetCtxVar("ctx_user", userInfo) //把userinfo放入上下文
	r.SetCtxVar("user_token", gconv.Map(a)["token"])
	//r.SetCtxVar("ctx_casbin", casbin2)
	var userInfo1 entity.User
	//var casbin3 casbin.Enforcer
	err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userInfo1) //获取上下文数据

	//err3 := r.GetCtxVar("ctx_casbin").Structs(&casbin3)
	//g.Dump(&casbin3)
	if err1 != nil {
		print("发生了错误")
		r.ExitAll()
	}
	r.Middleware.Next()
}
func Admin_api_logout(r *ghttp.Request) bool {

	fmt.Println("用户退出了哦")
	return true
}
