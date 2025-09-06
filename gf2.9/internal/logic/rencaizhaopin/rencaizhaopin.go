package rencaizhaopin

import (
	"context"
	"gf2/internal/dao"
	"gf2/internal/model"
	"gf2/internal/model/do"

	"database/sql"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"

	// "fmt"
	"gf2/internal/service"

	// "gf2/internal/service/internal/do"
	"github.com/gogf/gf/v2/database/gdb"
)

//var R1 *ghttp.Request

// type (
//
//	// sUser is service struct of module User.
//	sRencaizhaopin struct{}
//
// )
var a = sRencaizhaopin{}

type sRencaizhaopin struct{}

func init() {
	service.RegisterRencaizhaopin(New())
}

func New() *sRencaizhaopin {
	return &sRencaizhaopin{}
}

func (s *sRencaizhaopin) Fabu(ctx context.Context, in model.RenCaiZhaoPin) (err error, id int64) {

	err = dao.RenCaiZhaoPin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error {

		id, err = dao.RenCaiZhaoPin.Ctx(ctx).InsertAndGetId(do.RenCaiZhaoPin{
			GongSiMing:    in.GongSiMing,
			Gangwei:       in.Gangwei,
			Renshu:        in.Renshu,
			Xueli:         in.Xueli,
			Yaoqiu:        in.Yaoqiu,
			Baoxian:       in.Baoxian,
			Xinchou:       in.Xinchou,
			Lianxifangshi: in.Lianxifangshi,

			Liulanshu:       in.Liulanshu,
			YingpinzheId:    in.YingpinzheId,
			Kaishishijian:   in.Kaishishijian,
			Jieshushijian:   in.Jieshushijian,
			Youxiang:        in.Youxiang,
			Tupian:          in.TuPian,
			Qita:            in.Qita,
			Quanzhi:         in.Quanzhi,
			Dizhi:           in.Dizhi,
			Gongzuonianxian: in.Gongzuonianxian, Zuozhe: in.Zuozhe,
			Zhiding: in.Zhiding, Jinghua: in.Jinghua,
		})

		return err

	})

	return err, id
}

func (s *sRencaizhaopin) Query_job(ctx context.Context, map1 g.Map) (res gdb.Result, err error) { //筛选招聘信息

	// Gong_si_ming string // 公司名
	// Gangwei      string // 岗位
	// Riqi1        string // 汉字长度50
	// Riqi2        string //  不用设置时间,gf自动设定
	// Quan_zhi     int    // 全职
	// Xue_li       string //学历

	// biaoti := gconv.String(map1["Biaoti"])
	riqi1 := map1["Riqi1"]
	riqi2 := map1["Riqi2"]
	page := gconv.Int(map1["Page"])

	Gong_si_ming := gconv.String(map1["Gongsiming"]) //map1["Gong_si_ming"]返回的是接口,需要转换成字符串类型.用于查询语句
	Gangwei := map1["Gangwei"]
	Quan_zhi := map1["Quanzhi"]
	Xue_li := map1["Xueli"]
	Di_zhi := map1["Dizhi"]
	zuozhe := map1["Zuozhe"]
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
	if map1["Zuozhe"] != "" { //判断map的Riqi1是否存在.map1为url传递进来的参数

		a1["Zuozhe"] = zuozhe
	}

	if map1["Riqi1"] != "" { //判断map的Riqi1是否存在.map1为url传递进来的参数

		a1["update_at between ? and ?"] = g.Slice{riqi1, riqi2}
	}

	if map1["Gongsiming"] != "" {

		a1["gong_si_ming like ?"] = "%" + Gong_si_ming + "%"
	}

	if map1["Gangwei"] != "" {

		a1["gangwei"] = Gangwei
	}

	if map1["Quanzhi"] != "" {

		a1["quanzhi"] = Quan_zhi
	}

	if map1["Xueli"] != "" {

		a1["xueli"] = Xue_li
	}
	if map1["Dizhi"] != "" {

		a1["dizhi"] = Di_zhi
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
	res, err = dao.RenCaiZhaoPin.Ctx(ctx).WhereOr(a1).Page(page, 10).OrderAsc("id").All() //
	return res, err

}
func (*sRencaizhaopin) Get_gongsi(ctx context.Context, map1 g.Map) (res gdb.Result, err error) {
	res, err = dao.ZhaoPinGongSi.Ctx(ctx).Fields("id,gongsi_chengliriqi,gongsi_jian_jie,gongsi_xinyongdaima,gongsi_ye_wu,gongsi_name,gongsi_ling_yu,gongsi_pic,gongsi_fa_ren").Where("gongsi_name=?", map1["gongsiming"]).All() //返回一条数据
	return res, err
}
func (*sRencaizhaopin) Get_gangwei(ctx context.Context, map1 g.Map, page int) (res gdb.Result, err error) {
	res, err = dao.RenCaiZhaoPin.Ctx(ctx).Page(page, 10).OrderAsc("id").All()

	//res, err = dao.RenCaiZhaoPin.Ctx(ctx).Where("gong_si_ming=?", map1["GongSiMing"]).Page(page, 10).All()
	return res, err
}

func (*sRencaizhaopin) Get_fenlei_gangweixifen(ctx context.Context, map1 g.Map) (res gdb.Result, err error) {
	if map1["fenlei"] != "" {
		res, err = dao.ZhaopinFenleiGangwei.Ctx(ctx).Where("fen_lei=?", map1["fenlei"]).All()
	} else {
		res, err = dao.ZhaopinFenleiGangwei.Ctx(ctx).All()

	}

	return res, err
}

func (s *sRencaizhaopin) Set_fenlei_gangwei(ctx context.Context, in model.ZhaopinFenleiGangwei) (err error) {

	err = dao.ZhaopinFenleiGangwei.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error {
		_, err = dao.ZhaopinFenleiGangwei.Ctx(ctx).Data(do.ZhaopinFenleiGangwei{

			FenLei:    in.FenLei,
			GangWeiId: in.GangWei,
		}).Insert()

		return err
	})
	return err

}

func (s *sRencaizhaopin) Update_zhaopin(ctx context.Context, in model.RenCaiZhaoPin) (res sql.Result, err error) {
	err = dao.Admin.Transaction(ctx, func(ctx context.Context, tx gdb.TX) error { //事务插入数据

		res, err = dao.RenCaiZhaoPin.Ctx(ctx).Data(do.RenCaiZhaoPin{
			GongSiMing:    in.GongSiMing,
			Gangwei:       in.Gangwei,
			Renshu:        in.Renshu,
			Xueli:         in.Xueli,
			Yaoqiu:        in.Yaoqiu,
			Baoxian:       in.Baoxian,
			Xinchou:       in.Xinchou,
			Lianxifangshi: in.Lianxifangshi,

			Liulanshu:       in.Liulanshu,
			YingpinzheId:    in.YingpinzheId,
			Kaishishijian:   in.Kaishishijian,
			Jieshushijian:   in.Jieshushijian,
			Youxiang:        in.Youxiang,
			Tupian:          in.TuPian,
			Qita:            in.Qita,
			Quanzhi:         in.Quanzhi,
			Dizhi:           in.Dizhi,
			Gongzuonianxian: in.Gongzuonianxian, Zuozhe: in.Zuozhe,
			Zhiding: in.Zhiding, Jinghua: in.Jinghua,
		}).Where("id", in.Id).Update()
		println(in.YingpinzheId)
		return err

	})

	return res, err

}
