package xitong

import (
	"context"
	"encoding/hex"
	"fmt"
	v1 "gf2/api/v1"
	"gf2/internal/service"
	"github.com/goflyfox/gtoken/gtoken"
	"github.com/gogf/gf/v2/crypto/gaes"
	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
	"github.com/gogf/gf/v2/util/gconv"
	"strings"
	"time"
	// "github.com/gogf/gf/v2/frame/g"
	//"github.com/gogf/gf/v2/net/ghttp"
)

type (
	// sUser is service struct of module User.
	sXitong struct{}
)

func init() {
	service.RegisterXitong(New())
}

func New() *sXitong {
	return &sXitong{}
}

func (s *sXitong) STest_user_token(ctx context.Context, req *v1.Test_user_token_Req) (err error) {
	//g.Model()
	str, err := g.Cfg().Get(ctx, "gToken.DefaultCacheKey")

	if err != nil {
		g.Log().Fatal(ctx, err)
		g.Log().Fatal(ctx, "读取配置文件出错")
	}
	//user_token := ctx.Value("user_token").(string)
	//fmt.Println(user_token)
	value, err := g.Redis().Get(ctx, str.String()+req.Username) //组合成redis中的键
	if err != nil {
		g.Log().Fatal(ctx, err)
	}
	//根据token反推得出uuid和userKey,然后与gredis得存储数据做对比

	if value.String() == "" {
		return gerror.NewCode(gcode.New(1, "", nil), "用户登录信息不存在服务器中,需要重新登录")
	} else {

		//token := "dPYWvn+2JSSf+D53yBIGvf+354JojzCMrLRgIfKoguPNXYbRv7fRL4Ls6wflm3si"
		//var gfToken *gtoken.GfToken
		//在 if v := r.GetCtxVar("ctx_gftoken").Val(); v != nil 这一行，我们首先检查 ctx_gftoken 是否存在且不为空。
		//如果存在且不为空，我们使用类型断言 if gfToken, ok := v.(*gtoken.GfToken); ok 来尝试将 v 转换为 *gtoken.GfToken 类型。
		//如果类型断言成功，继续执行后续逻辑；如果失败，返回一个类型错误。
		//如果 ctx_gftoken 不存在，返回一个未找到的错误。这样可以确保代码的健壮性和安全性。
		r := g.RequestFromCtx(ctx)
		if v := r.GetCtxVar("ctx_gftoken").Val(); v != nil {
			if gfToken, ok := v.(*gtoken.GfToken); ok { //类型断言判断是否是*gtoken.GfToken,gfToken是转换为*gtoken.GfToken类型后得值
				aa := gfToken.DecryptToken(ctx, req.Token)
				fmt.Println(aa.Data)
				fmt.Println(gconv.Map(aa.Data)["userKey"])
				fmt.Println(gconv.Map(aa.Data)["uuid"])
				fmt.Println(gconv.Map(value.String())["userKey"])
				if (gconv.Map(value.String())["userKey"] == gconv.Map(aa.Data)["userKey"]) && (gconv.Map(value.String())["uuid"] == gconv.Map(aa.Data)["uuid"]) {
					fmt.Println(value.String())
					return //gerror.NewCode(gcode.New(0, "", nil), "用户登录信息存在服务器,无需重新登录")
				}
			} else {
				fmt.Println("ctx_gftoken 类型不正确")
				return gerror.NewCode(gcode.New(1, "类型错误", "ctx_gftoken 类型不正确"))
			}
		} else {
			fmt.Println("上下文ctx_gftoken 未找到")
			return gerror.NewCode(gcode.New(1, "未找到 ctx_gftoken", "上下文ctx_gftoken 未找到"))
		}

	}
	return
}

func (s *sXitong) Compare_time(ctx context.Context, time_str string, jihuochaoshi int) (err error) {
	b1, err3 := hex.DecodeString(time_str) //把16进制的字符串,解析成字节数组.如""010203"变成[01,02,03] .这里接收的为时间+域名

	if err3 != nil { //参数非16进制
		return gerror.NewCode(gcode.New(1, "参数错误", "参数错误! "))
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
				return gerror.NewCode(gcode.New(1, "注册链接解析错误", "注册链接解析错误! "))
			}
		} else { //链接不含有&符号

			return gerror.NewCode(gcode.New(1, "注册链接解析错误", "注册链接解析错误! "))

		}

		time1 := gtime.New(gtime.Datetime())
		bool1 := time1.Before(gtime.New(shijian).Add(time.Duration(jihuochaoshi) * time.Minute)) //当前的系统时间
		if bool1 {                                                                               //打开页面的时间,在获取url参数时间+10分之前,是可以的
			return nil

		} else {
			return gerror.NewCode(gcode.New(1, "注册的时间超时(10分钟内注册)", "时间超时错误! "))
		}

	}
	return

}
