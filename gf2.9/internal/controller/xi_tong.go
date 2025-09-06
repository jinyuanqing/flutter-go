package controller

//方法名首字母必须大写.控制器调用service
import (
	"context"
	"encoding/hex"
	send_email "gf2/gong_neng"
	"gf2/internal/service"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"strings"
	"time"

	//"gf2/internal/service"

	"github.com/gogf/gf/v2/os/gtime"

	v1 "gf2/api/v1"
	// "github.com/gogf/gf/v2/container/glist"
	// "github.com/gogf/gf/v2/encoding/gjson"
	"github.com/gogf/gf/v2/frame/g"

	"github.com/gogf/gf/v2/crypto/gaes"
	// "gf2/internal/model/entity"
	// "github.com/gogf/gf/v2/util/gconv"
	// "github.com/gogf/guuid"
	// "github.com/google/uuid"
	// "github.com/gogf/gf/v2/util/gconv"
	// "gf2/internal/service/internal/dao"
	// "gf2/internal/service/internal/dao/internal"
	// "github.com/gogf/gf/v2/util/gconv"
	//	"github.com/gogf/gf/v2/errors/gerror"
	// "github.com/goflyfox/gtoken/gtoken"
)

type cXitong struct{}

var Xitong = cXitong{}    //在cmd.go中绑定路由
var jihuochaoshi int = 10 //激活超时时间1分钟

func (c *cXitong) Test_user_token(ctx context.Context, req *v1.Test_user_token_Req) (res *v1.Test_user_token_Res, err error) {
	r := g.RequestFromCtx(ctx)

	err1 := service.Xitong().STest_user_token(ctx, req)
	if err1 != nil {

		r.Response.WriteJsonExit(g.Map{
			"code":    "1", //
			"data":    "1", //返回最后一条数据
			"message": "用户登录信息不存在服务器中,需要重新登录",
		})
	} else {

		r.Response.WriteJsonExit(g.Map{
			"code":    "0", //
			"data":    "0", //返回最后一条数据
			"message": "用户登录信息存在服务器,无需重新登录",
		})
	}
	//println(err1)
	return
}

// 获取系统时间并发送邮件
func (c *cXitong) Get_time(ctx context.Context, req *v1.Get_time_Req) (res *v1.Get_time_Res, err error) {
	// // 编码/解析 string
	// aa := gbinary.EncodeString("I'm string!")
	// println((aa))

	//对当前系统时间进行加密操作
	var key = []byte("1y2x3z4h5w6h7g8z") //aes算法加密的key 16个字符哦

	var str = []byte(gtime.Datetime() + "&" + "www.yxzhw.cn") //待加密的字符串:时间+固定字符串yxzhw.cn组成

	jiami, err1 := gaes.Encrypt(str, key) //cbc加密的字符需要是key的整数倍

	println(err1)

	str_jiami := hex.EncodeToString(jiami) //把字节数组按照元素进行字符串相连接[02,03]变成""0203"

	// 根据用户邮箱发送邮件.
	email := req.Email + ";"
	send_email.Main2(email, str_jiami)
	res = &v1.Get_time_Res{
		Encrypt_time: str_jiami,
	}

	return
}

func (c *cXitong) Compare(ctx context.Context, req *v1.Compare_time_Req) (res *v1.Compare_time_Res, err error) { //比较时间参数
	//http://127.0.0.1:8199/xitong/compare_time?Str_jiami=f74811179a62aa6a77d2d86648a5788d52128d2b239ace297a3192d1208257352426591e73af2a4fcadb61a8c1138c37
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r

	b1, err3 := hex.DecodeString(req.Str_jiami) //把16进制的字符串,解析成字节数组.如""010203"变成[01,02,03] .这里接收的为时间+域名

	if err3 != nil {
		return nil, err
	} else {
		var shijian string
		//print(gmd5.Encrypt("sdf")) //md5加密后不可逆.aes相当安全,占用资源少,
		var key = []byte("1y2x3z4h5w6h7g8z") //解密用的key,与加密一致哦 16个字符哦
		jiemi, err2 := gaes.Decrypt(b1, key) //解密的字符需要是key的整数
		print(jiemi, err2)
		var str_jiemi = string(jiemi)
		if strings.Contains(str_jiemi, "&") { // 链接含有&符号
			str1 := strings.Split(str_jiemi, "&")
			shijian = str1[0]                  //获取邮件链接的时间参数
			str_panduan := str1[1]             //获取邮件链接的固定字符串参数
			if str_panduan != "www.yxzhw.cn" { //邮件中不含有www.yxzhw.cn
				return nil, gerror.NewCode(gcode.New(1, "链接错误", "链接错误! "))
			}
		} else { //链接不含有&符号

			return nil, gerror.NewCode(gcode.New(1, "链接错误", "链接错误! "))
		}
		time1 := gtime.New(gtime.Datetime())
		bool1 := time1.Before(gtime.New(shijian).Add(time.Duration(jihuochaoshi) * time.Minute)) //当前的系统时间
		if bool1 {                                                                               //打开页面的时间,在获取url参数时间+10分之前,是可以的

			//r.Response.WriteJsonExit(g.Map{"code": "0",
			//	"data": bool1,
			//
			//	"message": "在10分钟内,可以继续操作",
			//})
			r.Response.WriteTpl("/gong_neng/jihuo.html", g.Map{"isok": true, "Str_jiami": req.Str_jiami}) //渲染模板view/gong_neng/jihuo.html,传递变量到模板
		} else {
			//r.Response.WriteJsonExit(g.Map{"code": "1",
			//	"data":    bool1,
			//	"message": "超过10分钟了,无法继续操作",
			//})
			r.Response.WriteTpl("/gong_neng/jihuo.html", g.Map{"isok": false, "Str_jiami": req.Str_jiami})
		}
		return
	}
}

func (c *cXitong) Compare_tijiao(ctx context.Context, req *v1.Compare_time1_Req) (res *v1.Compare_time_Res, err error) { //比较时间参数
	//http://127.0.0.1:8199/xitong/compare_time?Str_jiami=f74811179a62aa6a77d2d86648a5788d52128d2b239ace297a3192d1208257352426591e73af2a4fcadb61a8c1138c37
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	err = service.Xitong().Compare_time(ctx, req.Str_jiami, jihuochaoshi)

	if err != nil {
		//return nil, err
		r.Response.WriteJsonExit(g.Map{
			"code":    "1",     //
			"data":    "false", //返回最后一条数据
			"message": "请求异常无法注册",
		})

	} else {
		r.Response.WriteJsonExit(g.Map{
			"code":    "0",    //
			"data":    "true", //返回最后一条数据
			"message": "ok",
		})

	}

	return

}
