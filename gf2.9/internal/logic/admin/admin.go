package admin

//在控制器目录文件中调用的方法
import (
	"context"
	"database/sql"
	"fmt"
	v1 "gf2/api/v1"

	// "go/printer"
	"reflect"
	"time"

	// "github.com/gogf/gf/v2/container/gtree"
	// "github.com/gogf/gf/v2/util/gutil"
	// v1 "gf2/api/v1"
	//  "github.com/go-delve/delve/service"
	"gf2/internal/dao"
	// "gf2/internal/logic/user"
	"gf2/internal/model"
	"gf2/internal/model/do"
	"gf2/internal/model/entity"
	"gf2/internal/service"

	// "github.com/gogf/gf/v2/container/gmap"
	// "github.com/gogf/gf/v2/container/gvar"
	// "github.com/gogf/gf/v2/frame/g"

	// "github.com/gogf/gf/v2/container/garray"
	// "github.com/gogf/gf/v2/container/gmap"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
)

type (
	// 作为本页函数的返回值指针
	sAdmin struct{}
)

func init() {
	service.RegisterAdmin(New())
}

func New() *sAdmin {
	return &sAdmin{}
}

//var (
//	// inadmin is the instance of service User.
//	insAdmin = sAdmin{}
//)
//
//// User returns the interface of User service.
//func Admin() *sAdmin { //Admin在service->admin.go中使用了
//	return &insAdmin
//}

func (s *sAdmin) Set_user_authority(ctx context.Context, rolename string, add_authority g.Array, del_authority g.Array) (result sql.Result, err error) {
	a1 := g.List{}

	for index, value := range add_authority {
		a1 = append(a1, g.Map{
			"Ptype": "p",
			"V0":    rolename,
			"V1":    value,
			"V2":    "post",
			"V3":    "",
			"V4":    "",
			"V5":    ""}) //把a1,末尾追加传入的用户id

		println(index)
	}
	println(a1)

	result, err = dao.CasbinRule.Ctx(ctx).Data(a1).Insert()
	//删除掉v0是user角色的v1数据集合.必须加where,否则casbin_rule中包含多个角色,会造成其他角色的v1被误删除
	result1, err := dao.CasbinRule.Ctx(ctx).Where("v0", rolename).Delete("v1 IN (?)", del_authority)
	println(result)
	println(result1)
	return result, err

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

	//   result2, err2 :=service.User().Huo_qu_fen_lei(ctx)
	// 	  println(result2,err2)

	// result2, err2 :=user.New().Huo_qu_fen_lei(ctx)
	// println(result2,err2)
	return result, err

}

func (s *sAdmin) SignIn(ctx context.Context, in model.UserSignInInput) (err error) {
	r := g.RequestFromCtx(ctx)
	//r.SetCtxVar("Username", "user.Username")
	fmt.Println(r.GetCtxVar("Username"))
	//r.Session.Set("time", "123")

	print("打印session:")
	data, _ := r.Session.Data()
	print(data)

	var user *entity.User
	err = dao.Admin.Ctx(ctx).Where(do.Admin{ //使用admin表进行查询
		Username: in.Username,
		Password: in.Password,
		//	Qianming: in.Qianming,
	}).Scan(&user)
	if err != nil {
		return err
	}
	if user == nil {
		return gerror.New(`用户名或密码不对`)
	}

	if err = service.Session().SetUser(ctx, user); err != nil {
		return err
	}
	// 把用户名,昵称,签名放入ctx中.这样可在这个请求中任意位置获取
	service.Context().SetUser(ctx, &model.ContextUser{
		Id:       user.Id,
		Username: user.Username,
		Nickname: user.Nickname,
		Qianming: user.Qianming,
	})

	return nil
}

// type *v1.Admin_api_adminmenu_Res struct { //在service-admin.go中使用,决定了输出给用户前端的格式和字段数量
//
//		Id       int
//		MenuId   int
//		MenuUrl  string
//		MenuName string
//		ParentId int
//		Menupath string
//		Children []*v1.Admin_api_adminmenu_Res
//	}
type Menu_list *model.Admin_api_adminmenu_Res

// Create creates user account.
func (s *sAdmin) Create(ctx context.Context, in model.AdminCreateInput) (err error) {
	// If Nickname is not specified, it then uses Passport as its default Nickname.
	if len(in.Username) <= 1 {
		return gerror.Newf(`name "%s" is 不能为空哦`, in.Username)
	}

	// // Nickname checks.
	// available, err = s.IsNicknameAvailable(ctx, in.Nickname)
	// if err != nil {
	// 	return err
	// }
	// if !available {
	// 	return gerror.Newf(`Nickname "%s" is already token by others`, in.Nickname)
	// }
	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //写数据表
		//return dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //写数据表
		_, err = dao.Admin.Ctx(ctx).Data(do.Admin{
			Username: in.Username,
			Password: in.Password,
		}).Insert()

		return err

	})
	if err == nil {
		return gerror.NewCodeSkip(gcode.CodeOK, 999, "成功了") //	gerror.NewCodeskip不会输出堆栈信息,	gerror.NewCode会输出堆栈信息
	} else { //	fmt.Println("错误是:",err)
		return //gerror.New("不成功了")
	}
}

// // IsSignedIn checks and returns whether current user is already signed-in.
// func (s *admin) IsSignedIn(ctx context.Context) bool {
// 	if v := Context().Get(ctx); v != nil && v.User != nil {
// 		return true
// 	}
// 	return false
// }

// SignIn creates session for given user account.
func (s *sAdmin) Query(ctx context.Context, in model.AdminCreateInput) (err error) {
	var user *entity.User
	var admin *entity.Admin
	err = dao.Admin.Ctx(ctx).Where(do.Admin{ //ctx返回模型
		Username: in.Username,
		Password: in.Password,
	}).Scan(&admin) //查询到的一条数据.存放到了Scan的参数user中.user的值为{值1,值2....},而非json的{"x":"x"}
	//fmt.Println(user)
	if err != nil {
		return err
	}
	if admin == nil {
		return gerror.New(`用户名或密码不正确!`)
	}

	//	user.Username=admin.Username

	gconv.Struct(admin, &user) //将admin转换为user结构体
	fmt.Println("a:", admin)

	if err = service.Session().SetUser(ctx, user); err != nil {
		return err
	}
	// fmt.Println("b:", Session().GetUser(ctx))
	fmt.Println("c:", service.Session().GetUser(ctx).Username)
	fmt.Println("d:", service.Session().GetUser(ctx).Password)
	// Context().SetUser(ctx, &model.ContextUser{
	// 	Id:       user.Id,
	// 	Username: user.Username,
	// 	Nickname: user.Nickname,
	// })
	return nil //必须返回nil.然后传给token登录验证函数中的err.
}

func (s *sAdmin) Query0wen0zhang0num(ctx context.Context, zuozhe string) (res int, err error) { //获取全部文章数量

	res, err = dao.WenZhang.Ctx(ctx).Where("zuozhe", zuozhe).Count()

	return res, err

}

func (s *sAdmin) Update_user(ctx context.Context, user g.Map) (res sql.Result, err error) { //更新用户信息.返回结果为sql.result,要引入"database/sql"库

	res, err = dao.User.Ctx(ctx).Data(user).Where("id", gconv.String(user["id"])).Update()

	return res, err

}
func (s *sAdmin) Get_userinfo(ctx context.Context, user g.Map) (res gdb.Result, err error) { // 用户信息.返回结果为sql.result,要引入"database/sql"库

	var usermap = g.Map{}
	if user["username"] != "" && user["username"] != nil { //username传递为空字符串,或者不传递时为nil
		usermap["username"] = user["username"]
	}
	if user["id"] != "" && user["id"] != nil {
		usermap["id"] = user["id"]
	}
	if user["nickname"] != "" && user["nickname"] != nil {
		usermap["nickname"] = user["nickname"]
	}
	res, err = dao.User.Ctx(ctx).Where(usermap).OrderAsc("id").All()

	return res, err

}

// 获取角色权限
func (s *sAdmin) Get_user_authority(ctx context.Context, rolename string) (res gdb.Result, err error) { //更新用户信息.返回结果为sql.result,要引入"database/sql"库

	res, err = dao.CasbinRule.Ctx(ctx).Where("v0", rolename).All()

	return res, err

}

func (s *sAdmin) Get_user(ctx context.Context, user g.Map) (res gdb.Record, err error) { //更新用户信息.返回结果为sql.result,要引入"database/sql"库

	res, err = dao.User.Ctx(ctx).Where("id", user["Id"]).One()

	return res, err

}

func (s *sAdmin) Query0wen0zhang(ctx context.Context, page int, fenleiid int) (res gdb.Result, err error) { //获取全部文章
	if fenleiid == 0 {                                                                                      //不按分类查询所有的数据
		res, err = dao.WenZhang.Ctx(ctx).Page(page, 10).OrderDesc("id").All() //page是页数从1开始.
	} else { //按分类查询
		res, err = dao.WenZhang.Ctx(ctx).Where("fenleiid", fenleiid).Page(page, 10).OrderDesc("id").All() //page是页数从1开始.
	}
	return res, err

}

func (s *sAdmin) Query0tiao0jian0wen0zhang(ctx context.Context, map1 g.Map) (res gdb.Result, err error) { //筛选文章
	biaoti := gconv.String(map1["Biaoti"])
	riqi1 := map1["Riqi1"]
	riqi2 := map1["Riqi2"]
	page := gconv.Int(map1["Page"])

	zuozhe := map1["Zuozhe"]
	fenleiid := map1["Fenleiid"]
	// var condition g.Map
	var a1 g.Map
	a1 = g.Map{}
	// condition = g.Map{
	// 	"biaoti like ?": "%" + biaoti + "%",
	// 	// "fenleiid":                   fenlei_id,
	// 	"created_at between ? and ?": g.Slice{riqi1, riqi2}, //create_at字段在riqi1,2之间

	// 	// "zuozhe":                     zuozhe,
	// 	// "id":                         map1["Id"],
	// }

	// print(condition)
	print(gconv.String((map1["Riqi1"])))

	if map1["Riqi1"] != "" { //判断map的Riqi1是否存在.map1为url传递进来的参数

		a1["updated_at between ? and ?"] = g.Slice{riqi1, riqi2}
	}

	if map1["Biaoti"] != "" {

		a1["biaoti like ?"] = "%" + biaoti + "%"
	}

	if map1["Zuozhe"] != "" {

		a1["zuozhe"] = zuozhe
	}

	if map1["Fenleiid"] != 0 {

		a1["fenleiid"] = fenleiid
	}
	// if(   !g.IsNil(map1["Id"]  )) {

	// 	a1["id"] = map1["Id"]
	// }
	if map1["Id"] != 0 && map1["Id"] != nil { //id不传递或者 id传递的是非0时

		a1["id"] = map1["Id"]
	}

	//判断map1的键是否存在.
	// if _, ok := map1["Id"]; ok {
	// 	print(ok)//存在返回
	// 	a1["id"] = map1["Id"]
	// }

	// if map1["Id"] != 0 {
	// 	condition = g.Map{

	// 		"id": map1["Id"], //指定id和page进行搜索
	// 	}
	// } else {
	// 		condition = g.Map{
	// 			"biaoti like ?": "%" + biaoti + "%",
	// 			// "fenleiid":                   fenlei_id,
	// 			"created_at between ? and ?": g.Slice{riqi1, riqi2}, //create_at字段在riqi1,2之间

	// 			// "zuozhe":                     zuozhe,
	// 			// "id":                         map1["Id"],
	// 		}
	// 	// }
	// print(condition)
	// g.Model("article").Where(condition).All()

	//var page = gconv.Int(map1["page"])
	// delete(map1, "page")
	res, err = dao.WenZhang.Ctx(ctx).Where(a1).Page(page, 10).OrderAsc("id").All() //
	return res, err

}

func (s *sAdmin) Delete_user(ctx context.Context, req *v1.Admin_delete_user_Req) (res sql.Result, err error) { //获取全部文章

	//rres, err = dao.User.Ctx(ctx).Delete("id IN (?)", req.Userid)
	println(req.Userid)
	a := g.Slice{req.Userid}
	println(a[0])
	gconv.String(a[0])
	//b := gstr.s(req.Userid)
	//println(b)
	a1 := g.Array{}
	b1 := g.Array{}
	for index, value := range req.Userid {
		a1 = append(a1, gconv.Int(value)) //把a1,末尾追加传入的用户id

		println(index)
	}
	println(b1)

	res, err = dao.User.Ctx(ctx).Delete("id IN (?)", a1)
	return res, err

}

func (s *sAdmin) Query0all0wen0zhang(ctx context.Context, page int) (res gdb.Result, err error) { //获取全部文章

	res, err = dao.WenZhang.Ctx(ctx).Page(page, 10).OrderAsc("id").All()

	return res, err

}

// // IsPassportAvailable checks and returns given passport is available for signing up.
// func (s *admin) IsPassportAvailable(ctx context.Context, passport string) (bool, error) {
// 	count, err := dao.User.Ctx(ctx).Where(do.User{
// 		Passport: passport,
// 	}).Count()
// 	if err != nil {
// 		return false, err
// 	}
// 	return count == 0, nil
// }

// IsNicknameAvailable checks and returns given nickname is available for signing up.
func (s *sAdmin) IsNicknameAvailable(ctx context.Context, nickname string) (bool, error) {
	fmt.Println("b:", service.Session().GetUser(ctx))
	fmt.Println("c:", service.Session().GetUser(ctx).Username)
	fmt.Println("d:", service.Session().GetUser(ctx).Password)
	// if err != nil {
	// 	return false, err
	// }
	return false, nil
}

// 根据菜单id获取菜单
func (s *sAdmin) Get_menu_according_to_id(ctx context.Context, req *v1.Admin_get_menu_according_to_id_Req) (gdb.Result, error) {
	print(req)
	//dianzanshu, _ := dao.WenZhang.Ctx(ctx).Fields("dianzanshu").Where("id", in.Id).Value() //获取一条字段=yuedushu的id的数据

	res, err := dao.AdminMenu.Ctx(ctx).Where("id", req.Id_menu).All()
	return res, err
}

// 删除菜单,根据id
func (s *sAdmin) Delete_menu_according_to_id(ctx context.Context, req *v1.Admin_delete_menu_according_to_id_Req) (sql.Result, error) {
	print(req)
	//dianzanshu, _ := dao.WenZhang.Ctx(ctx).Fields("dianzanshu").Where("id", in.Id).Value() //获取一条字段=yuedushu的id的数据

	res, err := dao.AdminMenu.Ctx(ctx).Where("id", req.Id_menu).Delete()
	return res, err
}

func (s *sAdmin) Modify_menu(ctx context.Context, req *v1.Admin_modify_menu_Req) (sql.Result, error) {
	print(req)
	//dianzanshu, _ := dao.WenZhang.Ctx(ctx).Fields("dianzanshu").Where("id", in.Id).Value() //获取一条字段=yuedushu的id的数据

	res, err := dao.AdminMenu.Ctx(ctx).Data(do.AdminMenu{
		MenuUrl:  req.MenuUrl,
		MenuName: req.MenuName,
		ParentId: req.ParentId,
		Icon:     req.Icon,
		Sort:     req.Sort,
		Isshow:   req.Isshow,
	}).Where("id", req.Id).Update()
	return res, err
}

func (s *sAdmin) Insert_menu(ctx context.Context, req *v1.Admin_insert_menu_Req) (sql.Result, error) {
	print(req)
	res, err := dao.AdminMenu.Ctx(ctx).Data(do.AdminMenu{
		MenuUrl:  req.MenuUrl,
		MenuName: req.MenuName,
		ParentId: req.ParentId,
		Icon:     req.Icon,
		Sort:     req.Sort,
		Isshow:   req.Isshow,
		//CreatedAt *gtime.Time
		//UpdatedAt *gtime.Time

		//Id       :1,
		//
		//CreatedAt :2,
		//UpdatedAt:3,
		// Menupath string
		//Children :[],

	}).Insert()
	return res, err
}

// 获取后台所有菜单,不分权限
func (s *sAdmin) Get_allmenu(ctx context.Context) (interface{}, error) {
	//r := g.RequestFromCtx(ctx)
	//var userInfo1 entity.User
	g.Dump(ctx.Value("ctx_user"))

	//err1 := gconv.Struct(ctx.Value("ctx_user"), &userInfo1)
	//if err1 != nil {
	//	print("转换错误")
	//	return nil, err1
	//}
	//username = userInfo1.Username
	//role := gconv.String(ctx.Value("ctx_role")) //获取上下文的角色ctx_role

	var json_res model.Admin_api_adminmenu_Res //可代替var admin_menu *entity.AdminMenu.区别是可对字段进行筛选显示

	// var admin_menu *entity.AdminMenu
	// res, err := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: "0"}).All()
	// fmt.Println("res:", res)
	// gconv.Struct(res[0], &admin_menu) //把res由gdb.result(实质是map类型)json_res的值为{值1,值2....},而非json的{"x":"x"}
	// fmt.Println("admin_menu:", admin_menu)
	// g.Dump(admin_menu)
	//获取所有菜单.从表admin_menu表中
	res, err := dao.AdminMenu.Ctx(ctx).Where("parent_id >= 0").All() //parent_id >= 0与数据库中的表字段相互一致哦
	fmt.Println("res:", res)
	// fmt.Println("res[i+1]['menuid']:", res[0]["menuid"])
	// fmt.Println("res[0]:", res[0])
	fmt.Println("res[0]type:", reflect.TypeOf(res[0]))
	var treeList []model.Admin_api_adminmenu_Res
	var treeList0 []model.Admin_api_adminmenu_Res
	// var treeList1 []*v1.Admin_api_adminmenu_Res
	for i := 0; i < res.Len(); i++ { //查询casbin_rule表获取当前角色的所有可访问的url路由,放入treelist
		gconv.Struct(res[i], &json_res) //&json_res=*json_res.把res由gdb.result(实质是map类型)转成json_res的值为json的{"x":"x"}

		// fmt.Println("admin_menu:", json_res)
		//g.Dump(json_res)
		//权限菜单处理.无权限的菜单不加入
		//	e := service.Rbac().Rbac_test(ctx, role, json_res.MenuUrl, "") //json_res.MenuUrl是表中菜单的menu_url地址
		//if e == 1 {                                                    //符合权限验证的菜单加入
		treeList = append(treeList, json_res) //append 函数向 slice 尾部添加数据.treeList是菜单模型model.Admin_api_adminmenu_Res的切片,等同python的list
		//}
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
	treeList0 = getmenu1(treeList, 0) //递归获取层级菜单,0为父节点

	//var _ g.Map
	var m1 []g.Map
	// 创建并发安全的int类型数组
	// var shuzu1 []g.Array
	var m3 []g.Map
	var m4 []g.Map
	err4 := gconv.Scan(treeList0, &m1) //m1为层级菜单.要对其中的parentid=0,且Children=nil的去除
	if err4 != nil {
		return nil, err
	}

	for i := 0; i < len(m1); i++ {
		err5 := gconv.Scan(m1[i]["Children"], &m3)
		g.Dump(err5)
		g.Dump(len(m3)) //判断顶层菜单下属的children菜单是否存在.如果不存在长度为0,存在长度为1
		// g.Dump((m1[i]["Children"]))
		g.Dump(m1[i])
		//if len(m3) != 0 {
		m4 = append(m4, m1[i]) //m4为最终的用户可访问的多级菜单
		m3 = nil               //清空map数组,直接赋值nil即可
		//}
	}

	// treeList1 = getmenu1(treeList, treeList[i].MenuId)
	// treeList0[i].Children=treeList1
	// treeList2=append(treeList2, treeList0)
	// treeList2=append(treeList2, treeList0)

	// g.Dump(treeList2)
	// }

	// }

	// count := res.Len() //Huo获取所有顶级菜单数量,决定了循环次数
	// if err == nil {

	// 	for i := 0; i < count; i++ {
	// 		res1, err1 := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: res[i]["menuid"]}).All()
	// 		if err1==nil{
	// 		fmt.Println("res1:", res1)
	// 		// gconv.Struct(res1[0], &json_res) //&json_res=*json_res.把res由gdb.result(实质是map类型)json_res的值为{值1,值2....},而非json的{"x":"x"}

	// 		// // fmt.Println("admin_menu:", json_res)
	// 		// g.Dump(json_res)
	// 	}}
	// }

	// return g.Map{}, nil
	return m4, err
}

// 获取后台有权限的菜单
func (s *sAdmin) Get_menu(ctx context.Context, username string) (interface{}, error) {
	//r := g.RequestFromCtx(ctx)
	var userInfo1 entity.User
	g.Dump(ctx.Value("ctx_user"))

	err1 := gconv.Struct(ctx.Value("ctx_user"), &userInfo1)
	if err1 != nil {
		print("转换错误")
		return nil, err1
	}
	username = userInfo1.Username
	role := gconv.String(ctx.Value("ctx_role")) //获取上下文的角色ctx_role

	var json_res model.Admin_api_adminmenu_Res //可代替var admin_menu *entity.AdminMenu.区别是可对字段进行筛选显示

	// var admin_menu *entity.AdminMenu
	// res, err := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: "0"}).All()
	// fmt.Println("res:", res)
	// gconv.Struct(res[0], &admin_menu) //把res由gdb.result(实质是map类型)json_res的值为{值1,值2....},而非json的{"x":"x"}
	// fmt.Println("admin_menu:", admin_menu)
	// g.Dump(admin_menu)
	//获取所有菜单.从表admin_menu表中
	res, err := dao.AdminMenu.Ctx(ctx).Where("parent_id >= 0").All() //parent_id >= 0与数据库中的表字段相互一致哦
	fmt.Println("res:", res)
	// fmt.Println("res[i+1]['menuid']:", res[0]["menuid"])
	// fmt.Println("res[0]:", res[0])
	fmt.Println("res[0]type:", reflect.TypeOf(res[0]))
	var treeList []model.Admin_api_adminmenu_Res
	var treeList0 []model.Admin_api_adminmenu_Res
	// var treeList1 []*v1.Admin_api_adminmenu_Res
	for i := 0; i < res.Len(); i++ { //查询casbin_rule表获取当前角色的所有可访问的url路由,放入treelist
		gconv.Struct(res[i], &json_res) //&json_res=*json_res.把res由gdb.result(实质是map类型)转成json_res的值为json的{"x":"x"}

		// fmt.Println("admin_menu:", json_res)
		//g.Dump(json_res)
		//权限菜单处理.无权限的菜单不加入
		e := service.Rbac().Rbac_test(ctx, role, json_res.MenuUrl, "") //json_res.MenuUrl是表中菜单的menu_url地址
		if e == 1 {                                                    //符合权限验证的菜单加入
			treeList = append(treeList, json_res) //append 函数向 slice 尾部添加数据.treeList是菜单模型model.Admin_api_adminmenu_Res的切片,等同python的list
		}
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
	treeList0 = getmenu1(treeList, 0) //递归获取层级菜单,0为父节点

	//var _ g.Map
	var m1 []g.Map
	// 创建并发安全的int类型数组
	// var shuzu1 []g.Array
	var m3 []g.Map
	var m4 []g.Map
	err4 := gconv.Scan(treeList0, &m1) //m1为层级菜单.要对其中的parentid=0,且Children=nil的去除
	if err4 != nil {
		return nil, err
	}

	for i := 0; i < len(m1); i++ {
		err5 := gconv.Scan(m1[i]["Children"], &m3)
		g.Dump(err5)
		g.Dump(len(m3)) //判断顶层菜单下属的children菜单是否存在.如果不存在长度为0,存在长度为1
		// g.Dump((m1[i]["Children"]))
		g.Dump(m1[i])
		if len(m3) > 0 { //只有含二级菜单的一级菜单才显示,无此条件则二级菜单 ,一级菜单都显示
			m4 = append(m4, m1[i]) // //二级菜单 ,一级菜单都显示
		}
		m3 = nil //清空map数组,直接赋值nil即可

	}

	return m4, err
}

// 获取后台有权限的菜单
func (s *sAdmin) Get_menu_according_to_role(ctx context.Context, role string) (interface{}, error) {
	//r := g.RequestFromCtx(ctx)

	var json_res model.Admin_api_adminmenu_Res //可代替var admin_menu *entity.AdminMenu.区别是可对字段进行筛选显示

	// var admin_menu *entity.AdminMenu
	// res, err := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: "0"}).All()
	// fmt.Println("res:", res)
	// gconv.Struct(res[0], &admin_menu) //把res由gdb.result(实质是map类型)json_res的值为{值1,值2....},而非json的{"x":"x"}
	// fmt.Println("admin_menu:", admin_menu)
	// g.Dump(admin_menu)
	//获取所有菜单.从表admin_menu表中
	res, err := dao.AdminMenu.Ctx(ctx).Where("parent_id >= 0").All() //parent_id >= 0与数据库中的表字段相互一致哦
	fmt.Println("res:", res)
	// fmt.Println("res[i+1]['menuid']:", res[0]["menuid"])
	// fmt.Println("res[0]:", res[0])
	fmt.Println("res[0]type:", reflect.TypeOf(res[0]))
	var treeList []model.Admin_api_adminmenu_Res
	var treeList0 []model.Admin_api_adminmenu_Res
	// var treeList1 []*v1.Admin_api_adminmenu_Res
	for i := 0; i < res.Len(); i++ { //查询casbin_rule表获取当前角色的所有可访问的url路由,放入treelist
		gconv.Struct(res[i], &json_res) //&json_res=*json_res.把res由gdb.result(实质是map类型)转成json_res的值为json的{"x":"x"}

		// fmt.Println("admin_menu:", json_res)
		//g.Dump(json_res)
		//权限菜单处理.无权限的菜单不加入
		e := service.Rbac().Rbac_test(ctx, role, json_res.MenuUrl, "") //json_res.MenuUrl是表中菜单的menu_url地址
		if e == 1 {                                                    //符合权限验证的菜单加入
			treeList = append(treeList, json_res) //append 函数向 slice 尾部添加数据.treeList是菜单模型model.Admin_api_adminmenu_Res的切片,等同python的list
		}
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
	treeList0 = getmenu1(treeList, 0) //递归获取层级菜单,0为父节点

	//var _ g.Map
	var m1 []g.Map
	// 创建并发安全的int类型数组
	// var shuzu1 []g.Array
	var m3 []g.Map
	var m4 []g.Map
	err4 := gconv.Scan(treeList0, &m1) //m1为层级菜单.要对其中的parentid=0,且Children=nil的去除
	if err4 != nil {
		return nil, err
	}

	for i := 0; i < len(m1); i++ {
		err5 := gconv.Scan(m1[i]["Children"], &m3)
		g.Dump(err5)
		g.Dump(len(m3)) //判断顶层菜单下属的children菜单是否存在.如果不存在长度为0,存在长度为1
		// g.Dump((m1[i]["Children"]))
		g.Dump(m1[i])
		g.Dump(m1[i]["Children"])
		typ := reflect.TypeOf(m1[i]["Children"])
		fmt.Println("y的类型是：", typ)

		if len(m3) > 0 { //只有含二级菜单的一级菜单才显示,无此条件则二级菜单 ,一级菜单都显示
			m4 = append(m4, m1[i]) // //二级菜单 ,一级菜单都显示
		}
		m3 = nil //清空map数组,直接赋值nil即可
		//}
	}
	return m4, err
	// treeList1 = getmenu1(treeList, treeList[i].MenuId)
	// treeList0[i].Children=treeList1
	// treeList2=append(treeList2, treeList0)
	// treeList2=append(treeList2, treeList0)

	// g.Dump(treeList2)
	// }

	// }

	// count := res.Len() //Huo获取所有顶级菜单数量,决定了循环次数
	// if err == nil {

	// 	for i := 0; i < count; i++ {
	// 		res1, err1 := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: res[i]["menuid"]}).All()
	// 		if err1==nil{
	// 		fmt.Println("res1:", res1)
	// 		// gconv.Struct(res1[0], &json_res) //&json_res=*json_res.把res由gdb.result(实质是map类型)json_res的值为{值1,值2....},而非json的{"x":"x"}

	// 		// // fmt.Println("admin_menu:", json_res)
	// 		// g.Dump(json_res)
	// 	}}
	// }

	// return g.Map{}, nil

}

// var map1 map[string]interface{}
// var map1 map[string]string
// 递归获取层级菜单
func getmenu1(list0 []model.Admin_api_adminmenu_Res, pid int) []model.Admin_api_adminmenu_Res {

	var m []model.Admin_api_adminmenu_Res
	for _, r := range list0 {
		if r.ParentId == pid {
			r.Children = getmenu1(list0, r.Id)

			m = append(m, r)

		}

	}

	return m
}

//   func getmenu1(ctx context.Context,res  gdb.Result){
//  //调用格式为getmenu1(ctx,res)//res为数据库orm查询的多个结果
// 	// type Json_res struct {
// 	// 	Id       int
// 	// 	MenuId   string
// 	// 	MenuUrl  string
// 	// 	MenuName string
// 	// 	ParentId string
// 	// 	child struct{}
// 	// }
// 	//  var json_res *Json_res

// 	count := res.Len() //Huo获取所有顶级菜单数量,决定了循环次数
// 	if count != 0 {

// 		for i := 0; i < count; i++ {
// 			res1, err1 := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: res[i]["menuid"]}).All()
// 			fmt.Println("res1:", res1)
// 		 if err1==nil{
// 		if res1.Len()!=0 {
// getmenu1(ctx,res1)

// 		}else{
// 			fmt.Println("结束:", res1)
// // fmt.Println("i和res1:",i, res1)
// 		}

// 		 }

// 	}

// }

// }

// // func getmenu(ctx context.Context,res  gdb.Result){
// 	func getmenu(ctx context.Context,res map[string] gvar.Var){

// 		res0, err1 := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: res["menuid"]}).All()
// 		fmt.Println("err1:", err1)
// 		count := res0.Len() //Huo获取所有顶级菜单数量,决定了循环次数
// 		if count != 0 {

// 			for i := 0; i < count; i++ {
// 				res1, err1 := dao.AdminMenu.Ctx(ctx).Where(do.AdminMenu{Parentid: res0[i]["menuid"]}).All()
// 				fmt.Println("res1:", res1)
// 			 if err1==nil{
// 			if res1.Len()!=0 {
// 	getmenu(ctx,res1[0]["menuid"])

// 			}else{
// 				fmt.Println("结束:", res1)
// 	// fmt.Println("i和res1:",i, res1)
// 			}

// 			 }

// 		}

// 	}

// 	}

// 插入一个文章内容到数据库
func (s *sAdmin) Insert_article(ctx context.Context, in model.Admin8wen8zhang) (result gdb.Result, err error) {
	time1 := gtime.Now()

	gt1 := time1.Add(time.Duration(10) * time.Second) //在当前时间基础上+10s

	gt2 := gt1.Format("Y-m-d H:i:s")

	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //事务插入数据

		res, err := dao.WenZhang.Ctx(ctx).Data(do.WenZhang{ //WenZhang的定义来自于model-do-表名.go中的定义
			//A:B,A来自于do.WenZhang,B来自于in
			Biaoti: in.Biaoti,

			Zuozhe:  in.Zuozhe,
			Zhaiyao: in.Zhaiyao,
			//Riqi:     in.Riqi, 日期会自动生成的
			Suoluetu: in.Suoluetu,
			Neirong:  in.Neirong,
			Fenleiid: in.Fenleiid,
			Yuedushu: in.Yuedushu,
		}).Insert()
		println(res)
		return err

	})
	//插入数据后,查询
	result, err = service.Admin().Query0tiao0jian0wen0zhang(ctx, g.Map{
		"Biaoti": in.Biaoti,
		"Zuozhe": in.Zuozhe, "Fenleiid": in.Fenleiid,
		"Page":  "1",
		"Riqi1": time1.Format("Y-m-d H:i:s"), //"Y-m-d H:i:s" 如2008-03-03 03:03:03
		"Riqi2": gt2,
	})

	return result, err

}

// 修改更新一个文章内容到数据库
func (s *sAdmin) Update_article(ctx context.Context, in model.Admin8wen8zhang) (result sql.Result, err error) {
	// time1 := gtime.Now()

	// gt1 := time1.Add(time.Duration(10) * time.Second) //在当前时间基础上+10s

	// gt2 := gt1.Format("Y-m-d H:i:s")
	var res1 sql.Result

	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //事务插入数据

		result, err = dao.WenZhang.Ctx(ctx).Data(do.WenZhang{ //WenZhang的定义来自于model-do-表名.go中的定义
			//A:B,A来自于do.WenZhang,B来自于in
			Biaoti: in.Biaoti,

			Zuozhe:  in.Zuozhe,
			Zhaiyao: in.Zhaiyao,
			//Riqi:     in.Riqi, 日期会自动生成的
			Suoluetu:   in.Suoluetu,
			Neirong:    in.Neirong,
			Fenleiid:   in.Fenleiid,
			Dianzanshu: in.Dianzanshu,
		}).Where("id", in.Id).Update()

		return err

	})
	print(res1)
	// //插入数据后,查询
	// result, err = service.Admin().Query0tiao0jian0wen0zhang(ctx, g.Map{
	// 	"Biaoti": in.Biaoti,
	// 	"Zuozhe": in.Zuozhe, "Fenleiid": in.Fenleiid,
	// 	"Page":  "1",
	// 	"Riqi1": time1.Format("Y-m-d H:i:s"), //"Y-m-d H:i:s" 如2008-03-03 03:03:03
	// 	"Riqi2": gt2,
	// })

	return result, err

}

// 修改文章的阅读数
func (s *sAdmin) Update_article_yuedushu(ctx context.Context, in model.Admin8wen8zhang) (yuedush2 uint64, result sql.Result, err error) {

	var res1 sql.Result

	yuedush1, _ := dao.WenZhang.Ctx(ctx).Fields("yuedushu").Where("id", in.Id).Value() //获取一条字段=yuedushu的id的数据

	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //事务插入数据

		result, err = dao.WenZhang.Ctx(ctx).Data(do.WenZhang{ //WenZhang的定义来自于model-do-表名.go中的定义
			//A:B,A来自于do.WenZhang,B来自于in

			Yuedushu: yuedush1.Int() + 1,

			//Dianzanshu: in.Dianzanshu,
		}).Where("id", in.Id).Update()

		return err

	})

	print(res1)

	yuedush2 = yuedush1.Uint64() + 1
	// return yuedush2,result, err
	return
}

// 修改文章的点赞数
func (s *sAdmin) Update_article_dianzanshu(ctx context.Context, in model.Admin8wen8zhang) (dianzanshu1 uint64, result sql.Result, err error) {
	// time1 := gtime.Now()

	// gt1 := time1.Add(time.Duration(10) * time.Second) //在当前时间基础上+10s

	// gt2 := gt1.Format("Y-m-d H:i:s")
	var res1 sql.Result
	dianzanshu, _ := dao.WenZhang.Ctx(ctx).Fields("dianzanshu").Where("id", in.Id).Value() //获取一条字段=yuedushu的id的数据

	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //事务插入数据

		result, err = dao.WenZhang.Ctx(ctx).Data(do.WenZhang{ //WenZhang的定义来自于model-do-表名.go中的定义
			//A:B,A来自于do.WenZhang,B来自于in

			Dianzanshu: dianzanshu.Int() + 1,
		}).Where("id", in.Id).Update()

		return err

	})

	print(res1)
	// //插入数据后,查询
	// result, err = service.Admin().Query0tiao0jian0wen0zhang(ctx, g.Map{
	// 	"Biaoti": in.Biaoti,
	// 	"Zuozhe": in.Zuozhe, "Fenleiid": in.Fenleiid,
	// 	"Page":  "1",
	// 	"Riqi1": time1.Format("Y-m-d H:i:s"), //"Y-m-d H:i:s" 如2008-03-03 03:03:03
	// 	"Riqi2": gt2,
	// })
	dianzanshu1 = dianzanshu.Uint64() + 1
	// return dianzanshu1,result, err
	return

}

// 修改文章的置顶和精华信息.同时更新2个字段
func (s *sAdmin) Update_article_zhiding_jinghua(ctx context.Context, in model.Admin8wen8zhang) (result sql.Result, err error) {

	var res1 sql.Result

	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //事务插入数据

		result, err = dao.WenZhang.Ctx(ctx).Data(do.WenZhang{ //WenZhang的定义来自于model-do-表名.go中的定义
			//A:B,A来自于do.WenZhang,B来自于in

			Zhiding: in.Zhiding,
			Jinghua: in.Jinghua,
		}).Where("id", in.Id).Update()

		return err

	})
	print(res1)
	// //插入数据后,查询
	// result, err = service.Admin().Query0tiao0jian0wen0zhang(ctx, g.Map{
	// 	"Biaoti": in.Biaoti,
	// 	"Zuozhe": in.Zuozhe, "Fenleiid": in.Fenleiid,
	// 	"Page":  "1",
	// 	"Riqi1": time1.Format("Y-m-d H:i:s"), //"Y-m-d H:i:s" 如2008-03-03 03:03:03
	// 	"Riqi2": gt2,
	// })

	return result, err

}
