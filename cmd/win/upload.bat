:: �Ƿ��ڿ���̨��ʾ���� off�ر� on����
@echo off
:start
set /p NO=�����붩�����:
set URL=http://10.1.20.162:8000/api/customerApplication/orderNum/%NO%
echo.
echo ========У�鶩����ŵ�URLΪ��%URL%
::����һЩ���� ������if���涨�� ����Ȼȡ����ֵ������dirҪ����˫���ţ���Ȼȡֵ����ȷ
set ADDRESS=192.168.50.105:9333
set DIR=E:\Navicat Premium
set TTL=1y
echo ========�ļ��ϴ���URLΪ��http://%ADDRESS%
echo ========�ļ��ϴ���Ŀ¼Ϊ��%DIR%
echo ========�ļ�����������Ϊ��time to live, e.g.: 1m, 1h, 1d, 1M, 1y����%TTL%
echo.
::  curl -I -s -o "/dev/null"   -w "%%{http_code}\n"  "http://baidu.com" ������  ��bat�� ��   %%{http_code} Ҫ��2��% ,��cmd��ֻ��Ҫ1��%
:: ������Ϊ�˵���url���ص�״̬��洢��������
for /f "tokens=*" %%i in ('curl -I -s -o "/dev/null"   -w "%%{http_code}\n"  "%URL%"') do (
	set httpcode=%%i
)
::echo ���󷵻صĽ���ǣ�%httpcode%
:: ��������ļ���״̬�� �ܴ���ķֱ���200�����ݶ������ҵ������ݣ� ��400�����ݶ�����δ�ҵ����ݣ���404��url���ô���
set SUCCESSCODE=200
set NOERRORCODE=400
set URLERRORCODE=404
:: �ж����󷵻ص�״̬���ǲ���200��200�����ҵ���ƥ��Ķ����� ������״̬�����У�鲻ͨ��
if %httpcode% EQU %SUCCESSCODE% (
echo ========�������ƥ��ɹ�========

echo ========��ʼ�ϴ��ļ����ϴ���־����ǰĿ¼��log.txt��========
echo ====================��ʼ�ϴ�==================== >> log.txt
echo %date% %time%  >> log.txt
weed.exe upload -master="%ADDRESS%" -dir="%DIR%" -collection="%NO%" -ttl="%TTL%" >> log.txt
echo %date% %time% >> log.txt
echo ====================�����ϴ�==================== >> log.txt
:: ���һ���л�����־�ļ�
echo.>>log.txt
echo.>>log.txt
echo ========����ϴ��ļ����ϴ���־����ǰĿ¼��log.txt��========

) ELSE  IF %httpcode% EQU %NOERRORCODE% (
echo ========������Ų����ڣ����������붩�����========
goto start
) ELSE  IF %httpcode% EQU %URLERRORCODE% (
echo ========�����URL���ô�������������URL������ϵ����Ա����========
) ELSE (
echo ========δ֪���󣨿���ԭ�򣺷������쳣�����粻ͨ�ȣ������Ժ����Ի�����ϵ����Ա�Ų�========
)

:: ���� Ϊ�˷�ֹ˫������֮�����̨�Զ��ر�
pause
