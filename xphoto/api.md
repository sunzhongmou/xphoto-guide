#注意！
**除了'/signup', '/signin', '/active_account'这三个接口不需要携带JWTToken，其他所有接口必须携带！**

格式为【Authorization: 'Bearer ' + *JWTToken* 】

注册流程：注册——激活——登录

#注册
POST '/signup'

* username: 用户名至少需要5个字符。且满足该正则（/^[a-zA-Z0-9\-_]+$/i）
* email: email返回
* password
* repeat_password

####正确返回

```
{
    "success": "欢迎加入 xphoto！我们已给您的注册邮箱发送了一封邮件，请点击里面的链接来激活您的帐号。"
}
```

####错误返回
错误码：422

```
{
    "error": "用户名或邮箱已被使用。"
}
```

#激活账号

GET '/active_account'

* key
* username

还有key错误，账号错误，帐号已经是激活状态，但返回相同
####正确返回
```
{
	"success":"帐号已被激活，请登录"
}
```

####错误返回
错误码：422

如果已激活

```
{
    "error": "帐号已经是激活状态。"
}
```

#登录

POST '/signin'

* username/email
* password

####正确返回
```
{
    "success": "登录成功！",
    "JWTToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1MDA4MDY0OTB9.CdkQHo5ur72eVLYRjuWmEyxXIUrK7LMmiE3KBdNQoA0"
}
```

####错误返回
```
{
    "error": "此帐号还没有被激活，激活链接已发送到 282503846@qq.com 邮箱，请查收。"
}
```

```
{
    "error": "用户名或密码错误"
}
```
.....


#注销
由于JWT是前端保存身份信息的方式，服务器无法让Token在过期时间内失效，或者令客户端删除JWTToken，所以有如下方式可解决。

1. 在前端删除JWTToken，也就删除Authorization头并跳转回首页
2. 在后端创建黑名单，记录过期时间，每次在后端判断是否过期

现在简单来吧，就选第一个了。

#获取用户信息

GET '/userInfo'

####正确返回
```
{
    "id": "xxxxxxxxxxx",
    "username": "用户名",
    "email": "xxxxxxxxxxxx@qq.com",
    "iat": 1500813804
}
```

#上传图片
POST '/upload'

####正确返回
```
{
    "urls": [
        "http://little7-1252484566.cosgz.myqcloud.com/7212da46a42ba9af1fff52e57e1c8b59.png",
        "http://little7-1252484566.cosgz.myqcloud.com/7212da46a42ba9af1ffxxxxxxxx.png"
    ]
}
```
####错误返回
```
{
    "error": "File format must be png or jpg!"
}

{
    "error": "File size too large. Max is 1MB"
}

```

#获取用户所有的图片
GET '/images'

####正确返回
```
{
    "urls": [
        "http://little7-1252484566.cosgz.myqcloud.com/7212da46a42ba9af1fff52e57e1c8b59.png",
        "http://little7-1252484566.cosgz.myqcloud.com/7212da46a42ba9af1ffxxxxxxxx.png"
    ]
}
```

####错误返回
```
{
    "error": "there is no image about userId: xxx"
}
```

#注册人脸库
POST '/images-db

{"file": ["file1", "file2"]}

####正确返回
返回码201
```
{
    "message": "register success!"
}
```

#从人脸库中查找
POST '/images-db/?search

{"faceFile": "faceFile1"}

####正确返回
返回码200
```
{
    "isInterested": true
}
```

返回码404
```
{
    "isInterested": false
}
```

#全局异常
异常处理没有涵盖到的异常、参数不全导致的库调用异常统一格式、未知异常：

错误码：500

```
{
    "error": "服务器错误"
}
```