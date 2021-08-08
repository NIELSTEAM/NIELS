database = dofile("./libs/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./libs/serpent.lua")
JSON    = dofile("./libs/dkjson.lua")
json    = dofile("./libs/JSON.lua")
URL = dofile("./libs/url.lua")
https = require("ssl.https")
http = require("socket.http")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo)  
local Write_Info_Sudo = io.open("Info.lua", 'w')
Write_Info_Sudo:write([[
s = "BGBBB"
q = "FBBBBB"
token = "]]..Token..[["
Sudo = ]]..Sudo..[[  
]])
Write_Info_Sudo:close()
end  
if not database:get(Server_Done.."Token_Write") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31mSorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31mThe Token Is Saved\n\27[0;39;49m')
database:set(Server_Done.."Token_Write",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua install.lua')
end
if not database:get(Server_Done.."UserSudo_Write") then
print("\27[1;34mSend Your Id Sudo :\27[m")
local Id = io.read():gsub(' ','') 
io.write('\n\27[1;31m The Id Is Saved\n\27[0;39;49m')
database:set(Server_Done.."UserSudo_Write",Id)
---ifok
else
io.write('\n\27[1;31mThe Id was not Saved\n\27[0;39;49m')
os.execute('lua install.lua')
end ---ifnot

local function Files_Info_Get()
Create_Info(database:get(Server_Done.."Token_Write"),database:get(Server_Done.."UserSudo_Write"))   
print("::NIELS::")
local RunBot = io.open("NIELS", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/NIELS
token="]]..database:get(Server_Done.."Token_Write")..[["
rm -fr niels.lua
wget "https://raw.githubusercontent.com/NIELSTEAM/NIELS/main/niels.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./niels.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("ts", 'w')
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
database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('Info.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('Info.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
