package controller

//方法名首字母必须大写.控制器调用service
import (
	"context"
	"fmt"
	"gf2/internal/dao"
	"gf2/internal/model"
	"gf2/internal/service"
	"strings"

	"github.com/gogf/gf/v2/container/garray"

	// "github.com/gogf/gf/v2/container/glist"
	// "github.com/gogf/gf/v2/encoding/gjson"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"

	// "go/printer"

	v1 "gf2/api/v1"
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

type cRencaizhaopin struct{}

var Rencaizhaopin = cRencaizhaopin{} //在cmd.go中绑定路由

func (c *cRencaizhaopin) Get_gongsi(ctx context.Context, req *v1.Get_Gongsi_Req) (res *v1.Get_Gongsi_Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = gconv.Map(req)
	res0, err := service.Rencaizhaopin().Get_gongsi(ctx, map1)
	//代码1.  如果没有代码2,则下方的代码1会直接返回给客户端,但由于下方代码2的r.Response.WriteJsonExit代码存在,则不会再次返回了.屏蔽下方代码2就会继续返回给客户端了.代码2更灵活
	// res = &v1.Get_Gongsi_Res{
	// 	GongsiName:  "1",
	// 	GongsiFaRen: "教育",
	// 	GongsiYeWu:  "招生",
	// }
	//代码2,更灵活
	r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
		"data":    res0,
		"message": "查询公司信息成功",
	})
	return
}

// 获取招聘的岗位信息.用于招聘筛选页
func (c *cRencaizhaopin) Get_gangwei(ctx context.Context, req *v1.GetgangweiReq) (res *v1.GetgangweiRes, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = gconv.Map(req)
	//var res0 gdb.Result{}
	res0, err := service.Rencaizhaopin().Get_gangwei(ctx, map1, map1["Page"].(int))
	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询岗位失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data": g.Map{"num": res0.Len(), "res": res0},

			"message": "查询岗位成功",
		})

	}
	return
}
func (c *cRencaizhaopin) Fa_bu(ctx context.Context, req *v1.Fabu0Req) (res *v1.Fabu0Res, err error) {
	//请求的数据类似如下:其中yingpinzheId又包含了json
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r

	json_str := gconv.MapDeep(req) //将结构体req转为map类型
	g.Dump(json_str)
	fmt.Printf("变量类型为:%T ", json_str)
	//解析jsons数据应聘者
	// if j, err := gjson.DecodeToJson(json_str); err != nil { //DecodeToJson(map类型)转成json对象,其中有个自动转换
	// 	panic(err)
	// } else {

	// 	json_yingpanzhe := j.GetJson("yingpinzheId").Get("应聘者") //获取yinpinzheid下的json数据."yinpinzheid":[{"id":"1","name":"jin"},{"id":"59","name":"yuan"},{"id":"11","name":"qing"}]
	// 	fmt.Printf(`%+v`, json_yingpanzhe)                      //
	// 	fmt.Printf(`%+v`, len(json_yingpanzhe.Array()))         //转成数组,然后取大小
	// 	fmt.Printf(`%+v`, json_yingpanzhe.Array()[0])           //返回map类型
	// 	fmt.Printf(`%+v`, gconv.Map(json_yingpanzhe.Array()[0])["name"])
	// }
	err, id := service.Rencaizhaopin().Fabu(ctx, model.RenCaiZhaoPin{

		GongSiMing:      req.GongSiMing,
		Gangwei:         req.Gangwei,
		Renshu:          req.Renshu,
		Xueli:           req.Xueli,
		Yaoqiu:          req.Yaoqiu,
		Baoxian:         req.Baoxian,
		Xinchou:         req.Xinchou,
		Lianxifangshi:   req.Lianxifangshi,
		Liulanshu:       req.Liulanshu,
		YingpinzheId:    req.YingpinzheId,
		Qita:            req.Qita,
		Kaishishijian:   req.Kaishishijian,
		Jieshushijian:   req.Jieshushijian,
		Youxiang:        req.Youxiang,
		TuPian:          req.TuPian,
		Quanzhi:         req.Quanzhi,
		Dizhi:           req.Dizhi,
		Gongzuonianxian: req.Gongzuonianxian,

		Zuozhe:  req.Zuozhe,
		Zhiding: req.Zhiding, Jinghua: req.Jinghua,
	})
	//json1 := gconv.MapDeep(json["应聘者"])
	//g.Dump((json1))
	//println(gconv.Map(json["应聘者"]))
	//g.Dump(len(json["应聘者"]))
	//g.Dump(json["应聘者"])
	//	num1, err := service.Admin().Update_user(ctx, map1) //

	//fmt.Print(err)
	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    id, //返回最后一条数据id
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

// 获取岗位分类和岗位信息.用于招聘分类页.不能在传入page参数了
func (c *cRencaizhaopin) Get_fenlei_gangweixifen(ctx context.Context, req *v1.Fen_lei_Req) (res *v1.Fen_lei_Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	var map1 = gconv.Map(req)

	res1, err := service.Rencaizhaopin().Get_fenlei_gangweixifen(ctx, map1)
	// 创建并发安全的str类型数组
	var res0 = garray.NewStrArray(true)
	var res2 = garray.NewArray(true)
	var res4 interface{}        //var  res4=garray.NewArray(true)//*garray.Array 这个定义没法满足	res4 = res2.DeepCopy()的要求.res2.DeepCopy()返回的是interface{}.
	res3 := make([][]string, 0) //创建新切片
	////res7 := make([]interface{}, 0) //创建新切片
	//var res6 = garray.NewArray(true)
	////res5 := make([]garray.Array, 0) //创建新切片
	//var res3 = garray.NewArray(true)

	for i := 0; i < res1.Len(); i++ {
		res0.Clear()
		res0.Append(res1[i]["fen_lei"].String())

		s5 := res1[i]["gang_wei_id"].String()

		s4 := s5[1 : len(s5)-1]      //截取字符串,去除[]2个符号
		s2 := strings.Split(s4, ",") //分割字符串获取数组
		// println(s2)
		// s3 := gconv.SliceStr(res0)

		// s := garray.NewStrArrayFrom(s3)
		//   res0.Append(s2[0])把s2数组得第一个元素添加道res0数组得末尾
		res0.Merge(s2) //把s2数组添加道res0数组得末尾

		res2.Append(res0.DeepCopy()) //res0.deepcopy深拷贝后,对res0进行的操作不影响res2.
		res4 = res2.DeepCopy()

	}

	println(res4) //类型是interface,存放的是二维数组.如[["1","11"],["2","22"]].

	fmt.Printf("变量类型为:%T ", (res4))                 //变量类型为:*garray.Array
	fmt.Printf("变量类型为:%T ", gconv.Interfaces(res4)) //把*garray.Array接口转为[]interface{}此处已经是数组或切片类型了,这是数组和切片的定义方式哦.可以使用数组的下标
	println("长度", len(gconv.Interfaces(res4)))
	// b := gconv.Interfaces(gconv.Interfaces(res4))
	a := gconv.Interfaces(gconv.Interfaces(res4)[0]) //gconv.Interfaces(res4)的类型是[]insterface,[0]的类型[]insterface的第一个元素还是个interface如["1","11"].把interface["1","11"]再转换一次就是真正的数组元素了
	println("元素", gconv.String(a[0]))                //把[]中的第一个字符串元素取出来.a[0]类型是接口,因此需要转为gconv.string
	println(res3)

	//  fmt.Printf("var1: %s\n", reflect.TypeOf(res0))//获取变量类型
	var b2 = garray.NewArray(true)

	var b4 = garray.NewArray(true)                     //存放数组b2的深度拷贝结果
	for i := 0; i < len(gconv.Interfaces(res4)); i++ { //存放的是二维数组.如[["软件","1","2"],["硬件","3"]].
		// println(b[i])
		b1 := gconv.Interfaces(gconv.Interfaces(res4)[i]) //取res4[i]的数组的每个数组元素.如获得["软件","1","2"]
		println("len:", len(gconv.Interfaces(b1)))
		for i1 := 0; i1 < len(gconv.Interfaces(b1)); i1++ { //根据res4嵌套数组的子数组长度遍历["软件","1","2"],则遍历3次

			println("元素", gconv.String(b1[i1])) //输出"软件","1","2"

			if i1 > 0 { //b1的其他元素作为id查询job_gangwei表获取对应的岗位名称.
				id := gconv.Int(b1[i1])
				res5, err1 := dao.JobGangwei.Ctx(ctx).Where("id", id).One()

				if err1 != nil {

					println(err1)
				} else {
					println(res5)
					println(res5["gangwei"].String())
					b2.Append(res5["gangwei"].String()) //把查询jobgangwei表得到的岗位名称加入b2

				}

			} else { //i1=0时,把b1的第一个元素,分类加入b2中

				b2.Append(gconv.String(b1[i1])) //b1的第一个元素"软件"值作为分类加入到b2数组第一个元素中中
			}
		}
		b4.Append(b2.DeepCopy()) //b4放b2的深拷贝结果.这样b2使用clear后,不会影响b4的结果. 把b2数组加入到b4数组中,目的是实现[[],[]]数组的嵌套

		b2.Clear() //清空b2数组
		//
	}
	//获取job_gangwei表的所有数据.只要岗位名就可以.id作为序号.因此结果为发送给前台后为列表.下标就是id了
	id_gangwei, err2 := dao.JobGangwei.Ctx(ctx).OrderAsc("id").All()
	println(id_gangwei)

	if err != nil || err2 != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询分类和岗位失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data": g.Map{"num": len(gconv.Interfaces(b4)), "res": b4, "id_gangwei": id_gangwei}, //发送的数据如[[软件, c开发, python开发], [硬件, 单片机]]

			"message": "查询分类和岗位成功",
		})

	}
	return
}

func (c *cRencaizhaopin) Set_fenlei_gangwei(ctx context.Context, req *v1.Set_Fen_lei_Req) (res *v1.Set_Fen_lei_Res, err error) {
	//请求的数据类似如下:其中yingpinzheId又包含了json
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r

	// json_str := gconv.MapDeep(req) //将结构体req转为map类型
	// g.Dump(json_str)
	// fmt.Printf("变量类型为:%T ", json_str)
	// if j, err := gjson.DecodeToJson(json_str); err != nil { //DecodeToJson(map类型)转成json对象,其中有个自动转换
	// 	panic(err)
	// } else {

	// 	json_yingpanzhe := j.GetJson("yingpinzheId").Get("应聘者") //获取yinpinzheid下的json数据."yinpinzheid":[{"id":"1","name":"jin"},{"id":"59","name":"yuan"},{"id":"11","name":"qing"}]
	// 	fmt.Printf(`%+v`, json_yingpanzhe)                      //
	// 	fmt.Printf(`%+v`, len(json_yingpanzhe.Array()))         //转成数组,然后取大小
	// 	fmt.Printf(`%+v`, json_yingpanzhe.Array()[0])           //返回map类型
	// 	fmt.Printf(`%+v`, gconv.Map(json_yingpanzhe.Array()[0])["name"])
	// }
	err = service.Rencaizhaopin().Set_fenlei_gangwei(ctx, model.ZhaopinFenleiGangwei{

		FenLei:  req.FenLei,
		GangWei: req.GangWei,
	})
	//json1 := gconv.MapDeep(json["应聘者"])
	//g.Dump((json1))
	//println(gconv.Map(json["应聘者"]))
	//g.Dump(len(json["应聘者"]))
	//g.Dump(json["应聘者"])
	//	num1, err := service.Admin().Update_user(ctx, map1) //

	//fmt.Print(err)
	if err == nil { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    "", //返回最后一条数据id
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
func (c *cRencaizhaopin) Query_job(ctx context.Context, req *v1.Query0job0Req) (res *v1.Query0job0Res, err error) {
	var r = g.RequestFromCtx(ctx) //从上下文ctx中获取r
	//
	// var map2 = r.GetMap()
	// fmt.Println(map2)
	// fmt.Println(r.Get("Tiaojian").Map());
	var map1 = gconv.Map(req)
	delete(map1, "token")
	fmt.Println(map1)
	res0, err := service.Rencaizhaopin().Query_job(ctx, map1) //按map条件筛选

	if err != nil {

		r.Response.WriteJsonExit(g.Map{"code": "1", //代码此处随意填写.超过1000即可
			"data":    "",
			"message": "查询招聘信息失败",
		})

	} else {

		r.Response.WriteJsonExit(g.Map{"code": "0", //代码此处随意填写.超过1000即可
			"data": g.Map{
				"num": len(res0),
				"res": res0,
			},
			"message": "查询招聘信息成功",
		})

	}
	return
}

// 修改招聘信息
func (c *cRencaizhaopin) Zhaopin_update(ctx context.Context, req *v1.Zhaopin_Update_Req) (res *v1.Zhaopin_Update_Res, err error) {

	r := g.RequestFromCtx(ctx)

	//写入数据库.insert所在的service不做错误处理,直接在次控制器处理
	res1, _ := service.Rencaizhaopin().Update_zhaopin(ctx, model.RenCaiZhaoPin{
		//A:B, A--->model.Admin8wen8zhang
		Id:              req.Id,
		GongSiMing:      req.GongSiMing,
		Gangwei:         req.Gangwei,
		Renshu:          req.Renshu,
		Xueli:           req.Xueli,
		Yaoqiu:          req.Yaoqiu,
		Baoxian:         req.Baoxian,
		Xinchou:         req.Xinchou,
		Lianxifangshi:   req.Lianxifangshi,
		Liulanshu:       req.Liulanshu,
		YingpinzheId:    req.YingpinzheId,
		Qita:            req.Qita,
		Kaishishijian:   req.Kaishishijian,
		Jieshushijian:   req.Jieshushijian,
		Youxiang:        req.Youxiang,
		TuPian:          req.TuPian,
		Quanzhi:         req.Quanzhi,
		Dizhi:           req.Dizhi,
		Gongzuonianxian: req.Gongzuonianxian, Zuozhe: req.Zuozhe,
		Zhiding: req.Zhiding, Jinghua: req.Jinghua,
	})
	// print(res1.LastInsertId())
	// id ,err:=res1.LastInsertId()//插入文章后返回最后的记录id.多人插入可能存在获取id不准问题
	num, err := res1.RowsAffected()
	if err == nil && num == 1 { //err为空,没有错误发生,则正常.
		// print(0)
		r.Response.WriteJsonExit(g.Map{"code": "0", //
			"data":    "ok", //返回update影响的行数
			"message": "更新招聘信息成功",
		})

	} else {
		// print(1)
		r.Response.WriteJsonExit(g.Map{"code": "0",
			"data":    g.Map{"err": err},
			"message": "更新招聘信息失败",
		})
	}

	return
}
