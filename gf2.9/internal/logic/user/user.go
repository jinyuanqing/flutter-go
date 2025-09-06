package user

import (
	"context"
	"fmt"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
	"reflect"

	// "fmt"
	"gf2/internal/service"
	// "github.com/gogf/gf/v2/util/gconv"
	"gf2/internal/dao"
	"gf2/internal/model"
	"gf2/internal/model/do"
	"gf2/internal/model/entity"

	// "gf2/internal/service/internal/do"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"

	// "github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
)

var R1 *ghttp.Request

type (
	// sUser is service struct of module User.
	sUser struct{}
)

func init() {
	service.RegisterUser(New())
}

func New() *sUser {
	return &sUser{}
}

func (s *sUser) S_get_alluser_num(ctx context.Context) (num int, err error) {

	num, err = dao.User.Ctx(ctx).Where("id > ? ", 1).Count()
	// a, err1 := dao.User.Ctx(ctx).Where("usernamE='user2'").All()//查询username=user2的数据,其中的字段字母大小写都可
	return num, err

}
func (s *sUser) S_Get_user_accordto_page(ctx context.Context, page int) (res gdb.Result, err error) {

	res, err = dao.User.Ctx(ctx).Page(page, 10).OrderAsc("id").All()
	// a, err1 := dao.User.Ctx(ctx).Where("usernamE='user2'").All()//查询username=user2的数据,其中的字段字母大小写都可
	return res, err

}
func (s *sUser) Get_menu_user(ctx context.Context, username string) (interface{}, error) {
	//var m4 []g.Map
	//获取所有菜单.从表usermenu表中
	//
	//return res, err

	//var userInfo1 entity.User
	//g.Dump(ctx.Value("ctx_user"))/

	//err1 := gconv.Struct(ctx.Value("ctx_user"), &userInfo1)
	//if err1 != nil {
	//	print("转换错误")
	//	return nil, err1
	//}
	//username = userInfo1.Username
	//role := gconv.String(ctx.Value("ctx_role")) //获取上下文的角色ctx_role/

	var json_res model.UserMenuRes //可代替var admin_menu *entity.AdminMenu.区别是可对字段进行筛选显示

	// var admin_menu *entity.AdminMenu
	// res, err := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: "0"}).All()
	// fmt.Println("res:", res)
	// gconv.Struct(res[0], &admin_menu) //把res由gdb.result(实质是map类型)json_res的值为{值1,值2....},而非json的{"x":"x"}
	// fmt.Println("admin_menu:", admin_menu)
	// g.Dump(admin_menu)
	//获取所有菜单.从表admin_menu表中
	res, err := dao.UserMenu.Ctx(ctx).Where("user_menu_parentid >= 0").All() //parent_id >= 0与数据库中的表字段相互一致哦
	fmt.Println("res:", res)
	// fmt.Println("res[i+1]['menuid']:", res[0]["menuid"])
	// fmt.Println("res[0]:", res[0])
	fmt.Println("res[0]type:", reflect.TypeOf(res[0]))
	var treeList []model.UserMenuRes
	var treeList0 []model.UserMenuRes
	// var treeList1 []*v1.Admin_api_adminmenu_Res
	for i := 0; i < res.Len(); i++ { //查询casbin_rule表获取当前角色的所有可访问的url路由,放入treelist
		gconv.Struct(res[i], &json_res) //&json_res=*json_res.把res由gdb.result(实质是map类型)转成json_res的值为json的{"x":"x"}

		// fmt.Println("admin_menu:", json_res)
		//g.Dump(json_res)
		//权限菜单处理.无权限的菜单不加入

		treeList = append(treeList, json_res) //append 函数向 slice 尾部添加数据.treeList是菜单模型model.Admin_api_adminmenu_Res的切片,等同python的list

	}
	// g.Dump(treeList)
	//	m.Set(1, 0)
	//调用
	// fmt.Println(tree(list,0))
	// res1, err := dao.AdminMenu.Ctx(ctx).Where("Parentid == 0").All()
	g.Dump(len(treeList))
	// var treeList2 [][]*v1.Admin_api_adminmenu_Res
	// for i := 0; i < len(treeList); i++ {
	// 	if treeList[i].ParentId == 0 {
	treeList0 = getmenu(treeList, 0) //递归获取层级菜单,0为父节点

	//var _ g.Map
	//var m1 []g.Map
	// 创建并发安全的int类型数组
	// var shuzu1 []g.Array
	//var m3 []g.Map //存放顶层菜单下属的children菜单
	//var m4 []g.Map
	//err4 := gconv.Scan(treeList0, &m1) //m1为层级菜单.要对其中的parentid=0,且Children=nil的去除
	//if err4 != nil {
	//	return nil, err
	//}

	//for i := 0; i < len(m1); i++ {
	//	err5 := gconv.Scan(m1[i]["Children"], &m3)
	//	g.Dump(err5)
	//	g.Dump(len(m3)) //判断顶层菜单下属的children菜单是否存在.如果不存在长度为0,存在长度为1
	//	// g.Dump((m1[i]["Children"]))
	//	g.Dump(m1[i])
	//	if len(m3) != 0 {
	//		m4 = append(m4, m1[i]) //m4为最终的用户可访问的多级菜单
	//		m3 = nil               //清空map数组,直接赋值nil即可
	//	}
	//}

	return treeList0, err

}

// 递归获取层级菜单
func getmenu(list0 []model.UserMenuRes, pid int) []model.UserMenuRes {

	var m []model.UserMenuRes
	for _, r := range list0 {
		if r.UserMenuParentid == pid {
			r.Children = getmenu(list0, r.UserMenuId) //if此处没有UserMenuId则,getmenu返回的是空m,因此r.children就是空.
			m = append(m, r)
		}
	}

	return m //递归时候如果无children则返回空,因为m定义是空的列表
}

func (s *sUser) Huo_qu_fen_lei(ctx context.Context) (res gdb.Result, err error) {

	res, err = dao.Wenzhangfenlei.Ctx(ctx).OrderAsc("id").All()
	// a, err1 := dao.User.Ctx(ctx).Where("usernamE='user2'").All()//查询username=user2的数据,其中的字段字母大小写都可
	return res, err

}

func (s *sUser) Query0wen0zhang(ctx context.Context, page int) (res gdb.Result, err error) { //获取全部文章

	res, err = dao.WenZhang.Ctx(ctx).Page(page, 10).OrderAsc("id").All() //page是页数从1开始.

	return res, err

}

// 注册用户.
func (s *sUser) Create(ctx context.Context, in model.UserCreateInput) (err error) {
	// If Nickname is not specified, it then uses Passport as its default Nickname.
	if in.Nickname == "" {
		in.Nickname = in.Username
	}
	var (
		available bool
	)

	// Passport checks.
	available, err = s.IsPassportAvailable(ctx, in.Username)
	if err != nil {
		return err
	}
	if !available {
		// return gerror.Newf(`用户名已存在`, in.Username)

		return gerror.NewCode(gcode.New(1, "用户名已经存在了哦,"+in.Username, "detailed description"))

		// return gerror.Newf(`用户名已存在`, g.Map{"code": "1", //代码此处随意填写.超过1000即可
		// 	"data":    in.Username,
		// 	"message": "用户名已存在",
		// })
		// R1.Response.WriteJsonExit(g.Map{"code": "50", //代码此处随意填写.超过1000即可
		// 	"data":    "null",
		// 	"message": "用户名已存在",
		// }) //用于替换gerror.newf的功能
	}
	// Nickname checks.
	available, err = s.IsNicknameAvailable(ctx, in.Nickname)
	if err != nil {
		return err
	}
	if !available {
		// return gerror.Newf(`昵称被占用`, in.Nickname)
		return gerror.NewCode(gcode.New(1, "昵称被占用,"+in.Nickname, "detailed description"))

	}
	err = dao.User.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error {
		_, err = dao.User.Ctx(ctx).Data(do.User{
			Username:     in.Username,
			Password:     in.Password,
			Nickname:     in.Nickname,
			Email:        in.Email, //`json:"email"    ` // 邮箱
			Address:      in.Address,
			Tel:          in.Tel,
			Birthday:     in.Birthday,
			Sex:          in.Sex,
			Qianming:     in.Qianming,
			Shenfenzheng: in.Shenfenzheng,
			Ip:           in.Ip,
			Touxiang:     in.Touxiang,
			Jifen:        in.Jifen,
			Beiyong1:     in.Beiyong1,
			Isadmin:      in.Isadmin,
		}).Insert()

		return err
	})
	//给用户设置user角色,写入casbin_rule表.
	//r := g.RequestFromCtx(ctx)
	////casbin添加用户角色
	//var e *casbin.Enforcer
	////获取上下文的casbin
	//
	//err3 := r.GetCtxVar("Casbin_Enforcer").Structs(&e)
	////g.Dump(&casbin3)
	//if err3 != nil {
	//	print("发生了错误")
	//	r.ExitAll()
	//}
	//
	////连接casbin
	//mysqluserpasswd, _ := g.Cfg().Get(r.Context(), "database.default.link")
	////fmt.Println(gstr.StrEx(mysqluserpasswd.String(), ":"))                                                            // gstr.Split(mysqluserpasswd.String()":")[1]
	//a, err := xormadapter.NewAdapter("mysql", gstr.StrEx(mysqluserpasswd.String(), ":"), true) //会自动创建一个casbin_csv策略表
	//
	//if err != nil {
	//	r.Response.WriteJsonExit(g.Map{
	//		"code":    404,
	//		"message": "数据库连接出错",
	//		"data":    "",
	//	})
	//	r.ExitAll()
	//} else {
	//
	//	e, err = casbin.NewEnforcer("./manifest/config/rbac/rbac_model.conf", a) //从本地文件夹加载rbac.conf配置文件
	//
	//	if err != nil {
	//
	//		r.Response.WriteJsonExit(g.Map{
	//			"code":    "1",
	//			"message": "中间件权限错误",
	//			"data":    "",
	//		})
	//		//r.ExitAll()
	//	}
	//}
	//
	//jieguo, err := e.AddRoleForUser(in.Username, "user") //给用户添加user角色.
	//if jieguo == false {
	//
	//	r.Response.WriteJsonExit(g.Map{
	//		"code":    "1",
	//		"message": "给用户添加角色失败",
	//		"data":    "",
	//	})
	//	//r.ExitAll()
	//}

	return err

}

// IsSignedIn checks and returns whether current user is already signed-in.
func (s *sUser) IsSignedIn(ctx context.Context) bool {
	if v := service.Context().Get(ctx); v != nil && v.User != nil {
		return true
	}
	return false
}

// SignIn creates session for given user account.
func (s *sUser) SignIn(ctx context.Context, in model.UserSignInInput) (userinfo *entity.User, err error) {
	var user *entity.User

	err = dao.User.Ctx(ctx).Where(do.User{
		Username: in.Username,
		Password: in.Password,
	}).Scan(&user)
	if err != nil {
		return nil, err
	}
	if user == nil {
		return nil, gerror.NewCode(gcode.New(1, "用户名密码错误", nil), `用户名或者密码错误`)
	}
	// fmt.Println(ctx)
	//登陆成功设置session和上下文变量.主要是session,下次用于验证请求是否登录
	//if err = service.Session().SetUser(ctx, user); err != nil {
	//	return nil, err
	//}
	//此处不再把user信息放入上下文了.在gtoken的登陆验证中做
	//service.Context().SetUser(ctx, &model.ContextUser{
	//	Id:       user.Id,
	//	Username: user.Username,
	//	Nickname: user.Nickname,
	//	Qianming: user.Qianming,
	//})
	return user, nil
}

// SignOut removes the session for current signed-in user.
func (s *sUser) SignOut(ctx context.Context) error {
	return service.Session().RemoveUser(ctx)
}

// IsPassportAvailable checks and returns given passport is available for signing up.
func (s *sUser) IsPassportAvailable(ctx context.Context, Username string) (bool, error) {
	count, err := dao.User.Ctx(ctx).Where(do.User{
		Username: Username,
	}).Count()
	if err != nil {
		return false, err
	}
	return count == 0, nil
}

// IsNicknameAvailable checks and returns given nickname is available for signing up.
func (s *sUser) IsNicknameAvailable(ctx context.Context, nickname string) (bool, error) {
	count, err := dao.User.Ctx(ctx).Where(do.User{
		Nickname: nickname,
	}).Count()
	if err != nil {
		return false, err
	}
	return count == 0, nil
}

// GetProfile retrieves and returns current user info in session.
func (s *sUser) GetProfile(ctx context.Context) *entity.User {
	//r := g.RequestFromCtx(ctx)

	return service.Session().GetUser(ctx) //获取用户的session值
}
