package v1

// *api定义中写表中的所有字段,然后控制器中引入api的定义的结构体.logi中引入model中创建的模型表文件中的结构体字段
import (
	"gf2/internal/model/entity"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
)

// api中的结构体必须req,res成对出现
type UserProfileReq struct {
	g.Meta `path:"/user/profile" method:"get" tags:"用户" summary:"Get the profile of current user"`
}
type UserProfileRes struct {
	*entity.User
}
type UserGetReq struct {
	g.Meta `path:"/user/get_user_accordto_page" method:"post" tags:"用户" summary:"根据分页获取用户"`
	// Username string `v:"required|json:username" `
	Page int //分页默认为1
}

type Getallusernum_Req struct {
	g.Meta `path:"/user/get_alluser_num" method:"post" tags:"用户" summary:"获取用户数量"`
	//Id     string
}
type Getallusernum_Res struct {
}

type UserGetRes struct { //res中的字段无需,可以直接控制器中返回即可.所以这里多余
	// Id       uint   `json:"id"       ` // User ID
	Username string `json:"username" ` // 通行证/用户名
	// Password string `json:"password" ` // 密码
	// Email    string `json:"email"    ` // 邮箱
	Address string `json:"address"  ` // 地址
	// Nickname string `json:"nickname" ` // 昵称
	// CreateAt string `json:"createAt" ` // Created Time
	// UpdateAt string `json:"updateAt" ` // Updated Time
	// Tel      string `json:"tel"      ` // 电话
	// Birthday string `json:"birthday" ` // 出生日期
	// Beiyong1 string `json:"beiyong1" `
}

type UserSignUpReq struct {
	g.Meta `path:"/user/zhuce" method:"post" tags:"用户" summary:"注册Sign up a new user account"`
	Shibie string `json:"shibie"        description:"识别码,用于验证此次注册是否合法"`

	Username string `v:"required|length:6,16"`
	Password string `v:"required|length:6,16"`
	Isadmin  int    `json:"isadmin"        description:"用户身份"`
	Email    string `json:"email"        description:"邮箱"`
	Address  string `json:"address"      description:"地址"`
	Nickname string `v:"required|length:6,16" json:"nickname"     description:"昵称"`

	Tel          string `json:"tel"          description:"电话"`
	Birthday     string `json:"birthday"     description:"出生日期"`
	Beiyong1     string `json:"beiyong1"     description:"备用"`
	Sex          string `json:"sex"          description:"性别"`
	Qianming     string `json:"qianming"     description:"签名"`
	Shenfenzheng string `json:"shenfenzheng" description:"身份证号"`
	Ip           string `json:"ip"           description:"最后登录ip"`
	Touxiang     string `json:"touxiang"     description:"头像"`
	Jifen        uint   `json:"jifen"        description:"积分"`
}
type UserSignUpRes struct{}
type UsermenuReq struct {
	g.Meta   `path:"/user/get_user_menu" method:"post" tags:"用户" summary:"获取前台菜单"`
	Username string `v:"required"`
}
type UsermenuRes struct{}

type UserSignInReq struct {
	g.Meta   `path:"/user/SignIn" method:"post" tags:"用户" summary:"用户登录接口,在cmd.go中被调用"`
	Username string `v:"required"`
	Password string `v:"required"`
}
type UserSignInRes struct{}

type UserCheckPassportReq struct {
	g.Meta   `path:"/user/check-passport" method:"post" tags:"用户" summary:"Check passport available"`
	Username string `v:"required"`
}
type UserCheckPassportRes struct{}

type UserCheckNickNameReq struct {
	g.Meta   `path:"/user/check-passport" method:"post" tags:"用户" summary:"Check nickname available"`
	Nickname string `v:"required"`
}
type UserCheckNickNameRes struct{}

type UserIsSignedInReq struct {
	g.Meta `path:"/user/is-signed-in" method:"post" tags:"用户" summary:"Check current user is already signed-in"`
}
type UserIsSignedInRes struct {
	OK bool `dc:"True if current user is signed in; or else false"`
}

type UserSignOutReq struct {
	g.Meta `path:"/user/sign-out" method:"post" tags:"用户" summary:"Sign out current user"`
}
type UserSignOutRes struct{}

type UserUploadfileReq struct {
	g.Meta `path:"/user/uploadfile" method:"post" tags:"用户" summary:"上传文件"`
	File   *ghttp.UploadFile `json:"file" dc:"上传文件" type:"file"`
}
type UserUploadfileRes struct { //返回文件名和路径

	Name    string
	FileUrl string
}

// http://xx/xx/
type User0get0article0Req struct {
	g.Meta   `path:"/user/user_get_article" method:"get" tags:"用户" summary:"获取指定数量的文章" `
	Page     int //指定获取文章的数量,page是页数从1开始.
	Fenleiid int //文章分类id
}
type User0get0article0Res struct { //

}

type UserhuoqufenleiReq struct {
	g.Meta `path:"/user/user_huo_qu_fen_lei" method:"get" tags:"用户" summary:"获取文章分类" `
	// Page   int //指定获取文章的数量,page是页数从1开始.

}
type UserhuoqufenleiRes struct { //

}

type UserzhaopinReq struct {
	g.Meta `path:"/user/user_rencai_zhaopin" method:"get" tags:"用户" summary:"人才招聘信息" `
	// Page   int //指定获取文章的数量,page是页数从1开始.

}
type UserzhaopinRes struct { //

}
