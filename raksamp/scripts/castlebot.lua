local PATH = "/home/crow/RakSamp/Arizona";
local server_time = 3 * 60 * 60;

require("addon");
require("core");

local requests = require('requests')
local effil = require('effil')
local sampev = require("samp.events");
local json = require("json");
local encoding = require 'encoding';

encoding.default = 'CP1251';
u8 = encoding.UTF8;
local server_id = getCommandLineArgs():match("%-server (%d+)");
server_id = tonumber(server_id);

setLogPath(("Z:%s/logs/%d/%s.log"):format(PATH, server_id, os.date("%d.%m.%Y", os.time() + server_time)));
local server_prefix = "["..server_id.."] ";

local check = {
    afk = {}
};
setLogPath("RakSAMP Lite.log")
local TELEGRAM_TOKEN = '8328374143:AAHgQ4BBWgxiBK5hbCxRrvsaGrBirFNbwYM';
local TELEGRAM_CHATID = '241557613';
local BASE_URL = 'http://localhost:7776';

registerHandler("onReceivePacket", function(id, bs)
    bs:ignoreBits(8)
    if id == 220 then
        local type = bs:readUInt8()
        if type == 175 then
            local x, y, z = bs:readFloat(), bs:readFloat(), bs:readFloat()
            setBotPosition(x, y, z)
        end
    end
end)

function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str
end

local core = {
    orgs = {
        list = {
            {
                stats = "Полиция ЛС",
                name = "Полиция Лос-Сантоса",
                short = "LSPD",
                color = 4278214399,
                id = 1,
                group_id = 1,
                pos = {
                    1545.7,
                    -1675.51,
                    13.56
                }
            },
            {
                stats = "Областная полиция",
                name = "Областная полиция",
                short = "RCSD",
                color = 4278214399,
                id = 2,
                group_id = 1,
                pos = {
                    632.19,
                    -571.62,
                    16.34
                }
            },
            {
                stats = "FBI",
                name = "FBI",
                short = "FBI",
                color = 4278214399,
                id = 3,
                group_id = 1,
                pos = {
                    -2452.13,
                    503.66,
                    30.08
                }
            },
            {
                stats = "Полиция СФ",
                name = "Полиция Сан-Фиерро",
                short = "SFPD",
                color = 4278214399,
                id = 4,
                group_id = 1,
                pos = {
                    -1605.46,
                    714.37,
                    12.93
                }
            },
            {
                stats = "Больница LS",
                name = "Больница Лос-Сантоса",
                short = "LSMC",
                color = 4294926071,
                id = 5,
                group_id = 2,
                pos = {
                    1175.95,
                    -1323.18,
                    14.2
                }
            },
            {
                stats = "Правительство LS",
                name = "Правительство Лос-Сантоса",
                short = "Мэрия",
                color = 4290942976,
                id = 6,
                group_id = 3,
                pos = {
                    1495.59,
                    -1283.73,
                    14.53
                }
            },
            {
                stats = "Тюрьма строгого режима LV",
                name = "Тюрьма Строгого Режима",
                short = "ТСР",
                color = 4287583770,
                id = 7,
                group_id = 4,
                pos = {
                    234.65,
                    1902.83,
                    17.87
                }
            },
            {
                stats = "Больница СФ",
                name = "Больница Сан-Фиерро",
                short = "SFMC",
                color = 4294926071,
                gps_line = 1,
                id = 8,
                group_id = 2,
                pos = {
                    -2668.82,
                    635.49,
                    14.45
                }
            },
            {
                stats = "Центр лицензирования",
                name = "Центр лицензирования",
                short = "ЦЛ",
                color = 4294927872,
                id = 9,
                group_id = 3,
                pos = {
                    -2043.68,
                    -87.17,
                    35.16
                }
            },
            {
                stats = "TV студия",
                name = "Радиостудия Лос-Сантоса",
                short = "СМИ LS",
                color = 4294935552,
                id = 10,
                group_id = 5,
                pos = {
                    1653.59,
                    -1659.43,
                    22.52
                }
            },
            {
                stats = "Grove Street",
                name = "Grove Street",
                short = "Grove",
                color = 4279279872,
                id = 11,
                group_id = 6,
                pos = {
                    2495.12,
                    -1686.18,
                    13.51
                }
            },
            {
                stats = "Los Santos Vagos",
                name = "Los Santos Vagos",
                short = "Vagos",
                color = 4294952960,
                id = 12,
                group_id = 6,
                pos = {
                    2792.42,
                    -1618.52,
                    10.92
                }
            },
            {
                stats = "East Side Ballas",
                name = "East Side Ballas",
                short = "Ballas",
                color = 4291166420,
                id = 13,
                group_id = 6,
                pos = {
                    2001.31,
                    -1108.86,
                    26.77
                }
            },
            {
                stats = "Varrios Los Aztecas",
                name = "Varrios Los Aztecas",
                short = "Aztec",
                color = 4278255581,
                id = 14,
                group_id = 6,
                gps_line = 6,
                pos = {
                    2521.17,
                    -2001.66,
                    13.55
                }
            },
            {
                stats = "The Rifa",
                name = "The Rifa",
                short = "Rifa",
                color = 4285229567,
                id = 15,
                group_id = 6,
                pos = {
                    2185.81,
                    -1810.84,
                    13.55
                }
            },
            {
                stats = "Russian Mafia",
                name = "Russian Mafia",
                short = "РМ",
                color = 4282149833,
                id = 16,
                group_id = 7,
                pos = {
                    940.19,
                    1731.2,
                    8.85
                }
            },
            {
                stats = "Yakuza",
                name = "Yakuza",
                short = "Yakuza",
                color = 4289069056,
                id = 17,
                group_id = 7,
                gps_line = 7,
                pos = {
                    -2460.88,
                    134.67,
                    35.17
                }
            },
            {
                stats = "La Cosa Nostra",
                name = "La Cosa Nostra",
                short = "LCN",
                color = 4289078907,
                id = 18,
                group_id = 7,
                gps_line = 8,
                pos = {
                    1460.89,
                    2773.17,
                    10.82
                }
            },
            {
                stats = "Warlock MC",
                name = "Warlock MC",
                short = "Warlock",
                color = 4290265856,
                id = 19,
                group_id = 7,
                pos = {
                    -2189.72,
                    -2350.17,
                    30.63
                }
            },
            {
                stats = "Армия ЛС",
                name = "Армия Лос-Сантоса",
                short = "LSa",
                color = 4287583770,
                id = 20,
                group_id = 4,
                pos = {
                    2732.91,
                    -2450.7,
                    17.59
                }
            },
            {
                stats = "Центральный Банк",
                name = "Центральный Банк",
                short = "ЦБ",
                color = 4279005611,
                id = 21,
                group_id = 3,
                hided = true,
                pos = {
                    1480.85,
                    -1768.75,
                    18.8
                }
            },
            {
                stats = "Больница LV",
                name = "Больница Лас-Вентураса",
                short = "LVMC",
                color = 4294926071,
                id = 22,
                group_id = 2,
                pos = {
                    1607.5,
                    1819.17,
                    10.83
                }
            },
            {
                stats = "Полиция ЛВ",
                name = "Полиция Лас-Вентураса",
                short = "LVPD",
                color = 4278214399,
                id = 23,
                group_id = 1,
                pos = {
                    2287.05,
                    2428.53,
                    10.82
                }
            },
            {
                stats = "TV студия LV",
                name = "Радиостудия Лас-Вентураса",
                short = "СМИ LV",
                color = 4294935552,
                id = 24,
                group_id = 5,
                gps_line = 5,
                pos = {
                    2637.76,
                    1181.8,
                    10.82
                }
            },
            {
                stats = "Night Wolves",
                name = "Night Wolves",
                short = "Wolves",
                color = 4286928969,
                id = 25,
                group_id = 6,
                gps_line = 9,
                pos = {
                    2204.61,
                    -1160.4,
                    25.74
                }
            },
            {
                stats = "TV студия SF",
                name = "Радиостудия Сан-Фиерро",
                short = "СМИ SF",
                color = 4294935552,
                id = 26,
                group_id = 5,
                gps_line = 4,
                pos = {
                    -1941.4,
                    459.78,
                    35.17
                }
            },
            {
                stats = "Армия SF",
                name = "Армия Сан-Фиерро",
                short = "SFa",
                color = 4287583770,
                id = 27,
                group_id = 4,
                pos = {
                    -1369.94,
                    499.02,
                    11.2
                }
            },
            {
                stats = "Темное Братство",
                name = "Темное Братство",
                short = "Хитманы",
                color = 4284900966,
                id = 28,
                group_id = 8,
                pos = {
                    0,
                    0,
                    0
                }
            },
            {
                stats = "Страховая компания",
                name = "Страховая компания",
                short = "СК",
                color = 4279005594,
                id = 29,
                group_id = 8,
                gps_line = 3,
                pos = {
                    -1735.77,
                    788.35,
                    24.89
                }
            },
            {
                stats = "Tierra Robada Bikers",
                name = "Tierra Robada Bikers",
                short = "Bikers",
                color = 4291800902,
                id = 30,
                group_id = 7,
                gps_line = 10,
                pos = {
                    -1938.38,
                    2380.97,
                    49.49
                }
            },
            {
                stats = "Больница Jefferson",
                name = "Больница Jefferson",
                short = "JMC",
                color = 4294926071,
                id = 31,
                group_id = 2,
                gps_line = 2,
                pos = {
                    2032.97,
                    -1406.97,
                    17.19
                }
            },
            {
                stats = "Пожарный департамент",
                name = "Пожарный департамент",
                short = "SFFD",
                color = 4294919424,
                id = 32,
                group_id = 3,
                pos = {
                    -2023.86,
                    67.16,
                    28.47
                }
            }
        },
        vc = {
            {
                id = 1,
                name = "Полицейский участок",
                pos = {
                    648.82,
                    -420.16,
                    1505.71
                }
            },
            {
                id = 5,
                name = "Больница",
                pos = {
                    116.23,
                    -931.09,
                    1504.42
                }
            },
            {
                id = 10,
                name = "Радиостанция",
                pos = {
                    795,
                    243.57,
                    1508.45
                }
            }
        },
        groups = {
            {
                color = 4278214399,
                name = "Министерство юстиции"
            },
            {
                color = 4294926071,
                name = "Министерство здравоохранения"
            },
            {
                color = 4290942976,
                name = "Государственные учреждения"
            },
            {
                color = 4287583770,
                name = "Министерство обороны"
            },
            {
                color = 4294935552,
                name = "Средства массовой информации"
            },
            {
                color = 4279279872,
                name = "Уличные группировки"
            },
            {
                color = 4289078907,
                name = "Мафии"
            },
            {
                color = 4284900966,
                name = "Прочее"
            }
        }
    },
    bot_bandit = {
        positions = {
            {
                x = 1779.00,
                y = -1908.12,
                z = 12.39,
                range = 50
            },
            {
                x = 1113.42,
                y = -1785.42,
                z = 15.59,
                range = 80
            }
        }
    },
    zones = {
        ghetto = {
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -962
            },
            {
                is_drug_den = true,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -861,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -962
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -962,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1063
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = true,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = true,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1063,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1164
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1164,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1265
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1265,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1366
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1366,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1467
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1568
            },
            {
                is_drug_den = true,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1568
            },
            {
                is_drug_den = true,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1467,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1568
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = true,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1568,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1669
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1770
            },
            {
                is_drug_den = true,
                y2 = -1669,
                color = 0,
                is_central = true,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = true,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1669,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1770
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = true,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1770,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1871
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -1972
            },
            {
                is_drug_den = true,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1871,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -1972
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                x2 = 1770,
                y1 = -2073
            },
            {
                is_drug_den = true,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                x2 = 1898,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                x2 = 2026,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                x2 = 2154,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                x2 = 2282,
                y1 = -2073
            },
            {
                is_drug_den = true,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                x2 = 2410,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = true,
                organization = 0,
                x1 = 2410,
                x2 = 2538,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                x2 = 2666,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                x2 = 2794,
                y1 = -2073
            },
            {
                is_drug_den = false,
                y2 = -1972,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                x2 = 2922,
                y1 = -2073
            },
            {
                x2 = 1770,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1642,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 1898,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1770,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2026,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 1898,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2154,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2026,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2282,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2154,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2410,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2282,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2538,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2410,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2666,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2538,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2794,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2666,
                is_drug_den = false,
                y1 = -2174
            },
            {
                x2 = 2922,
                y2 = -2073,
                color = 0,
                is_central = false,
                is_respawn = false,
                organization = 0,
                x1 = 2794,
                is_drug_den = false,
                y1 = -2174
            }
        },
        mafia = {
            {
                organization = 0,
                money = 86032,
                name = "Магазин 24%/7",
                id = 175
            },
            {
                organization = 0,
                money = 30478,
                name = "Ларек с уличной едой",
                id = 197
            },
            {
                organization = 0,
                money = 316151,
                name = "Ларек с уличной едой",
                id = 198
            },
            {
                organization = 0,
                money = 237525,
                name = "Ларек с уличной едой",
                id = 199
            },
            {
                organization = 0,
                money = 51336,
                name = "Ларек с уличной едой",
                id = 201
            },
            {
                organization = 0,
                money = 224778,
                name = "Ларек с уличной едой",
                id = 203
            },
            {
                organization = 0,
                money = 3852801,
                name = "Автомастерская",
                id = 213
            },
            {
                organization = 0,
                money = 39455,
                name = "Ларек с уличной едой",
                id = 218
            },
            {
                organization = 0,
                money = 237359,
                name = "Sport Club LV",
                id = 226
            },
            {
                organization = 0,
                money = 1483647,
                name = "Автомастерская FC",
                id = 228
            },
            {
                organization = 0,
                money = 39511,
                name = "Школа танцев",
                id = 234
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 243
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 246
            },
            {
                organization = 0,
                money = 38555,
                name = "АЗС%/Магазин механики",
                id = 253
            },
            {
                organization = 0,
                money = 114290,
                name = "Сельскохозяйственный магазин",
                id = 254
            },
            {
                organization = 0,
                money = 17341,
                name = "Магазин 24%/7",
                id = 257
            },
            {
                organization = 0,
                money = 16475,
                name = "Закусочная",
                id = 259
            },
            {
                organization = 0,
                money = 933281,
                name = "АЗС%/Магазин механики",
                id = 262
            },
            {
                organization = 0,
                money = 489578,
                name = "АЗС%/Магазин механики",
                id = 264
            },
            {
                organization = 0,
                money = 18879,
                name = "Ларек с уличной едой",
                id = 267
            },
            {
                organization = 0,
                money = 104307,
                name = "Закусочная",
                id = 271
            },
            {
                organization = 0,
                money = 16868,
                name = "Магазин одежды",
                id = 273
            },
            {
                organization = 0,
                money = 192130,
                name = "Спортивная площадка",
                id = 274
            },
            {
                organization = 0,
                money = 0,
                name = "Автосалон Luxe",
                id = 275
            },
            {
                organization = 0,
                money = 2108880,
                name = "Магазин видеокарт",
                id = 277
            },
            {
                organization = 0,
                money = 2621807,
                name = "Секонд хенд",
                id = 281
            },
            {
                organization = 0,
                money = 2624974,
                name = "Секонд хенд",
                id = 284
            },
            {
                organization = 0,
                money = 203541,
                name = "АЗС%/Магазин механики",
                id = 286
            },
            {
                organization = 0,
                money = 3132237,
                name = "АЗС%/Магазин механики",
                id = 287
            },
            {
                organization = 0,
                money = 100932,
                name = "Ларек с уличной едой",
                id = 292
            },
            {
                organization = 0,
                money = 373688,
                name = "Ларек с уличной едой",
                id = 293
            },
            {
                organization = 0,
                money = 37392,
                name = "Закусочная",
                id = 295
            },
            {
                organization = 0,
                money = 37734,
                name = "Закусочная",
                id = 296
            },
            {
                organization = 0,
                money = 47030,
                name = "Магазин 24%/7",
                id = 298
            },
            {
                organization = 0,
                money = 100878,
                name = "Авто Сервис",
                id = 303
            },
            {
                organization = 0,
                money = 16452,
                name = "Авто Сервис",
                id = 306
            },
            {
                organization = 0,
                money = 68300,
                name = "Авто Сервис",
                id = 308
            },
            {
                organization = 0,
                money = 134346,
                name = "Авто Сервис",
                id = 309
            },
            {
                organization = 0,
                money = 68908,
                name = "Авто Сервис",
                id = 313
            },
            {
                organization = 0,
                money = 37393,
                name = "Авто Сервис",
                id = 314
            },
            {
                organization = 0,
                money = 628089,
                name = "Рыболовный магазин",
                id = 326
            },
            {
                organization = 0,
                money = 98581,
                name = "Ларек с уличной едой",
                id = 328
            },
            {
                organization = 0,
                money = 16901,
                name = "Ломбард",
                id = 330
            },
            {
                organization = 0,
                money = 284931,
                name = "Отель",
                id = 349
            },
            {
                organization = 0,
                money = 32782,
                name = "Магазин одежды",
                id = 350
            },
            {
                organization = 0,
                money = 172809,
                name = "Магазин 24%/7",
                id = 353
            },
            {
                organization = 0,
                money = 1254000,
                name = "Эликсир Мастер",
                id = 354
            },
            {
                organization = 0,
                money = 175254,
                name = "АЗС%/Магазин механики",
                id = 355
            },
            {
                organization = 0,
                money = 18931,
                name = "Бар",
                id = 356
            },
            {
                organization = 0,
                money = 21603,
                name = "Закусочная",
                id = 357
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 381
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 382
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 383
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 384
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 385
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 386
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 387
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 388
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 389
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 390
            },
            {
                organization = 0,
                money = 374063,
                name = "Амуниция%/Тир",
                id = 0
            },
            {
                organization = 0,
                money = 499402,
                name = "Магазин 24%/7",
                id = 11
            },
            {
                organization = 0,
                money = 425586,
                name = "Магазин одежды",
                id = 12
            },
            {
                organization = 0,
                money = 17373,
                name = "Магазин одежды",
                id = 14
            },
            {
                organization = 0,
                money = 4331395,
                name = "Предприятие",
                id = 126
            },
            {
                organization = 0,
                money = 18844,
                name = "Предприятие",
                id = 129
            },
            {
                organization = 0,
                money = 446775,
                name = "Отель",
                id = 142
            },
            {
                organization = 0,
                money = 9813544,
                name = "Бар",
                id = 165
            },
            {
                organization = 0,
                money = 581951,
                name = "Закусочная",
                id = 167
            },
            {
                organization = 0,
                money = 107610,
                name = "Закусочная",
                id = 168
            },
            {
                organization = 0,
                money = 17767,
                name = "Закусочная",
                id = 171
            },
            {
                organization = 0,
                money = 39247,
                name = "Амуниция%/Тир",
                id = 178
            },
            {
                organization = 0,
                money = 42673,
                name = "Ларек с уличной едой",
                id = 182
            },
            {
                organization = 0,
                money = 68265,
                name = "Ларек с уличной едой",
                id = 183
            },
            {
                organization = 0,
                money = 21309,
                name = "Ларек с уличной едой",
                id = 184
            },
            {
                organization = 0,
                money = 46679,
                name = "Ларек с уличной едой",
                id = 185
            },
            {
                organization = 0,
                money = 170702,
                name = "Ларек с уличной едой",
                id = 186
            },
            {
                organization = 0,
                money = 172162,
                name = "Ларек с уличной едой",
                id = 189
            },
            {
                organization = 0,
                money = 28081,
                name = "Ларек с уличной едой",
                id = 206
            },
            {
                organization = 0,
                money = 135891,
                name = "Ларек с уличной едой",
                id = 207
            },
            {
                organization = 0,
                money = 18551,
                name = "Ларек с уличной едой",
                id = 209
            },
            {
                organization = 0,
                money = 60457,
                name = "Аренда транспорта",
                id = 215
            },
            {
                organization = 0,
                money = 120000,
                name = "Казино (4 Дракона)",
                id = 229
            },
            {
                organization = 0,
                money = 120000,
                name = "Центральный Рынок",
                id = 230
            },
            {
                organization = 0,
                money = 34678,
                name = "Школа танцев",
                id = 235
            },
            {
                organization = 0,
                money = 5006067,
                name = "Мастерская одежды",
                id = 239
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 241
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 242
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 247
            },
            {
                organization = 0,
                money = 16921,
                name = "АЗС%/Магазин механики",
                id = 250
            },
            {
                organization = 0,
                money = 23745,
                name = "АЗС%/Магазин механики",
                id = 251
            },
            {
                organization = 0,
                money = 17120,
                name = "Сельскохозяйственный магазин",
                id = 255
            },
            {
                organization = 0,
                money = 35500,
                name = "Аренда сельхоз техники",
                id = 256
            },
            {
                organization = 0,
                money = 42273,
                name = "АЗС%/Магазин механики",
                id = 263
            },
            {
                organization = 0,
                money = 0,
                name = "Секонд хенд",
                id = 282
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 391
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 392
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 393
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 394
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 395
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 396
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 397
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 398
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 399
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 400
            },
            {
                organization = 0,
                money = 39799,
                name = "Амуниция%/Тир",
                id = 1
            },
            {
                organization = 0,
                money = 18203,
                name = "Амуниция%/Тир",
                id = 2
            },
            {
                organization = 0,
                money = 30416,
                name = "Бар",
                id = 4
            },
            {
                organization = 0,
                money = 163204,
                name = "Бар",
                id = 5
            },
            {
                organization = 0,
                money = 248514,
                name = "Магазин 24%/7",
                id = 6
            },
            {
                organization = 0,
                money = 59564,
                name = "Магазин 24%/7",
                id = 7
            },
            {
                organization = 0,
                money = 70552,
                name = "Магазин 24%/7",
                id = 8
            },
            {
                organization = 0,
                money = 165332,
                name = "Магазин 24%/7",
                id = 9
            },
            {
                organization = 0,
                money = 306917,
                name = "Магазин 24%/7",
                id = 10
            },
            {
                organization = 0,
                money = 17687,
                name = "Магазин одежды",
                id = 13
            },
            {
                organization = 0,
                money = 1208431,
                name = "АЗС%/Магазин механики",
                id = 19
            },
            {
                organization = 0,
                money = 126663,
                name = "АЗС%/Магазин механики",
                id = 22
            },
            {
                organization = 0,
                money = 324054,
                name = "АЗС%/Магазин механики",
                id = 25
            },
            {
                organization = 0,
                money = 22551,
                name = "АЗС%/Магазин механики",
                id = 27
            },
            {
                organization = 0,
                money = 1068088,
                name = "АЗС%/Магазин механики",
                id = 28
            },
            {
                organization = 0,
                money = 553997,
                name = "АЗС%/Магазин механики",
                id = 30
            },
            {
                organization = 0,
                money = 95035,
                name = "Закусочная",
                id = 33
            },
            {
                organization = 0,
                money = 101739,
                name = "Закусочная",
                id = 35
            },
            {
                organization = 0,
                money = 125713,
                name = "Аренда транспорта",
                id = 39
            },
            {
                organization = 0,
                money = 21602,
                name = "Аренда транспорта",
                id = 41
            },
            {
                organization = 0,
                money = 169549,
                name = "Магазин 24%/7",
                id = 46
            },
            {
                organization = 0,
                money = 249253,
                name = "Магазин 24%/7",
                id = 47
            },
            {
                organization = 0,
                money = 86090,
                name = "Магазин 24%/7",
                id = 48
            },
            {
                organization = 0,
                money = 22845,
                name = "Закусочная",
                id = 49
            },
            {
                organization = 0,
                money = 16370,
                name = "Аренда транспорта",
                id = 53
            },
            {
                organization = 0,
                money = 27173,
                name = "Аренда транспорта",
                id = 57
            },
            {
                organization = 0,
                money = 37869,
                name = "Магазин 24%/7",
                id = 72
            },
            {
                organization = 0,
                money = 15352,
                name = "Магазин 24%/7",
                id = 74
            },
            {
                organization = 0,
                money = 21603,
                name = "Закусочная",
                id = 83
            },
            {
                organization = 0,
                money = 126150,
                name = "Магазин аксессуаров",
                id = 95
            },
            {
                organization = 0,
                money = 21361,
                name = "Амуниция%/Тир",
                id = 117
            },
            {
                organization = 0,
                money = 16336,
                name = "Телефонные коммуникации",
                id = 130
            },
            {
                organization = 0,
                money = 24143,
                name = "Предприятие",
                id = 131
            },
            {
                organization = 0,
                money = 185385,
                name = "Отель",
                id = 146
            },
            {
                organization = 0,
                money = 1138652,
                name = "Отель",
                id = 147
            },
            {
                organization = 0,
                money = 88031,
                name = "Отель",
                id = 151
            },
            {
                organization = 0,
                money = 116540,
                name = "Отель",
                id = 152
            },
            {
                organization = 0,
                money = 823798,
                name = "Отель",
                id = 155
            },
            {
                organization = 0,
                money = 0,
                name = "",
                id = 162
            },
            {
                organization = 0,
                money = 73859,
                name = "Бар",
                id = 164
            },
            {
                organization = 0,
                money = 465248,
                name = "Ларек с уличной едой",
                id = 180
            },
            {
                organization = 0,
                money = 19755,
                name = "Ларек с уличной едой",
                id = 187
            },
            {
                organization = 0,
                money = 103654,
                name = "Ларек с уличной едой",
                id = 188
            },
            {
                organization = 0,
                money = 598560,
                name = "Ларек с уличной едой",
                id = 190
            },
            {
                organization = 0,
                money = 249358,
                name = "Ларек с уличной едой",
                id = 191
            },
            {
                organization = 0,
                money = 709920,
                name = "Ларек с уличной едой",
                id = 192
            },
            {
                organization = 0,
                money = 170531,
                name = "Ларек с уличной едой",
                id = 193
            },
            {
                organization = 0,
                money = 218866,
                name = "Магазин тюнинга LS",
                id = 223
            },
            {
                organization = 0,
                money = 4048334,
                name = "Аукцион контейнеров",
                id = 227
            },
            {
                organization = 0,
                money = 174763,
                name = "Магазин 24%/7",
                id = 231
            },
            {
                organization = 0,
                money = 15631,
                name = "Школа танцев",
                id = 236
            },
            {
                organization = 0,
                money = 57942,
                name = "Мастерская одежды",
                id = 238
            },
            {
                organization = 0,
                money = 1258028,
                name = "Мастерская одежды",
                id = 240
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 248
            },
            {
                organization = 0,
                money = 46765,
                name = "АЗС%/Магазин механики",
                id = 249
            },
            {
                organization = 0,
                money = 50346,
                name = "АЗС%/Магазин механики",
                id = 252
            },
            {
                organization = 0,
                money = 26395,
                name = "Магазин 24%/7",
                id = 258
            },
            {
                organization = 0,
                money = 26621,
                name = "Закусочная",
                id = 260
            },
            {
                organization = 0,
                money = 134760,
                name = "АЗС%/Магазин механики",
                id = 261
            },
            {
                organization = 0,
                money = 655139,
                name = "АЗС%/Магазин механики",
                id = 265
            },
            {
                organization = 0,
                money = 20090,
                name = "Ларек с уличной едой",
                id = 266
            },
            {
                organization = 0,
                money = 244998,
                name = "Отель",
                id = 268
            },
            {
                organization = 0,
                money = 562143,
                name = "Отель",
                id = 269
            },
            {
                organization = 0,
                money = 523071,
                name = "Закусочная",
                id = 270
            },
            {
                organization = 0,
                money = 2035800,
                name = "Магазин видеокарт",
                id = 276
            },
            {
                organization = 0,
                money = 2463840,
                name = "Магазин видеокарт",
                id = 278
            },
            {
                organization = 0,
                money = 435957,
                name = "Тест-Драйв",
                id = 279
            },
            {
                organization = 0,
                money = 2612410,
                name = "Секонд хенд",
                id = 283
            },
            {
                organization = 0,
                money = 230242,
                name = "АЗС%/Магазин механики",
                id = 285
            },
            {
                organization = 0,
                money = 185767,
                name = "АЗС%/Магазин механики",
                id = 288
            },
            {
                organization = 0,
                money = 124081,
                name = "Отель",
                id = 289
            },
            {
                organization = 0,
                money = 61021,
                name = "Магазин 24%/7",
                id = 290
            },
            {
                organization = 0,
                money = 10967154,
                name = "Букмекерская компания",
                id = 291
            },
            {
                organization = 0,
                money = 293853,
                name = "Бар",
                id = 297
            },
            {
                organization = 0,
                money = 151252,
                name = "Отель",
                id = 300
            },
            {
                organization = 0,
                money = 37298,
                name = "Авто Сервис",
                id = 304
            },
            {
                organization = 0,
                money = 61538,
                name = "Авто Сервис",
                id = 307
            },
            {
                organization = 0,
                money = 387403,
                name = "Авто Сервис",
                id = 310
            },
            {
                organization = 0,
                money = 35129,
                name = "Авто Сервис",
                id = 311
            },
            {
                organization = 0,
                money = 6374664,
                name = "Тюнинг салон",
                id = 316
            },
            {
                organization = 0,
                money = 323697,
                name = "Склад Дальнобойщиков",
                id = 317
            },
            {
                organization = 0,
                money = 1479000,
                name = "Склад Дальнобойщиков",
                id = 318
            },
            {
                organization = 0,
                money = 59214,
                name = "Амуниция%/Тир",
                id = 320
            },
            {
                organization = 0,
                money = 1004363,
                name = "Отель",
                id = 321
            },
            {
                organization = 0,
                money = 547223,
                name = "Отель",
                id = 322
            },
            {
                organization = 0,
                money = 136527,
                name = "Рыболовный магазин",
                id = 324
            },
            {
                organization = 0,
                money = 18401,
                name = "Ломбард",
                id = 329
            },
            {
                organization = 0,
                money = 26544,
                name = "Магазин 24%/7",
                id = 348
            },
            {
                organization = 0,
                money = 40605,
                name = "Бар",
                id = 351
            },
            {
                organization = 0,
                money = 2446995,
                name = "Магазин аксессуаров",
                id = 352
            },
            {
                organization = 0,
                money = 844839,
                name = "АЗС%/Магазин механики",
                id = 359
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 401
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 402
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 403
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 404
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 405
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 406
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 407
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 408
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 409
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 410
            },
            {
                organization = 0,
                money = 2716488,
                name = "Лотерейная",
                id = 301
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 331
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 332
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 333
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 334
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 335
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 336
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 337
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 338
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 339
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 340
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 341
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 342
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 343
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 344
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 345
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 346
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 347
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 360
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 361
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 362
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 363
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 364
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 365
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 366
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 367
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 368
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 369
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 370
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 371
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 372
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 373
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 374
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 375
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 376
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 377
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 378
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 379
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 380
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 421
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 422
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 423
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 424
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 425
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 426
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 427
            },
            {
                organization = 0,
                money = 20952,
                name = "Бар LUX",
                id = 428
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 429
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 430
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 431
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 432
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 433
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 434
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 435
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 436
            },
            {
                organization = 0,
                money = 0,
                name = "Киоск",
                id = 437
            },
            {
                organization = 0,
                money = 141039,
                name = "Центр Обмена Имуществом",
                id = 438
            },
            {
                organization = 0,
                money = 0,
                name = "Электрокомпания",
                id = 439
            },
            {
                organization = 0,
                money = 0,
                name = "Электрокомпания",
                id = 440
            },
            {
                organization = 0,
                money = 15688,
                name = "Электрокомпания",
                id = 441
            },
            {
                organization = 0,
                money = 0,
                name = "Электрокомпания",
                id = 442
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 443
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 444
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 445
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 446
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 447
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 448
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 449
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 450
            },
            {
                organization = 0,
                money = 17688,
                name = "Бар",
                id = 3
            },
            {
                organization = 0,
                money = 99840,
                name = "Предприятие",
                id = 15
            },
            {
                organization = 0,
                money = 146563,
                name = "Магазин 24%/7",
                id = 16
            },
            {
                organization = 0,
                money = 34221,
                name = "Магазин 24%/7",
                id = 17
            },
            {
                organization = 0,
                money = 0,
                name = "Тюнинг салон",
                id = 18
            },
            {
                organization = 0,
                money = 1222092,
                name = "АЗС%/Магазин механики",
                id = 20
            },
            {
                organization = 0,
                money = 2753266,
                name = "АЗС%/Магазин механики",
                id = 21
            },
            {
                organization = 0,
                money = 1647805,
                name = "АЗС%/Магазин механики",
                id = 23
            },
            {
                organization = 0,
                money = 247245,
                name = "АЗС%/Магазин механики",
                id = 24
            },
            {
                organization = 0,
                money = 1751447,
                name = "АЗС%/Магазин механики",
                id = 26
            },
            {
                organization = 0,
                money = 1434018,
                name = "АЗС%/Магазин механики",
                id = 29
            },
            {
                organization = 0,
                money = 281085,
                name = "АЗС%/Магазин механики",
                id = 31
            },
            {
                organization = 0,
                money = 182738,
                name = "АЗС%/Магазин механики",
                id = 32
            },
            {
                organization = 0,
                money = 21844,
                name = "Закусочная",
                id = 34
            },
            {
                organization = 0,
                money = 502075,
                name = "Закусочная",
                id = 36
            },
            {
                organization = 0,
                money = 55963,
                name = "Закусочная",
                id = 37
            },
            {
                organization = 0,
                money = 38673,
                name = "Закусочная",
                id = 38
            },
            {
                organization = 0,
                money = 18596,
                name = "Аренда транспорта",
                id = 40
            },
            {
                organization = 0,
                money = 0,
                name = "Аренда транспорта",
                id = 42
            },
            {
                organization = 0,
                money = 64290,
                name = "Магазин 24%/7",
                id = 43
            },
            {
                organization = 0,
                money = 117161,
                name = "Магазин 24%/7",
                id = 44
            },
            {
                organization = 0,
                money = 196243,
                name = "Магазин 24%/7",
                id = 45
            },
            {
                organization = 0,
                money = 96694,
                name = "Закусочная",
                id = 50
            },
            {
                organization = 0,
                money = 39407,
                name = "Бар",
                id = 51
            },
            {
                organization = 0,
                money = 22892,
                name = "Аренда транспорта",
                id = 52
            },
            {
                organization = 0,
                money = 20030,
                name = "Аренда транспорта",
                id = 54
            },
            {
                organization = 0,
                money = 19092,
                name = "Аренда транспорта",
                id = 55
            },
            {
                organization = 0,
                money = 113603,
                name = "Аренда транспорта",
                id = 56
            },
            {
                organization = 0,
                money = 1227782,
                name = "Аренда транспорта",
                id = 58
            },
            {
                organization = 0,
                money = 149069,
                name = "АЗС%/Магазин механики",
                id = 59
            },
            {
                organization = 0,
                money = 216934,
                name = "АЗС%/Магазин механики",
                id = 60
            },
            {
                organization = 0,
                money = 250925,
                name = "АЗС%/Магазин механики",
                id = 61
            },
            {
                organization = 0,
                money = 669645,
                name = "АЗС%/Магазин механики",
                id = 62
            },
            {
                organization = 0,
                money = 307634,
                name = "АЗС%/Магазин механики",
                id = 63
            },
            {
                organization = 0,
                money = 12380,
                name = "АЗС%/Магазин механики",
                id = 64
            },
            {
                organization = 0,
                money = 0,
                name = "Амуниция%/Тир",
                id = 65
            },
            {
                organization = 0,
                money = 0,
                name = "Амуниция%/Тир",
                id = 66
            },
            {
                organization = 0,
                money = 10955,
                name = "Амуниция%/Тир",
                id = 67
            },
            {
                organization = 0,
                money = 19155,
                name = "Амуниция%/Тир",
                id = 68
            },
            {
                organization = 0,
                money = 68155,
                name = "Магазин 24%/7",
                id = 69
            },
            {
                organization = 0,
                money = 59891,
                name = "Магазин 24%/7",
                id = 70
            },
            {
                organization = 0,
                money = 179508,
                name = "Магазин 24%/7",
                id = 71
            },
            {
                organization = 0,
                money = 320608,
                name = "Магазин 24%/7",
                id = 73
            },
            {
                organization = 0,
                money = 47059,
                name = "Магазин 24%/7",
                id = 75
            },
            {
                organization = 0,
                money = 36018,
                name = "Магазин 24%/7",
                id = 76
            },
            {
                organization = 0,
                money = 153457,
                name = "Магазин 24%/7",
                id = 77
            },
            {
                organization = 0,
                money = 105784,
                name = "Закусочная",
                id = 78
            },
            {
                organization = 0,
                money = 36491,
                name = "Закусочная",
                id = 79
            },
            {
                organization = 0,
                money = 34259,
                name = "Закусочная",
                id = 80
            },
            {
                organization = 0,
                money = 154296,
                name = "Закусочная",
                id = 81
            },
            {
                organization = 0,
                money = 46800,
                name = "Закусочная",
                id = 82
            },
            {
                organization = 0,
                money = 22073,
                name = "Закусочная",
                id = 84
            },
            {
                organization = 0,
                money = 30818,
                name = "Закусочная",
                id = 85
            },
            {
                organization = 0,
                money = 15667,
                name = "Бар",
                id = 86
            },
            {
                organization = 0,
                money = 4723447,
                name = "Бар",
                id = 87
            },
            {
                organization = 0,
                money = 16473,
                name = "Бар",
                id = 88
            },
            {
                organization = 0,
                money = 20012,
                name = "Магазин одежды",
                id = 89
            },
            {
                organization = 0,
                money = 17170,
                name = "Магазин одежды",
                id = 90
            },
            {
                organization = 0,
                money = 23349,
                name = "Бар",
                id = 91
            },
            {
                organization = 0,
                money = 18059,
                name = "Бар",
                id = 92
            },
            {
                organization = 0,
                money = 17418,
                name = "Бар",
                id = 93
            },
            {
                organization = 0,
                money = 16806,
                name = "Бар",
                id = 94
            },
            {
                organization = 0,
                money = 247950,
                name = "Магазин аксессуаров",
                id = 96
            },
            {
                organization = 0,
                money = 65900,
                name = "Магазин аксессуаров",
                id = 97
            },
            {
                organization = 0,
                money = 973504,
                name = "Магазин аксессуаров",
                id = 98
            },
            {
                organization = 0,
                money = 213094,
                name = "Магазин аксессуаров",
                id = 99
            },
            {
                organization = 0,
                money = 52200,
                name = "Магазин аксессуаров",
                id = 100
            },
            {
                organization = 0,
                money = 135392,
                name = "Магазин 24%/7",
                id = 101
            },
            {
                organization = 0,
                money = 123267,
                name = "Магазин 24%/7",
                id = 102
            },
            {
                organization = 0,
                money = 39099,
                name = "Магазин 24%/7",
                id = 103
            },
            {
                organization = 0,
                money = 132606,
                name = "Магазин 24%/7",
                id = 104
            },
            {
                organization = 0,
                money = 31641,
                name = "Магазин 24%/7",
                id = 105
            },
            {
                organization = 0,
                money = 75866,
                name = "Закусочная",
                id = 106
            },
            {
                organization = 0,
                money = 171753,
                name = "Закусочная",
                id = 107
            },
            {
                organization = 0,
                money = 73983,
                name = "Закусочная",
                id = 108
            },
            {
                organization = 0,
                money = 139813,
                name = "Закусочная",
                id = 109
            },
            {
                organization = 0,
                money = 34257,
                name = "Закусочная",
                id = 110
            },
            {
                organization = 0,
                money = 109965,
                name = "Закусочная",
                id = 111
            },
            {
                organization = 0,
                money = 276311,
                name = "Закусочная",
                id = 112
            },
            {
                organization = 0,
                money = 70386,
                name = "Закусочная",
                id = 113
            },
            {
                organization = 0,
                money = 30854,
                name = "Закусочная",
                id = 114
            },
            {
                organization = 0,
                money = 24604,
                name = "Амуниция%/Тир",
                id = 115
            },
            {
                organization = 0,
                money = 207554,
                name = "Амуниция%/Тир",
                id = 116
            },
            {
                organization = 0,
                money = 16366,
                name = "Амуниция%/Тир",
                id = 118
            },
            {
                organization = 0,
                money = 20257,
                name = "Магазин одежды",
                id = 119
            },
            {
                organization = 0,
                money = 47559,
                name = "Магазин одежды",
                id = 120
            },
            {
                organization = 0,
                money = 52435,
                name = "Магазин одежды",
                id = 121
            },
            {
                organization = 0,
                money = 174780,
                name = "Аренда транспорта",
                id = 122
            },
            {
                organization = 0,
                money = 42133,
                name = "Аренда транспорта",
                id = 123
            },
            {
                organization = 0,
                money = 84306,
                name = "Аренда транспорта",
                id = 124
            },
            {
                organization = 0,
                money = 25246,
                name = "Аренда транспорта",
                id = 125
            },
            {
                organization = 0,
                money = 35691,
                name = "Амуниция%/Тир",
                id = 127
            },
            {
                organization = 0,
                money = 21973,
                name = "Телефонные коммуникации",
                id = 128
            },
            {
                organization = 0,
                money = 17689,
                name = "Телефонные коммуникации",
                id = 132
            },
            {
                organization = 0,
                money = 18000,
                name = "Предприятие",
                id = 133
            },
            {
                organization = 0,
                money = 1180634,
                name = "Магазин 24%/7",
                id = 134
            },
            {
                organization = 0,
                money = 246326,
                name = "Закусочная",
                id = 135
            },
            {
                organization = 0,
                money = 109185,
                name = "Амуниция%/Тир",
                id = 136
            },
            {
                organization = 0,
                money = 639656,
                name = "АЗС%/Магазин механики",
                id = 137
            },
            {
                organization = 0,
                money = 544311,
                name = "Отель",
                id = 138
            },
            {
                organization = 0,
                money = 129658,
                name = "Отель",
                id = 139
            },
            {
                organization = 0,
                money = 429079,
                name = "Отель",
                id = 140
            },
            {
                organization = 0,
                money = 49496,
                name = "Отель",
                id = 141
            },
            {
                organization = 0,
                money = 240122,
                name = "Отель",
                id = 143
            },
            {
                organization = 0,
                money = 431495,
                name = "Отель",
                id = 144
            },
            {
                organization = 0,
                money = 311297,
                name = "Отель",
                id = 145
            },
            {
                organization = 0,
                money = 1453390,
                name = "Отель",
                id = 148
            },
            {
                organization = 0,
                money = 137135,
                name = "Отель",
                id = 149
            },
            {
                organization = 0,
                money = 154050,
                name = "Отель",
                id = 150
            },
            {
                organization = 0,
                money = 523353,
                name = "Отель",
                id = 153
            },
            {
                organization = 0,
                money = 46529,
                name = "Отель",
                id = 154
            },
            {
                organization = 0,
                money = 437757,
                name = "Отель",
                id = 156
            },
            {
                organization = 0,
                money = 748184,
                name = "Отель",
                id = 157
            },
            {
                organization = 0,
                money = 362947,
                name = "Отель",
                id = 158
            },
            {
                organization = 0,
                money = 800400,
                name = "Авто-сервис LS",
                id = 159
            },
            {
                organization = 0,
                money = 2201970,
                name = "Авто-сервис SF",
                id = 160
            },
            {
                organization = 0,
                money = 1141440,
                name = "Авто-сервис LV",
                id = 161
            },
            {
                organization = 0,
                money = 16195,
                name = "Бар",
                id = 163
            },
            {
                organization = 0,
                money = 66736,
                name = "Закусочная",
                id = 166
            },
            {
                organization = 0,
                money = 18873,
                name = "Закусочная",
                id = 169
            },
            {
                organization = 0,
                money = 33080,
                name = "Закусочная",
                id = 170
            },
            {
                organization = 0,
                money = 22828,
                name = "Закусочная",
                id = 172
            },
            {
                organization = 0,
                money = 20564,
                name = "Магазин одежды",
                id = 173
            },
            {
                organization = 0,
                money = 409942,
                name = "Магазин 24%/7",
                id = 174
            },
            {
                organization = 0,
                money = 959395,
                name = "Магазин 24%/7",
                id = 176
            },
            {
                organization = 0,
                money = 40386,
                name = "Амуниция%/Тир",
                id = 177
            },
            {
                organization = 0,
                money = 18889,
                name = "Ларек с уличной едой",
                id = 179
            },
            {
                organization = 0,
                money = 53853,
                name = "Ларек с уличной едой",
                id = 181
            },
            {
                organization = 0,
                money = 185527,
                name = "Ларек с уличной едой",
                id = 194
            },
            {
                organization = 0,
                money = 68599,
                name = "Ларек с уличной едой",
                id = 195
            },
            {
                organization = 0,
                money = 786480,
                name = "Ларек с уличной едой",
                id = 196
            },
            {
                organization = 0,
                money = 498998,
                name = "Ларек с уличной едой",
                id = 200
            },
            {
                organization = 0,
                money = 199941,
                name = "Ларек с уличной едой",
                id = 202
            },
            {
                organization = 0,
                money = 100430,
                name = "Ларек с уличной едой",
                id = 204
            },
            {
                organization = 0,
                money = 69362,
                name = "Ларек с уличной едой",
                id = 205
            },
            {
                organization = 0,
                money = 115383,
                name = "Ларек с уличной едой",
                id = 208
            },
            {
                organization = 0,
                money = 360675,
                name = "Ферма",
                id = 210
            },
            {
                organization = 0,
                money = 234375,
                name = "Шахта",
                id = 211
            },
            {
                organization = 0,
                money = 334080,
                name = "Риелторское агентство",
                id = 212
            },
            {
                organization = 0,
                money = 17337,
                name = "Концертный зал",
                id = 214
            },
            {
                organization = 0,
                money = 18192,
                name = "Ларек с уличной едой",
                id = 216
            },
            {
                organization = 0,
                money = 906012,
                name = "Ларек с уличной едой",
                id = 217
            },
            {
                organization = 0,
                money = 399919,
                name = "Ларек с уличной едой",
                id = 219
            },
            {
                organization = 0,
                money = 0,
                name = "Автосалон эконом",
                id = 220
            },
            {
                organization = 0,
                money = 0,
                name = "Автосалон средний",
                id = 221
            },
            {
                organization = 0,
                money = 0,
                name = "Автосалон люкс",
                id = 222
            },
            {
                organization = 0,
                money = 427026,
                name = "Магазин тюнинга SF",
                id = 224
            },
            {
                organization = 0,
                money = 17291,
                name = "Магазин тюнинга LV",
                id = 225
            },
            {
                organization = 0,
                money = 2360795,
                name = "Магазин аксессуаров",
                id = 232
            },
            {
                organization = 0,
                money = 261835,
                name = "Магазин одежды",
                id = 233
            },
            {
                organization = 0,
                money = 4349826,
                name = "Мастерская одежды",
                id = 237
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 244
            },
            {
                organization = 0,
                money = 0,
                name = "Нефтевышка",
                id = 245
            },
            {
                organization = 0,
                money = 568539,
                name = "Закусочная",
                id = 272
            },
            {
                organization = 0,
                money = 15637,
                name = "Кинотеатр AZMAX",
                id = 280
            },
            {
                organization = 0,
                money = 29084,
                name = "Закусочная",
                id = 294
            },
            {
                organization = 0,
                money = 19423,
                name = "Бар",
                id = 299
            },
            {
                organization = 0,
                money = 42973,
                name = "Авто Сервис",
                id = 302
            },
            {
                organization = 0,
                money = 16038,
                name = "Авто Сервис",
                id = 305
            },
            {
                organization = 0,
                money = 18338,
                name = "Авто Сервис",
                id = 312
            },
            {
                organization = 0,
                money = 19515,
                name = "Авто Сервис",
                id = 315
            },
            {
                organization = 0,
                money = 563866,
                name = "Склад Дальнобойщиков",
                id = 319
            },
            {
                organization = 0,
                money = 22525,
                name = "Стриптиз Клуб",
                id = 323
            },
            {
                organization = 0,
                money = 19614,
                name = "Рыболовный магазин",
                id = 325
            },
            {
                organization = 0,
                money = 3047329,
                name = "Рыболовный магазин",
                id = 327
            },
            {
                organization = 0,
                money = 11745,
                name = "Закусочная",
                id = 358
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 411
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 412
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 413
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 414
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 415
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 416
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 417
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 418
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 419
            },
            {
                organization = 0,
                money = 0,
                name = "Парковочное место",
                id = 420
            }
        },
        family = {
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2459,
                y2 = 2595,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2323,
                y2 = 2459,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = true,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2187,
                y2 = 2323,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 2051,
                y2 = 2187,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1916,
                y2 = 2051,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = true,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1780,
                y2 = 1916,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1644,
                y2 = 1780,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1508,
                y2 = 1644,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = true,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = true,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1372,
                y2 = 1508,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1236,
                y2 = 1372,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = true,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 1100,
                y2 = 1236,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = true,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 964,
                y2 = 1100,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1222,
                x2 = 1344,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1344,
                x2 = 1467,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1467,
                x2 = 1589,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1589,
                x2 = 1712,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1712,
                x2 = 1834,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1834,
                x2 = 1957,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 1957,
                x2 = 2079,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2079,
                x2 = 2202,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2202,
                x2 = 2324,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2324,
                x2 = 2447,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2447,
                x2 = 2569,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            },
            {
                y1 = 828,
                y2 = 964,
                coins = 0,
                money = 0,
                next_capture = {
                    status = false,
                    enemy = nil,
                    unix = 0
                },
                x1 = 2569,
                x2 = 2692,
                is_enterprise = false,
                captured_at = 0,
                color = 0
            }
        }
    }
};

local getip = {
    delay = nil,
    match = "^Nick %[(.+)%]%s+R%-IP%s+%[([%d%.]+)%]%s+IP%s+|%s+A%-IP%s+%[{......}([%d%.]+)%s+|%s+",
    forma = "Геолокационные данные игрока %s(%s):\nIP: [REG: %s / LAST: %s]\nСтрана: [REG: %s] / [LAST: %s]\nГород: [REG: %s] / [LAST: %s]\nПровайдер: [REG: %s] / [LAST: %s]\nРасстояние: %s км.",
    player = "Неизвестно",
    data = {
        {
            as = "Неизвестно",
            country = "Неизвестно",
            lon = 0,
            city = "Неизвестно",
            lat = 0
        },
        {
            as = "Неизвестно",
            country = "Неизвестно",
            lon = 0,
            city = "Неизвестно",
            lat = 0
        }
    },
    dist = 0
};

getip.get_ip = function()
    if (getip.delay and os.clock() - getip.delay < 2.5 ) then
        check.getip_analysis = nil;
        return;
    end

    local url = "http://ipwho.is/%s?output=json&lang=ru";

    getip.dist = 0;
    getip.data[1].ok = nil;
    getip.data[2].ok = nil;
    getip.delay = os.clock();

    for i = 1, 2 do
        asyncHttpRequest("GET", url:format(getip.data[i].ip), nil, function(response)
            if (response.status_code ~= 200) then
                check.getip_analysis = nil;
                getip.data[i].ok = false;
                return nil;
            end

            response.text = string.gsub(response.text, "\\u(%x%x%x%x)", function(resp)
                return unicode_to_utf8(tonumber("0x" .. resp));
            end)

            response.text = u8:decode(response.text);
            local answer = json.decode(response.text);

            if (type(answer) == "table") then
                local as;

                if (type(answer.connection) == "table") then
                    as = answer.connection.org;
                elseif type(answer.as) == "string" then
                    as = answer.as;
                end

                getip.data[i] = {
                    ok = true,
                    ip = getip.data[i].ip,
                    country = answer.country or "Неизвестно",
                    city = answer.city or "Неизвестно",
                    as = as or "Неизвестно",
                    lat = answer.lat or answer.latitude or 0,
                    lon = answer.lon or answer.longitude or 0,
                    proxy = answer.proxy == true,
                    mobile = answer.mobile == true
                };

                if (i == 2) then
                    repeat
                        wait(0)
                    until getip.data[1].ok;

                    getip.dist = getDistanceBetweenLatLon(getip.data[1].lat, getip.data[1].lon, getip.data[2].lat, getip.data[2].lon);

                    if (check.getip_analysis ~= nil) then
                        check.getip_analysis = nil;

                        sendMessage("/a Результаты проверки игрока %s:", getip.nick);

                        local data = {};

                        if (getip.data[1].country ~= getip.data[2].country) then
                            table.insert(data, "страна");
                        end

                        if (getip.data[1].city ~= getip.data[2].city) then
                            table.insert(data, "город");
                        end

                        if (getip.data[1].as ~= getip.data[2].as) then
                            table.insert(data, "провайдер");
                        end

                        if (#data > 0) then
                            sendMessage("/a Отличается от рег. данных: %s", table.concat(data, ", "));
                            sendMessage("/a Приблизительное расстояние: %d км.", getip.dist);

                            if (getip.data[1].proxy) then
                                sendMessage("/a [!] Игрок, возможно, регистрировался через VPN/Proxy.");
                            elseif (getip.data[1].mobile) then
                                sendMessage("/a [!] Игрок регистрировался с мобильного интернета.");
                            end

                            if (getip.data[2].proxy) then
                                sendMessage("/a [!] Игрок, возможно, сейчас использует VPN/Proxy.");
                            elseif getip.data[2].mobile then
                                sendMessage("/a [!] Игрок сейчас использует мобильный интернет.");
                            end
                        else
                            sendMessage("/a Различия между REG IP и LAST IP не найдены.");
                        end
                    end
                end
            else
                check.getip_analysis = nil;
                getip.data[i].ok = false;
            end
        end, function(err)
            check.getip_analysis = nil;
            getip.data[i].ok = false;
        end)
    end
end

local license = {
    sellLicenses = false,
    types = {
        [0] = {
            phrase = "авто",
            rank = 1
        },
        [1] = {
            phrase = "мото",
            rank = 2
        },
        [2] = {
            phrase = "полёты",
            rank = 7
        },
        [3] = {
            phrase = "рыбалка",
            rank = 3
        },
        [4] = {
            phrase = "лодки",
            rank = 4
        },
        [5] = {
            phrase = "оружие",
            rank = 5
        },
        [6] = {
            phrase = "охота",
            rank = 5
        },
        [7] = {
            phrase = "раскопки",
            rank = 6
        },
        [8] = {
            phrase = "такси",
            rank = 6
        },
        [9] = {
            phrase = "механик",
            rank = 6
        }
    }
};

local admin_ranks = {
    ["Основатель"] = 8,
    ["Главный Администратор"] = 7,
    ["Заместитель ГА"] = 6,
    ["Куратор"] = 5,
    ["Администратор"] = 4,
    ["Старший Модератор"] = 3,
    ["Модератор"] = 2,
    ["Младший Модератор"] = 1
};

local ao_messages = {};

sendMessage = {
    queue = {},
    timer = 0
};

setmetatable(sendMessage, {
    __call = function(self, text, ...)
        local ttext = tostring(text)

        table.insert(self.queue, string.format(ttext, ...))
    end
})

local settings = {
    active = false,
    debug = false,
    server_ip = "",
    server_port = 0,
    bot_nickname = "",
    bot_password_server = "",
    bot_password_admin = "",
    bot_password_bank = "",
    bot_is_spawned = false,
    last_bot_connect = 0,
    last_bot_disconnect = 0,
    license_system = nil,
    spawn_quaternion = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0
    },
    license_second_position = "",
    license_quaternion_second = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0
    },
    license_first_position = "",
    license_quaternion_first = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0
    },
    spawn_position = "",
    amember_system = false,
    amember_fraction = 0,
    amember_rank = 0,
    skin_system = false,
    skin_id = 0,
    bot_admin_lvl = 0,
    property_purchase_system = false,
    send_information_to_admins_time = 0,
    last_send_information_to_admins = 0,
    plveh_auto_set_id = false,
    auto_respawn_cars = false,
    auto_respawn_cars_time = 0,
    last_respawn_cars = 0,
    send_mpdonate_system = false,
    send_mpdonate_time = 0,
    last_send_mpdonate = 0,
    send_ao_system = false,
    send_conference_system = false,
    bot_bandit_checker_system = false
};

local messagesRemover = {};

local guard = {};

local server_stats = {
    b = false,
    players = 0,
    build = nil,
    packetloss = 0,
    admins = {
        special = {
            total = 0
        },
        chief = {
            total = 0,
            afk = 0,
        },
        admins = {
            total = 0,
            afk = 0,
        },
        helpers = {
            total = 0,
            afk = 0,
        },
        report = 0,
        idle = {},
        list = {}
    },
    leaders = {
        total = 0,
        afk = 0,
        list = {}
    },
    zams = {
        total = 0,
        afk = 0,
        list = {}
    },
    special = {},
    ticks = {
        current = 0,
        average = 0,
        maximum = 0,
        minimum = 0
    }
};

local businesses_mafia = {
    b = false,
    last = 0,
    delay = 0,
    fractions = {16, 17, 18, 19, 30},
    pool = {}
};

local bot_bandit = {
    b = false,
    delay = 0,
    last = 0,
    players = {},
    pool = {}
};

local morg = {
    b = false,
    delay = 0,
    last = os.time(),
    judges = {},
    pool = {}
};

local pledge = {
    b = false,
    delay = 0,
    last = os.time(),
    action = 0,
    pool = {}
};

function loadMorg()
    local query = ("SELECT `fraction_id`, `active`, `uval_system`, `uval_time` FROM `arizona`.fractions_system WHERE `server_id` = %d;"):format(server_id);
    local data = mysqlQuery(query);
    morg.pool = {};

    for i = 1, 32 do
        morg.pool[i] = {
            active = false,
            process = false,
            error_stats = 0,
            error_first = false,
            error_second = false,
            money = 0,
            dormitory = false,
            check = 1,
            leader = {},
            zams = 0,
            online = 0,
            afk = 0,
            uval = {
                enabled = false,
                time = 14 * 24,
                pool = {}
            },
            sobes = {
                time = nil,
                place = nil
            },
            owner = {
                family = nil,
                leader = nil,
                zams = {}
            },
            ranks = {
                [1] = {
                    salary = 0,
                    pool = {},
                },
                [2] = {
                    salary = 0,
                    pool = {},
                },
                [3] = {
                    salary = 0,
                    pool = {},
                },
                [4] = {
                    salary = 0,
                    pool = {},
                },
                [5] = {
                    salary = 0,
                    pool = {},
                },
                [6] = {
                    salary = 0,
                    pool = {},
                },
                [7] = {
                    salary = 0,
                    pool = {},
                },
                [8] = {
                    salary = 0,
                    pool = {},
                },
                [9] = {
                    salary = 0,
                    pool = {},
                },
                [10] = {
                    salary = 0,
                    pool = {},
                }
            }
        }

        if (data) then
            if (data[i].active == 1) then
                morg.pool[i].active = true;

                if (data[i].uval_system == 1) then
                    morg.pool[i].uval.enabled = true;
                    morg.pool[i].uval.time = data[i].uval_time;
                end
            end
        end
    end

    for i = 1, 5 do
        morg.judges[i] = {
            nickname = nil,
            date = 0
        }
    end
end

local props = {
    b = false,
    delay = 0,
    days = 0,
    last = os.time(),
    pool = {}
};

local igForms = {
    igForms = {},
    b = false,
    last = "",
    accepted_first = nil,
    widget = {
        start_time = os.clock(),
        player = {
            id = -1
        },
        admin = {
            nick = "",
            id = -1
        }
    },
    show_error = false,
    errors = {
        {
            error = "%[Ошибка%] %{ffffff%}Данный игрок не участвует в мероприятии%!",
            answer = "Данный игрок не участвует в мероприятии!"
        },
        {
            error = "%[Информация%] %{ffffff%}Вы можете выдать еще 0 RP Points %(зависит от уровня администрирования%)",
            answer = "Бот больше не может выдать RP Points!"
        },
        {
            error = "%[Подсказка%] %{ffffff%}%/setmember %[id игрока%] %[id организации %(1%-32%)%] %[ранг %(1%-9%)%] %[причина%]",
            answer = "Вы неверно заполнили форму!"
        },
        {
            error = "%[Подсказка%] %{ffffff%}%/grppoint %[id игрока%] %[причина%]",
            answer = "Вы неверно заполнили форму!"
        },
        {
            error = "%[Ошибка%] %{ffffff%}Используйте%: %/setfuel %[carid%] %[кол-во топлива%]",
            answer = "Вы ввели неверный ID транспорта, либо неверное количество топлива!"
        },
        {
            error = "%[Ошибка%] %{FFFFFF%}Игрок не найден%!",
            answer = "Игрок не в сети!"
        },
        {
            error = "%[Ошибка%] %{FFFFFF%}Игрок не в сети%!",
            answer = "Игрок не в сети!"
        }
    },
    runners = {},
    list = {}
};

igForms.runners = {
    pgetip = function(form, regex)
        check.pgetip = {};

        sendMessage(form);
    end,
    pgetips = function(form, regex)
        check.pgetip = {};

        sendMessage(form);
    end,
    getip = function(form, regex)
        check.getip_analysis = true;

        sendMessage(form);
    end,
    spcarall = function(form, regex)
        if (not (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt")) then
            settings.last_respawn_cars = os.time();
            check.spawncars = "form_ig";

            license.sellLicenses = false;

            set_bot_position();

            newTask(function ()
                settings.last_respawn_cars = os.time();

                local query = ("UPDATE `arizona`.servers_raksamp SET `last_respawn_cars` = %d WHERE `server_id` = %d;"):format(settings.last_respawn_cars, server_id);
                AsyncMysqlQuery(query);

                sendMessage("/ao [Спавн транспорта] Уважаемые игроки, через 60 секунд будет спавн всего транспорта!");
                sendMessage("/ao [Спавн транспорта] Займите свой транспорт, в противном случае он пропадет!");

                wait(60 * 1000);

                sendMessage("/vehicleapanel");
            end)
        end
    end,
    setmember = function(form, regex)
        local playerId, orgId, orgRank, reason = form:match(regex);

        if (tonumber(playerId) == tonumber(igForms.widget.admin.id)) then
            sendMessage("/a [Forma] +");
            sendMessage(form);
        end
    end,
    uval = function(form, regex)
        local playerId = form:match(regex);

        if (tonumber(playerId) == tonumber(igForms.widget.admin.id)) then
            sendMessage("/a [Forma] +");
            sendMessage(form);
        end
    end,
    plveh = function(form, regex)
        local playerId, carId = form:match(regex);

        if (settings.plveh_auto_set_id) then
            if (carId) then
                sendMessage("/plveh " .. playerId .. " " .. 462 .. " 0");
            else
                form = form .. " " .. 462;
                sendMessage(form .. " 0");
            end
        else
            if (carId) then
                sendMessage("/plveh " .. playerId .. " " .. carId .. " 0");
            else
                form = form .. " " .. 462;
                sendMessage(form .. " 0");
            end
        end
    end
};

setmetatable(igForms.list, {
    __call = function(self, data)
        if (type(data) == "table") then
            data.send_type = data.lvl <= settings.bot_admin_lvl and 3 or 1;
            data.pre_spec = false;
            data.runner = igForms.runners[data.name] or sendMessage;
            data.params = string.gsub(data.params, "%s+", "%%s+");

            local err = false;

            for i, form in ipairs(igForms.list) do
                if form.name == data.name then
                    igForms.list[i] = data;
                    err = true;
                    break;
                end
            end

            if (not err) then
                table.insert(self, data);
                table.sort(self, function(a, b)
                    return a.name < b.name;
                end)
            end
        end
    end
})
connect_list = {}
function sendKey(id)
    key = id
    updateSync()
end

function onRunCommand(cmd)
    if cmd:find('^!key %d+$') then
        sendKey(tonumber(cmd:match('%d+')))
        return false
    end
end

function sampev.onSendPlayerSync(data)
    if key then
        data.keysData = key
        key = nil
    end
end

function sampev.onPlayerJoin(id,color,isnps,nickname)
    connect_list[tostring(nickname)] = os.time()
	if(check.offForms.form == "antibot") and nickname == check.offForms.nick then
		sampSendChat("/getip " .. nickname)
	end
end


function sendCustomPacket(array)
    local bs = bitStream.new()
    for _, v in pairs(array) do bs:writeInt8(v) end
    bs:sendPacketEx(1, 9, 0)
end

function sampev.onSendClientJoin(version, mod, nickname, challengeResponse, joinAuthKey, clientVer, challengeResponse2)
    newTask(function()
        wait(0); sendCustomPacket({220, 38, 99, 57, 102, 102, 48, 52, 55, 102, 101, 49, 49, 56, 52, 51, 48, 57, 97, 56, 101, 97, 56, 48, 98, 102, 48, 100, 97, 99, 52, 55, 50, 101, 50, 49, 98, 102, 99, 98, 52, 52, 52, 97, 98, 53, 55, 98, 53, 49, 100, 53, 97, 99, 100, 52, 53, 102, 56, 56, 97, 100, 56, 101, 53, 54})
        wait(0); sendCustomPacket({220, 140, 156, 0, 0, 0, 34, 103, 116, 97, 95, 115, 97, 46, 101, 120, 101, 34, 32, 32, 45, 99, 32, 45, 104, 32, 49, 56, 53, 46, 49, 54, 57, 46, 49, 51, 52, 46, 49, 48, 55, 32, 45, 112, 32, 55, 55, 55, 55, 32, 45, 110, 32, 89, 117, 107, 105, 95, 82, 105, 99, 101, 32, 45, 109, 101, 109, 32, 50, 48, 52, 56, 32, 45, 119, 105, 110, 100, 111, 119, 32, 45, 120, 32, 45, 108, 100, 111, 32, 45, 115, 101, 97, 115, 111, 110, 115, 32, 45, 101, 110, 97, 98, 108, 101, 95, 103, 114, 97, 115, 115, 32, 45, 97, 108, 108, 111, 119, 95, 104, 100, 114, 32, 45, 97, 114, 105, 122, 111, 110, 97, 32, 45, 114, 101, 102, 101, 114, 114, 101, 114, 32, 117, 116, 109, 95, 115, 111, 117, 114, 99, 101, 61, 97, 114, 105, 122, 111, 110, 97, 114, 112})
    end)

    return{4057, 1, nickname, challengeResponse, '301F63E436DA623027B21DE0DA077881ED694F75081', 'Arizona PC', challengeResponse2}
end

function initIgForms(data)
    if (not igForms.b) then return end;
    asyncHttpRequest("GET", BASE_URL.."/files/raksamp/ig_forms.json", nil, function(response)
        local filejson = json.decode(response.text);
        for i, v in ipairs(filejson) do
            for j, set in pairs(data) do
                local form_db_name = string.match(j, "^form_ig_(.*)$");
                if (form_db_name) then
                    if (v.name == form_db_name) then
                        v.state = set == 1;
                    end
                end
            end
            igForms.list(v);
        end
    end, function(err)
        igForms.b = false;
    end)
end

local offForms = {
    b = false,
    process = false,
    widget = {
        start_time = os.clock(),
        index = -1
    },
    runners = {},
    list = {},
    pool = {}
};

offForms.runners = {
    other = function(form_name, form, regex)
        local playerId = getPlayerIdByNickname(offForms.widget.args[offForms.widget.f_plId]);

        if (playerId == -1) then
            local new_cmd = ("%soff"):format(offForms.widget.args[1]);
            offForms.widget.args[1] = new_cmd;
        else
            offForms.widget.args[offForms.widget.f_plId] = getPlayerNickNameById(playerId);
        end
        offForms.widget.form = table.concat(offForms.widget.args, " ");

        sendMessage(offForms.widget.form);
    end,
	antibot = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local a,b = form:match(regex);

			check.offForms = {
				form = "antibot",
				nick = a,
				ip = b
			};

			license.sellLicenses = false;

			set_bot_position();

			sendMessage("/getip" .. a);
        end
    end,
	bank = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local a = form:match(regex);

			check.offForms = {
				form = "bank",
				amount = tonumber(a)
			};

			license.sellLicenses = false;

			set_bot_position();

			sendMessage("/abankmenu");
        end
    end,
    pay = function(compensations, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local n, a = form:match(regex);

            if (getPlayerIdByNickname(n) == -1) then
                offForms.process = false;
                offForms.widget = {};
            else
                check.offForms = {
                    form = "pay",
                    nickname = n,
                    amount = tonumber(a)
                };

                license.sellLicenses = false;

                set_bot_position();

                sendMessage("/abankmenu");
            end
        end
    end,
    setname = function(form_name, form, regex)
        local o, n = form:match(regex);

        if (getPlayerIdByNickname(o) == -1) then
            offForms.process = false;
            offForms.widget = {};
        else
            sendMessage("/setname " .. getPlayerIdByNickname(o) .. " " .. n);
        end
    end,
    makeleader = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local n, o, r = form:match(regex);

            if (getPlayerIdByNickname(n) == -1) then
                offForms.process = false;
                offForms.widget = {};
            else
                check.offForms = {
                    form = "makeleader",
                    nickname = n,
                    organization = tonumber(o),
                    reason = r
                };

                license.sellLicenses = false;

                set_bot_position();

                sendMessage("/makeleader " ..  getPlayerIdByNickname(n));
            end
        end
    end,
    unleader = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local o, r = form:match(regex);

            check.offForms = {
                form = "unleader",
                organization = tonumber(o),
                reason = r
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/apanel");
        end
    end,
    makejudge = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local n = form:match(regex);

            if (getPlayerIdByNickname(n) == -1) then
                offForms.process = false;
                offForms.widget = {};
            else
                check.offForms = {
                    form = "makejudge",
                    nickname = n
                };

                license.sellLicenses = false;

                set_bot_position();

                sendMessage("/apanel");
            end
        end
    end,
    unjudge = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local n = form:match(regex);

            check.offForms = {
                form = "unjudge",
                nickname = n
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/apanel");
        end
    end,
    props = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local t, i, b = form:match(regex);

            if (tonumber(b) == 1) then
                b = "Подтвердить верификацию";
            elseif (tonumber(b) == 0) then
                b = "Отклонить верификацию";
            end

            check.offForms = {
                form = "props",
                id = tonumber(i),
                type = tonumber(t),
                action = b
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/props " .. t .. " " .. i);
        end
    end,
    rasform = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local t = form:match(regex);

            check.offForms = {
                form = "rasform",
                type = tonumber(t)
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/rasform");
        end
    end,
    ban = function(form_name, form, regex)
        local n, t, r = form:match(regex);

        sendMessage("/banoff 0 " .. n .. " " .. t .. " " .. r);
    end,
    ao = function(form_name, form, regex)
        sendMessage(form);
    end,
    agl = function(form_name, form, regex)
        local n, t = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            offForms.process = false;
            offForms.widget = {};
        else
            sendMessage("/agl " .. n .. " " .. t);
        end
    end,
    delhname = function(form_name, form, regex)
        sendMessage(form);
    end,
    delbname = function(form_name, form, regex)
        sendMessage(form);
    end,
    famwarban = function(form_name, form, regex)
        sendMessage(form);
    end,
    unfamwarban = function(form_name, form, regex)
        sendMessage(form);
    end,
    stopfractionpeace = function(form_name, form, regex)
        sendMessage(form);
    end,
    stopfractionwar = function(form_name, form, regex)
        sendMessage(form);
    end,
    cancelfamgz = function(form_name, form, regex)
        sendMessage(form);
    end,
    setbizmafia = function(form_name, form, regex)
        local b, o = form:match(regex);

        check.offForms = {
            form = "setfamgz",
            organization = tonumber(o),
            businesses = json.decode(b),
            process = false,
            notLast = true
        };

        for id, business in ipairs(check.offForms.businesses) do
            if (#check.offForms.businesses == id) then
                check.offForms.notLast = false;
            end

            sendMessage("/setbizmafia " .. business .. " " .. o);

            wait(2000);
        end
    end,
    setfamgz = function(form_name, form, regex)
        local t, f = form:match(regex);

        check.offForms = {
            form = "setfamgz",
            family = f,
            territories = json.decode(t),
            process = false,
            notLast = true
        };

        for id, territory in ipairs(check.offForms.territories) do
            if (#check.offForms.territories == id) then
                check.offForms.notLast = false;
            end

            sendMessage("/setfamgz " .. territory .. " " .. f);

            wait(2000);
        end
    end,
    setgangzone = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local o, t = form:match(regex);

            check.offForms = {
                form = "setgangzone",
                organization = tonumber(o),
                territories = json.decode(t),
                process = false,
                notLast = true
            };

            license.sellLicenses = false;

            for id, territory in ipairs(check.offForms.territories) do
				wait(20000)
                if (#check.offForms.territories == id) then
                    check.offForms.notLast = false;
                end

                check.offForms.process = true;

                local x = core.zones.ghetto[tonumber(territory)].x1 + (core.zones.ghetto[tonumber(territory)].x2 - core.zones.ghetto[tonumber(territory)].x1) / 2;
                local y = core.zones.ghetto[tonumber(territory)].y1 + (core.zones.ghetto[tonumber(territory)].y2 - core.zones.ghetto[tonumber(territory)].y1) / 2;

                sendMessage("/gc " .. x .. " " .. y .. " 0 0 0");
				wait(5000);
				if (check.offForms) then
					print('Условие 1');
					if (check.offForms.form == "setgangzone") then
						print('Условие 2');
						sendMessage("/setgangzone " .. check.offForms.organization);

						if (not check.offForms.notLast) then
							set_bot_position();
						end

						check.offForms.process = false;
					end
				end
                while (check.offForms and check.offForms.process) do
                    wait(2500);
                end
            end
        end
    end,
    unban = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local n, r = form:match(regex);

            check.offForms = {
                form = "unban",
                nickname = n,
                reason = r
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/unban " .. n .. " " .. r);
        end
    end,
    notif = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local n, t = form:match(regex);

            check.offForms = {
                form = "notif",
                nickname = n,
                text = t
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage(form);
        end
    end,
    defmarker = function(form_name, form, regex)
        local n, r = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            offForms.process = false;
            offForms.widget = {};
        else
            sendMessage("/defmarker " .. getPlayerIdByNickname(n) .. " " .. r);
        end
    end,
    unapunish = function(form_name, form, regex)
        local n, r = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            sendMessage("/unapunishoff " .. n .. " " .. r);
        else
            sendMessage("/skick " .. getPlayerIdByNickname(n));
            sendMessage("/unapunishoff " .. n .. " " .. r);
        end
    end,
    rmute = function(form_name, form, regex)
        local n, t, r = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            offForms.process = false;
            offForms.widget = {};
        else
            sendMessage("/rmute " .. getPlayerIdByNickname(n) .. " " .. t .. " " .. r);
        end
    end,
    unrmute = function(form_name, form, regex)
        local n, r = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            offForms.process = false;
            offForms.widget = {};
        else
            sendMessage("/unrmute " .. getPlayerIdByNickname(n) .. " " .. r);
        end
    end,
    setmember = function(form_name, form, regex)
        local n, f, a, r = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            offForms.process = false;
            offForms.widget = {};
        else
            sendMessage("/setmember " .. getPlayerIdByNickname(n) .. " " .. f .. " " .. a .. " " .. r);
        end
    end,
    banip = function(form_name, form, regex)
        local ip, r = form:match(regex);

        sendMessage("/banipoff " .. ip .. " " .. r);
    end,
    unbanip = function(form_name, form, regex)
        local ip = form:match(regex);

        sendMessage("/unbanip " .. ip);
    end,
    ungivedemotalon = function(form_name, form, regex)
        local n = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            sendMessage("/ungivedemotalonoff " .. n);
        else
            local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("У игрока недостаточно талонов.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
            mysqlQuery(query);

            offForms.process = false;
            offForms.widget = {};
        end
    end,
    ungiveantimute = function(form_name, form, regex)
        local n = form:match(regex);

        if (getPlayerIdByNickname(n) == -1) then
            sendMessage("/ungiveantimuteoff " .. n);
        else
            local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("У игрока недостаточно талонов.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
            mysqlQuery(query);

            offForms.process = false;
            offForms.widget = {};
        end
    end,
    votestart = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            local t, i, l, n, u = form:match(regex);
            local nicknames = json.decode(u);

            if (#nicknames == 1) then
                nicknames = {
                    "За " .. nicknames[1],
                    "Против " .. nicknames[1],
                }
            end

            check.offForms = {
                form = "votestart",
                step = 0,
                time = tostring(t),
                name = n,
                ip = tostring(i),
                level = tostring(l),
                nicknames = nicknames
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/vote");
        end
    end,
    votestop = function(form_name, form, regex)
        if (check.morg or check.businesses_mafia or check.props or check.mpdonate or check.pledge or check.spawncars or check.compensations or check.recovery_account or check.recovery_fraction or check.server_stats == "svrnt") then
            offForms.process = false;
            offForms.widget = {};
        else
            check.offForms = {
                form = "votestop",
            };

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/vote");
        end
    end,
};

setmetatable(offForms.list, {
    __call = function(self, data)
        if (type(data) == "table") then
            data.runner = offForms.runners[data.name] or offForms.runners["other"];
            data.params = string.gsub(data.params, "%s+", "%%s+");

            local err = false;

            for i, form in ipairs(offForms.list) do
                if (form.name == data.name) then
                    offForms.list[i] = data;
                    err = true;
                    break;
                end
            end

            if (not err) then
                table.insert(self, data);
                table.sort(self, function(a, b)
                    return a.name < b.name;
                end)
            end
        end
    end
})

function initOffForms(data)
    if (not offForms.b) then return end;
    asyncHttpRequest("GET", BASE_URL.."/files/raksamp/off_forms.json", nil, function(response)
        local filejson = json.decode(u8:decode(response.text));
        for i, v in ipairs(filejson) do
            for db_name, set in pairs(data) do
                local form_db_name = db_name:match("^form_off_(.*)$");
                if (form_db_name) then
                    if (v.name == form_db_name) then
                        v.state = set == 1;
                    end
                end
            end
            offForms.list(v);
        end
    end, function(err)
        offForms.b = false;
    end)
end

local compensations = {
    b = false,
    process = false,
    widget = {
        start_time = os.clock(),
        index = -1
    },
    runners = {},
    list = {},
    pool = {}
};

compensations.runners = {
    other = function(form_name, form, regex)
        local playerId = getPlayerIdByNickname(compensations.widget.args[compensations.widget.f_plId]);

        if (playerId == -1) then
            local new_cmd = ("%soff"):format(compensations.widget.args[1]);
            compensations.widget.args[1] = new_cmd;
        else
            compensations.widget.args[compensations.widget.f_plId] = getPlayerNickNameById(playerId);
        end
        compensations.widget.form = table.concat(compensations.widget.args, " ");

        sendMessage(compensations.widget.form);
    end,
    giveantiwarn = function(form_name, form, regex)
        compensations.widget.args[1] = ("%soff"):format(compensations.widget.args[1]);
        compensations.widget.form = table.concat(compensations.widget.args, " ");

        sendMessage("/notif " .. compensations.widget.args[compensations.widget.f_plId] .. " Заявка на компенсацию по жалобе №" .. compensations.widget.complaintId .. " была одобрена администратором " .. compensations.widget.administrator .. ".");
        sendMessage("/notif " .. compensations.widget.args[compensations.widget.f_plId] .. " Ожидайте выдачи от Главного администратора/Заместителя главного администратора.");

        local query = "UPDATE `arizona`.compensations_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Необходимо выдать форму вручную: " .. compensations.widget.form) .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `compensation_id` = " .. compensations.widget.compensation_id .. " AND `server_id` = " .. server_id .. ';';
        mysqlQuery(query);

        compensations.process = false;
        compensations.widget = {};
    end,
};

setmetatable(compensations.list, {
    __call = function(self, data)
        if (type(data) == "table") then
            data.runner = compensations.runners[data.name] or compensations.runners["other"];
            data.params = string.gsub(data.params, "%s+", "%%s+");

            local err = false;

            for i, form in ipairs(compensations.list) do
                if (form.name == data.name) then
                    compensations.list[i] = data;
                    err = true;
                    break;
                end
            end

            if (not err) then
                table.insert(self, data);
                table.sort(self, function(a, b)
                    return a.name < b.name;
                end)
            end
        end
    end
})

function initCompensations()
    if (not compensations.b) then return end;
    asyncHttpRequest("GET", BASE_URL.."/files/raksamp/compensations.json", nil, function(response)
        local filejson = json.decode(u8:decode(response.text));
        for i, v in ipairs(filejson) do
            compensations.list(v);
        end
    end, function(err)
        compensations.b = false;
    end)
end

local recovery_fraction = {
    b = false,
    process = false,
    widget = {
        start_time = os.clock(),
        index = -1
    },
    pool = {}
};

local recovery_account = {
    b = false,
    process = false,
    widget = {
        start_time = os.clock(),
        index = -1
    },
    pool = {}
};

function initMessagesRemover()
    asyncHttpRequest("GET", BASE_URL.."/files/raksamp/messages_remover.json", nil, function(response)
        local filejson = json.decode(u8:decode(response.text));
        for i, v in ipairs(filejson) do
            table.insert(messagesRemover, v);
        end
    end, function(err)
        local error_string = server_prefix .. "[ MessagesRemover | Критическая ошибка ] Не был получен ответ от API.";
		print(error_string);
		asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
    end)
end

function initGuard()
    asyncHttpRequest("GET", BASE_URL.."/files/raksamp/guard.json", nil, function(response)
        local filejson = json.decode(u8:decode(response.text));
        for i, v in ipairs(filejson) do
            table.insert(guard, v);
        end
    end, function(err)
        local error_string = server_prefix .. "[ MessagesRemover | Критическая ошибка ] Не был получен ответ от API.";
		print(error_string);
		asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
    end)
end

do
    local function isset(p1, p2)
        if (p1 ~= nil) then return p1; end
        return p2;
    end

    local query = ("UPDATE `arizona`.servers_raksamp SET `started` = %d, `last_bot_start` = %d WHERE `server_id` = %d;"):format(1, os.time(), server_id);
    AsyncMysqlQuery(query);

    query = "SELECT * FROM `arizona`.servers_raksamp WHERE `server_id` = " .. server_id .. ";";
    local data = mysqlQuery(query)[1];

    settings.active = isset(data.active == 1, settings.active);
    settings.start = isset(data.start == 1, settings.start);
    settings.debug = isset(data.debug == 1, settings.debug);
    settings.server_ip = isset(data.server_ip, settings.server_ip);
    settings.server_port = isset(tonumber(data.server_port), settings.server_port);
    settings.bot_nickname = isset(data.bot_nickname, settings.bot_nickname);
    settings.bot_password_server = isset(data.bot_password_server, settings.bot_password_server);
    settings.bot_password_admin = isset(data.bot_password_admin, settings.bot_password_admin);
    settings.bot_password_bank = isset(data.bot_password_bank, settings.bot_password_bank);

    settings.last_bot_start = isset(data.last_bot_start, settings.last_bot_start);
    settings.last_bot_restart = isset(data.last_bot_restart, settings.last_bot_restart);
    settings.last_bot_stop = isset(data.last_bot_stop, settings.last_bot_stop);
    settings.last_bot_connect = isset(data.last_bot_connect, settings.last_bot_connect);
    settings.last_bot_disconnect = isset(data.last_bot_disconnect, settings.last_bot_disconnect);

    settings.spawn_position = isset(data.spawn_position, settings.spawn_position)
    settings.spawn_quaternion = {
        [0] = isset(tonumber(data.spawn_position_quaternion_zero), settings.spawn_quaternion[0]),
        [1] = isset(tonumber(data.spawn_position_quaternion_one), settings.spawn_quaternion[1]),
        [3] = isset(tonumber(data.spawn_position_quaternion_three), settings.spawn_quaternion[3]),
        [2] = isset(tonumber(data.spawn_position_quaternion_two), settings.spawn_quaternion[2]),
    };

    settings.license_system = isset(data.license_system == 1, settings.license_system);
    settings.license_first_position = isset(data.license_first_position, settings.license_first_position);
    settings.license_quaternion_first = {
        [0] = isset(data.license_first_position_quaternion_zero, settings.license_quaternion_first[0]),
        [1] = isset(data.license_first_position_quaternion_one, settings.license_quaternion_first[1]),
        [2] = isset(data.license_first_position_quaternion_two, settings.license_quaternion_first[2]),
        [3] = isset(data.license_first_position_quaternion_three, settings.license_quaternion_first[3])
    };

    settings.license_second_position = isset(data.license_second_position, settings.license_second_position);
    settings.license_quaternion_second = {
        [0] = isset(data.license_second_position_quaternion_zero, settings.license_quaternion_second[0]),
        [1] = isset(data.license_second_position_quaternion_one, settings.license_quaternion_second[1]),
        [2] = isset(data.license_second_position_quaternion_two, settings.license_quaternion_second[2]),
        [3] = isset(data.license_second_position_quaternion_three, settings.license_quaternion_second[3])
    };

    settings.skin_system = isset(data.skin_system == 1, settings.skin_system);
    settings.skin_id = isset(data.skin_id, settings.skin_id);

    settings.amember_system = isset(data.amember_system == 1, settings.amember_system);
    settings.amember_fraction = isset(data.amember_fraction, settings.amember_fraction);
    settings.amember_rank = isset(data.amember_rank, settings.amember_rank);

    settings.bot_admin_lvl = isset(tonumber(data.bot_admin_lvl), settings.bot_admin_lvl);

    settings.property_purchase_system = isset(data.property_purchase_system == 1, settings.property_purchase_system);

    settings.send_information_to_admins_system = isset(data.send_information_to_admins_system == 1, settings.send_information_to_admins_system);
    settings.send_information_to_admins_time = isset(tonumber(data.send_information_to_admins_time), settings.send_information_to_admins_time);
    settings.last_send_information_to_admins = isset(tonumber(data.last_send_information_to_admins), settings.last_send_information_to_admins);

    settings.auto_respawn_cars = isset(data.auto_respawn_cars == 1, settings.auto_respawn_cars);
    settings.auto_respawn_cars_time = isset(tonumber(data.auto_respawn_cars_time), settings.auto_respawn_cars_time);
    settings.last_respawn_cars = isset(tonumber(data.last_respawn_cars), settings.last_respawn_cars);

    settings.send_mpdonate_system = isset(data.send_mpdonate_system == 1, settings.send_mpdonate_system);
    settings.send_mpdonate_time = isset(tonumber(data.send_mpdonate_time), settings.send_mpdonate_time);
    settings.last_send_mpdonate = isset(tonumber(data.last_send_mpdonate), settings.last_send_mpdonate);

    settings.send_ao_system = isset(data.send_ao_system == 1, settings.send_ao_system);

    settings.send_conference_system = isset(data.send_conference_system == 1, settings.send_conference_system);
    settings.last_send_conference_first = isset(tonumber(data.last_send_conference_first), settings.last_send_conference_first);
    settings.send_conference_first_hour = isset(tonumber(data.send_conference_first_hour), settings.send_conference_first_hour);
    settings.send_conference_first_minute = isset(tonumber(data.send_conference_first_minute), settings.send_conference_first_minute);
    settings.last_send_conference_second = isset(tonumber(data.last_send_conference_second), settings.last_send_conference_second);
    settings.send_conference_second_hour = isset(tonumber(data.send_conference_second_hour), settings.send_conference_second_hour);
    settings.send_conference_second_minute = isset(tonumber(data.send_conference_second_minute), settings.send_conference_second_minute);
    settings.last_send_conference_third = isset(tonumber(data.last_send_conference_third), settings.last_send_conference_third);
    settings.send_conference_third_hour = isset(tonumber(data.send_conference_third_hour), settings.send_conference_third_hour);
    settings.send_conference_third_minute = isset(tonumber(data.send_conference_third_minute), settings.send_conference_third_minute);
    settings.last_send_conference_fourth = isset(tonumber(data.last_send_conference_fourth), settings.last_send_conference_fourth);
    settings.send_conference_fourth_hour = isset(tonumber(data.send_conference_fourth_hour), settings.send_conference_fourth_hour);
    settings.send_conference_fourth_minute = isset(tonumber(data.send_conference_fourth_minute), settings.send_conference_fourth_minute);
    settings.last_send_conference_fifth = isset(tonumber(data.last_send_conference_fifth), settings.last_send_conference_fifth);
    settings.send_conference_fifth_hour = isset(tonumber(data.send_conference_fifth_hour), settings.send_conference_fifth_hour);
    settings.send_conference_fifth_minute = isset(tonumber(data.send_conference_fifth_minute), settings.send_conference_fifth_minute);

    bot_bandit.b = isset(data.bot_bandit_checker_system == 1, bot_bandit.b);
    bot_bandit.delay = isset(tonumber(data.bot_bandit_checker_time), bot_bandit.delay);
    bot_bandit.last = isset(tonumber(data.last_bot_bandit_checker), bot_bandit.last);

    igForms.b = isset(data.form_ig_system == 1, igForms.b);
    settings.plveh_auto_set_id = isset(data.form_set_plveh_auto_set_id == 1, settings.plveh_auto_set_id);

    server_stats.b = isset(data.server_stats == 1, server_stats.b);

    morg.b = isset(data.fractions_system == 1, morg.b);
    morg.delay = isset(tonumber(data.fractions_time), morg.delay);
    morg.last = isset(tonumber(data.last_fractions), morg.last);

    businesses_mafia.b = isset(data.businesses_mafia_system == 1, businesses_mafia.b);
    businesses_mafia.delay = isset(tonumber(data.businesses_mafia_time), businesses_mafia.delay);
    businesses_mafia.last = isset(tonumber(data.last_businesses_mafia), businesses_mafia.last);

    pledge.b = isset(data.pledge_system == 1, pledge.b);
    pledge.delay = isset(tonumber(data.pledge_time), pledge.delay);
    pledge.last = isset(tonumber(data.last_pledge), pledge.last);

    props.b = isset(data.property_sell_system == 1, props.b);
    props.delay = isset(tonumber(data.property_sell_time), props.delay);
    props.days = isset(tonumber(data.property_sell_days), props.days);
    props.last = isset(tonumber(data.last_property_sell), props.last);

    offForms.b = isset(data.form_off_system == 1, offForms.b);

    compensations.b = isset(data.compensations_system == 1, compensations.b);

    recovery_account.b = isset(data.recovery_account_system == 1, recovery_account.b);

    recovery_fraction.b = isset(data.recovery_fraction_system == 1, recovery_fraction.b);

    if (not settings.debug) then
        initMessagesRemover();
    end

    initGuard();

    initIgForms(data);
    initOffForms(data);

    if (compensations.b) then
        initCompensations();
    end
end

do
    if (settings.server_ip ~= "" and settings.server_port ~= 0) then
        if (server_id > 0) then
            asyncHttpRequest("GET", ("http://%s:80/"):format(settings.server_ip), nil, function(response)
                if (response.status_code == 200) then
					local error_string = server_prefix .. "[ mobile2 ] API успешно обработано.";
					print(error_string);
					asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                else
					local error_string = server_prefix .. "[ mobile2 | Критическая ошибка ] Не был получен ответ от API.";
					print(error_string);
					asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                end
            end, function(err)
				local error_string = server_prefix .. "[ mobile2 | Критическая ошибка ] Не был получен ответ от API.";
				print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
            end)
        end

        local ip = ("%s:%d"):format(settings.server_ip, settings.server_port);
        setServerAddress(ip);
    else
        settings.last_bot_disconnect = os.time();
        local query = ("UPDATE `arizona`.servers_raksamp SET `started` = %d, `last_bot_disconnect` = %d, `last_bot_stop` = %d WHERE `server_id` = %d;"):format(0, settings.last_bot_disconnect, os.time(), server_id);
        AsyncMysqlQuery(query);

        exit();
    end

    if (settings.bot_nickname ~= "") then
        setBotNick(settings.bot_nickname);
    else
        settings.last_bot_disconnect = os.time();
        local query = ("UPDATE `arizona`.servers_raksamp SET `started` = %d, `last_bot_disconnect` = %d, `last_bot_stop` = %d WHERE `server_id` = %d;"):format(0, settings.last_bot_disconnect, os.time(), server_id);
        AsyncMysqlQuery(query);

        exit();
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if (dialogId == 25527) then
		sendDialogResponse(dialogId, 1, -1, '1');
	end
    if (dialogId == 0) then
        if (text:find("В этой организации никто не состоит!")) then
            if (check.morg) then
                morg.pool[tonumber(check.morg)].check = 3;
                sendMessage('/lmenu');
            end
        end

        if (text:find("%{FFFFFF%}Ошибка! У этой организации уже есть лидер!")) then
            if (check.offForms) then
                if (check.offForms.form == "makeleader") then
                    local query = "UPDATE `arizona`.form_off_system SET `error` = 1, `text_error` = '" .. u8("У этой организации уже есть лидер.") .. "', `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    check.offForms = nil;
                    offForms.process = false;
                    offForms.widget = {};
                end
            end
        end

        if (text:find("На данный момент под вашем контролем нет бизнесов!")) then
            if (check.businesses_mafia) then
                check.businesses_mafia = true;
            end
        end

        if (title:find("Собеседования"))  then
            for line in text:gmatch("[^\n]+") do
                line = line:gsub("{%x+}", "");
                local organization, interview_time, location = line:match("(.-)%s+(%d?%d:%d%d)%s+(.*)$");

                if (not organization) then
                    organization, interview_time, location = line:match("(.-)%s+(Не запланировано)%s+(.*)$");
                end

                if (organization) then
                    organization = organization:gsub("- ", "");

                    for id, v in ipairs(core.orgs.list) do
                        if (v.stats == organization) then
                            if (interview_time ~= "Не запланировано") then
                                morg.pool[tonumber(v.id)].sobes.time = interview_time;
                            end

                            if (interview_time ~= "Не назначено!") then
                                morg.pool[tonumber(v.id)].sobes.place = location;
                            end
                        end
                    end
                end
            end
        end

        if (title:find("Уведомление создано"))  then
            local nickname = text:match("Ник:%s*{%x+}(%S+)");

            if (check.offForms and check.offForms.form == "notif") then
                if (check.offForms.nickname == nickname) then
                    local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    check.offForms = nil;
                    offForms.process = false;
                    offForms.widget = {};
                end
            end
        end
    end

    if (dialogId == 2) then
        settings.last_bot_connect = os.time();
        local query = ("UPDATE `arizona`.servers_raksamp SET `last_bot_connect` = %d WHERE `server_id` = %d;"):format(os.time(), server_id);
        AsyncMysqlQuery(query);

        sendDialogResponse(dialogId, 1, -1, settings.bot_password_server);
    end

    if (dialogId == 26) then
        if (check.offForms) then
            if (check.offForms.form == "makeleader") then
                local organization = findListInDialog(text, style, "%[" .. check.offForms.organization .. "%]");
                sendDialogResponse(dialogId, 1, organization, "");
            end
        end
    end

    if (dialogId == 33) then
        if (check.offForms.form == "pay") then
            local action = findListInDialog(text, style, "Перевести деньги с основного счета");
            sendDialogResponse(dialogId, 1, action, "");
        end
		if (check.offForms.form == "bank") then
			local action = findListInDialog(text, style, "Пополнить основной счет");
            sendDialogResponse(dialogId, 1, action, "");
		end
    end
	if (dialogId == 34) then
		if (check.offForms.form == "bank") then
            sendDialogResponse(dialogId, 1, -1, tostring(check.offForms.amount));
		end
	end
    if (dialogId == 37) then
        if (check.offForms.form == "pay") then
            sendDialogResponse(dialogId, 1, -1, check.offForms.nickname);
        end
    end

    if (dialogId == 41) then
        if (check.offForms.form == "pay") then
            sendDialogResponse(dialogId, 1, -1, tostring(check.offForms.amount));
        end
    end

    if (dialogId == 91) then
        local nickname = title:gsub("{%x+}", "");
        if (check.offForms and check.offForms.form == "unban") then
            if (check.offForms.nickname == nickname) then
                sendDialogResponse(dialogId, 1, -1, "");

                check.offForms = nil;
            end
        end

        if (check.recovery_account) then
            sendDialogResponse(dialogId, 1, -1, "");
        end
    end

    if (dialogId == 115) then
        if (check.offForms.form == "unleader") then
            for id, v in ipairs(core.orgs.list) do
                if (v.id == check.offForms.organization) then
                    check.offForms.organization_name = v.stats;
                end
            end

            local action = findListInDialog(text, style, check.offForms.organization_name);

            sendDialogResponse(dialogId, 1, action, "");
        end
    end

    if (dialogId == 211) then
        sendDialogResponse(dialogId, 1, -1, settings.bot_password_admin);
    end

    if (dialogId == 266) then
        sendDialogResponse(dialogId, 1, 0, "");
        sendMessage("/ao [Спавн транспорта] Весь транспорт был успешно заспавнен!");
        check.spawncars = nil;
    end

    if (dialogId == 567) then
        local count = 0;

        for line in text:gmatch("[^\n]+") do
            count = count + 1;
            local nickname, time_value, time_unit, rank_name, rank_number, additional_days, total_hours = line:match("(%S+)%s+(%d+)%s+(%S+)%s+(.+)%[(%d+)%]%s+%((%d+)%s+дней%)?%s+%[%s+(%d+%.%d+)%s+час");
            local isPayed = line:find("{90EE90}") ~= nil;

            if (nickname) then
                nickname = nickname:gsub("{.-}%s*", "");
                time_value = tonumber(time_value);

                if time_unit:match("дней") then
                    time_value = time_value * 24;
                end

                rank_number = tonumber(rank_number);
                rank_name = rank_name:gsub("{%x+}", "");
                total_hours = tonumber(total_hours);

                if ((time_value >= morg.pool[tonumber(check.morg)].uval.time * 24) and (not isPayed)) then
                    if (morg.pool[tonumber(check.morg)].uval.enabled) then
                        table.insert(morg.pool[tonumber(check.morg)].uval.pool, {
                            nickname = nickname,
                            time = tonumber(time_value),
                        });
                    end
                else
                    if (tonumber(rank_number) == 0) then
                        sendMessage("/uvaloff " .. nickname);
                        sendMessage("/notif " .. nickname .. " Вы были уволены из организации в связи с возникновением бага, обратитесь к администрации для возврата ранга.");
                        sendMessage("/a [ CheckFractions | Error ] FractionID: " .. tostring(check.morg) .. " | PlayerName: " .. nickname);
                    elseif (tonumber(rank_number) > 0 and tonumber(rank_number) <= 11) then
                        table.insert(morg.pool[tonumber(check.morg)].ranks[tonumber(rank_number)].pool, {
                            nickname = nickname,
                            rank = tonumber(rank_number),
                            rank_name = u8(rank_name),
                            last = tonumber(time_value),
                            days = tonumber(additional_days),
                            payed = isPayed
                        });
                    end
                end
            else
                nickname, time_value, time_unit, rank_name, rank_number, total_hours = line:match("(%S+)%s+(%d+)%s+(%S+)%s+(.+)%[(%d+)%]%s+%[%s+(%d+%.%d+)%s+час");

                if (nickname) then
                    nickname = nickname:gsub("{.-}%s*", "");
                    time_value = tonumber(time_value);

                    if time_unit:match("дней") then
                        time_value = time_value * 24;
                    end

                    rank_number = tonumber(rank_number);
                    rank_name = rank_name:gsub("{%x+}", "");
                    total_hours = tonumber(total_hours);

                    if ((time_value >= morg.pool[tonumber(check.morg)].uval.time * 24) and (not isPayed)) then
                        if (morg.pool[tonumber(check.morg)].uval.enabled) then
                            table.insert(morg.pool[tonumber(check.morg)].uval.pool, {
                                nickname = nickname,
                                time = tonumber(time_value),
                            });
                        end
                    else
                        if (tonumber(rank_number) == 0) then
                            sendMessage("/uvaloff " .. nickname);
                            sendMessage("/notif " .. nickname .. " Вы были уволены из организации в связи с возникновением бага, обратитесь к администрации для возврата ранга.");
                            sendMessage("/a [ CheckFractions | Error ] FractionID: " .. tostring(check.morg) .. " | PlayerName: " .. nickname);
                        elseif (tonumber(rank_number) > 0 and tonumber(rank_number) <= 11) then
                            table.insert(morg.pool[tonumber(check.morg)].ranks[tonumber(rank_number)].pool, {
                                nickname = nickname,
                                rank = tonumber(rank_number),
                                rank_name = u8(rank_name),
                                last = tonumber(time_value),
                                days = 0,
                                payed = isPayed
                            });
                        end
                    end
                end
            end
        end

        local nextList = findListInDialog(text, style, "Вперед");
        local prevList = findListInDialog(text, style, "Назад");

        if ((nextList) and (not prevList)) then
            morg.pool[tonumber(check.morg)].error_second = false;
            sendDialogResponse(dialogId, 1, nextList, "");
        elseif ((nextList) and (prevList)) then
            if (morg.pool[tonumber(check.morg)].error_second) then
                sendDialogResponse(dialogId, 1, prevList, "");
            else
                sendDialogResponse(dialogId, 1, nextList, "");
            end
        elseif ((not nextList) and (prevList)) then
            if (morg.pool[tonumber(check.morg)].error_second) then
                sendDialogResponse(dialogId, 1, prevList, "");
            else
                morg.pool[tonumber(check.morg)].check = 3;
                sendMessage('/lmenu');
            end
        elseif ((not nextList) and (not prevList)) then
            morg.pool[tonumber(check.morg)].error_second = false;
            morg.pool[tonumber(check.morg)].check = 3;
            sendMessage('/lmenu');
        end
    end

    if (dialogId == 1009) then
        if (tonumber(check.morg)) then
            if (morg.pool[tonumber(check.morg)].check == 1) then
                sendDialogResponse(dialogId, 1, 0, "");
            elseif (morg.pool[tonumber(check.morg)].check == 2) then
                sendDialogResponse(dialogId, 1, 1, "");
            end
        end
    end

    if (dialogId == 1214) then
        local money = title:match("{%x+}Банк: .*%$(%d+)");
        if (money) then
            money = tonumber(money);
            if (tonumber(check.morg)) then
                morg.pool[tonumber(check.morg)].money = money;

                for list in text:gmatch("[^\n]+") do
                    if (list:gsub("{%x+}", ""):find("Общак %[Открыт%]")) then
                        morg.pool[tonumber(check.morg)].dormitory = true;
                        break;
                    end
                end

                local members = findListInDialog(text, style, "Управление членами организации");
                local salary = findListInDialog(text, style, "Изменить зарплаты");
                if (morg.pool[tonumber(check.morg)].check == 3) then
                    if (salary) then
                        sendDialogResponse(dialogId, 1, salary, "");
                    end
                else
                    if (members) then
                        sendDialogResponse(dialogId, 1, members, "");
                    end
                end
            end
        end
    end

    if (dialogId == 1599) then
        sendDialogResponse(dialogId, 1, 0, "");
    end

    if (dialogId == 2015) then
        local count = 0;

        for line in text:gmatch("[^\n]+") do
            count = count + 1;

            local name, rank_name, rank_number, additional_days = line:match("(%w+_%w+)%(%d+%)%s+(.-)%((%d+)%)%s+%((%d+)%s+дней%)*");
            local isPayed = line:find("{90EE90}") ~= nil;

            if (name) then
                name = name:gsub("%[.-%]%s*", "");
                rank_name = rank_name:gsub("{%x+}", "");

                if (tonumber(rank_number) == 0) then
                    newTask(function ()
                        wait(5 * 1000);
                        sendMessage("/uval " .. getPlayerIdByNickname(name));
                        sendMessage("/notif " .. name .. " Вы были уволены из организации в связи с возникновением бага, обратитесь к администрации для возврата ранга.");
                        sendMessage("/skick " .. getPlayerIdByNickname(name));
                        sendMessage("/a [ CheckFractions | Error ] FractionID: " .. tostring(check.morg) .. " | PlayerName: " .. name);
                    end)
                elseif (tonumber(rank_number) > 0 and tonumber(rank_number) <= 11) then
                    table.insert(morg.pool[tonumber(check.morg)].ranks[tonumber(rank_number)].pool, {
                        nickname = name,
                        rank = tonumber(rank_number),
                        rank_name = u8(rank_name),
                        last = 0,
                        days = tonumber(additional_days),
                        payed = isPayed
                    });
                end
            else
                local name, playerId, rank_name, rank_number = line:match("([%w_]+)%((%d+)%)%s*([^%(]+)%((%d+)%)");

                if (name) then
                    if (tonumber(rank_number) == 0) then
                        newTask(function ()
                            wait(5 * 1000);
                            sendMessage("/uval " .. getPlayerIdByNickname(name));
                            sendMessage("/notif " .. name .. " Вы были уволены из организации в связи с возникновением бага, обратитесь к администрации для возврата ранга.");
                            sendMessage("/skick " .. getPlayerIdByNickname(name));
                            sendMessage("/a [ CheckFractions | Error ] FractionID: " .. tostring(check.morg) .. " | PlayerName: " .. name);
                        end)
                    elseif (tonumber(rank_number) > 0 and tonumber(rank_number) <= 11) then
                        table.insert(morg.pool[tonumber(check.morg)].ranks[tonumber(rank_number)].pool, {
                            nickname = name,
                            rank = tonumber(rank_number),
                            rank_name = u8(rank_name),
                            last = 0,
                            days = 0,
                            payed = isPayed
                        });
                    end
                end
            end
        end

        local nextList = findListInDialog(text, style, "Следующая страница");
        local prevList = findListInDialog(text, style, "Предыдущая страница");

        if ((nextList) and (not prevList)) then
            morg.pool[tonumber(check.morg)].error_first = false;
            sendDialogResponse(dialogId, 1, nextList, "");
        elseif ((nextList) and (prevList)) then
            if (morg.pool[tonumber(check.morg)].error_first) then
                sendDialogResponse(dialogId, 1, prevList, "");
            else
                sendDialogResponse(dialogId, 1, nextList, "");
            end
        elseif ((not nextList) and (prevList)) then
            if (morg.pool[tonumber(check.morg)].error_first) then
                if (morg.pool[tonumber(check.morg)].error_stats > 2) then
                    morg.pool[tonumber(check.morg)].error_first = false;
                    morg.pool[tonumber(check.morg)].check = 2;

                    sendMessage("/lmenu");
                else
                    sendDialogResponse(dialogId, 1, prevList, "");
                end
            else
                morg.pool[tonumber(check.morg)].error_first = false;
                morg.pool[tonumber(check.morg)].check = 2;

                sendMessage("/lmenu");
            end
        elseif ((not nextList) and (not prevList)) then
            morg.pool[tonumber(check.morg)].error_first = false;
            morg.pool[tonumber(check.morg)].check = 2;

            sendMessage("/lmenu");
        end
    end

    if (dialogId == 2016) then
        if (check.morg) then
            morg.pool[tonumber(check.morg)].error_stats = morg.pool[tonumber(check.morg)].error_stats + 1;
            sendDialogResponse(dialogId, 0, -1, "");
        end
    end

    if (dialogId == 3869) then
        if (check.morg) then
            local count = 1;

            for line in text:gmatch("[^\n]+") do
                local money = line:match("{%x+}.*%s*{%x+}(%d+)%$$");
                if (money) then
                    morg.pool[tonumber(check.morg)].ranks[tonumber(count)].salary = tonumber(money);
                    count = count + 1;
                end
            end
            morg.pool[tonumber(check.morg)].process = false;
        end
    end

    if (dialogId == 10000) then
        if (check.offForms and check.offForms.form == "votestart") then
            if (check.offForms.step == 0) then
                local action = findListInDialog(text, style, "Завершить");

                if (action) then
                    local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Голосование уже запущено.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    check.offForms = nil;
                    offForms.process = false;
                    offForms.widget = {};
                else
                    action = findListInDialog(text, style, "Кандидатов:");
                    sendDialogResponse(dialogId, 1, action, "");
                end
            elseif (check.offForms.step == 2) then
                local action = findListInDialog(text, style, "Часов до окончания:");
                sendDialogResponse(dialogId, 1, action, "");
            elseif (check.offForms.step == 3) then
                local action = findListInDialog(text, style, "Наименование:");
                sendDialogResponse(dialogId, 1, action, "");
            elseif (check.offForms.step == 4) then
                local action = findListInDialog(text, style, "Ограничение по IP:");
                sendDialogResponse(dialogId, 1, action, "");
            elseif (check.offForms.step == 5) then
                local action = findListInDialog(text, style, "Ограничение по уровню:");
                sendDialogResponse(dialogId, 1, action, "");
            elseif (check.offForms.step == 6) then
                local action = findListInDialog(text, style, "Статус:");
                sendDialogResponse(dialogId, 1, action, "");
            end
        elseif (check.offForms and check.offForms.form == "votestop") then
            local action = findListInDialog(text, style, "Завершить");

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            else
                local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Голосование не запущено.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                mysqlQuery(query);

                check.offForms = nil;
                offForms.process = false;
                offForms.widget = {};
            end
        end
    end

    if (dialogId == 10001) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 6) then
                check.offForms.step = 7;
                sendDialogResponse(dialogId, 1, 0, "");
            end
        elseif (check.offForms.form == "votestop") then
            sendDialogResponse(dialogId, 1, 0, "");
        end
    end

    if (dialogId == 10003) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 3) then
                check.offForms.step = 4;
                sendDialogResponse(dialogId, 1, 0, check.offForms.name);
            end
        end
    end

    if (dialogId == 10004) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 0) then
                local count = 0;

                for line in text:gmatch("[^\n]+") do
                    count = count + 1;
                end

                if (count >= 3) then
                    sendDialogResponse(dialogId, 1, 1, "");
                else
                    check.offForms.step = 1;

                    local action = findListInDialog(text, style, "Добавить кандидата");
                    sendDialogResponse(dialogId, 1, action, "");
                end
            elseif (check.offForms.step == 1) then
                table.remove(check.offForms.nicknames, 1);

                if (#check.offForms.nicknames >= 1) then
                    local action = findListInDialog(text, style, "Добавить кандидата");
                    sendDialogResponse(dialogId, 1, action, "");
                else
                    check.offForms.step = 2;

                    sendDialogResponse(dialogId, 0, 0, "");
                end
            end
        end
    end

    if (dialogId == 10005) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 1) then
                sendDialogResponse(dialogId, 1, 0, check.offForms.nicknames[1]);
            end
        end
    end

    if (dialogId == 10006) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 0) then
                local action = findListInDialog(text, style, "Удалить кандидата");
                sendDialogResponse(dialogId, 1, action, "");
            end
        end
    end

    if (dialogId == 10008) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 0) then
                sendDialogResponse(dialogId, 1, 0, "");
            end
        end
    end

    if (dialogId == 10009) then
        if (check.offForms.form == "votestart") then
            if (check.offForms.step == 2) then
                check.offForms.step = 3;
                sendDialogResponse(dialogId, 1, 0, check.offForms.time);
            elseif (check.offForms.step == 4) then
                check.offForms.step = 5;
                sendDialogResponse(dialogId, 1, 0, check.offForms.ip);
            elseif (check.offForms.step == 5) then
                check.offForms.step = 6;
                sendDialogResponse(dialogId, 1, 0, check.offForms.level);
            end
        end
    end

    if (dialogId == 15059) then
        if (check.offForms.form == "rasform") then
            sendDialogResponse(dialogId, 1, check.offForms.type, "");
        end
    end

    if (dialogId == 15087) then
        if (check.offForms.form == "unleader") then
            local nickname = text:match("Вы уверены что хотите снять {ffff00}(%S+) {ffffff}с поста лидера организации");

            if (nickname) then
                sendDialogResponse(dialogId, 1, 0, "");
            end
        end
    end

    if (dialogId == 25221) then
        local next = findListInDialog(text, style, "Следующая страница");
        local prev = findListInDialog(text, style, "Предыдущая страница");

        for line in text:gmatch("[^\n]+") do
            local name, id, money = line:match("^{%x%x%x%x%x%x}(.-)%[(%d+)%]\t(%d+)%$\t%[.+%]$")

            if (name) then
                table.insert(businesses_mafia.pool, {
                    name = name,
                    id = tonumber(id),
                    money = tonumber(money),
                    organization = check.businesses_mafia,
                    found = false
                })
            end
        end

        if (prev and next) then
            sendDialogResponse(dialogId, 1, next, "");
        elseif (next and (not prev)) then
            sendDialogResponse(dialogId, 1, next, "");
        elseif ((not next) and prev) then
            check.businesses_mafia = true;
        elseif ((not next) and (not prev)) then
            check.businesses_mafia = true;
        end
    end

    if (dialogId == 25526) then
        sendDialogResponse(dialogId, 1, 0, "");
    end

    if (dialogId == 25310) then -- /gps
        if (check.morg == 'gps') then
            local action = findListInDialog(text, style, 'Поиск');

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            end
        end
    end
    if (dialogId == 26368) then
        if (check.licenses.sellid) then
            sendDialogResponse(dialogId, 1, check.licenses.sellid, "");
        end
    end

    if (dialogId == 26369) then
        sendDialogResponse(dialogId, 1, 0, "");
    end

    if (dialogId == 26526) then -- /props
        local count = 0;

        if (check.props == "props") then
            for line in text:gmatch("[^\n]+") do
                count = count + 1;
                local id, nick, time, date = line:match("№(%d+)%s*(%S+)%s*%[ (%d+:%d+) ([%d%.]+) %]");

                if (id) then
                    local day, month, year = date:match("(%d+).(%d+).(%d+)");
                    local hour, minute = time:match("(%d+):(%d+)");

                    local timestamp = os.time({year=year, month=month, day=day, hour=hour, min=minute, sec=0});
                    local current_timestamp = os.time();

                    local type = -1;
                    if (line:find("Дом")) then
                        type = 0;
                    elseif (line:find("Бизнес")) then
                        type = 1;
                    end
                    table.insert(props.pool, {
                        id = tonumber(id),
                        type = tonumber(type),
                        owner = nick,
                        sell = (props.days ~= 0) and (current_timestamp - timestamp >= props.days * 24 * 60 * 60),
                        time = timestamp
                    });
                end
            end
            check.props = 'check';
        end
    end

    if (dialogId == 26527) then -- Диалог деталей имущества при верификации
        if (type(check.props) == "table") then
            local propsType, id = text:match("Имущество:%s*(%S+) №(%d+)");

            if (text:find("Дом")) then
                propsType = 0;
            elseif (text:find("Бизнес")) then
                propsType = 1;
            end

            if ((propsType == check.props.type) and (tonumber(id) == check.props.id)) then
                local action = findListInDialog(text, style, check.props.action);

                if (action) then
                    sendDialogResponse(dialogId, 1, action, "");
                end
            end
        elseif (check.offForms and check.offForms.form == "props") then
            local propsType, id = text:match("Имущество:%s*(%S+) №(%d+)");

            if (text:find("Дом")) then
                propsType = 0;
            elseif (text:find("Бизнес")) then
                propsType = 1;
            end

            if ((propsType == check.offForms.type) and (tonumber(id) == check.offForms.id)) then
                local action = findListInDialog(text, style, check.offForms.action);
                if (action) then
                    sendDialogResponse(dialogId, 1, action, "");
                end
            end
        end
    end

    if (dialogId == 26528) then -- Диалог подтверждения верификации
        if (type(check.props) == "table") then
            local propsType, id = text:match("Имущество:%s*(%S+) №(%d+)");

            if (propsType == "Дом") then
                propsType = 0;
            elseif (propsType == "Бизнес") then
                propsType = 1;
            end

            if ((propsType == check.props.type) and (tonumber(id) == check.props.id) and (check.props.action == "Подтвердить верификацию")) then
                sendDialogResponse(dialogId, 1, -1, "");
            end
        elseif (check.offForms.form == "props") then
            local propsType, id = text:match("Имущество:%s*(%S+) №(%d+)");

            if (text:find("Дом")) then
                propsType = 0;
            elseif (text:find("Бизнес")) then
                propsType = 1;
            end

            if ((propsType == check.offForms.type) and (tonumber(id) == check.offForms.id) and (check.offForms.action == "Подтвердить верификацию")) then
                sendDialogResponse(dialogId, 1, -1, "");

                check.offForms = nil;
            end
        end
    end

    if (dialogId == 26529) then -- Диалог отклонения верификации
        if (type(check.props) == "table") then
            local propsType, id = text:match("Имущество:%s*(%S+) №(%d+)");

            if (propsType == "Дом") then
                propsType = 0;
            elseif (propsType == "Бизнес") then
                propsType = 1;
            end

            if ((propsType == check.props.type) and (tonumber(id) == check.props.id) and (check.props.action == "Отклонить верификацию")) then
                sendDialogResponse(dialogId, 1, -1, "");
            end
        elseif (check.offForms.form == "props") then
            local propsType, id = text:match("Имущество:%s*(%S+) №(%d+)");

            if (text:find("Дом")) then
                propsType = 0;
            elseif (text:find("Бизнес")) then
                propsType = 1;
            end

            if ((propsType == check.offForms.type) and (tonumber(id) == check.offForms.id) and (check.offForms.action == "Отклонить верификацию")) then
                sendDialogResponse(dialogId, 1, -1, "");

                check.offForms = nil;
            end
        end
    end

    if (dialogId == 26583) then -- Список залогов
        if (check.pledge == "pledge") then
            if (#pledge.pool == 0) then
                for line in text:gmatch("[^\n]+") do
                    local nick, guarantor, money = line:match("^{C0C0C0}%[%d+%] {FFFFFF}(%S+)%s+(%S+)%s+%$(%d+)$");

                    if (nick) then
                        table.insert(pledge.pool, {
                            nickname = nil,
                            author = nil,
                            admin = nil,
                            reason = nil,
                            money = 0,
                            time_ban = 0,
                            time_unban = 0
                        });
                    end
                end
            end

            if (pledge.action + 1 <= #pledge.pool) then
                for line in text:gmatch("[^\n]+") do
                    local nick, guarantor, money = line:match("^{C0C0C0}%[%d+%] {FFFFFF}(%S+)%s+(%S+)%s+%$(%d+)$");

                    if (nick) then
                        sendDialogResponse(dialogId, 1, pledge.action, "");
                        pledge.action = pledge.action + 1;
                        break;
                    end
                end
            else
                check.pledge = nil;
            end
        end

        if (type(check.pledge) == "table") then
            local action = findListInDialog(text, style, check.pledge.author .. "%s+" .. check.pledge.nickname .. "%s+%$" .. check.pledge.money);

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            else
                local query = ("UPDATE `arizona`.pledge_system SET `expired` = 1, `passed` = 1, `time_passed` = DEFAULT WHERE `server_id` = %d AND `pledge_id` = %d;"):format(server_id, check.pledge.pledge_id);
                AsyncMysqlQuery(query);

                check.pledge = nil;
            end
        end
    end

    if (dialogId == 26584) then -- Решение по залогу
        if (type(check.pledge) == "table") then
            local action;

            if (check.pledge.action == 0) then
                action = findListInDialog(text, style, "Отказать");
            else
                action = findListInDialog(text, style, "Одобрить");
            end

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            end
        end
    end

    if (dialogId == 26587) then -- Информация о залоге
        local nick = text:match("Ник заблокированного: {E9967A}([%w_]+)");
        local admin = text:match("Кто заблокировал: {E9967A}([%w_]+)");
        local reason = text:match("Причина: {E9967A}([^\n]+)"):gsub("\\n", "");
        local ban_date = text:match("Дата бана: {E9967A}([%d%-: ]+)");
        local unban_date = text:match("Дата разбана: {E9967A}([%d%-: ()дн.]+)");
        local guarantor = text:match("Залогодержатель: {E9967A}([%w_]+)");
        local bail = text:match("Сумма залога: {E9967A}%$(%d+)");

        if (check.pledge == "pledge") then
            if (nick) then
                local year, month, day, hour, min, sec = ban_date:match("(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)");
                ban_date = os.time({
                    year = tonumber(year),
                    month = tonumber(month),
                    day = tonumber(day),
                    hour = tonumber(hour),
                    min = tonumber(min),
                    sec = tonumber(sec)
                });

                year, month, day, hour, min, sec = unban_date:match("(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)");
                unban_date = os.time({
                    year = tonumber(year),
                    month = tonumber(month),
                    day = tonumber(day),
                    hour = tonumber(hour),
                    min = tonumber(min),
                    sec = tonumber(sec)
                });

                pledge.pool[pledge.action].nickname = nick;
                pledge.pool[pledge.action].author = guarantor;
                pledge.pool[pledge.action].admin = admin;
                pledge.pool[pledge.action].reason = reason;
                pledge.pool[pledge.action].money = tonumber(bail);
                pledge.pool[pledge.action].time_ban = ban_date;
                pledge.pool[pledge.action].time_unban = unban_date;

                sendDialogResponse(dialogId, 0, 0, "");
            end
        end

        if (type(check.pledge) == "table") then
            if (nick == check.pledge.nickname) then
                sendDialogResponse(dialogId, 1, 0, "");
            else
                local query = ("UPDATE `arizona`.pledge_system SET `expired` = 1, `passed` = 1, `time_passed` = DEFAULT WHERE `server_id` = %d AND `pledge_id` = %d;"):format(server_id, check.pledge.pledge_id);
                AsyncMysqlQuery(query);

                check.pledge = nil;
            end
        end
    end

    if (dialogId == 26769) then -- /gps диалог поиска
        if (check.morg == 'gps') then
            sendDialogResponse(dialogId, 1, 0, "%[ЧАСТНАЯ%]");
        end
    end

    if (dialogId == 26778) then -- /gps После поиска
        if (check.morg == 'gps') then
            local count = 0;

            for line in text:gmatch("[^\n]+") do
                count = count + 1;

                for _, organization in ipairs(core.orgs.list) do
                    if (organization.gps_line and (count == organization.gps_line + 1)) then
                        local family = line:match("%[ Владеет:%s*([^%]]+)%s*%]");

                        if (family) then
                            morg.pool[organization.id].owner.family = family:trim();
                            sendMessage("/checkfam " .. family:trim());
                        end
                        break;
                    end
                end
            end
        end
    end

    if (dialogId == 27091) then -- /apanel
        if (check.mpdonate) then
            local action = findListInDialog(text, style, "Фонд мероприятий");

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            end
        end

        if (check.offForms) then
            if (check.offForms.form == "unleader") then
                local action = findListInDialog(text, style, "Лидеры/Снять лидера");

                if (action) then
                    sendDialogResponse(dialogId, 1, action, "");
                end
            elseif (check.offForms.form == "makejudge") then
                local action = findListInDialog(text, style, "Назначить/снять судью");

                if (action) then
                    sendDialogResponse(dialogId, 1, action, "");
                end
            elseif (check.offForms.form == "unjudge") then
                local action = findListInDialog(text, style, "Назначить/снять судью");

                if (action) then
                    sendDialogResponse(dialogId, 1, action, "");
                end
            end
        end

        if (check.morg == "judges") then
            local action = findListInDialog(text, style, "Назначить/снять судью");

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            end
        end
    end

    if (dialogId == 27151) then -- /apanel -> Транспорт диалог
        local list = findListInDialog(text, style, "Спавн Транспорта");

        if (check.spawncars) then
            if (list) then
                sendDialogResponse(dialogId, 1, list, "");
            end
        end
    end

    if (dialogId == 27158) then
        if (check.offForms) then
            if (check.offForms.form == "makejudge") then
                local action = findListInDialog(text, style, check.offForms.nickname);

                if (action) then
                    local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Игрок уже является судьёй.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    check.offForms = nil;
                    offForms.process = false;
                    offForms.widget = {};
                else
                    action = findListInDialog(text, style, "Свободный слот");

                    if (action) then
                        sendDialogResponse(dialogId, 1, action, "");
                    else
                        local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Все слоты судей заняты.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        check.offForms = nil;
                        offForms.process = false;
                        offForms.widget = {};
                    end
                end
            elseif (check.offForms.form == "unjudge") then
                local action = findListInDialog(text, style, check.offForms.nickname);

                if (action) then
                    sendDialogResponse(dialogId, 1, action, "");
                else
                    local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Игрок не является судьёй.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    check.offForms = nil;
                    offForms.process = false;
                    offForms.widget = {};
                end
            end
        end

        if (check.morg == "judges") then
            for line in text:gmatch("[^\n]+") do
                if (line:find("Свободный слот")) then
                    local num = line:match("{ff6666}%[(%d+)%]");

                    morg.judges[tonumber(num)] = {
                        nickname = nil,
                        date = 0
                    };
                else
                    local num, name, time, date = line:match("%[(%d+)%]%s+{ffffff}([%w_]+)%s+{CCCCCC}%[%s*([%d]+:%d+)%s+([%d]+%.%d+%.%d+)%s*%]");

                    if (name) then
                        local hour, min = time:match("(%d+):(%d+)");
                        local day, month, year = date:match("(%d+)%.(%d+)%.(%d+)");

                        hour = tonumber(hour);
                        min = tonumber(min);
                        day = tonumber(day);
                        month = tonumber(month);
                        year = tonumber(year);

                        local date_table = {
                            day = day,
                            month = month,
                            year = year,
                            hour = hour,
                            min = min,
                            sec = 0
                        };

                        local unix_time = os.time(date_table);

                        morg.judges[tonumber(num)] = {
                            nickname = name,
                            date = unix_time
                        };
                    end
                end
            end
        end
    end

    if (dialogId == 27159) then
        if (check.offForms.form == "makejudge") then
            sendDialogResponse(dialogId, 1, 0, check.offForms.nickname);
        end
    end

    if (dialogId == 27160) then
        if (check.offForms.form == "makejudge") then
            sendDialogResponse(dialogId, 1, 0, "");
        end
    end

    if (dialogId == 27161) then
        if (check.offForms.form == "unjudge") then
            sendDialogResponse(dialogId, 1, 0, "");
        end
    end

    if (dialogId == 27236) then -- /svrnt dialog
        local build = text:match("Build: (.+)");

        if (build) then
            server_stats.build = build:trim();
        end
    end

    if (dialogId == 27285) then
        if (check.mpdonate) then
            local action = findListInDialog(text, style, "Прорекламировать фонд");

            if (action) then
                sendDialogResponse(dialogId, 1, action, "");
            end
        end
    end

    if (dialogId == 27295) then
        if (check.mpdonate) then
            check.mpdonate = nil;

            sendDialogResponse(dialogId, 1, -1, "");
        end
    end

    if (not settings.debug) then
        return false;
    end
end

function sampev.onServerMessage(color, text)
    if (text:find("%[A%] Вы успешно авторизовались как {%x+}(.*)")) then
        sendMessage('/ticks');
        set_bot_position();

        local adm_rank = text:match("%[A%] Вы успешно авторизовались как {%x+}(.*)");
        for i, v in pairs(admin_ranks) do
            if (i == adm_rank) then
                if (settings.bot_admin_lvl ~= v) then
                    local query = ("UPDATE `arizona`.servers_raksamp SET `bot_admin_lvl` = %d WHERE `server_id` = %d;"):format(v, server_id);
                    AsyncMysqlQuery(query);
                end
            end
        end
    end

    if (text:find("%[(%d+)%]%s+([^|]+)%s+|%s+Уровень:%s+(%d+)%s+|%s+UID:%s+(%d+)%s+|%s+packetloss:%s+([%d%.]+)%s+%((.-)%)")) then
        local id, nickname, level, uid, packetloss, client = text:match("%[(%d+)%]%s+([^|]+)%s+|%s+Уровень:%s+(%d+)%s+|%s+UID:%s+(%d+)%s+|%s+packetloss:%s+([%d%.]+)%s+%((.-)%)");
        packetloss = packetloss:gsub(",", ".");
        packetloss = tonumber(packetloss);

        if (nickname) then
            if (nickname == getBotNick()) then
                server_stats.packetloss = packetloss;
            end
        end
    end

    if (text:find("^%[Жалоба%] от .-%[(%d+)%]:{%x+} (.+)")) then
        local player_id, data = text:match("^%[Жалоба%] от .-%[(%d+)%]:{%x+} (.+)");

        if (player_id) then
            local text, queue = data:match("(.-)%. Уже (%d+) жалоб[аы]?!!!$");

            if (text) then
                server_stats.admins.report = tonumber(queue);
            else
                server_stats.admins.report = server_stats.admins.report + 1;
            end
        end
    end

    if (text:find("%[A%] (%S+)%[%d+%] %-> (%S+)%[%d+%]:{%x%x%x%x%x%x}.*")) then
        local nickname, nickname2 = text:match("%[A%] (%S+)%[%d+%] %-> (%S+)%[%d+%]:{%x%x%x%x%x%x}.*");
        local time = os.time();

        local playerId = getPlayerIdByNickname(nickname);

        if (server_stats.admins.report > 0) then
            server_stats.admins.report = server_stats.admins.report - 1;
        end

        if (playerId ~= -1) then
            if (not server_stats.admins.idle[playerId]) then
                table.insert(server_stats.admins.idle, playerId, {
                    nickname = nickname,
                    last = time
                });
            end

            if (server_stats.admins.idle[playerId].nickname == nickname) then
                server_stats.admins.idle[playerId].last = time;
            else
                server_stats.admins.idle[playerId] = {
                    nickname = nickname,
                    last = time
                };
            end
        end
    end

    if (text:find("^%[A%] (%S+)%[(%d+)%] заспавнил транспорт!")) then
        local nick, id = text:match("^%[A%] (%S+)%[(%d+)%] заспавнил транспорт!");

        if (nick ~= getBotNick()) then
            settings.last_respawn_cars = os.time();

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_respawn_cars` = %d WHERE `server_id` = %d;"):format(settings.last_respawn_cars, server_id);
            AsyncMysqlQuery(query);
        end
    end

    if (text:find("^Nick %[(.+)%]%s+R%-IP%s+%[([%d%.]+)%]%s+IP%s+|%s+A%-IP%s+%[{%x%x%x%x%x%x}([%d%.]+)%s+|%s+")) then
        local nick, regip, lastip = text:match("^Nick %[(.+)%]%s+R%-IP%s+%[([%d%.]+)%]%s+IP%s+|%s+A%-IP%s+%[{%x%x%x%x%x%x}([%d%.]+)%s+|%s+");

        if (check.accepts) then
            if (nick == check.accepts.admin) then
                local query = ("UPDATE `arizona`.accept_system SET `getip` = %d, `regip` = '%s', `lastip` = '%s' WHERE `accept_id` = %d AND `server_id` = %d;"):format(1, regip, lastip, check.accepts.accept_id, server_id);
                AsyncMysqlQuery(query);
            else
                local query = ("UPDATE `arizona`.accept_system SET `denied` = %d, `time_denied` = DEFAULT WHERE `accept_id` = %d AND `server_id` = %d;"):format(1, check.accepts.accept_id, server_id);
                AsyncMysqlQuery(query);
            end

            check.accepts = nil;
        end

        if (nick) then
            getip.nick = nick;
            getip.data[1].ip = regip;
            getip.data[2].ip = lastip;

            getip.get_ip();
        end
		
		if check.offForms.form == "antibot" and nick == check.offForms.nick == nick then
			if lastip == check.offForms.ip then
				query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
				mysqlQuery(query);

				check.offForms = nil;
				offForms.process = false;
				offForms.widget = {};
			else
				sendMessage("/skick " .. nick)
			end
		end
		
        if (not settings.debug) then
            return false;
        end
    end

    if (text:find("^Переводить деньги можно раз в минуту!")) then
        check.offForms = nil;
        offForms.process = false;
        offForms.widget = {};
    end

    if (text:find("([%w_]+)%[ID: (%d+)%] | ([%d%.%-]+), ([%d%.%-]+), ([%d%.%-]+), ([%d%.%-]+) | State: (%d+), Int: (%d+), Vw: (%d+), VehicleID: (%d+)")) then
        local nickname, id, x_position, y_position, z_position, quaternion, state, int, vw, vehicle = text:match("([%w_]+)%[ID: (%d+)%] | ([%d%.%-]+), ([%d%.%-]+), ([%d%.%-]+), ([%d%.%-]+) | State: (%d+), Int: (%d+), Vw: (%d+), VehicleID: (%d+)");
        local isOnSpawn = false;
        x_position = tonumber(x_position);
        y_position = tonumber(y_position);
        z_position = tonumber(z_position);
        quaternion = tonumber(quaternion);
        state = tonumber(state);
        int = tonumber(int);
        vw = tonumber(vw);
        vehicle = tonumber(vehicle);

        if ((int == 0) and (vw == 0)) then
            for i, v in ipairs(core.bot_bandit.positions) do
                if (getDistanceBetweenCoords3d(x_position, y_position, z_position, v.x, v.y, v.z) <= v.range) then
                    isOnSpawn = true;
                end
            end
        end

        if (bot_bandit.players[getPlayerIdByNickname(nickname)]) then
            if (bot_bandit.players[getPlayerIdByNickname(nickname)].nickname == nickname) then
                if (isOnSpawn) then
                    if (getDistanceBetweenCoords3d(x_position, y_position, z_position, bot_bandit.players[getPlayerIdByNickname(nickname)].position.x, bot_bandit.players[getPlayerIdByNickname(nickname)].position.y, bot_bandit.players[getPlayerIdByNickname(nickname)].position.z) <= 2) then
                        bot_bandit.players[getPlayerIdByNickname(nickname)].repeats = bot_bandit.players[getPlayerIdByNickname(nickname)].repeats + 1;
                    else
                        bot_bandit.players[getPlayerIdByNickname(nickname)].repeats = 0;
                    end
                end
            else
                bot_bandit.players[getPlayerIdByNickname(nickname)] = {
                    nickname = nickname,
                    position = {
                        x = x_position,
                        y = y_position,
                        z = z_position,
                    },
                    repeats = 0
                };
            end

            if (bot_bandit.players[getPlayerIdByNickname(nickname)].repeats >= 5) then
                bot_bandit.players[getPlayerIdByNickname(nickname)].repeats = 0;
                sendMessage("/setvw " .. getPlayerIdByNickname(nickname) .. " 1");
                sendMessage("/pm " .. getPlayerIdByNickname(nickname) .. " 1 Вы были автоматически телепортированы в виртуальный мир из-за подозрений в прокачивании промокода.");
            end
        else
            table.insert(bot_bandit.players, getPlayerIdByNickname(nickname), {
                nickname = nickname,
                position = {
                    x = x_position,
                    y = y_position,
                    z = z_position,
                },
                repeats = 0
            });
        end
    end

    if (text:find("%[Ошибка%] %{ffffff%}Доступ к управлению фондом мероприятий имеют администраторы от (%d+) уровня.")) then
        if (check.mpdonate) then
            check.mpdonate = nil;
        end
    end

    if (text:find("%[Ошибка%] {FFFFFF}Нет членов организации в сети!")) then
        if check.morg and morg.pool[tonumber(check.morg)].check == 1 then
            morg.pool[tonumber(check.morg)].error_first = false;
            morg.pool[tonumber(check.morg)].check = 2;
            sendMessage("/lmenu");
        end
    end

    if (text:find("^%[(.-)%] Лидер (%S*)%[id: (%d+)], Замы: (%d+) чел, Состав: (%d+) чел %(из них афк: (%d+)%)")) then
        local fraction, leader, leader_id, zams, online, afk = string.match(text, "^%[(.-)%] Лидер (%S*)%[id: (%d+)], Замы: (%d+) чел, Состав: (%d+) чел %(из них афк: (%d+)%)")

        if (fraction) then
            for id, v in ipairs(core.orgs.list) do
                if (v.stats == fraction) then
                    if (leader == "Свободна" or leader:isSpace()) then
                        morg.pool[tonumber(v.id)].leader.status = 0;
                        morg.pool[tonumber(v.id)].leader.nick = nil;
                        morg.pool[tonumber(v.id)].leader.id = 0;
                    else
                        if (getPlayerIdByNickname(leader) == -1) then
                            morg.pool[tonumber(v.id)].leader.status = 0;
                        else
                            morg.pool[tonumber(v.id)].leader.status = 1;
                        end
                        morg.pool[tonumber(v.id)].leader.nick = leader;
                        morg.pool[tonumber(v.id)].leader.id = leader_id == "65535" and -1 or tonumber(leader_id);

                        table.insert(morg.pool[tonumber(v.id)].ranks[10].pool, {
                            nickname = leader,
                            rank = 10,
                            rank_name = '',
                            last = 0,
                            days = 0
                        });
                    end

                    morg.pool[tonumber(v.id)].zams = tonumber(zams);
                    morg.pool[tonumber(v.id)].online = tonumber(online)
                    morg.pool[tonumber(v.id)].afk = tonumber(afk);

                    break;
                end
            end
        end
    end

    if (text:find("Семья:%s*([^%[%]]+)%s*%[(%d+)%]%s*%{[^%}]*%}%s*Количество участников:%s*(%d+)")) then
        local family, id, count = text:match("Семья:%s*([^%[%]]+)%s*%[(%d+)%]%s*%{[^%}]*%}%s*Количество участников:%s*(%d+)");

        if (family) then
            check.gps = family:trim();
        end
    end
    
    if (text:find("Лидер:%s*([^,]+),%s*Зам1:%s*([^,]+),%s*Зам2:%s*([^,]+),%s*Зам3:%s*([^,]+)")) then
        local leader, zam1, zam2, zam3 = text:match("Лидер:%s*([^,]+),%s*Зам1:%s*([^,]+),%s*Зам2:%s*([^,]+),%s*Зам3:%s*([^,]+)");

        if (leader) then
            for id, organization in ipairs(morg.pool) do
                if (organization.owner.family == check.gps) then
                    morg.pool[id].owner.leader = leader:trim();

                    for _, zam in ipairs({zam1, zam2, zam3}) do
                        if (zam:trim() ~= "The State") then
                            table.insert(morg.pool[id].owner.zams, zam:trim());
                        end
                    end

                    break;
                end
            end
        end
    end

    if (text:find("(%S+) %[%d+%] купил (.-) ID: (%d+) по гос. цене за ([0-9%.]+) ms! %(old%)")) then
        local nick, property, id, captcha = text:match("(%S+) %[%d+%] купил (.-) ID: (%d+) по гос. цене за ([0-9%.]+) ms! %(old%)");
        if (settings.property_purchase_system and captcha) then
            sendMessage(("/pm %s 1 Поздравляю! Скорее предоставьте опровержение на покупку %sа №%s (капча: %s ms)."):format(nick, property, id, captcha));
        end
    end

    if (text:find("^(%S+)%[%d+%] говорит:{B7AFAF} (.*)$")) then
        local nick, msg = text:match("^(%S+)%[%d+%] говорит:{B7AFAF} (.*)$");
        if (settings.license_system and msg and license.sellLicenses) then
            for i, v in pairs(license.types) do
                if (msg:lower():find(v.phrase)) then
                    local licenseId = i;
                    check.licenses = {
                        sellid = licenseId
                    };
                    sendMessage("/givelicense " .. nick);
                    break;
                end
            end
        end
    end

    if (text:find("^%[Информация%] {FFFFFF}Вы предложили (%S+) купить лицензию на '(.*)' за %$(.*), сроком на %d+ месяцев$")) then
        local nick, license, price = text:match("^%[Информация%] {FFFFFF}Вы предложили (%S+) купить лицензию на '(.*)' за %$(.*), сроком на %d+ месяцев$");
        if (settings.license_system and price) then
            check.licenses = {
                sellName = nick,
                sellPrice = price,
                sellLicense = license,
                sellid = check.licenses.sellid
            };
        end
    end

    if (text:find("^%[Информация%] {FFFFFF}Вы успешно продали лицензию на '(.*)' игроку (%S+)%.$")) then
        local sType, sName = text:match("^%[Информация%] {FFFFFF}Вы успешно продали лицензию на '(.*)' игроку (%S+)%.$");
        if (settings.license_system and sName) then
            sendMessage(("%s, спасибо за приобретение лицензии на '%s'. Удачного дня!"):format(sName, sType));

            local query = ("INSERT INTO `arizona`.license_system SET `server_id` = %d, `license` = %d, `player` = '%s';"):format(server_id, check.licenses.sellid, sName);
            AsyncMysqlQuery(query);

            check.licenses = {};
        end
    end

    if (text:find("^%[Ошибка%] {ffffff}У игрока недостаточно денежных средств!%.")) then
        if (settings.license_system and check.licenses.sellName and check.licenses.sellPrice and check.licenses.sellLicense) then
            local message = ("%s, у вас недостаточно денег для приобретения лицензии на '%s'. Возвращайтесь, как накопите %d!"):format(check.licenses.sellName, check.licenses.sellLicense, check.licenses.sellPrice);
            sendMessage(message);
            check.licenses = {};
        end
    end

    if (text:find("^%[Ошибка%] {ffffff}Список ожидающих решений пуст.")) then
        if (check.pledge) then
            local query = ("UPDATE `arizona`.pledge_system SET `expired` = %d, `passed` = %d, `time_passed` = DEFAULT WHERE `server_id` = %d AND `passed` = 0 AND `expired` = 0 AND `edited` = 0;"):format(1, 1, server_id);
            AsyncMysqlQuery(query);

            check.pledge = nil;
        end

        if (type(check.pledge) == "table") then
            local query = ("UPDATE `arizona`.pledge_system SET `expired` = %d, `passed` = %d, `time_passed` = DEFAULT WHERE `server_id` = %d AND `pledge_id` = %d;"):format(1, 1, server_id, check.pledge.pledge_id);
            AsyncMysqlQuery(query);

            check.pledge = nil;
        end
    end

    if (text:find("^%[Ошибка%] {ffffff}Сейчас нет имущества ожидающего верификации.")) then
        if (check.props) then
            --local query = ("DELETE FROM `arizona`.properties_system WHERE `server_id` = %d"):format(server_id);
            --AsyncMysqlQuery(query);

            check.props = nil;
        end
    end

    if (text:find("^%[Информация%] {ffffff}Вы одобрили залог на игрока (%S+), в размере %$(%d+), игрок разблокирован%.$")) then
        local nickname, money = text:match("^%[Информация%] {ffffff}Вы одобрили залог на игрока (%S+), в размере %$(%d+), игрок разблокирован%.$");

        if (type(check.pledge) == "table") then
            if (nickname == check.pledge.nickname) then
                local query = ("UPDATE `arizona`.pledge_system SET `expired` = %d, `passed` = %d, `time_passed` = DEFAULT WHERE `server_id` = %d AND `pledge_id` = %d;"):format(0, 1, server_id, check.pledge.pledge_id);
                AsyncMysqlQuery(query);

                check.pledge = nil;
            end
        end
    end

    if (text:find("^%[Информация%] {ffffff}Вы отклонили залог на игрока (%S+).$")) then
        local nickname = text:match("^%[Информация%] {ffffff}Вы отклонили залог на игрока (%S+).$");

        if (type(check.pledge) == "table") then
            if (nickname == check.pledge.nickname) then
                local query = ("UPDATE `arizona`.pledge_system SET `expired` = %d, `passed` = %d, `time_passed` = DEFAULT WHERE `server_id` = %d AND `pledge_id` = %d;"):format(0, 1, server_id, check.pledge.pledge_id);
                AsyncMysqlQuery(query);

                check.pledge = nil;
            end
        end
    end

    if (text:find("%[A%] (%S+) назначил игрока (%S+) лидером организации '(.*)'")) then
        local admin, player, organization = text:match("%[A%] (%S+) назначил игрока (%S+) лидером организации '(.*)'");

        if (check.offForms) then
            if (check.offForms.form == "makeleader") then
                if ((player == check.offForms.nickname) and (admin == getBotNick())) then
                    sendMessage("/ao " .. check.offForms.nickname .. "[" .. getPlayerIdByNickname(check.offForms.nickname) .. "] назначен на пост лидера организации '" .. organization .. "'.");
                    sendMessage("/ao Причина: " .. check.offForms.reason .. ".");
                end
            end
        end
    end

    if (text:find("%[Информация%] {FFFFFF}Вы сняли игрока (%S+) с поста лидера")) then
        local player = text:match("%[Информация%] {FFFFFF}Вы сняли игрока (%S+) с поста лидера");

        if (check.offForms) then
            if (check.offForms.form == "unleader") then
                if (player) then
                    sendMessage("/ao " .. player .. "[" .. getPlayerIdByNickname(player) .. "] снят с поста лидера организации '" .. check.offForms.organization_name .. "'.");
                    sendMessage("/ao Причина: " .. check.offForms.reason .. ".");
                end
            end
        end
    end

    if (text:find("^%[(%d+)%] (.-) | (%d+) / (%d+) | Was: %[(%d+)%] | Will be: (.-)$")) then
        local id, owner, coins, money, captured_at, next_war = text:match("^%[(%d+)%] (.-) | (%d+) / (%d+) | Was: %[(%d+)%] | Will be: (.-)$");

        if (id) then
            local enemy, next_war_unix = next_war:match("^(.-) %[(%d+)%]$");
            local status = false;
            id = tonumber(id);
            coins = tonumber(coins) or 0;
            money = tonumber(money) or 0;
            captured_at = tonumber(captured_at) or 0;
            next_war_unix = tonumber(next_war_unix) or 0;

            if (enemy) then
                status = true;
            end

            core.zones.family[id].owner = owner;
            core.zones.family[id].coins = coins;
            core.zones.family[id].money = money;
            core.zones.family[id].captured_at = captured_at;
            core.zones.family[id].next_capture = {
                status = status,
                unix = next_war_unix,
                enemy = enemy
            };

            local query = ("UPDATE `arizona`.gangzones_family_system SET `owner` = %s, `color` = '%s', `coins` = %d, `money` = %d, `last_capture_at` = %d, `next_capture_status` = %d, `next_capture_at` = %d, `next_capture_enemy` = %s WHERE `server_id` = %d AND `zone_id` = %d;"):format(core.zones.family[id].owner and u8("'" .. core.zones.family[id].owner .. "'") or 'NULL', to_hex(ColorConvertU32ToFloat4(core.zones.family[id].color)), core.zones.family[id].coins, core.zones.family[id].money, core.zones.family[id].captured_at, (core.zones.family[id].next_capture.status and 1 or 0), core.zones.family[id].next_capture.unix, core.zones.family[id].next_capture.enemy and u8("'" .. core.zones.family[id].next_capture.enemy .. "'") or 'NULL', server_id, id);
            mysqlQuery(query);
        end

        if (not settings.debug) then
            return false;
        end
    end

    if (text:find("^{%x%x%x%x%x%x}(%S+)%[(%d+)%] %- {%x%x%x%x%x%x}(.-){%x%x%x%x%x%x} | Номер: .+")) then
        local nickname, id, organization = text:match("^{%x%x%x%x%x%x}(%S+)%[(%d+)%] %- {%x%x%x%x%x%x}(.-){%x%x%x%x%x%x} | Номер: .+");

        if (nickname and id and organization) then
            local afk = text:match("AFK: (%d+) секунд");

            if (afk) then
                afk = tonumber(afk);
            end

            if (check.server_stats == "leaders") then
                server_stats.leaders.total = server_stats.leaders.total + 1;
                if (afk) then
                    server_stats.leaders.afk = server_stats.leaders.afk + 1;
                end

                for _, org in ipairs(core.orgs.list) do
                    if (org.stats == organization) then
                        organization = org.id;
                    end
                end

                table.insert(server_stats.leaders.list, {
                    nickname = nickname,
                    id = tonumber(id),
                    organization = organization,
                    afk = afk,
                });
            elseif (check.server_stats == "zams") then
                server_stats.zams.total = server_stats.zams.total + 1;
                if (afk) then
                    server_stats.zams.afk = server_stats.zams.afk + 1;
                end

                for _, org in ipairs(core.orgs.list) do
                    if (org.stats == organization) then
                        organization = org.id;
                    end
                end

                table.insert(server_stats.zams.list, {
                    nickname = nickname,
                    id = tonumber(id),
                    organization = organization,
                    afk = afk,
                });
            end
        end

        if (not settings.debug) then
            return false;
        end
    end

    if (text:find("^%- %- %- %- Совпадение с: [0-9.]+%. %- %- %- %-")) then
        if (type(check.pgetip) == "table") then
            newTask(function()
                wait(350);

                if (#check.pgetip <= 1) then
                    sendMessage("/a Не найдено других аккаунтов, играющих с этого IP в данный момент!");
                else
                    local answer = string.format("Найдено %s %s, играющих с этого IP:", #check.pgetip, plural(#check.pgetip, {
                        "аккаунт",
                        "аккаунта",
                        "аккаунтов"
                    }));

                    sendMessage("/a " .. answer);

                    for i, v in ipairs(check.pgetip) do
                        wait(350);
                        sendMessage("/a " .. v);
                    end
                end

                check.pgetip = nil;
            end)

            if (not settings.debug) then
                return false;
            end
        end
    end

    if (text:find("^%- (%S+)$")) then
        local player = text:match("^%- (%S+)$");

        if (player and color == -89368321) then
            table.insert(check.pgetip, player);

            if (not settings.debug) then
                return false;
            end
        end
    end

    if (text:find("^%[A%] (%S+)%[(%d+)%]: (.*)")) then
        local acNick, acId, acText = text:match("^%[A%] (%S+)%[(%d+)%]: (.*)");

        if (acText) then
            acId = tonumber(acId);
            acNick = acNick:gsub("^%[.*%]", "", 1);

            if (igForms.b and acText:startsWith("/") and (not is_self(acId))) then
                local args = string.split(acText);

                args[1] = string.lower(args[1] or "");

                for _, form in ipairs(igForms.list) do
                    if (args[1] == ("/%s"):format(form.name) and form.send_type >= 2) then
                        local f_plId = form.param_target + 1;
                        local widget = igForms.widget;
                        widget.start_time = os.clock();
                        widget.accepted = nil;
                        widget.admin = {
                            nick = acNick,
                            id = acId
                        };
                        widget.player.id = tonumber(args[f_plId]) or getPlayerIdByNickname(args[f_plId]) or -1;
                        widget.form = table.concat(args, " ");
                        widget.runner = form.runner;
                        widget.match = ("/%s %s"):format(form.name, form.params);
                        igForms.last = widget.form;
                        igForms.show_error = false;
                        igForms.accepted_first = nil;

                        newTask(function()
                            widget.accepted = {
                                os.clock(),
                                true
                            };

                            if (form.name ~= "setmember" and form.name ~= "uval") then
                                sendMessage("/a [Forma] +");
                            else
                                igForms.accepted_first = getBotNick();
                            end

                            local time = os.clock();

                            while (not igForms.accepted_first) do
                                if (os.clock() - time > 3) then
                                    break;
                                end

                                wait(0);
                            end

                            if (igForms.accepted_first == getBotNick()) then
                                widget.runner(widget.form, widget.match);

                                local query = ("INSERT INTO `arizona`.form_ig_system SET `server_id` = %d, `form` = '%s', `sender` = '%s';"):format(server_id, u8(widget.form), acNick);
                                AsyncMysqlQuery(query);

                                wait(3000);
                                igForms.widget.form = nil;
                                igForms.widget.accepted = nil

                                if (not settings.debug) then
                                    return false;
                                end
                            end
                        end)
                    end
                end
            end

            if (acText == "[Forma] +") then
                if (igForms.accepted_first == nil) then
                    igForms.accepted_first = acNick;
                end

                if (igForms.widget.accepted == nil) then
                    igForms.widget.accepted = {
                        os.clock(),
                        false
                    };
                end

                if (not settings.debug) then
                    return false;
                end
            end
        end
    end

    if (text:find("^{%x%x%x%x%x%x}([A-z0-9_]+)%[(%d+)%]")) then
        local isRed = text:find("Начальник") ~= nil;
        local nick, id = text:match("^{%x%x%x%x%x%x}([A-z0-9_]+)%[(%d+)%]");
        local alvl = isRed and "8" or text:match("%[(%d+) lvl%]");
        local recon = text:match("/re (%d+)");
        local afk = text:match("%[AFK: ([%d:]+)");
        local reputation = text:match("Репутация: ([%-%d]+)");

        if (nick and alvl and reputation) then
            local idle = os.time();
            alvl = tonumber(alvl);
            id = tonumber(id);
            reputation = tonumber(reputation);
            recon = tonumber(recon);

            if (afk and afk:find(":")) then
                local params = afk:split(":");

                if (#params == 2) then
                    table.insert(params, 1, 0);
                end

                local h = (tonumber(params[1]) or 0) * 3600;
                local m = (tonumber(params[2]) or 0) * 60;
                local s = tonumber(params[3]) or 0;
                afk = h + m + s;
            else
                afk = tonumber(afk) or 0;
            end

            local found = false;
            local admin = -1;
            for i, v in ipairs(server_stats.admins.list) do
                if (v.nickname == nick) then
                    found = true;
                    admin = i;
                    if (server_stats.admins.idle[admin]) then
                        if (nick == server_stats.admins.idle[admin].nickname) then
                            idle = server_stats.admins.idle[admin].last;
                        else
                            server_stats.admins.idle[admin] = {
                                nickname = nick,
                                last = idle
                            };
                        end
                    else
                        table.insert(server_stats.admins.idle, admin, {
                            nickname = nick,
                            last = idle
                        });
                    end
                end
            end

            if (found) then
                server_stats.admins.list[admin].idle = os.time() - idle;
                server_stats.admins.list[admin].id = id;
                server_stats.admins.list[admin].lvl = alvl;
                server_stats.admins.list[admin].rep = reputation;
                server_stats.admins.list[admin].afk = afk;
                server_stats.admins.list[admin].re = recon;
            else
                table.insert(server_stats.admins.list, {
                    nickname = nick,
                    id = id,
                    idle = os.time() - idle,
                    lvl = alvl,
                    rep = reputation,
                    afk = afk,
                    re = recon,
                    is_self = is_self(id)
                });
            end

            if (not settings.debug) then
                return false;
            end
        end
    end

    if (igForms.widget.accepted and igForms.widget.accepted[2] and (not igForms.show_error) and (igForms.accepted_first == getBotNick())) then
        for i, v in ipairs(igForms.errors) do
            if (text:find(v.error)) then
                igForms.show_error = true;
                sendMessage("/a @" .. igForms.widget.admin.nick .. ", " .. v.answer);
                break;
            end
        end
    end

    if (offForms.widget.form) then
        for i, v in ipairs(offForms.list) do
            if (v.name == offForms.widget.form_name) then
                local query;
                for j, z in ipairs(v.errors) do
                    if (text:match(z.error)) then
                        query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8(z.answer) .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        check.offForms = nil;
                        offForms.process = false;
                        offForms.widget = {};
                    end
                end

                for j, z in ipairs(v.success) do
                    if (text:match(z)) then
                        if (check.offForms and (not check.offForms.notLast)) then
                            query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                            mysqlQuery(query);

                            check.offForms = nil;
                            offForms.process = false;
                            offForms.widget = {};
                        elseif (not check.offForms) then
                            query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. offForms.widget.form_id .. " AND `server_id` = " .. server_id .. ';';
                            mysqlQuery(query);

                            check.offForms = nil;
                            offForms.process = false;
                            offForms.widget = {};
                        end
                    end
                end

                break;
            end
        end
    end

    if (compensations.widget.form) then
        for i, v in ipairs(compensations.list) do
            if (v.name == compensations.widget.form_name) then
                local query;
                for j, z in ipairs(v.errors) do
                    if (text:match(z.error)) then
                        query = "UPDATE `arizona`.compensations_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8(z.answer) .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `compensation_id` = " .. compensations.widget.compensation_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        compensations.process = false;
                        compensations.widget = {};
                    end
                end

                for j, z in ipairs(v.success) do
                    if (text:match(z)) then
                        query = "UPDATE `arizona`.compensations_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `compensation_id` = " .. compensations.widget.compensation_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        sendMessage("/notif " .. compensations.widget.player .. " Заявка на компенсацию по жалобе №" .. compensations.widget.complaintId .. " была одобрена администратором " .. compensations.widget.administrator .. ".");

                        compensations.process = false;
                        compensations.widget = {};
                    end
                end

                break;
            end
        end
    end

    if (check.recovery_fraction) then
        if (text:find("%[A%] %S+%[ID: %d+%] устроил %S+ %[%d+%] в .* на %d+ ранг%. Причина: .*")) then
            local query = "UPDATE `arizona`.recovery_fraction_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. check.recovery_fraction.uid .. " AND `server_id` = " .. server_id .. ';';
            mysqlQuery(query);

            sendMessage("/notif " .. check.recovery_fraction.player .. " Заявка на восстановление во фракции по жалобе №" .. check.recovery_fraction.complaintId .. " была одобрена администратором " .. check.recovery_fraction.administrator .. ".");

            check.recovery_fraction = nil;
        end

        if (text:find("^%[Подсказка%] {ffffff}%/setmember %[id игрока%] %[id организации %(1%-32%)%] %[ранг %(1%-9%)%] %[причина%]$")) then
            local query = "UPDATE `arizona`.recovery_fraction_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Данная организация отключена на сервере.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. check.recovery_fraction.uid .. " AND `server_id` = " .. server_id .. ';';
            mysqlQuery(query);

            sendMessage("/notif " .. check.recovery_fraction.player .. " Заявка на восстановление во фракции по жалобе №" .. check.recovery_fraction.complaintId .. " была отклонена из-за ошибки.");

            check.recovery_fraction = nil;
        end
    end

    if (check.recovery_account) then
        if (text:find("A: %S+ разбанил игрока %S+, причина: .*")) then
            local query = "UPDATE `arizona`.recovery_account_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. check.recovery_account.uid .. " AND `server_id` = " .. server_id .. ';';
            mysqlQuery(query);

            sendMessage("/notif " .. check.recovery_account.player .. " Заявка на восстановление аккаунта по жалобе №" .. check.recovery_account.complaintId .. " была одобрена администратором " .. check.recovery_account.administrator .. ".");

            check.recovery_account = nil;
        end

        if (text:find("Игрок %S+ не забанен")) then
            local query = "UPDATE `arizona`.recovery_account_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Игрок не забанен.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. check.recovery_account.uid .. " AND `server_id` = " .. server_id .. ';';
            mysqlQuery(query);

            sendMessage("/notif " .. check.recovery_account.player .. " Заявка на восстановление аккаунта по жалобе №" .. check.recovery_account.complaintId .. " была отклонена из-за ошибки.");

            check.recovery_account = nil;
        end
    end

    for i, v in ipairs(guard) do
        if (text:find(v.regular)) then
            local array = table.pack(text:match(v.regular));

            if ((v.position == -1) or ((array[v.position + 1] == getBotId() or array[v.position + 1] == getBotNick()) and (array[v.target + 1] ~= getBotId() and array[v.target + 1] ~= getBotNick()))) then
                if (v.action == "exit") then
                    settings.last_bot_disconnect = os.time();
                    local query = ("UPDATE `arizona`.servers_raksamp SET `start` = %d, `started` = %d, `last_bot_disconnect` = %d, `last_bot_stop` = %d WHERE `server_id` = %d;"):format(0, 0, settings.last_bot_disconnect,  os.time(), server_id);
                    AsyncMysqlQuery(query);

                    exit();
                elseif (v.action == "aclear") then
                    sendMessage("/aclear " .. getBotId());
                elseif (v.action == "unfreeze") then
                    sendMessage("/unfreeze " .. getBotId());
                elseif (v.action == "spawn") then
                    set_bot_position();
                elseif (v.action == "spplayer") then
                    sendMessage("/spplayer " .. array[v.target + 1]);
                elseif (v.action == "sethp") then
                    sendMessage("/sethp " .. getBotId() .. " 100");
                end

                return false;
            end
        end
    end

    for i, v in ipairs(messagesRemover) do
        if (text:find(v.regular)) then
            if (v.position_first == -1) then
                return false;
            else
                local array = table.pack(text:match(v.regular));
                local player_first = array[v.position_first + 1];

                if (v.position_second == -1) then
                    if (getBotNick() == player_first or getBotId() == tonumber(player_first)) then
                        return false;
                    end
                else
                    local player_second = array[v.position_second + 1];

                    if ((getBotNick() == player_first or getBotId() == tonumber(player_first)) and (getBotNick() == player_second or getBotId() == tonumber(player_second))) then
                        return false;
                    end
                end
            end
        end
    end
end

function sampev.onConnectionRequestAccepted(ip, port, playerId, challenge)
    if (CHECK_TASK and not CHECK_TASK:isAlive()) then
        CHECK_TASK:kill();
    end

    CHECK_TASK = newTask(function()
        repeat
            wait(0);
        until isBotSpawned();

        wait(1500);
        sendMessage("/apanel");
    end)
end

function sampev.onConnectionClosed()
    settings.bot_is_spawned = false;
    license.sellLicenses = false;
    check = {
        afk = {}
    };
    settings.last_bot_disconnect = os.time();

    local query = ("UPDATE `arizona`.servers_raksamp SET `last_bot_disconnect` = %d WHERE `server_id` = %d;"):format(settings.last_bot_disconnect, server_id);
    AsyncMysqlQuery(query);
end

function sampev.onConnectionLost()
    settings.bot_is_spawned = false;
    license.sellLicenses = false;
    check = {
        afk = {}
    };
    settings.last_bot_disconnect = os.time();

    local query = ("UPDATE `arizona`.servers_raksamp SET `last_bot_disconnect` = %d WHERE `server_id` = %d;"):format(settings.last_bot_disconnect, server_id);
    AsyncMysqlQuery(query);
end

function sampev.onSendPlayerSync(data)
    if (settings.license_system) then
        if (license.sellLicenses) then
            data.quaternion = settings.license_quaternion_second;
        else
            data.quaternion = settings.license_quaternion_first;
        end
    else
        data.quaternion = settings.spawn_quaternion;
    end

    return data;
end

function sampev.onSendTakeDamage(data)
    sendMessage("/sethp " .. getBotId() .. " 100");
end

function sampev.onSetPlayerSkin(playerId, skinId)
    if ((is_self(playerId)) and (settings.bot_is_spawned) and (settings.skin_system) and (skinId ~= settings.skin_id)) then
        if ((not check.morg) and (not check.props) and (not check.mpdonate) and (not check.spawncars) and (not check.pledge) and (not check.offForms)) then
            if (settings.license_system) then
                if (license.sellLicenses) then
                    sendMessage("/setskin " .. getBotId() .. " " .. settings.skin_id .. " 0");
                end
            else
                sendMessage("/setskin " .. getBotId() .. " " .. settings.skin_id .. " 0");
            end
        end
    end
end

function sampev.onSetInterior(interior)
    if (interior == 218) then
        sendMessage("/sethp " .. getBotId() .. " 100");
        set_bot_position();
    end
end

function sampev.onSetPlayerPos(position)
    if (check.offForms) then
        if (check.offForms.form == "setgangzone") then
            sendMessage("/setgangzone " .. check.offForms.organization);

            if (not check.offForms.notLast) then
                set_bot_position();
            end

            check.offForms.process = false;
        end
    end
end

function sampev.onPlayerChatBubble(playerId, color, distance, duration, message)
    if (color == -1 and distance == 7 and duration == 3000) then
        local found = false;
        for i, v in ipairs(check.afk) do
            if (v.id == playerId) then
                v.lastUpdate = os.time();
                found = true;
                break;
            end
        end

        if (not found) then
            table.insert(check.afk, {
                id = playerId,
                lastUpdate = os.time()
            });
        end
    end
end

function sampev.onCreateGangZone(zoneId, squareStart, squareEnd, color)
    color = int32_to_uint32(color);
    for id, zone in ipairs(core.zones.ghetto) do
        if ((zone.x1 == math.floor(squareStart.x)) and (zone.y1 == math.floor(squareStart.y)) and (zone.x2 == math.floor(squareEnd.x)) and (zone.y2 == math.floor(squareEnd.y))) then
            zone.organization = 0;

            for _, organization in ipairs(core.orgs.list) do
                if (organization.color_zone == color) then
                    zone.color = color;
                    zone.organization = organization.id;
                    break;
                end
            end

            local query = ("UPDATE `arizona`.gangzones_ghetto_system SET `organization` = %d, `color` = '%s' WHERE `server_id` = %d AND `zone_id` = %d;"):format(zone.organization, to_hex(ColorConvertU32ToFloat4(color)), server_id, id);
            mysqlQuery(query);
        end
    end

    for id, zone in ipairs(core.zones.family) do
        if ((zone.x1 == math.floor(squareStart.x)) and (zone.y1 == math.floor(squareStart.y)) and (zone.x2 == math.floor(squareEnd.x)) and (zone.y2 == math.floor(squareEnd.y))) then
            zone.color = color;
            break;
        end
    end
end

function sampev.onShowTextDraw(textdrawId, textdraw)
    if (textdrawId == 1027) then
        if (textdraw.text:find("ticks:%s*(%d+)%s*/%s*min:%s*(%d+)%s*/%s*avg:%s*(%d+)%s*/%s*max:%s*(%d+)")) then
            local ticks, min, avg, max = textdraw.text:match("ticks:%s*(%d+)%s*/%s*min:%s*(%d+)%s*/%s*avg:%s*(%d+)%s*/%s*max:%s*(%d+)");

            server_stats.ticks = {
                current = tonumber(ticks),
                average = tonumber(avg),
                maximum = tonumber(max),
                minimum = tonumber(min)
            };
        end
    end
end

function onLoad()
    newTask(function ()
        repeat wait(0) until settings.active;

        newTask(loadMorg);
        newTask(handle_errors);
        newTask(system_tasks);
        -- newTask(accept);
		newTask(server_stats_check);
        newTask(businesses_mafia_check);
        newTask(send_admin_information);
        -- newTask(bot_bandit_checker);
        newTask(auto_car_spawn);
        newTask(auto_ao_messages);
        newTask(auto_conference_ao);
        newTask(auto_send_mpdonate);
        -- newTask(afk_nearby_check);
        newTask(license_nearby_check);
        newTask(props_check);
        newTask(pledge_check);
        -- newTask(fractions_check);
        newTask(offline_forms);
        newTask(compensations_forms);
        newTask(recovery_fraction_forms);
        newTask(recovery_account_forms);

        while (true) do
            wait(0);

            if (#sendMessage.queue > 0 and os.clock() - sendMessage.timer >= 1) then
                sendInput(sendMessage.queue[1]);
                table.remove(sendMessage.queue, 1);
                sendMessage.timer = os.clock();
            end
        end
    end)
end

function handle_errors()
    local functions = {
        server_stats = {
            duration = 0,
            start = 0
        },
        businesses_mafia = {
            duration = 0,
            start = 0
        },
        bot_bandit = {
            duration = 0,
            start = 0
        },
        spawncars = {
            duration = 0,
            start = 0
        },
        mpdonate = {
            duration = 0,
            start = 0
        },
        props = {
            duration = 0,
            start = 0
        },
        morg = {
            duration = 0,
            start = 0
        },
        pledge = {
            duration = 0,
            start = 0
        },
        offForms = {
            duration = 0,
            start = 0
        }
    };

    local function reset_bot()
        settings.bot_is_spawned = false;
        license.sellLicenses = false;
        check = {
            afk = {}
        };
        settings.last_bot_disconnect = os.time();
        functions = {
            server_stats = {
                duration = 0,
                start = 0
            },
            businesses_mafia = {
                duration = 0,
                start = 0
            },
            bot_bandit = {
                duration = 0,
                start = 0
            },
            spawncars = {
                duration = 0,
                start = 0
            },
            mpdonate = {
                duration = 0,
                start = 0
            },
            props = {
                duration = 0,
                start = 0
            },
            morg = {
                duration = 0,
                start = 0
            },
            pledge = {
                duration = 0,
                start = 0
            },
            offForms = {
                duration = 0,
                start = 0
            }
        };

        local query = ("UPDATE `arizona`.servers_raksamp SET `last_bot_disconnect` = %d WHERE `server_id` = %d;"):format(settings.last_bot_disconnect, server_id);
        AsyncMysqlQuery(query);

        reconnect();
    end

    local function handle()
        if (check.server_stats and check.server_stats == 'svrnt') then
            if (functions.server_stats.start == 0) then
                functions.server_stats = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.server_stats.duration = os.time() - functions.server_stats.start;
            end
        else
            functions.server_stats = {
                duration = 0,
                start = 0
            };
        end

        if (check.bot_bandit) then
            if (functions.bot_bandit.start == 0) then
                functions.bot_bandit = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.bot_bandit.duration = os.time() - functions.bot_bandit.start;
            end
        else
            functions.bot_bandit = {
                duration = 0,
                start = 0
            };
        end

        if (check.spawncars) then
            if (functions.spawncars.start == 0) then
                functions.spawncars = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.spawncars.duration = os.time() - functions.spawncars.start;
            end
        else
            functions.spawncars = {
                duration = 0,
                start = 0
            };
        end

        if (check.mpdonate) then
            if (functions.mpdonate.start == 0) then
                functions.mpdonate = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.mpdonate.duration = os.time() - functions.mpdonate.start;
            end
        else
            functions.mpdonate = {
                duration = 0,
                start = 0
            };
        end

        if (check.props) then
            if (functions.props.start == 0) then
                functions.props = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.props.duration = os.time() - functions.props.start;
            end
        else
            functions.props = {
                duration = 0,
                start = 0
            };
        end

        if (check.morg) then
            if (functions.morg.start == 0) then
                functions.morg = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.morg.duration = os.time() - functions.morg.start;
            end
        else
            functions.morg = {
                duration = 0,
                start = 0
            };
        end

        if (check.pledge) then
            if (functions.pledge.start == 0) then
                functions.pledge = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.pledge.duration = os.time() - functions.pledge.start;
            end
        else
            functions.pledge = {
                duration = 0,
                start = 0
            };
        end

        if (check.offForms) then
            if (functions.offForms.start == 0) then
                functions.offForms = {
                    start = os.time(),
                    duration = 0
                };
            else
                functions.offForms.duration = os.time() - functions.offForms.start;
            end
        else
            functions.offForms = {
                duration = 0,
                start = 0
            };
        end

        for i, v in pairs(functions) do
            if (v.duration >= 10 * 60) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'check." .. i .. "' ошибочно зависла на " .. v.duration .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();
                break;
            end
        end
    end

    local function handle_idle()
        if (settings.auto_respawn_cars) then
            if (os.time() - settings.last_respawn_cars >= settings.auto_respawn_cars_time * 60 * 2) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'auto_respawn_cars' ошибочно не запускалась " .. os.time() - settings.last_respawn_cars .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();

                return;
            end
        end

        if (settings.send_mpdonate_system) then
            if (os.time() - settings.last_send_mpdonate >= settings.send_mpdonate_time * 60 * 2) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'send_mpdonate' ошибочно не запускалась " .. os.time() - settings.last_send_mpdonate .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();

                return;
            end
        end

        if (props.b) then
            if (os.time() - props.last >= props.delay * 60 * 2) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'check_props' ошибочно не запускалась " .. os.time() - props.last .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();

                return;
            end
        end

        if (bot_bandit.b) then
            if (os.time() - bot_bandit.last >= bot_bandit.delay * 60 * 2) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'bot_bandit' ошибочно не запускалась " .. os.time() - props.last .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();

                return;
            end
        end

        if (morg.b) then
            if (os.time() - morg.last >= morg.delay * 60 * 2) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'check_fractions' ошибочно не запускалась " .. os.time() - morg.last .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();

                return;
            end
        end

        if (pledge.b) then
            if (os.time() - pledge.last >= pledge.delay * 60 * 2) then
				local error_string = server_prefix .. "[ Информация | handleErrors ] Функция 'check_pledge' ошибочно не запускалась " .. os.time() - pledge.last .. " секунд. Система перезапущена.";
                print(error_string);
				asyncHttpRequest('GET', 'https://api.telegram.org/bot'.. TELEGRAM_TOKEN .. '/sendMessage?chat_id='.. TELEGRAM_CHATID ..'&text='..urlencode(u8:encode(error_string, 'CP1251')), nil, nil, nil)
                reset_bot();

                return;
            end
        end
    end

    while (true) do
        wait(0);
        handle();

        if (settings.bot_is_spawned) then
            if (settings.last_bot_connect > settings.last_bot_disconnect and (os.time() - settings.last_bot_connect >= 1.5 * 60 * 60)) then
                handle_idle();
            end
        end
    end
end

function system_tasks()
    local tasks = {};
    local function check_and_send()
        for i, v in ipairs(tasks) do
            local year, month, day, hour, min, sec = v.time:match("(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)");

            local date_table = {
                year = tonumber(year),
                month = tonumber(month),
                day = tonumber(day),
                hour = tonumber(hour),
                min = tonumber(min),
                sec = tonumber(sec)
            };

            local target_time = os.time(date_table);
            local current_time = os.time();

            if ((current_time - target_time) < (7 * 24 * 60 * 60)) then
                if (v.task == "stop") then
                    settings.last_bot_disconnect = current_time;
                    local query = "UPDATE `arizona`.tasks_system SET `half_passed` = 1, `time_half_passed` = DEFAULT WHERE `passed` = 0 AND `task_id` = " .. v.task_id .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    query = ("UPDATE `arizona`.servers_raksamp SET `start` = %d, `started` = %d, `last_bot_disconnect` = %d, `last_bot_stop` = %d WHERE `server_id` = %d;"):format(0, 0, settings.last_bot_disconnect, current_time, server_id);
                    mysqlQuery(query);

                    exit();
                elseif (v.task == "restart") then
                    if (v.half_passed) then
                        local query = "UPDATE `arizona`.tasks_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Бот уже запущен.") .. "' WHERE `passed` = 0 AND `task_id` = " .. v.task_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);
                    else
                        settings.last_bot_disconnect = current_time;
                        local query = "UPDATE `arizona`.tasks_system SET `half_passed` = 1, `time_half_passed` = DEFAULT WHERE `passed` = 0 AND `task_id` = " .. v.task_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        query = ("UPDATE `arizona`.servers_raksamp SET `started` = %d, `last_bot_disconnect` = %d, `last_bot_restart` = %d WHERE `server_id` = %d;"):format(0, settings.last_bot_disconnect, current_time, server_id);
                        mysqlQuery(query);

                        exit();
                    end
                end
            end
        end
    end

    while (true) do
        wait(1 * 1000);
        tasks = {};

        local query = "SELECT * FROM `arizona`.tasks_system WHERE `passed` = 0 AND `server_id` = " .. server_id .. ';';
        local data = mysqlQuery(query);

        if (data) then
            for i, v in ipairs(data) do
                table.insert(tasks, {
                    task_id = v.task_id,
                    task = v.task,
                    time = v.time_created
                });
            end
        end

        check_and_send();
    end
end

function accept()
    local process = false;
    local accepts = {};

    local function check_and_send()
        process = true;
        for i, v in ipairs(accepts) do
            local current_time = os.time();
            check.accepts = {
                admin = v.admin,
                accept_id = v.accept_id
            };

            if (getPlayerIdByNickname(v.admin)) then
                sendMessage("/getip " .. getPlayerIdByNickname(v.admin));
            else
                local query = ("UPDATE `arizona`.accept_system SET `denied` = %d, `time_denied` = DEFAULT WHERE `accept_id` = %d AND `server_id` = %d;"):format(1, v.accept_id, server_id);
                AsyncMysqlQuery(query);
            end

            while (check.accepts) do
                wait(0);

                if (os.time() - current_time > 60) then
                    local query = ("UPDATE `arizona`.accept_system SET `getip` = %d WHERE `accept_id` = %d AND `server_id` = %d;"):format(1, check.accepts.accept_id, server_id);
                    AsyncMysqlQuery(query);
                    check.accepts = nil;
                end
            end
        end
        process = false;
    end

    while (true) do
        wait(1 * 1000);
        if (settings.bot_is_spawned) then
            if (not process) then
                accepts = {};

                local query = "SELECT * FROM `arizona`.accept_system WHERE `time_created` >= NOW() - INTERVAL 1 HOUR AND `accepted` = 0  AND `denied` = 0 AND `getip` = 0 AND `sent` = 0 AND `server_id` = " .. server_id .. ';';
                local data = mysqlQuery(query);

                if (data) then
                    for i, v in ipairs(data) do
                        table.insert(accepts, {
                            admin = v.admin,
                            accept_id = v.accept_id
                        });
                    end
                end

                check_and_send();
            end
        else
            process = false;
        end
    end
end

function server_stats_check()
    local first = true;
    local query = "SELECT * FROM `arizona`.server_stats_system WHERE `server_id` = " .. server_id .. ';';
    local data = mysqlQuery(query);
    server_stats.special = data[1].special_list;

    local function check_and_send()
        local time = os.time();
        server_stats.admins.special = {
            total = 0
        };
        server_stats.admins.chief = {
            total = 0,
            afk = 0
        };
        server_stats.admins.admins = {
            total = 0,
            afk = 0
        };
        server_stats.admins.helpers = {
            total = 0,
            afk = 0
        };
        server_stats.leaders = {
            total = 0,
            afk = 0,
            list = {}
        };
        server_stats.zams = {
            total = 0,
            afk = 0,
            list = {}
        };

        for i, v in ipairs(server_stats.special) do
            local playerId = getPlayerIdByNickname(v);
            local playerName = v;

            if (playerId ~= -1) then
                local found = false;
                server_stats.admins.special.total = server_stats.admins.special.total + 1;

                for x, y in ipairs(server_stats.admins.list) do
                    if (y.nickname == playerName) then
                        found = true;
                    end
                end

                if (not found) then
                    table.insert(server_stats.admins.list, {
                        nickname = playerName,
                        id = playerId,
                        lvl = 8,
                        rep = 0,
                        afk = 0,
                        re = nil,
                        is_self = false
                    });
                end
            end
        end

        if (first) then
            -- DEBUG("[ DEBUG | server_stats ] morg: " .. tostring(check.morg) .. " | props: " .. tostring(check.props) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | pledge: " .. tostring(check.pledge) .. " | spawncars: " .. tostring(check.spawncars) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
            if (not (check.morg or check.props or check.mpdonate or check.pledge or check.spawncars or check.bot_bandit or check.businesses_mafia or check.compensations or check.recovery_account or check.recovery_fraction)) then
                check.server_stats = "svrnt";
                set_bot_position();
                sendMessage("/svrnt");
                wait(5000);
                first = false;
            end
        end

        check.server_stats = "leaders";
        sendMessage("/leaders_tools");
        wait(10000);
        check.server_stats = "zams";
        sendMessage("/zams_tools");
        wait(10000);
        check.server_stats = nil;
        sendMessage("/admins");
        sendMessage("/id " .. getBotId());
        wait(10000);
        sendMessage("/famgzinfo_tools");
        wait(10000);

        for i, v in ipairs(server_stats.admins.list) do
            if (getPlayerIdByNickname(v.nickname) == -1) then
                table.remove(server_stats.admins.list, i);
            end

            if (not v.is_self) then
                if (v.lvl == 1 or v.lvl == 2) then
                    server_stats.admins.helpers.total = server_stats.admins.helpers.total + 1;
                    if (v.afk > 0) then
                        server_stats.admins.helpers.afk = server_stats.admins.helpers.afk + 1;
                    end
                elseif (v.lvl == 3 or v.lvl == 4) then
                    server_stats.admins.admins.total = server_stats.admins.admins.total + 1;
                    if (v.afk > 0) then
                        server_stats.admins.admins.afk = server_stats.admins.admins.afk + 1;
                    end
                elseif (v.lvl == 5 or v.lvl == 6 or v.lvl == 7) then
                    server_stats.admins.chief.total = server_stats.admins.chief.total + 1;
                    if (v.afk > 0) then
                        server_stats.admins.chief.afk = server_stats.admins.chief.afk + 1;
                    end
                end
            end
        end

        if (server_stats.build) then
            query = ("UPDATE `arizona`.server_stats_system SET `last` = %d, `ticks_current` = %d, `ticks_average` = %d, `ticks_maximum` = %d, `ticks_minimum` = %d, `packetloss` = %f, `build` = '%s', `players` = %d, `report` = %d, `special_total` = %d, `chief_total` = %d, `chief_afk` = %d, `admins_total` = %d, `admins_afk` = %d, `helpers_total` = %d, `helpers_afk` = %d, `leaders_total` = %d, `leaders_afk` = %d, `zams_total` = %d, `zams_afk` = %d, `admins_list` = '%s', `leaders_list` = '%s', `zams_list` = '%s' WHERE `server_id` = %d;"):format(time, server_stats.ticks.current, server_stats.ticks.average, server_stats.ticks.maximum, server_stats.ticks.minimum, server_stats.packetloss, server_stats.build, getPlayerCount(), server_stats.admins.report, server_stats.admins.special.total, server_stats.admins.chief.total, server_stats.admins.chief.afk, server_stats.admins.admins.total, server_stats.admins.admins.afk, server_stats.admins.helpers.total, server_stats.admins.helpers.afk, server_stats.leaders.total, server_stats.leaders.afk, server_stats.zams.total, server_stats.zams.afk, json.encode(server_stats.admins.list), json.encode(server_stats.leaders.list), json.encode(server_stats.zams.list), server_id);
        else
            query = ("UPDATE `arizona`.server_stats_system SET `last` = %d, `ticks_current` = %d, `ticks_average` = %d, `ticks_maximum` = %d, `ticks_minimum` = %d, `packetloss` = %f, `players` = %d, `report` = %d, `special_total` = %d, `chief_total` = %d, `chief_afk` = %d, `admins_total` = %d, `admins_afk` = %d, `helpers_total` = %d, `helpers_afk` = %d, `leaders_total` = %d, `leaders_afk` = %d, `zams_total` = %d, `zams_afk` = %d, `admins_list` = '%s', `leaders_list` = '%s', `zams_list` = '%s' WHERE `server_id` = %d;"):format(time, server_stats.ticks.current, server_stats.ticks.average, server_stats.ticks.maximum, server_stats.ticks.minimum, server_stats.packetloss, getPlayerCount(), server_stats.admins.report, server_stats.admins.special.total, server_stats.admins.chief.total, server_stats.admins.chief.afk, server_stats.admins.admins.total, server_stats.admins.admins.afk, server_stats.admins.helpers.total, server_stats.admins.helpers.afk, server_stats.leaders.total, server_stats.leaders.afk, server_stats.zams.total, server_stats.zams.afk, json.encode(server_stats.admins.list), json.encode(server_stats.leaders.list), json.encode(server_stats.zams.list), server_id);
        end

        AsyncMysqlQuery(query);
    end

    while (server_stats.b) do
        wait(5 * 1000 * 60);
        if (settings.bot_is_spawned) then
            check_and_send();
        else
            first = true;
        end
    end
end

function businesses_mafia_check()
    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | businesses_mafia ] morg: " .. tostring(check.morg) .. " | props: " .. tostring(check.props) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | pledge: " .. tostring(check.pledge) .. " | spawncars: " .. tostring(check.spawncars) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.morg) then return end;
        if (check.spawncars) then return end;
        if (check.bot_bandit) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        local time = os.time();

        if (time - businesses_mafia.last > (businesses_mafia.delay * 60)) then
            process = true;
            check.businesses_mafia = true;
            businesses_mafia.last = time;

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_businesses_mafia` = %d WHERE `server_id` = %d;"):format(businesses_mafia.last, server_id);
            AsyncMysqlQuery(query);

            license.sellLicenses = false;

            set_bot_position();

            for _, fraction_id in ipairs(businesses_mafia.fractions) do
                check.businesses_mafia = fraction_id;
                sendMessage("/ambiz " .. fraction_id);

                while (check.businesses_mafia == fraction_id) do
                    wait(100);
                end
            end

            table.sort(businesses_mafia.pool, function(a, b)
                return a.id < b.id;
            end)

            for _, business in ipairs(core.zones.mafia) do
                local found = true;

                for _, businessPool in ipairs(businesses_mafia.pool) do
                    if (business.id ~= businessPool.id) then
                        found = false;
                        break;
                    end
                end

                if (not found) then
                    query = ("UPDATE `arizona`.businesses_mafia_system SET `organization` = %d, `money` = %d WHERE `server_id` = %d AND `business_id` = %d;"):format(0, 0, server_id, business.id);
                    mysqlQuery(query);
                end
            end

            for _, business in ipairs(businesses_mafia.pool) do
                query = ("UPDATE `arizona`.businesses_mafia_system SET `organization` = %d, `money` = %d WHERE `server_id` = %d AND `business_id` = %d;"):format(business.organization, business.money, server_id, business.id);
                mysqlQuery(query);
            end

            check.businesses_mafia = false;
            process = false;
        end
    end

    while (businesses_mafia.b) do
        wait(1000);
        if (settings.bot_is_spawned) then
            check_and_send();
        else
            process = false;
        end
    end
end

function send_admin_information()
    if (not settings.send_information_to_admins_system) then return end;

    local function get_forms_list()
        local t = {};

        for i, v in ipairs(igForms.list) do
            if (v.state) then
                table.insert(t, "/" .. v.name);
            end
        end

        return t;
    end

    local function splitCommands(commands, maxLength)
        local lines = {};
        local currentLine = "Автоматически принимается: ";

        for _, command in ipairs(commands) do
            if #currentLine + #command + 2 > maxLength then
                table.insert(lines, currentLine);
                currentLine = command;
            else
                if currentLine ~= "Автоматически принимается: " then
                    currentLine = currentLine .. ", " .. command;
                else
                    currentLine = currentLine .. command;
                end
            end
        end

        table.insert(lines, currentLine);
        return lines;
    end

    local function check_and_send()
        local time = os.time();
        local last_message_seconds_ago = time - settings.last_send_information_to_admins;

        if (last_message_seconds_ago > (settings.send_information_to_admins_time * 60)) then
            settings.last_send_information_to_admins = time;

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_send_information_to_admins` = %d WHERE `server_id` = %d;"):format(settings.last_send_information_to_admins, server_id);
            AsyncMysqlQuery(query);

            sendMessage("/a ---------------------------Информация для администрации---------------------------");

            if (igForms.b) then
                local t = get_forms_list();
                local commandLines = splitCommands(t, 90);
                for _, line in ipairs(commandLines) do
                    sendMessage("/a " .. line);
                end
            end

            sendMessage("/a Перед принятием форм от других администраторов,");
            sendMessage("/a обязательно проверьте наличие админ тега и прочитайте причину выдачи.");
            sendMessage("/a ---------------------------Информация для администрации---------------------------");
        end
    end

    while (settings.send_information_to_admins_system) do
        wait(1 * 1000 * 60);
        if (settings.bot_is_spawned) then
            check_and_send();
        end
    end
end

function bot_bandit_checker()
    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | bot_bandit ] morg: " .. tostring(check.morg) .. " | props: " .. tostring(check.props) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | pledge: " .. tostring(check.pledge) .. " | spawncars: " .. tostring(check.spawncars) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.morg) then return end;
        if (check.spawncars) then return end;
        if (check.businesses_mafia) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        if (os.time() - bot_bandit.last >= bot_bandit.delay * 60) then
            process = true;
            check.bot_bandit = true;
            bot_bandit.last = os.time();

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_bot_bandit_checker` = %d WHERE `server_id` = %d;"):format(bot_bandit.last, server_id);
            AsyncMysqlQuery(query);

            license.sellLicenses = false;

            set_bot_position();

            for _, position in ipairs(core.bot_bandit.positions) do
                sendMessage("/gc " .. position.x .. " " .. position.y .. " " .. position.z - 3 .. " 0 0");
                wait(5000);

                for id, player in pairs(getAllPlayers()) do
                    if (player.exist) then
                        local isInRange = false;

                        for _, pos in ipairs(core.bot_bandit.positions) do
                            if (getDistanceBetweenCoords3d(player.position.x, player.position.y, player.position.z, pos.x, pos.y, pos.z) <= pos.range) then
                                isInRange = true;
                                break;
                            end
                        end

                        if (bot_bandit.players[id]) then
                            if (bot_bandit.players[id].nickname == player.nick) then
                                if (isInRange) then
                                    if (getDistanceBetweenCoords3d(player.position.x, player.position.y, player.position.z, bot_bandit.players[id].position.x, bot_bandit.players[id].position.y, bot_bandit.players[id].position.z) <= 5) then
                                        bot_bandit.players[id].repeats = bot_bandit.players[id].repeats + 1;
                                    else
                                        bot_bandit.players[id].repeats = 0;
                                    end
                                end
                            else
                                bot_bandit.players[id] = {
                                    nickname = player.nick,
                                    position = {
                                        x = player.position.x,
                                        y = player.position.y,
                                        z = player.position.z,
                                    },
                                    repeats = 0
                                };
                            end

                            if (bot_bandit.players[id].repeats >= 2) then
                                bot_bandit.players[id].repeats = 0;
                                sendMessage("/setvw " .. id .. " 1");
                                sendMessage("/pm " .. id .. " 1 Вы были автоматически телепортированы в виртуальный мир из-за подозрений в прокачивании промокода.");
                            end
                        else
                            if ((player.score > 0) and (player.score <= 5)) then
                                table.insert(bot_bandit.players, id, {
                                    nickname = player.nick,
                                    position = {
                                        x = player.position.x,
                                        y = player.position.y,
                                        z = player.position.z,
                                    },
                                    repeats = 0
                                });
                            end
                        end
                    end
                end
            end

            bot_bandit.last = os.time();
            check.bot_bandit = false;
            process = false;
        end
    end

    while (bot_bandit.b) do
        wait(1000);

        if (settings.bot_is_spawned) then
            check_and_send();
        else
            process = false;
        end
    end
end

function auto_car_spawn()
    if (not settings.auto_respawn_cars) then return end;

    local function check_and_spawn()
        -- DEBUG("[ DEBUG | auto_car_spawn ] morg: " .. tostring(check.morg) .. " | props: " .. tostring(check.props) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | pledge: " .. tostring(check.pledge) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.morg) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        local time = os.time();
        local last_cars_spawn_second_ago = time - settings.last_respawn_cars;

        if (last_cars_spawn_second_ago > (settings.auto_respawn_cars_time * 60)) then
            check.spawncars = "auto";
            settings.last_respawn_cars = time;

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_respawn_cars` = %d WHERE `server_id` = %d;"):format(settings.last_respawn_cars, server_id);
            AsyncMysqlQuery(query);

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/ao [Спавн транспорта] Уважаемые игроки, через 60 секунд будет спавн всего транспорта!");
            sendMessage("/ao [Спавн транспорта] Займите свой транспорт, в противном случае он пропадет!");

            wait(60 * 1000);

            sendMessage("/vehicleapanel");
        end
    end

    while (settings.auto_respawn_cars) do
        wait(1 * 1000 * 60);
        if (settings.bot_is_spawned) then
            check_and_spawn();
        else
            process = false;
        end
    end
end

function auto_ao_messages()
    if (not settings.send_ao_system) then return end;

    local process = false;

    local function check_and_send()
        local edited = false;
        local time = os.time();
        local day = tonumber(os.date("%w", os.time() + server_time));
        local hour = tonumber(os.date("%H", os.time() + server_time));
        local minute = tonumber(os.date("%M", os.time() + server_time));

        process = true;
        for _, pool in ipairs(ao_messages) do
            if (pool.type == 0) then
                for _, times in ipairs(pool.time) do
                    if ((day == times.day) and (hour == times.hour) and (minute == times.minute) and (time - times.last > 60 * 1000)) then
                        edited = true;
                        times.last = time;

                        for _, message in ipairs(pool.text) do
                            sendMessage("/ao " .. message);
                        end
                    end
                end
            elseif (pool.type == 1) then
                if (time - pool.time.last > (pool.time.delay * 60)) then
                    edited = true;
                    pool.time.last = time;

                    for _, message in ipairs(pool.text) do
                        sendMessage("/ao " .. message);
                    end
                end
            end

            if (edited) then
                local query = ("UPDATE `arizona`.ao_system SET `time` = '%s' WHERE `server_id` = %d AND `ao_id` = %d;"):format(json.encode(pool.time), server_id, pool.id);
                AsyncMysqlQuery(query);
            end
        end
        process = false;
    end

    while (settings.send_ao_system) do
        wait(1000);
        if (settings.bot_is_spawned) then
            if (not process) then
                ao_messages = {};
                local query = "SELECT * FROM `arizona`.ao_system WHERE `server_id` = " .. server_id .. ';';
                local data = mysqlQuery(query);

                if (data) then
                    for i, v in ipairs(data) do
                        table.insert(ao_messages, {
                            id = v.ao_id,
                            type = v.type,
                            time = v.time,
                            text = v.text
                        });
                    end
                end

                check_and_send();
            end
        else
            process = false;
        end
    end
end

function auto_conference_ao()
    if (not settings.send_conference_system) then return end;

    local function check_and_send()
        local time = os.time();
        local day = tonumber(os.date("%w", os.time() + server_time));
        local hour = tonumber(os.date("%H", os.time() + server_time));
        local minute = tonumber(os.date("%M", os.time() + server_time));

        if (time - settings.last_send_conference_first >= 604800) then
            if ((day == 2) and (hour == settings.send_conference_first_hour) and (minute == settings.send_conference_first_minute)) then
                settings.last_send_conference_first = settings.last_send_conference_first + 604800;

                local q = ("UPDATE `arizona`.servers_raksamp SET `last_send_conference_first` = %d WHERE `server_id` = %d;"):format(settings.last_send_conference_first, server_id);
                AsyncMysqlQuery(q);

                sendMessage("/ao [Конференция] По средам в 18 часов в Discord Аrizona Gаmes проходит тет-а-тет конференция.");
                sendMessage("/ao [Конференция] Вы сможете решить ваш вопрос напрямую с Главной администрацией или Красной администрацией!");
            end
        end

        if (time - settings.last_send_conference_second >= 604800) then
            if ((day == 2) and (hour == settings.send_conference_second_hour) and (minute == settings.send_conference_second_minute)) then
                settings.last_send_conference_second = settings.last_send_conference_second + 604800;

                local q = ("UPDATE `arizona`.servers_raksamp SET `last_send_conference_second` = %d WHERE `server_id` = %d;"):format(settings.last_send_conference_second, server_id);
                AsyncMysqlQuery(q);

                sendMessage("/ao [Конференция] По средам в 18 часов в Discord Аrizona Gаmes проходит тет-а-тет конференция.");
                sendMessage("/ao [Конференция] Вы сможете решить ваш вопрос напрямую с Главной администрацией или Красной администрацией!");
            end
        end

        if (time - settings.last_send_conference_third >= 604800) then
            if ((day == 2) and (hour == settings.send_conference_third_hour) and (minute == settings.send_conference_third_minute)) then
                settings.last_send_conference_third = settings.last_send_conference_third + 604800;

                local q = ("UPDATE `arizona`.servers_raksamp SET `last_send_conference_third` = %d WHERE `server_id` = %d;"):format(settings.last_send_conference_third, server_id);
                AsyncMysqlQuery(q);

                sendMessage("/ao [Конференция] По средам в 18 часов в Discord Аrizona Gаmes проходит тет-а-тет конференция.");
                sendMessage("/ao [Конференция] Вы сможете решить ваш вопрос напрямую с Главной администрацией или Красной администрацией!");
            end
        end

        if (time - settings.last_send_conference_fourth >= 604800) then
            if ((day == 3) and (hour == settings.send_conference_fourth_hour) and (minute == settings.send_conference_fourth_minute)) then
                settings.last_send_conference_fourth = settings.last_send_conference_fourth + 604800;

                local q = ("UPDATE `arizona`.servers_raksamp SET `last_send_conference_fourth` = %d WHERE `server_id` = %d;"):format(settings.last_send_conference_fourth, server_id);
                AsyncMysqlQuery(q);

                sendMessage("/ao [Конференция] Через 30 минут в Discord Аrizona Gаmes пройдёт тет-а-тет конференция.");
                sendMessage("/ao [Конференция] Вы сможете решить ваш вопрос напрямую с Главной администрацией или Красной администрацией!");
            end
        end

        if (time - settings.last_send_conference_fifth >= 604800) then
            if ((day == 3) and (hour == settings.send_conference_fifth_hour) and (minute == settings.send_conference_fifth_minute)) then
                settings.last_send_conference_fifth = settings.last_send_conference_fifth + 604800;

                local q = ("UPDATE `arizona`.servers_raksamp SET `last_send_conference_fifth` = %d WHERE `server_id` = %d;"):format(settings.last_send_conference_fifth, server_id);
                AsyncMysqlQuery(q);

                sendMessage("/ao [Конференция] На данный момент в Discord Аrizona Gаmes проходит тет-а-тет конференция.");
                sendMessage("/ao [Конференция] Вы сможете решить ваш вопрос напрямую с Главной администрацией или Красной администрацией!");
            end
        end
    end

    while (settings.send_conference_system) do
        wait(1 * 1000 * 60);
        if (settings.bot_is_spawned) then
            check_and_send();
        end
    end
end

function auto_send_mpdonate()
    if (not settings.send_mpdonate_system) then return end;

    local function check_and_send()
        -- DEBUG("[ DEBUG | mpdonate ] morg: " .. tostring(check.morg) .. " | props: " .. tostring(check.props) .. " | spawncars: " .. tostring(check.spawncars) .. " | pledge: " .. tostring(check.pledge) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.morg) then return end;
        if (check.pledge) then return end;
        if (check.spawncars) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.compensations) then return end;

        local time = os.time();

        if (time - settings.last_send_mpdonate >= settings.send_mpdonate_time * 60) then
            settings.last_send_mpdonate = time;
            check.mpdonate = true;
            license.sellLicenses = false;

            set_bot_position();

            local q = ("UPDATE `arizona`.servers_raksamp SET `last_send_mpdonate` = %d WHERE `server_id` = %d;"):format(settings.last_send_mpdonate, server_id);
            AsyncMysqlQuery(q);

            sendMessage("/apanel");
        end
    end

    while (settings.send_conference_system) do
        wait(1 * 1000 * 60);
        if (settings.bot_is_spawned) then
            check_and_send();
        else
            process = false;
        end
    end
end

function afk_nearby_check()
    check.afk = {};

    while (true) do
        wait(1000);
        local currentTime = os.time();
        for i, v in ipairs(check.afk) do
            if ((currentTime - v.lastUpdate) > 5) then
                table.remove(check.afk, i);
            end
        end
    end
end

function license_nearby_check()
    if (not settings.license_system) then return end;

    wait(1500);

    local i = 1;
    while (settings.license_system) do
        wait(10 * 1000);
        local isLicensorNearby = false;
        for id, player in pairs(getAllPlayers()) do
            if (player.exist) then
				-- DEBUG(id .. ' - ' .. player.color, settings.debug)
                if (player.color == -10079360) then
                    local found = false;
                    for j, v in ipairs(check.afk) do
                        if (id == v.id) then
                            found = true;
                            break;
                        end
                    end

                    if (not found) then
                        isLicensorNearby = true;
                    end
                end
            end
        end

        if (license.sellLicenses == isLicensorNearby) then
            if ((settings.bot_is_spawned) and (not check.morg) and (not check.props) and (not check.spawncars) and (not check.offForms) and (not check.mpdonate) and (not check.pledge) and (not check.bot_bandit) and (not check.businesses_mafia) and (not check.compensations) and (not check.recovery_fraction) and (not check.recovery_account)) then
                license.sellLicenses = not isLicensorNearby;

                set_bot_position();
            end
        end
        i = i + 1;
    end
end

function props_check()
    if (not props.b) then return end

    local props_names = {
        [0] = {
            [0] = "дома",
            [1] = "бизнеса"
        },
        [1] = {
            [0] = "дом",
            [1] = "бизнес"
        }
    };

    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | props_check ] morg: " .. tostring(check.morg) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | spawncars: " .. tostring(check.spawncars) .. " | pledge: " .. tostring(check.pledge) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.morg) then return end;
        if (check.spawncars) then return end;
        if (check.pledge) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        local time = os.time();
        local last_message_seconds_ago = time - props.last;
		-- DEBUG(last_message_seconds_ago .. '>' .. (props.delay * 60), settings.debug)
        if (last_message_seconds_ago > (props.delay * 60)) then
            process = true;
            check.props = "props";
            props.last = time;

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_property_sell` = %d WHERE `server_id` = %d;"):format(props.last, server_id);
            AsyncMysqlQuery(query);

            query = ("SELECT * FROM `arizona`.properties_system WHERE `server_id` = %d;"):format(server_id);
            local properties = mysqlQuery(query);
            license.sellLicenses = false;

            set_bot_position();
			wait(2000);
            sendMessage("/props");

            while (check.props == "props") do
                wait(1000);
            end

            for _, poolData in ipairs(props.pool) do
                if (poolData.sell) then
                    check.props = {
                        id = poolData.id,
                        type = poolData.type,
                        action = "Отклонить верификацию"
                    };

                    query = ("DELETE FROM `arizona`.properties_system WHERE `id` = %d AND `type` = %d AND `owner` = '%s' AND `time` = %d AND `server_id` = %d;"):format(poolData.id, poolData.type, poolData.owner, poolData.time, server_id);
                    AsyncMysqlQuery(query);

                    sendMessage("/notif " .. poolData.owner .. " Вы не предоставили опровержение на ловлю " .. props_names[0][poolData.type] .. " №" .. poolData.id .. ". Верификация отклонена, а " .. props_names[1][poolData.type] .. " отправлен на аукцион.");
                    sendMessage("/props " .. poolData.type .. " " .. poolData.id);
                    wait(5000);
                else
                    query = ("SELECT * FROM `arizona`.properties_system WHERE `id` = %d AND `type` = %d AND `owner` = '%s' AND `time` = %d AND `server_id` = %d;"):format(poolData.id, poolData.type, poolData.owner, poolData.time, server_id);
                    local data = mysqlQuery(query);

                    if (not data[1]) then
                        query = ("INSERT INTO `arizona`.properties_system SET `id` = %d, `type` = %d, `owner` = '%s', `time` = %d, `server_id` = %d;"):format(poolData.id, poolData.type, poolData.owner, poolData.time, server_id);
                        AsyncMysqlQuery(query);
                    end
                end
            end

            for _, property in ipairs(properties) do
                local found = false;

                for _, poolData in ipairs(props.pool) do
                    if (property.id == poolData.id) then
                        found = true;
                        break;
                    end
                end

                if (not found) then
                    query = ("DELETE FROM `arizona`.properties_system WHERE `id` = %d AND `type` = %d AND `owner` = '%s' AND `time` = %d AND `server_id` = %d;"):format(property.id, property.type, property.owner, property.time, server_id);
                    AsyncMysqlQuery(query);
                end
            end

            props.pool = {};
            check.props = nil;
            process = false;
        end
    end

    while (true) do
        wait(1000);
        if (settings.bot_is_spawned) then
            check_and_send();
        else
            process = false;
        end
    end
end

function pledge_check()
    if (not pledge.b) then return end
    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | pledge_check ] morg: " .. tostring(check.morg) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | spawncars: " .. tostring(check.spawncars) .. " | props: " .. tostring(check.props) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.morg) then return end;
        if (check.spawncars) then return end;
        if (check.props) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        local time = os.time();
        local last_message_seconds_ago = time - pledge.last;

        if (last_message_seconds_ago > (pledge.delay * 60)) then
            process = true;
            check.pledge = "pledge";
            pledge.last = time;

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_pledge` = %d WHERE `server_id` = %d;"):format(pledge.last, server_id);
            AsyncMysqlQuery(query);

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/apledge");

            while (check.pledge) do
                wait(100);
            end

            for _, bail in ipairs(pledge.pool) do
                if (bail.nickname) then
                    query = ("SELECT * FROM `arizona`.pledge_system WHERE `nickname` = '%s' AND `author` = '%s' AND `admin` = '%s' AND `reason` = '%s' AND `money` = %d AND `time_ban` = %d AND `time_unban` = %d AND `server_id` = %d;"):format(bail.nickname, bail.author, bail.admin, u8(bail.reason), bail.money, bail.time_ban, bail.time_unban, server_id);
                    local data = mysqlQuery(query);

                    if (not data[1]) then
                        query = ("INSERT INTO `arizona`.pledge_system SET `server_id` = %d, `nickname` = '%s', `author` = '%s', `admin` = '%s', `reason` = '%s', `money` = %d, `time_ban` = %d, `time_unban` = %d;"):format(server_id, bail.nickname, bail.author, bail.admin, u8(bail.reason), bail.money, bail.time_ban, bail.time_unban);
                        AsyncMysqlQuery(query);
                    end
                end
            end

            pledge.action = 0;
            pledge.pool = {};
            process = false;
        end
    end

    local function accept()
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.morg) then return end;
        if (check.spawncars) then return end;
        if (check.props) then return end;
        if (check.server_stats == "svrnt") then return end;

        local query = "SELECT * FROM `arizona`.pledge_system WHERE `server_id` = " .. server_id .. ' AND `accepted` = 1 AND `passed` = 0 AND `expired` = 0;';
        local data = mysqlQuery(query);

        if (data) then
            process = true;
            for _, bail in ipairs(data) do
                check.pledge = {
                    pledge_id = bail.pledge_id,
                    action = bail.action,
                    nickname = bail.nickname,
                    author = bail.author,
                    money = bail.money
                };

                wait(5000);
                sendMessage("/apledge");

                while (check.pledge) do
                    wait(100);
                end
            end
            process = false;
        end
    end

    while (true) do
        wait(1000);
        if (settings.bot_is_spawned) then
            check_and_send();
            accept();
        else
            process = false;
        end
    end
end

function fractions_check()
    if (not morg.b) then return end;

    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | fractions_check ] pledge: " .. tostring(check.pledge) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | spawncars: " .. tostring(check.spawncars) .. " | props: " .. tostring(check.props) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | compensations: " .. tostring(check.compensations) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.spawncars) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        local time = os.time();
        local last_message_seconds_ago = time - morg.last;

        if (last_message_seconds_ago > (morg.delay * 60)) then
            process = true;
            check.morg = "orgmembers";
            morg.last = time;

            local query = ("UPDATE `arizona`.servers_raksamp SET `last_fractions` = %d WHERE `server_id` = %d;"):format(time, server_id);
            AsyncMysqlQuery(query);

            license.sellLicenses = false;

            set_bot_position();

            sendMessage("/orgmembers -1");
            wait(1500);

            -- check.morg = "sobes";
            --sendMessage("/sobes");
            --wait(5000);

            check.morg = "judges";
            sendMessage("/apanel");
            wait(5000);

            -- check.morg = "gps";
            -- sendMessage("/gps");
            -- wait(5000);

             local members  = {};
             local salary = {};
             for i = 1, 32 do
                 members[i] = {};
                 salary[i] = {
                     rank_1_salary = 0,
                     rank_2_salary = 0,
                     rank_3_salary = 0,
                     rank_4_salary = 0,
                     rank_5_salary = 0,
                     rank_6_salary = 0,
                     rank_7_salary = 0,
                     rank_8_salary = 0,
                     rank_9_salary = 0,
                     rank_10_salary = 0,
                 };
             end

            for id, judge in ipairs(morg.judges) do
                query = ("UPDATE `arizona`.judges_system SET `nickname` = %s, `time_assignment` = %s WHERE `judge_id` = %d AND `server_id` = %d;"):format(judge.nickname and "'" .. judge.nickname .. "'" or "null", judge.date > 0 and tostring(judge.date) or "null", id, server_id);
                AsyncMysqlQuery(query);
            end

            for id, poolData in ipairs(morg.pool) do
                if (poolData.active) then
                    poolData.process = true;
                    poolData.error_stats = 0;
                    poolData.error_first = true;
                    poolData.error_second = true;
                    check.morg = id;

                    -- sendMessage("/amember " .. id .. " 9");
                    -- sendMessage("/members");

                    while (poolData.process) do
                        wait(0);
                    end

                    --for rank = 1, 10 do
                        --for i, rankData in ipairs(poolData.ranks[rank].pool) do
                            --table.insert(members[id], rankData);
                            --rankData = {};
                        --end
                        --salary[id]["rank_" .. tostring(rank) .. "_salary"] = poolData.ranks[rank].salary;
                    --end

                    if ((poolData.sobes.time) and (poolData.sobes.place)) then
                        query = ("UPDATE `arizona`.fractions_system SET `money` = %d, `dormitory` = %s, `leaders` = %d, `zams` = %d, `online` = %d, `afk` = %d, `rank_1_salary` = %d, `rank_2_salary` = %d, `rank_3_salary` = %d, `rank_4_salary` = %d, `rank_5_salary` = %d, `rank_6_salary` = %d, `rank_7_salary` = %d, `rank_8_salary` = %d, `rank_9_salary` = %d, `rank_10_salary` = %d, `members` = '%s', `sobes_time` = '%s', `sobes_place` = '%s', `owner_family` = %s, `owner_leader` = %s, `owner_deputies` = '%s' WHERE `fraction_id` = %d AND `server_id` = %d;"):format(poolData.money, poolData.dormitory, poolData.leader.status, poolData.zams, poolData.online, poolData.afk, salary[id].rank_1_salary, salary[id].rank_2_salary, salary[id].rank_3_salary, salary[id].rank_4_salary, salary[id].rank_5_salary, salary[id].rank_6_salary, salary[id].rank_7_salary, salary[id].rank_8_salary, salary[id].rank_9_salary, salary[id].rank_10_salary, json.encode(members[id]), u8(poolData.sobes.time), u8(poolData.sobes.place), poolData.owner.family and "'" .. poolData.owner.family .. "'" or 'null', poolData.owner.leader and "'" .. poolData.owner.leader .. "'" or 'null', json.encode(poolData.owner.zams), id, server_id);
                        AsyncMysqlQuery(query);
                    else
                        query = ("UPDATE `arizona`.fractions_system SET `money` = %d, `dormitory` = %s, `leaders` = %d, `zams` = %d, `online` = %d, `afk` = %d, `rank_1_salary` = %d, `rank_2_salary` = %d, `rank_3_salary` = %d, `rank_4_salary` = %d, `rank_5_salary` = %d, `rank_6_salary` = %d, `rank_7_salary` = %d, `rank_8_salary` = %d, `rank_9_salary` = %d, `rank_10_salary` = %d, `members` = '%s', `sobes_time` = %s, `sobes_place` = %s, `owner_family` = %s, `owner_leader` = %s, `owner_deputies` = '%s' WHERE `fraction_id` = %d AND `server_id` = %d;"):format(poolData.money, poolData.dormitory, poolData.leader.status, poolData.zams, poolData.online, poolData.afk, salary[id].rank_1_salary, salary[id].rank_2_salary, salary[id].rank_3_salary, salary[id].rank_4_salary, salary[id].rank_5_salary, salary[id].rank_6_salary, salary[id].rank_7_salary, salary[id].rank_8_salary, salary[id].rank_9_salary, salary[id].rank_10_salary, json.encode(members[id]), 'null', 'null', poolData.owner.family and "'" .. poolData.owner.family .. "'" or 'null', poolData.owner.leader and "'" .. poolData.owner.leader .. "'" or 'null', json.encode(poolData.owner.zams), id, server_id);
                        AsyncMysqlQuery(query);
                    end

                    members[id] = {};
                    poolData.sobes.time = nil;
                    poolData.sobes.place = nil;
                end
            end

            --for id, poolData in ipairs(morg.pool) do
                --for i, uvalData in ipairs(poolData.uval.pool) do
                    --sendMessage("/uvaloff " .. uvalData.nickname);
                    --sendMessage("/notif " .. uvalData.nickname .. " Вы были автоматически уволены из организации из-за того, что вы не заходили в игру " .. tostring(uvalData.time / 24) .. " дней.");
                --end
            --end

            check.morg = nil;
            process = false;
            loadMorg();
            set_bot_position();
        end
    end

    while (true) do
        wait(1000);
        if (settings.bot_is_spawned) then
            check_and_send();
        else
            process = false;
        end
    end
end

function offline_forms()
    if (not offForms.b) then return end;
    local process = false;

    local function check_and_send()
        process = true;

        for i, v in ipairs(offForms.pool) do
            offForms.process = true;
            local args = string.split(v.form);
            args[1] = string.lower(args[1] or "");

            for j, formData in ipairs(offForms.list) do
                if (args[1] == ("/%s"):format(formData.name)) then
                    if (formData.state) then
                        local f_plId = formData.param_target + 1;

                        local year, month, day, hour, min, sec = v.time:match("(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)");

                        local date_table = {
                            year = tonumber(year),
                            month = tonumber(month),
                            day = tonumber(day),
                            hour = tonumber(hour),
                            min = tonumber(min),
                            sec = tonumber(sec)
                        };

                        local target_time = os.time(date_table);
                        local current_time = os.time();

                        if ((current_time - target_time) >= (7 * 24 * 60 * 60)) then
                            local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Прошло 7 дней.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. v.form_id .. " AND `server_id` = " .. server_id .. ';';
                            mysqlQuery(query);

                            offForms.process = false;
                            offForms.widget = {};
                            check.offForms = nil;
                        else
                            wait(1 * 1000 * 3);

                            offForms.widget.form_name = args[1]:gsub("/", "");
                            offForms.widget.args = args;
                            offForms.widget.form_id = v.form_id;
                            offForms.widget.f_plId = f_plId;
                            offForms.widget.form = table.concat(args, " ");
                            offForms.widget.runner = formData.runner;
                            offForms.widget.match = ("/%s %s"):format(formData.name, formData.params):gsub(" ", "%%s+");
                            offForms.widget.runner(offForms.widget.form_name, offForms.widget.form, offForms.widget.match);

                            while (offForms.process) do
                                wait(0);

                                if (os.time() - current_time > 10) then
                                    offForms.process = false;
                                    offForms.widget = {};
                                    check.offForms = nil;
                                end
                            end
                        end
                    else
                        local query = "UPDATE `arizona`.form_off_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8('Форма отключена на сервере.') .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `form_id` = " .. v.form_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        offForms.process = false;
                        offForms.widget = {};
                        check.offForms = nil;
                    end
                end
            end
        end
        offForms.pool = {};
        process = false;
    end

    while (offForms.b) do
        wait(1 * 1000 * 10);
        if (settings.bot_is_spawned) then
            if (not process) then
                offForms.pool = {};
 
                local query = "SELECT * FROM `arizona`.form_off_system WHERE `time_created` <= NOW() AND `accepted` = 1 AND `passed` = 0 AND `server_id` = " .. server_id .. ';';
                local data = mysqlQuery(query);

                if (data) then
                    for i, v in ipairs(data) do
                        table.insert(offForms.pool, {
                            form_id = v.form_id,
                            form = v.form,
                            time = v.time_created
                        });
                    end
                end

                check_and_send();
            end
        else
            process = false;
        end
    end
end

function compensations_forms()
    if (not compensations.b) then return end;
    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | compensations_forms ] pledge: " .. tostring(check.pledge) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | spawncars: " .. tostring(check.spawncars) .. " | props: " .. tostring(check.props) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | morg: " .. tostring(check.morg) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | recovery_fraction: " .. tostring(check.recovery_fraction), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.spawncars) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.morg) then return end;
        if (check.recovery_account) then return end;
        if (check.recovery_fraction) then return end;

        local spawned = false;
        process = true;

        for _, v in ipairs(compensations.pool) do
            compensations.process = true;
            local args = string.split(v.form);
            args[1] = string.lower(args[1] or "");

            for _, formData in ipairs(compensations.list) do
                if (args[1] == ("/%s"):format(formData.name)) then
                    local f_plId = formData.param_target + 1;
                    local complaintId = tonumber(v.url:match("%d+"));

                    if (not spawned) then
                        spawned = true;
                        license.sellLicenses = false;
                        check.compensations = true;

                        set_bot_position();
                    end

                    if (v.denied) then
                        local query = "UPDATE `arizona`.compensations_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `compensation_id` = " .. v.compensation_id .. " AND `server_id` = " .. server_id .. ';';
                        mysqlQuery(query);

                        sendMessage("/notif " .. args[f_plId] .. " Заявка на компенсацию по жалобе №" .. complaintId .. " была отклонена администратором " .. v.administrator .. ".");
                    else
                        local year, month, day, hour, min, sec = v.time:match("(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)");

                        local date_table = {
                            year = tonumber(year),
                            month = tonumber(month),
                            day = tonumber(day),
                            hour = tonumber(hour),
                            min = tonumber(min),
                            sec = tonumber(sec)
                        };

                        local target_time = os.time(date_table);
                        local current_time = os.time();

                        if ((current_time - target_time) >= (7 * 24 * 60 * 60)) then
                            local query = "UPDATE `arizona`.compensations_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Прошло 7 дней.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `compensation_id` = " .. v.compensation_id .. " AND `server_id` = " .. server_id .. ';';
                            mysqlQuery(query);

                            sendMessage("/notif " .. args[f_plId] .. " Заявка на компенсацию по жалобе №" .. complaintId .. " была отклонена из-за ошибки.");

                            compensations.process = false;
                            compensations.widget = {};
                        else
                            wait(1 * 1000 * 3);

                            compensations.widget.form_name = args[1]:gsub("/", "");
                            compensations.widget.args = args;
                            compensations.widget.compensation_id = v.compensation_id;
                            compensations.widget.f_plId = f_plId;
                            compensations.widget.player = args[f_plId];
                            compensations.widget.administrator = v.administrator;
                            compensations.widget.complaintId = complaintId;
                            compensations.widget.form = table.concat(args, " ");
                            compensations.widget.runner = formData.runner;
                            compensations.widget.match = ("/%s %s"):format(formData.name, formData.params):gsub(" ", "%%s+");
                            compensations.widget.runner(compensations.widget.form_name, compensations.widget.form, compensations.widget.match);

                            while (compensations.process) do
                                wait(0);

                                if (os.time() - current_time > 10) then
                                    compensations.process = false;
                                    compensations.widget = {};
                                end
                            end
                        end
                    end
                end
            end
        end
        compensations.pool = {};
        check.compensations = false;
        process = false;
    end

    while (compensations.b) do
        wait(1 * 1000 * 10);
        if (settings.bot_is_spawned) then
            if (not process) then
                compensations.pool = {};

                local query = "SELECT * FROM `arizona`.compensations_system WHERE `accepted` = 1 AND `passed` = 0 AND `server_id` = " .. server_id .. ';';
                local data = mysqlQuery(query);

                if (data) then
                    for i, v in ipairs(data) do
                        table.insert(compensations.pool, {
                            compensation_id = v.compensation_id,
                            form = v.form,
                            denied = v.denied == 1,
                            url = v.url,
                            administrator = v.user_accepted,
                            time = v.time_created
                        });
                    end
                end

                check_and_send();
            end
        else
            process = false;
        end
    end
end

function recovery_fraction_forms()
    if (not recovery_fraction.b) then return end;
    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | recovery_fraction_forms ] pledge: " .. tostring(check.pledge) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | spawncars: " .. tostring(check.spawncars) .. " | props: " .. tostring(check.props) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | morg: " .. tostring(check.morg) .. " | recovery_account: " .. tostring(check.recovery_account) .. " | compensations: " .. tostring(check.compensations), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.spawncars) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.morg) then return end;
        if (check.compensations) then return end;
        if (check.recovery_account) then return end;

        local spawned = false;
        process = true;

        for _, form in ipairs(recovery_fraction.pool) do
            local complaintId = tonumber(form.url:match("%d+"));
            recovery_fraction.process = true;

            if (form.denied) then
                if (not spawned) then
                    spawned = true;
                    license.sellLicenses = false;
                    check.recovery_fraction = true;

                    set_bot_position();
                end

                local query = "UPDATE `arizona`.recovery_fraction_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. form.uid .. " AND `server_id` = " .. server_id .. ';';
                mysqlQuery(query);

                sendMessage("/notif " .. form.player .. " Заявка на восстановление во фракции по жалобе №" .. complaintId .. " была отклонена администратором " .. form.administrator .. ".");
            else
                local year, month, day, hour, min, sec = form.time:match("(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)");

                local date_table = {
                    year = tonumber(year),
                    month = tonumber(month),
                    day = tonumber(day),
                    hour = tonumber(hour),
                    min = tonumber(min),
                    sec = tonumber(sec)
                };

                local target_time = os.time(date_table);
                local current_time = os.time();

                if ((current_time - target_time) >= (7 * 24 * 60 * 60)) then
                    if (not spawned) then
                        spawned = true;
                        license.sellLicenses = false;
                        check.recovery_fraction = true;

                        set_bot_position();
                    end

                    local query = "UPDATE `arizona`.recovery_fraction_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Прошло 7 дней.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. form.uid .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    sendMessage("/notif " .. form.player .. " Заявка на восстановление во фракции по жалобе №" .. complaintId .. " была отклонена из-за ошибки.");

                    recovery_fraction.process = false;
                else
                    if (getPlayerIdByNickname(form.player) >= 0) then
                        if (not spawned) then
                            spawned = true;
                            license.sellLicenses = false;
                            check.recovery_fraction = true;

                            set_bot_position();
                        end

                        check.recovery_fraction = {
                            uid = form.uid,
                            player = form.player,
                            administrator = form.administrator,
                            complaintId = complaintId
                        };

                        sendMessage("/setmember " .. getPlayerIdByNickname(form.player) .. " " .. form.fraction .. " " .. form.rank .. " по жалобе №" .. complaintId);
                    end

                    while (recovery_fraction.process) do
                        wait(0);

                        if (os.time() - current_time > 10) then
                            recovery_fraction.process = false;
                        end
                    end
                end
            end
        end

        recovery_fraction.pool = {};
        check.recovery_fraction = false;
        process = false;
    end

    while (recovery_fraction.b) do
        wait(1 * 1000 * 10);
        if (settings.bot_is_spawned) then
            if (not process) then
                recovery_fraction.pool = {};

                local query = "SELECT * FROM `arizona`.recovery_fraction_system WHERE `accepted` = 1 AND `passed` = 0 AND `server_id` = " .. server_id .. ';';
                local data = mysqlQuery(query);

                if (data) then
                    for i, v in ipairs(data) do
                        table.insert(recovery_fraction.pool, {
                            uid = v.uid,
                            denied = v.denied == 1,
                            url = v.url,
                            fraction = v.fraction,
                            rank = v.rank,
                            player = v.user_created,
                            administrator = v.user_accepted,
                            time = v.time_created
                        });
                    end
                end

                check_and_send();
            end
        else
            process = false;
        end
    end
end

function recovery_account_forms()
    if (not recovery_account.b) then return end;
    local process = false;

    local function check_and_send()
        -- DEBUG("[ DEBUG | recovery_account_forms ] pledge: " .. tostring(check.pledge) .. " | mpdonate: " .. tostring(check.mpdonate) .. " | spawncars: " .. tostring(check.spawncars) .. " | props: " .. tostring(check.props) .. " | bot_bandit: " .. tostring(check.bot_bandit) .. " | businesses_mafia: " .. tostring(check.businesses_mafia) .. " | server_stats: " .. tostring(check.server_stats == "svrnt") .. " | morg: " .. tostring(check.morg) .. " | recovery_fraction: " .. tostring(check.recovery_fraction) .. " | compensations: " .. tostring(check.compensations), settings.debug);
        if (process) then return end;
        if (check.mpdonate) then return end;
        if (check.offForms) then return end;
        if (check.props) then return end;
        if (check.pledge) then return end;
        if (check.spawncars) then return end;
        if (check.server_stats == "svrnt") then return end;
        if (check.businesses_mafia) then return end;
        if (check.bot_bandit) then return end;
        if (check.morg) then return end;
        if (check.compensations) then return end;
        if (check.recovery_fraction) then return end;

        local spawned = false;
        process = true;

        for _, form in ipairs(recovery_account.pool) do
            local complaintId = tonumber(form.url:match("%d+"));
            recovery_account.process = true;

            if (not spawned) then
                spawned = true;
                license.sellLicenses = false;
                check.recovery_account = true;

                set_bot_position();
            end

            if (form.denied) then
                local query = "UPDATE `arizona`.recovery_account_system SET `passed` = 1, `time_passed` = DEFAULT WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. form.uid .. " AND `server_id` = " .. server_id .. ';';
                mysqlQuery(query);

                sendMessage("/notif " .. form.player .. " Заявка на восстановление аккаунта по жалобе №" .. complaintId .. " была отклонена администратором " .. form.administrator .. ".");
            else
                local year, month, day, hour, min, sec = form.time:match("(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)");

                local date_table = {
                    year = tonumber(year),
                    month = tonumber(month),
                    day = tonumber(day),
                    hour = tonumber(hour),
                    min = tonumber(min),
                    sec = tonumber(sec)
                };

                local target_time = os.time(date_table);
                local current_time = os.time();

                if ((current_time - target_time) >= (7 * 24 * 60 * 60)) then
                    local query = "UPDATE `arizona`.recovery_account_system SET `passed` = 1, `time_passed` = DEFAULT, `error` = 1, `text_error` = '" .. u8("Прошло 7 дней.") .. "' WHERE `accepted` = 1 AND `passed` = 0 AND `uid` = " .. form.uid .. " AND `server_id` = " .. server_id .. ';';
                    mysqlQuery(query);

                    sendMessage("/notif " .. form.player .. " Заявка на восстановление аккаунта по жалобе №" .. complaintId .. " была отклонена из-за ошибки.");

                    recovery_account.process = false;
                else
                    check.recovery_account = {
                        uid = form.uid,
                        player = form.player,
                        administrator = form.administrator,
                        complaintId = complaintId
                    };

                    sendMessage("/unban " .. form.player .. " по жалобе №" .. complaintId);

                    while (recovery_account.process) do
                        wait(0);

                        if (os.time() - current_time > 10) then
                            recovery_account.process = false;
                        end
                    end
                end
            end
        end

        recovery_account.pool = {};
        check.recovery_account = false;
        process = false;
    end

    while (recovery_account.b) do
        wait(1 * 1000 * 10);
        if (settings.bot_is_spawned) then
            if (not process) then
                recovery_account.pool = {};

                local query = "SELECT * FROM `arizona`.recovery_account_system WHERE `accepted` = 1 AND `passed` = 0 AND `server_id` = " .. server_id .. ';';
                local data = mysqlQuery(query);

                if (data) then
                    for i, v in ipairs(data) do
                        table.insert(recovery_account.pool, {
                            uid = v.uid,
                            denied = v.denied == 1,
                            url = v.url,
                            player = v.user_created,
                            administrator = v.user_accepted,
                            time = v.time_created
                        });
                    end
                end

                check_and_send();
            end
        else
            process = false;
        end
    end
end

function set_bot_position()
    if (settings.license_system) then
        if (license.sellLicenses) then
            sendMessage("/gc " .. settings.license_second_position);
        else
            sendMessage("/gc " .. settings.license_first_position);
        end
    else
        sendMessage("/gc " .. settings.spawn_position);
    end

    if (settings.amember_system) then
        if ((not check.morg) and (not check.props) and (not check.mpdonate) and (not check.spawncars) and (not check.pledge) and (not check.offForms) and (check.server_stats ~= 'svrnt')) then
            sendMessage("/amember " .. settings.amember_fraction .. " " .. settings.amember_rank);
        end
    end

    settings.bot_is_spawned = true;
end