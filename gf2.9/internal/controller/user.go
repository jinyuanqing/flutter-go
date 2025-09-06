package controller

import (
	"context"
	"fmt"
	"gf2/internal/model/entity"
	"strings"

	v1 "gf2/api/v1"
	"gf2/internal/model"
	"gf2/internal/service"

	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"

	"github.com/gogf/guuid"
	"github.com/google/uuid"
)

type cUser struct{}

var User = cUser{}

// func (c *cUser) user_rencai_zhaopin(ctx context.Context, req *v1.UserGetReq) {

// }

func (c *cUser) Get_user_menu(ctx context.Context, req *v1.UsermenuReq) (res *model.UserMenuRes, err error) { //登录

	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//var userinfo entity.User

	//err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userinfo)
	//println(err1)
	//println(&userinfo)

	res1, err := service.User().Get_menu_user(ctx, req.Username)

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

func (c *cUser) Zhuce(ctx context.Context, req *v1.UserSignUpReq) (res *v1.UserSignUpRes, err error) {
	//Xitong.Compare1(ctx, req.Shibie)
	r := g.RequestFromCtx(ctx)
	err1 := service.Xitong().Compare_time(ctx, req.Shibie, 10) //10为激活超时时间分钟

	if err1 != nil {
		r.Response.WriteJsonExit(g.Map{"code": "1", //
			"data":    "注册存在问题",
			"message": "注册存在问题",
		})
	}

	err = service.User().Create(ctx, model.UserCreateInput{ //插入数据
		//其中的所有字段必须与model->entity中的x.go一致
		Username:     req.Username,
		Password:     req.Password,
		Nickname:     req.Nickname,
		Email:        req.Email, //`json:"email"    ` // 邮箱
		Address:      req.Address,
		Tel:          req.Tel,
		Birthday:     req.Birthday,
		Sex:          req.Sex,
		Qianming:     req.Qianming,
		Shenfenzheng: req.Shenfenzheng,
		Ip:           req.Ip,
		Touxiang:     req.Touxiang,
		Jifen:        req.Jifen,
		Beiyong1:     req.Beiyong1,
		Isadmin:      req.Isadmin,
	})

	if err == nil {
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    "ok",
			"message": "注册成功",
		})
	} else { //如果失败返回logic中的err

		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    "注册失败",
			"message": err,
		})

	}

	return
}

func (c *cUser) Get_alluser_num(ctx context.Context, req *v1.Getallusernum_Req) (res *v1.UserGetRes, err error) { //获取所有用户
	r := g.RequestFromCtx(ctx)
	num, err := service.User().S_get_alluser_num(ctx)
	// fmt.Print(err,result)

	if err != nil {
		r.Response.WriteJsonExit(g.Map{"code": "1", //
			"data":    err,
			"message": "获取数据数量有误",
		})
	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    num,
			"message": "ok",
		})
	}

	return
	// return res,err
}

func (c *cUser) Get_user_accordto_page(ctx context.Context, req *v1.UserGetReq) (res *v1.UserGetRes, err error) { //获取所有用户
	r := g.RequestFromCtx(ctx)
	result, err := service.User().S_Get_user_accordto_page(ctx, req.Page)
	// fmt.Print(err,result)

	var user model.User
	gconv.Struct(result[0], &user)
	// gconv.Struct(result[0], res)
	//  res = &v1.UserGetRes{
	// 	  Address:user.Address,
	// 	  Username: user.Username,
	// }

	//fmt.Print(result)
	//fmt.Print(user.Nickname)
	r.Response.WriteJsonExit(g.Map{"code": "0", //
		"data":    result,
		"message": "ok",
	})

	return
	// return res,err
}

// 用户登录后,会把sessionid放入header中返回给客户端浏览器.
func (c *cUser) SignIn(ctx context.Context, req *v1.UserSignInReq) (res *v1.UserSignInRes, err error) {
	userinfo, err := service.User().SignIn(ctx, model.UserSignInInput{
		Username: req.Username,
		Password: req.Password,
	})
	print(userinfo)
	return
}

func (c *cUser) IsSignedIn(ctx context.Context, req *v1.UserIsSignedInReq) (res *v1.UserIsSignedInRes, err error) {
	res = &v1.UserIsSignedInRes{
		OK: service.User().IsSignedIn(ctx),
	}
	return
}

func (c *cUser) SignOut(ctx context.Context, req *v1.UserSignOutReq) (res *v1.UserSignOutRes, err error) {
	err = service.User().SignOut(ctx)
	return
}

func (c *cUser) CheckPassport(ctx context.Context, req *v1.UserCheckPassportReq) (res *v1.UserCheckPassportRes, err error) {
	available, err := service.User().IsPassportAvailable(ctx, req.Username)
	if err != nil {
		return nil, err
	}
	if !available {
		return nil, gerror.Newf(`Username "%s" is already token by others`, req.Username)
	}
	return
}

func (c *cUser) CheckNickName(ctx context.Context, req *v1.UserCheckNickNameReq) (res *v1.UserCheckNickNameRes, err error) {
	available, err := service.User().IsNicknameAvailable(ctx, req.Nickname)
	if err != nil {
		return nil, err
	}
	if !available {
		return nil, gerror.Newf(`Nickname "%s" is already token by others`, req.Nickname)
	}
	return
}

func (c *cUser) Profile(ctx context.Context, req *v1.UserProfileReq) (res *v1.UserProfileRes, err error) {
	r := g.RequestFromCtx(ctx)
	print("打印session:")
	data := service.Session().Getvar(ctx, "bian1")

	print(data.String())
	var userInfo1 entity.User
	//token的data方式获取用户信息.
	err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userInfo1)
	if err1 != nil {
		print("发生了错误")
	}
	//session方式获取用户信息.
	//var res1 = &v1.UserProfileRes{
	//	User: service.User().GetProfile(ctx),
	//}

	if err1 == nil { //err为空,没有错误发生,则正常.
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data": g.Map{"bian1": data,
				//"res": res1,
				"res": userInfo1,
			},
			"message": "成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{},
			"message": "失败",
		})
	}

	return
}

func (c *cUser) Uploadfile(ctx context.Context, req *v1.UserUploadfileReq) (res *v1.UserUploadfileRes, err error) {
	r := g.RequestFromCtx(ctx)
	// files := r.GetUploadFiles("upload-file")
	// names, err := files.Save("./upload_file/")//cmd.go中设置为s.AddStaticPath("/upload_file", "./upload_file")//设置访问目录的别名upload_file,访问路径为    http://localhost:8888/upload_file/1.jpg

	// if err != nil {
	// 	r.Response.WriteExit(err)
	// }
	// r.Response.WriteExit("upload successfully: ", names)
	// return
	var uuid0 uuid.UUID = guuid.New() //生成一个uuid
	fmt.Println(uuid0)

	// err1=fmt.Errorf("12")//自定义错误
	// if err1 != nil {
	// 	r.Response.WriteExit("上传失败,请重试!")

	// }
	//var	 map11  g.Var

	// hou_zhui0 := r.Get("suffix").String() //直接获取传递的form表单字段,无法获取文件
	// print(hou_zhui0)
	// map1 := r.GetFormMap() //无法获取文件字段,只能是普通的字符串字段
	// print(map1)
	// map2 := r.GetMultipartForm()
	// print(map2.Value["suffix"][0])
	// print(map2.Value["suffix1"][0])
	// print(map2.File["file"][0].Filename) //文件名
	// print(map2.File["file"][0].Size)     //文件大小
	// print(len(map2.File["file"]))        //文件
	var hou_zhui string
	files := r.GetUploadFiles("file") //form表单的字段
	//  r.GetFormMap("suffix", map1)

	//hou_zhui = files[0].FileHeader.Header.Get("Content-Type") //上传文件的类型,也就是后缀
	len_str1 := len(strings.Split(files[0].Filename, "."))
	hou_zhui = strings.Split(files[0].Filename, ".")[len_str1-1]               //文件后缀
	if !((hou_zhui == "png") || (hou_zhui == "jpg") || (hou_zhui == "jpeg")) { //上传类型判断
		r.Response.WriteExit("请上传jpg/png/jpeg格式")
	}
	uploadfile_size, err := g.Cfg().Get(ctx, "server.uploadfile_size") //获取配置结果,需要对结果进行int转换
	fmt.Print(uploadfile_size.Int64())
	if r.Request.ContentLength > uploadfile_size.Int64() { //上传大小判断
		r.Response.WriteExit("上传文件超出500k限制!")
	}

	for key, file := range files {
		fmt.Println(key, file)
		//  var err1 error

		uuid0, err1 := guuid.NewRandom() //随机生成一个uuid.和上一个类似
		if err1 != nil {
			r.Response.WriteExit("生成随机文件名失败!")

		}
		file.Filename = uuid0.String() + "." + hou_zhui //
	}
	//files[0].Filename=uuid0.String()+".jpg"//["FileHeader"]["Filename"]=1

	//names, err := files.Save("./upload_file/",true)//./项目目录下建立文件夹.而/是在项目所在盘符的根目录下创建
	names, err := files.Save("./upload_file/") //names为列表
	if err != nil {
		r.Response.WriteExit(err)
	}

	//r.Response.WriteExit("upload successfully: ", names,	files)
	// r.Response.WriteExit("upload successfully: ", names  )

	if err == nil { //err为空,没有错误发生,则正常.
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    g.Map{"pic_url": "http://127.0.0.1:8199/upload_file/" + names[0]},
			"message": "上传图片成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "1",
			"data":    g.Map{"err": err},
			"message": "上传图片失败,大小不大于500k",
		})
	}

	return
}

func (c *cUser) User_get_article(ctx context.Context, req *v1.User0get0article0Req) (res *v1.User0get0article0Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	fmt.Println(r.GetCtxVar("Username"))
	//先获取上下文
	num1, err := service.Admin().Query0wen0zhang(ctx, req.Page, req.Fenleiid) //据文章分类id和页码获取文章
	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询文章失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data":    num1,
			"message": "查询文章成功",
		})

	}
	return
}

func (c *cUser) User_huo_qu_fen_lei(ctx context.Context, req *v1.UserhuoqufenleiReq) (res *v1.UserhuoqufenleiRes, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r

	res0, err := service.User().Huo_qu_fen_lei(ctx) //
	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询分类失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data":    res0,
			"message": "查询分类成功",
		})

	}
	return
}
