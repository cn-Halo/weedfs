:: 是否在控制台显示命令 off关闭 on开启
@echo off
:start
set /p NO=请输入订单编号:
set URL=http://10.1.20.162:8000/api/customerApplication/orderNum/%NO%
echo.
echo ========校验订单编号的URL为：%URL%
::定义一些变量 不能在if里面定义 ，不然取不到值，对于dir要加上双引号，不然取值不正确
set ADDRESS=192.168.50.105:9333
set DIR=E:\Navicat Premium
set TTL=1y
echo ========文件上传的URL为：http://%ADDRESS%
echo ========文件上传的目录为：%DIR%
echo ========文件的生命周期为（time to live, e.g.: 1m, 1h, 1d, 1M, 1y）：%TTL%
echo.
::  curl -I -s -o "/dev/null"   -w "%%{http_code}\n"  "http://baidu.com" 这条命  在bat中 令   %%{http_code} 要加2个% ,在cmd中只需要1个%
:: 以下是为了调用url返回的状态码存储到变量中
for /f "tokens=*" %%i in ('curl -I -s -o "/dev/null"   -w "%%{http_code}\n"  "%URL%"') do (
	set httpcode=%%i
)
::echo 请求返回的结果是：%httpcode%
:: 区分请求的几种状态码 能处理的分别是200（根据订单号找到了数据） 、400（根据订单号未找到数据）、404（url配置错误）
set SUCCESSCODE=200
set NOERRORCODE=400
set URLERRORCODE=404
:: 判断请求返回的状态码是不是200，200代表找到了匹配的订单号 、其余状态码代表校验不通过
if %httpcode% EQU %SUCCESSCODE% (
echo ========订单编号匹配成功========

echo ========开始上传文件（上传日志见当前目录下log.txt）========
echo ====================开始上传==================== >> log.txt
echo %date% %time%  >> log.txt
weed.exe upload -master="%ADDRESS%" -dir="%DIR%" -collection="%NO%" -ttl="%TTL%" >> log.txt
echo %date% %time% >> log.txt
echo ====================结束上传==================== >> log.txt
:: 添加一个行换到日志文件
echo.>>log.txt
echo.>>log.txt
echo ========完成上传文件（上传日志见当前目录下log.txt）========

) ELSE  IF %httpcode% EQU %NOERRORCODE% (
echo ========订单编号不存在，请重新输入订单编号========
goto start
) ELSE  IF %httpcode% EQU %URLERRORCODE% (
echo ========请求的URL配置错误，请重新配置URL或者联系管理员配置========
) ELSE (
echo ========未知错误（可能原因：服务器异常、网络不通等），请稍后再试或者联系管理员排查========
)

:: 阻塞 为了防止双击命令之后控制台自动关闭
pause
