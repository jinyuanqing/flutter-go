package v1

//对外提供服务的输入/输出数据结构定义.可以对页面输入字段进行取舍
import (
	"github.com/gogf/gf/v2/frame/g"
	//  "github.com/gogf/gf-demo-user/v2/internal/model/entity"
)

type Rbac_add_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta `path:"/rbac_add" method:"post" tags:"rbacService"  summary:"rbac设置用户权限"`
	Sub    string `v:"required"` // 想要访问资源的用户
	Obj    string `v:"required"` // r.Request.URL.RequestURI()// 将要被访问的资源
	Act    string `v:"required"` //r.Request.Method// 用户对资源实施的操作

}

type Rbac_add_Res struct {
}
