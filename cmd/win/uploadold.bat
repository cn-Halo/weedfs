:: 是否在控制台显示命令 off关闭 on开启
@echo off
:: 注意：这个要放在chcp 65001命令的前面，不然输出日期格式里面带有中文 类似这种 周二 2022/06/07 16:41:22.15
set NOW_TIME=%date:~0,4%-%date:~5,2%-%date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%
:: 代码页更改为Unicode(utf-8)
chcp 65001
echo "====================开始上传====================" > a.txt
echo %date% %time%  >> a.txt
weed.exe upload -master="139.196.103.195:9333" -dir="E:\Navicat Premium" -collection=uploadByWinTest -ttl=1y >> a.txt
echo %date% %time% >> a.txt
echo "====================结束上传====================" >> a.txt
:: 重命名文件
ren a.txt %NOW_TIME%.txt
:: 阻塞 为了防止双击命令之后控制台自动关闭
pause