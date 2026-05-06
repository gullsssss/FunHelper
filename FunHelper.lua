script_name("AutoUpdate Example")
script_author("You")

local version = "1.0"
local version_url = "https://example.com/version.txt"
local script_url = "https://example.com/script.lua"
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    wait(2000)

    sampAddChatMessage("[Updater] Проверка обновлений...", -1)

    downloadUrlToFile(version_url, getWorkingDirectory() .. "\\version.txt",
        function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                local file = io.open(getWorkingDirectory() .. "\\version.txt", "r")
                if file then
                    local new_version = file:read("*a")
                    file:close()

                    if new_version ~= version then
                        sampAddChatMessage("[Updater] Найдена новая версия: " .. new_version, -1)
                        updateScript()
                    else
                        sampAddChatMessage("[Updater] У вас актуальная версия", -1)
                    end
                end
            end
        end
    )
end

function updateScript()
    local temp_path = getWorkingDirectory() .. "\\update.lua"

    downloadUrlToFile(script_url, temp_path,
        function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                sampAddChatMessage("[Updater] Обновление скачано!", -1)

                -- замена файла
                os.remove(script_path)
                os.rename(temp_path, script_path)

                sampAddChatMessage("[Updater] Перезапуск скрипта...", -1)
                thisScript():reload()
            end
        end
    )
end
