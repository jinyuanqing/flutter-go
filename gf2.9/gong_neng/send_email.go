package send_email

import (
	"flag"
	"fmt"
	"strings"

	"gopkg.in/gomail.v2"
)

const (
	// 邮件服务器地址  //https://qiye.163.com/help/client-profile.html中查询stmp端口和服务器地址
	MAIL_HOST = "smtphz.qiye.163.com"
	// 端口
	MAIL_PORT = 25
	// 发送邮件用户账号. 免费的网易企业邮箱
	MAIL_USER = "yxzhw@yxzhw.cn"
	// 授权密码2034-12-31
	MAIL_PWD = "vaDLc9Zf2rtWMcF5"
)

// 接收者邮箱,多个邮箱用分号分隔.一个邮箱不用分号.
var to *string = flag.String("to", "2838386460@qq.com;761153454@qq.com;", "to")

// 主题
var sub *string = flag.String("sub", "悠闲综合网的验证邮件", "subject")

// var bd *string = flag.String("bd", "这是一个验证链接http://127.0.0.1:8199/xitong/compare_time?Str_jiami="+shijian+"<br>这是来自悠闲综合网的邮件,请勿回复!", "body")

var file *string = flag.String("file", "", "i want to send ...")

/*
title 使用gomail发送邮件
@param []string mailAddress 收件人邮箱
@param string subject 邮件主题
@param string body 邮件内容
@param string attaches 附件内容
@return error
*/
func SendGoMail(mailAddress []string, subject string, body string, attaches []string) error {

	m := gomail.NewMessage()
	nickname := "悠闲综合网yxzhw.cn"
	//gomail.Rename(mime.QEncoding.Encode("UTF-8", nickname))
	//m.SetHeader("From", nickname+"<"+MAIL_USER+">")
	m.SetHeader("From", m.FormatAddress(MAIL_USER, nickname)) //nickename别名,注意使用 m.FormatAddress哦
	// 发送给多个用户
	m.SetHeader("To", mailAddress...)
	// 设置邮件主题
	m.SetHeader("Subject", subject)
	// 设置邮件正文
	m.SetBody("text/html", body)
	//for _, file := range attaches {
	//	_, err := os.Stat(file)
	//	if err != nil {
	//		fmt.Println("Error:", file, "does not exist")
	//	} else {
	//		fmt.Println("uploading", file, "...")
	//		m.Attach(file)
	//	}
	//}
	d := gomail.NewDialer(MAIL_HOST, MAIL_PORT, MAIL_USER, MAIL_PWD)
	// 发送邮件
	err := d.DialAndSend(m)
	return err
}

func Main2(email string, shijian string) {
	flag.Parse() // 内容

	// var bd *string = flag.String("bd", "这是一个验证链接http://127.0.0.1:8199/xitong/compare_time?Str_jiami="+shijian1+"<br>这是来自悠闲综合网的邮件,请勿回复!", "body")

	if (to != nil) || (file != nil) {
		//字符串分割, 使用字符分割出to,file

		if strings.Contains(email, ";") { //含有分号,说明是多个接收者.返回真...给email添加了分号,方便多邮件处理
			tos := strings.Split(email, ";")

			var tos1 []string = make([]string, len(tos)-1)

			copy(tos1, tos[0:len(tos)-1])
			print((tos1))

			files := strings.Split(*file, ";")
			body1 := "这是一个验证链接,请您在10分钟内点击链接进行验证<br>http://127.0.0.1:8199/xitong/compare?Str_jiami=" + shijian + "<br>这是来自悠闲综合网的邮件,请勿回复!" //xitong/是控制器,compare_time是控制器内的方法
			err := SendGoMail(tos1, *sub, body1, files)

			if err != nil {
				fmt.Printf("请求异常，请检查请求参数！")
				return
			}
		}
	}
}
