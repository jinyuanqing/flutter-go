package router

import (
	"context"
	"fmt"
	_ "github.com/gogf/gf/contrib/nosql/redis/v2" //redis已经在gf的仓库了,因此直接导入就行了.复制这个地址到浏览器可以看到所属仓库信息

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
)

func Init(ctx context.Context, s *ghttp.Server) { //首字母必须大写哦.
	println("执行了model1")
	//测试redis默认
	_, err := g.Redis().Set(ctx, "key", "value")
	if err != nil {
		g.Log().Fatal(ctx, err)
	}
	value, err := g.Redis().Get(ctx, "key")
	if err != nil {
		g.Log().Fatal(ctx, err)
	}
	fmt.Println(value.String())

	//测试redis配置文件1 增加值
	_, err1 := g.Redis("cache1").Set(ctx, "key1", "value1")
	if err != nil {
		g.Log().Fatal(ctx, err1)
	}
	value, err2 := g.Redis("cache1").Get(ctx, "key1")
	if err != nil {
		g.Log().Fatal(ctx, err2)
	}
	fmt.Println(value.String())
	//测试redis配置文件1 移除/不存在的键直接忽略,无法返回错误.
	_, err3 := g.Redis("cache1").Do(ctx, "DEL", "key31231231") //不存在的键,err3是空的
	if err3 != nil {
		g.Log().Fatal(ctx, err3)
	}
	_, err4 := g.Redis("cache1").Do(ctx, "DEL", "key")
	if err4 != nil {
		g.Log().Fatal(ctx, err4)
	}
	s.Group("model1", func(group *ghttp.RouterGroup) {
		//group.GET("/getModel1", new(controller.UserController).Add1)
		group.GET("/get", func(r *ghttp.Request) {
			r.Response.Write("get")
		})
	})
	//s.Run()

}
