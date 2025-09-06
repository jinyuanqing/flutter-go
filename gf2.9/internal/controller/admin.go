package controller

//方法名首字母必须大写.控制器调用service
import (
	"context"
	"fmt"

	// "go/printer"
	v1 "gf2/api/v1"
	"gf2/internal/model"

	// "gf2/internal/model/entity"
	"gf2/internal/service"

	// "github.com/gogf/gf/v2/util/gconv"

	// "github.com/gogf/guuid"
	// "github.com/google/uuid"

	// "github.com/gogf/gf/v2/util/gconv"
	// "gf2/internal/service/internal/dao"
	// "gf2/internal/service/internal/dao/internal"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
	// "github.com/gogf/gf/v2/util/gconv"
	//	"github.com/gogf/gf/v2/errors/gerror"
	// "github.com/goflyfox/gtoken/gtoken"
)

type cAdmin struct{}

var Admin = cAdmin{}

func (c *cAdmin) Admin_update_user(ctx context.Context, req *v1.Admin_update_user_Req) (res *v1.Admin_update_user_Res, err error) {

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = r.GetFormMap()     //从请求中获取参数组成map类型
	//delete(map1, "token")         //删除token字段
	//fmt.Println(map1)
	num1, err := service.Admin().Update_user(ctx, map1) //

	fmt.Print(num1)
	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    "", //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

func (c *cAdmin) Admin_delete_user(ctx context.Context, req *v1.Admin_delete_user_Req) (res *v1.Admin_delete_user_Res, err error) {
	// fmt.Println(req.Nickname)
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = r.GetFormMap()     //从请求中获取参数组成map类型
	// delete(map1,"token") //删除token字段
	fmt.Println(map1)
	res0, err := service.Admin().Delete_user(ctx, req) //

	fmt.Print(res0)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res0, //返回最后一条数据
			"message": "删除ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

func (c *cAdmin) Admin_get_userinfo(ctx context.Context, req *v1.Admin_get_userinfo_Req) (res *v1.Admin_get_userinfo_Res, err error) {
	// fmt.Println(req.Nickname)
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = r.GetFormMap()     //从请求中获取参数组成map类型
	// delete(map1,"token") //删除token字段
	fmt.Println(map1)
	res0, err := service.Admin().Get_userinfo(ctx, map1) //

	fmt.Print(res0)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res0, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

func (c *cAdmin) Set_user_authority(ctx context.Context, req *v1.Admin_set_user_authority_Req) (res *v1.Admin_set_user_authority_Res, err error) {

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = r.GetFormMap()     //从请求中获取参数组成map类型
	// delete(map1,"token") //删除token字段
	fmt.Println(map1)
	res0, err := service.Admin().Set_user_authority(ctx, req.Rolename, req.Add_authorrity, req.Del_authorrity) //

	fmt.Print(res0)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res0, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

// 获取角色权限
func (c *cAdmin) Get_user_authority(ctx context.Context, req *v1.Admin_get_user_authority_Req) (res *v1.Admin_get_user_authority_Res, err error) {

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = r.GetFormMap()     //从请求中获取参数组成map类型
	// delete(map1,"token") //删除token字段
	fmt.Println(map1)
	res0, err := service.Admin().Get_user_authority(ctx, req.Rolename) //

	fmt.Print(res0)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res0, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}
func (c *cAdmin) Admin_get_user(ctx context.Context, req *v1.Admin_get_user_Req) (res *v1.Admin_get_user_Res, err error) {

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = r.GetFormMap()     //从请求中获取参数组成map类型
	// delete(map1,"token") //删除token字段
	fmt.Println(map1)
	res0, err := service.Admin().Get_user(ctx, map1) //

	fmt.Print(res0)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res0, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

func (c *cAdmin) Admin_get_article(ctx context.Context, req *v1.Admin0get0article0Req) (res *v1.Admin0get0article0Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r

	res0, err := service.Admin().Query0wen0zhang(ctx, req.Page, req.Fenleiid) //page是页数从1开始.
	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询文章失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data": res0,

			"message": "查询文章成功",
		})

	}
	return
}

func (c *cAdmin) Admin_query_article(ctx context.Context, req *v1.Admin0query0article0Req) (res *v1.Admin0query0article0Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//
	// var map2 = r.GetMap()
	// fmt.Println(map2)
	// fmt.Println(r.Get("Tiaojian").Map());
	var map1 = gconv.Map(req)
	delete(map1, "token")
	fmt.Println(map1)
	res0, err := service.Admin().Query0tiao0jian0wen0zhang(ctx, map1) //按map条件筛选

	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询文章失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data": g.Map{
				"num": len(res0),
				"res": res0,
			},
			"message": "查询文章成功",
		})

	}
	return
}

func (c *cAdmin) Admin_get_article_num(ctx context.Context, req *v1.Admin0get0article0num0Req) (res *v1.Admin0get0article0num0Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	num1, err := service.Admin().Query0wen0zhang0num(ctx, req.Zuozhe)
	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询文章数量出错",
		})

	} else {

		res = &v1.Admin0get0article0num0Res{
			Num: num1,
		}

		// r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
		// 	"data":
		// 		num1,
		// 	"message": "查询文章数量正确",
		// })

	}
	return
}

func (c *cAdmin) Admin_get_all_article(ctx context.Context, req *v1.Admin0get0all0article0Req) (res *v1.Admin0get0all0article0Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	res0, err := service.Admin().Query0all0wen0zhang(ctx, req.Page)
	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询文章和数量出错",
		})

	} else {

		// var res1 model.Admin8wen8zhang
		// gconv.Struct(res0[0],&res1)

		// fmt.Println(res1)
		fmt.Println(len(res0))
		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data": g.Map{
				"num": len(res0),
				"res": res0,
			},
			"message": "查询文章和数量正确",
		})

	}
	return
}

func (c *cAdmin) Admin_modify_menu(ctx context.Context, req *v1.Admin_modify_menu_Req) (res *v1.Admin_modify_menu_Res, err error) {

	var r = g.RequestFromCtx(ctx)
	//print(req.MenuUrl)
	//print(r.Form.Get("menu_name"))
	//var boo1 bool
	sql_res, err := service.Admin().Modify_menu(ctx, req)

	print(sql_res, err)
	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		id, _ := sql_res.LastInsertId()
		num, _ := sql_res.RowsAffected()
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    g.Map{"影响行数:": num, "插入的数据id:": id}, //返回最后一条数据
			"message": "修改菜单成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "修改菜单失败",
		})
	}
	return

}

func (c *cAdmin) Admin_insert_menu(ctx context.Context, req *v1.Admin_insert_menu_Req) (res *v1.Admin_insert_menu_Res, err error) {

	var r = g.RequestFromCtx(ctx)
	//print(req.MenuUrl)
	//print(r.Form.Get("menu_name"))
	//var boo1 bool
	sql_res, err := service.Admin().Insert_menu(ctx, req)

	print(sql_res, err)
	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		id, _ := sql_res.LastInsertId()
		num, _ := sql_res.RowsAffected()
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    g.Map{"影响行数:": num, "插入的数据id:": id}, //返回最后一条数据
			"message": "插入菜单成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "插入菜单失败",
		})
	}
	return

}
func (c *cAdmin) Admin_delete_menu_according_to_id(ctx context.Context, req *v1.Admin_delete_menu_according_to_id_Req) (res *v1.Admin_delete_menu_according_to_id_Res, err error) { //登录

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//var userinfo entity.User

	//err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userinfo)
	//println(err1)
	//println(&userinfo)

	res1, err := service.Admin().Delete_menu_according_to_id(ctx, req)

	// g.Dump(gconv.Map(res1))
	// gconv.Structs(gconv.MapDeep(res1),&res)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res1, //返回最后一条数据
			"message": "据id,删除菜单成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "据id,删除菜单失败",
		})
	}

	return
}
func (c *cAdmin) Admin_get_menu_according_to_id(ctx context.Context, req *v1.Admin_get_menu_according_to_id_Req) (res *v1.Admin_get_menu_according_to_id_Res, err error) { //登录

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//var userinfo entity.User

	//err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userinfo)
	//println(err1)
	//println(&userinfo)

	res1, err := service.Admin().Get_menu_according_to_id(ctx, req)

	// g.Dump(gconv.Map(res1))
	// gconv.Structs(gconv.MapDeep(res1),&res)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res1, //返回最后一条数据
			"message": "据id,获取菜单成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "据id,获取菜单失败",
		})
	}

	return
}

func (c *cAdmin) Admin_all_menu(ctx context.Context, req *v1.Admin_allmenu_Req) (res *model.Admin_api_adminmenu_Res, err error) { //登录

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//var userinfo entity.User

	//err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userinfo)
	//println(err1)
	//println(&userinfo)

	res1, err := service.Admin().Get_allmenu(ctx)

	// g.Dump(gconv.Map(res1))
	// gconv.Structs(gconv.MapDeep(res1),&res)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res1, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

func (c *cAdmin) Admin_Get_menu_according_to_role(ctx context.Context, req *v1.Admin_api_adminmenu_role_Req) (res *model.Admin_api_adminmenu_Res, err error) { //登录

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//var userinfo entity.User

	//err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userinfo)
	//println(err1)
	//println(&userinfo)

	res1, err := service.Admin().Get_menu_according_to_role(ctx, req.Role)

	// g.Dump(gconv.Map(res1))
	// gconv.Structs(gconv.MapDeep(res1),&res)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res1, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

// 这里内部实现也是根据角色获取后台菜单功能=Admin_Get_menu_according_to_role,无需提供角色,而是登陆后根据用户名自动获取的角色
func (c *cAdmin) Admin_menu(ctx context.Context, req *v1.Admin_api_adminmenu_Req) (res *model.Admin_api_adminmenu_Res, err error) { //登录

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//var userinfo entity.User

	//err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userinfo)
	//println(err1)
	//println(&userinfo)

	res1, err := service.Admin().Get_menu(ctx, "")

	// g.Dump(gconv.Map(res1))
	// gconv.Structs(gconv.MapDeep(res1),&res)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res1, //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

// IsNicknameAvailable

// func (c *cAdmin) Admin_api_check_session(ctx context.Context, req *v1.Admin_api_signin_Req) (res *v1.Admin_api_signin_Res, err error) {//登录

// 	err = service.Admin().Query(ctx, model.AdminCreateInput{
// 	//id:	res.Id,
// 	Username:     req.Username,
// 	Password: req.Password,
// })
// fmt.Print(err)
//  return
// }

func (c *cAdmin) Admin_set_article_fenlei(ctx context.Context, req *v1.Admin_set_article_fenlei_Req) (res *v1.Admin_set_article_fenlei_Res, err error) {

	r := g.RequestFromCtx(ctx)
	//fenlei_name := r.Get("fenleiname").String()
	res0, err := service.Admin().Set_fen_lei_name(ctx, model.Wenzhangfenlei{
		FenleiName: req.Fenleiname,
	})
	println(err)

	println(res0)

	result, err := service.User().Huo_qu_fen_lei(ctx)

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    result,
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "设置文章分类失败",
		})
	}
	return
}

// 上传文章
func (c *cAdmin) Upload8article(ctx context.Context, req *v1.Admin8upload8article8Req) (res *v1.Admin8upload8article8Res, err error) {
	r := g.RequestFromCtx(ctx)

	// biao8ti := r.Get("biao8ti").String()       //form表单的字段
	// zuo8zhe := r.Get("zuo8zhe").String()       //form表单的字段
	// zhai8yao := r.Get("zhai8yao").String()     //form表单的字段
	// suo8lue8tu := r.Get("suo8lue8tu").String() //form表单的字段
	// nei8rong := r.Get("nei8rong").String()     //form表单的字段
	// ri8qi := gtime.Datetime()                  //时间
	// println(ri8qi)
	// println(biao8ti)
	// println(zuo8zhe)
	// println(zhai8yao)
	// println(suo8lue8tu)
	// println(nei8rong)

	//写入数据库.insert所在的service不做错误处理,直接在次控制器处理
	res1, err := service.Admin().Insert_article(ctx, model.Admin8wen8zhang{
		//A:B, A--->model.Admin8wen8zhang
		// Id: 1,
		Biaoti:  req.Biaoti,
		Zuozhe:  req.Zuozhe,
		Zhaiyao: req.Zhaiyao,
		// Riqi:     注意日期不写,会自动生成的日期
		Suoluetu: req.Suoluetu,
		Neirong:  req.Neirong,
		Fenleiid: req.Fenleiid,
		Yuedushu: req.Yuedushu,
	})
	// print(res1.LastInsertId())
	// id ,err:=res1.LastInsertId()//插入文章后返回最后的记录id.多人插入可能存在获取id不准问题

	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    res1[len(res1)-1], //返回最后一条数据
			"message": "ok",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "no",
		})
	}

	return
}

// 修改文章
func (c *cAdmin) Update_article(ctx context.Context, req *v1.AdminupdatearticleReq) (res *v1.AdminupdatearticleRes, err error) {

	r := g.RequestFromCtx(ctx)

	//写入数据库.insert所在的service不做错误处理,直接在次控制器处理
	res1, _ := service.Admin().Update_article(ctx, model.Admin8wen8zhang{
		//A:B, A--->model.Admin8wen8zhang
		Id: req.Id,

		Biaoti:  req.Biaoti,
		Zuozhe:  req.Zuozhe,
		Zhaiyao: req.Zhaiyao,
		// Riqi:     注意日期不写,会自动生成的日期
		Suoluetu:   req.Suoluetu,
		Neirong:    req.Neirong,
		Fenleiid:   req.Fenleiid,
		Yuedushu:   req.Yuedushu,
		Dianzanshu: req.Dianzanshu,
	})
	// print(res1.LastInsertId())
	// id ,err:=res1.LastInsertId()//插入文章后返回最后的记录id.多人插入可能存在获取id不准问题
	num, err := res1.RowsAffected()
	if err == nil && num == 1 { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    "ok", //返回update影响的行数
			"message": "更新文章成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "0",
			"data":    g.Map{"err": err},
			"message": "更新文章失败",
		})
	}

	return
}

// 修改文章阅读数
func (c *cAdmin) Update_article_yuedushu(ctx context.Context, req *v1.Adminupdatearticle_yuedushu_Req) (res *v1.Adminupdatearticle_yuedushu_Res, err error) {

	r := g.RequestFromCtx(ctx)

	//写入数据库.insert所在的service不做错误处理,直接在次控制器处理
	yuedushu, res1, err := service.Admin().Update_article_yuedushu(ctx, model.Admin8wen8zhang{
		//A:B, A--->model.Admin8wen8zhang
		Id: req.Id,

		//Biaoti:  req.Biaoti,
		//Zuozhe:  req.Zuozhe,
		//Zhaiyao: req.Zhaiyao,
		//// Riqi:     注意日期不写,会自动生成的日期
		//Suoluetu:   req.Suoluetu,
		//Neirong:    req.Neirong,
		//Fenleiid:   req.Fenleiid,
		Yuedushu: req.Yuedushu,
		//Dianzanshu: req.Dianzanshu,
	})
	// print(res1.LastInsertId())
	// id ,err:=res1.LastInsertId()//插入文章后返回最后的记录id.多人插入可能存在获取id不准问题
	num, err := res1.RowsAffected()
	if err == nil && num == 1 { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    yuedushu, //返回update影响的行数
			"message": "更新文章阅读数成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "更新文章阅读数失败",
		})
	}

	return
}

// 修改文章点赞数
func (c *cAdmin) Update_article_dianzanshu(ctx context.Context, req *v1.Adminupdatearticle_dianzanshu_Req) (res *v1.Adminupdatearticle_dianzanshu_Res, err error) {

	r := g.RequestFromCtx(ctx)

	//写入数据库.insert所在的service不做错误处理,直接在次控制器处理
	dianzanshu1, res1, err := service.Admin().Update_article_dianzanshu(ctx, model.Admin8wen8zhang{
		//A:B, A--->model.Admin8wen8zhang
		Id: req.Id,

		//Biaoti:  req.Biaoti,
		//Zuozhe:  req.Zuozhe,
		//Zhaiyao: req.Zhaiyao,
		//// Riqi:     注意日期不写,会自动生成的日期
		//Suoluetu:   req.Suoluetu,
		//Neirong:    req.Neirong,
		//Fenleiid:   req.Fenleiid,
		//Yuedushu: req.Yuedushu,
		Dianzanshu: req.Dianzanshu,
	})
	// print(res1.LastInsertId())
	// id ,err:=res1.LastInsertId()//插入文章后返回最后的记录id.多人插入可能存在获取id不准问题
	num, err := res1.RowsAffected()
	if err == nil && num == 1 { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    dianzanshu1, //返回update影响的行数
			"message": "更新文章点赞数成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "更新文章点赞数失败",
		})
	}

	return
}

// 设置文章的置顶和精华
func (c *cAdmin) Update_article_zhiding_jinghua(ctx context.Context, req *v1.Adminupdate_article_zhiding_jinghuaReq) (res *v1.Adminupdate_article_zhiding_jinghuaRes, err error) {

	r := g.RequestFromCtx(ctx)

	//写入数据库.insert所在的service不做错误处理,直接在次控制器处理
	res1, err := service.Admin().Update_article_zhiding_jinghua(ctx, model.Admin8wen8zhang{
		//A:B, A--->model.Admin8wen8zhang
		Id:      req.Id,
		Zhiding: req.Zhiding,
		Jinghua: req.Jinghua,
	})
	// print(res1.LastInsertId())
	// id ,err:=res1.LastInsertId()//插入文章后返回最后的记录id.多人插入可能存在获取id不准问题
	num, err := res1.RowsAffected()
	if err == nil && num == 1 { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    "ok", //返回update影响的行数
			"message": "更新置顶或精华成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "更新置顶或精华失败",
		})
	}

	return
}
