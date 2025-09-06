package v1

//对外提供服务的输入/输出数据结构定义.可以对页面输入字段进行取舍
import (
	"github.com/gogf/gf/v2/frame/g"
	//  "github.com/gogf/gf-demo-user/v2/internal/model/entity"
)

type Get_time_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta `path:"/get_time" method:"post" tags:"系统功能"  summary:"获取系统的时间"`
	Email  string
}

type Get_time_Res struct {
	Encrypt_time string //[]byte //返回加密的系统时间
}

type Compare_time_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta    `path:"/compare" method:"get" tags:"系统功能"  summary:"废"`
	Str_jiami string // []byte //机密后的系统时间+www.yxzhw.cn
}

type Compare_time_Res struct {
	Result string //返回比较结果.ok通过,fail不通过
}

type Compare_time1_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta    `path:"/compare_tijiao" method:"get" tags:"系统功能"  summary:"注册链接是否超时,无须token"`
	Str_jiami string // []byte //机密后的系统时间+www.yxzhw.cn
}
type Test_user_token_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/test_user_token" method:"post" tags:"系统功能"  summary:"验证用户的token,需要token.拦截路径要排除"`
	Username string //`  json:"username"  description:"用户名"`
	Token    string
}

type Test_user_token_Res struct {
	Data    int //返回比较结果.ok通过,fail不通过
	Code    int
	Message string
}
