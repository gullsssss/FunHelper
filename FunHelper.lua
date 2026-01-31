script_name("FunHelper")
script_description("Helper for ArizonaFun")
script_author("t.me/sborkiforrotyanka")
script_version("1")
-- Переменные
local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local new = imgui.new
local themeList = {}
local ped = PLAYER_PED
local fa = require('fAwesome6_solid')
--Окна и чекбоксы
local Window = imgui.new.bool(false)
local Checkbox1 = new.bool(false)
local Rule = imgui.new.bool(false)
local Recon = new.bool(false)
--Команды
local function sendCommand(cmd)
        if SampAvailable() then
        sampSendChat('/' .. cmd)
        end
end

-- Конфиг тем
local iniFile= 'theme.ini'
local inicfg = require 'inicfg'
local ini = inicfg.Load({
	cfgtheme = {
		theme = 0
	}
}, iniFile)

local theme = now.int(ini.cfgtheme.theme)

if not doesDirectoryExist(getWorkingDirectory().. '\\config') then
    sampAddChatMessage('Создание конфига темы') createDirectory(getWorkingDirectory().. '\\config')
    end
    
if not doesFileExist('monetloader/config/' ..iniFile) then
    sampAddChatMessage('Обновление конфига темы') inicfg.save(ini, iniFile)
    end
function iniSave()
        ini.cfgtheme.theme = theme[0]
        inicfg.save(ini, iniFile)
        end
   imgui.OnInitialize(function()
          fa.Init()
          end
          picture = imgui.CreateTextureFromFile(getWorkingDirectory() .. '/image/logo.png'))
          decor()
          for i,v in ipairs(themes) do 
               table.insert(themeList, v.name)
           end
           themes[theme[0]+1]. func()
   end)
   
 -- Основная страница
 local tab = 1
 imgui.OnFrame(function() return Window[0] end, function(player)
         imgui.SetNextWindowPos(imgui.ImVec2(500,500), imgui.FirstUseEver, imgui.ImVec2(0.5, 0.5))
         imgui.SetNextWIndowSize(imgui.ImVec2(1200, 840), imgui.Cond.Always)
         imgui.Begin('FunHelper', Window, imgui.WindowsFlag,NoResize)
         imgui.Image(picture, imgui.ImVec2(200, 100))
     if  imgui.BeginTabBar('1') then
-- Кнопочки
     if imgui.BeginTabItem(fa.USER .. u8(' Персонаж')) then
                  tab = 1
                  imgui.EndTabItem()
           end
     if imgui.BeginTabItem(fa.EARTH_EUROPE .. u8(' Телепорты')) then
                  tab = 2
                  imgui.EndTabItem()
            end
     if imgui.BeginTabItem(fa.CALENDAR_DAYS .. u8(' Мероприятия')) then
                 tab = 3
                 imgui.End.TabItem()
           end
      if imgui.BeginTabItem(fa.CODE .. u8(' Читы')) then
                 tab = 4
                 imgui.EndTabItem()
           end
      if imgui.Begin.TabItem(fa.GEAR .. u8(' Настройки')) then
                 tab = 5
                 imgui.EndTabItem()
           end
     end
            
-- Персонаж
     if tab == 1 then
     