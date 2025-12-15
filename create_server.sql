DROP TRIGGER IF EXISTS create_server;
CREATE TRIGGER create_server
AFTER INSERT ON arizona.servers_raksamp
FOR EACH ROW
BEGIN
    INSERT INTO arizona.server_stats_system (server_id, special_list, admins_list, leaders_list, zams_list)
    VALUES (NEW.server_id, '["Farmer", "Sam_Mason", "Conor", "root", "Ioan_Grozny", "Lucifer_Heaven", "Christian_Carrington", "Dorian_Gray", "Hasdasok_Hasdmai"]', '[]', '[]', '[]');

    INSERT INTO arizona.vk_chats (server_id, chief, admin, other)
    VALUES (NEW.server_id, '[]', '[]', '[]');
    INSERT INTO arizona.vk_access (server_id)
    VALUES (NEW.server_id);

    INSERT INTO arizona.discord_guilds (server_id)
    VALUES (NEW.server_id);
    INSERT INTO arizona.discord_roles(server_id)
    VALUES (NEW.server_id);
    INSERT INTO arizona.discord_channels (server_id)
    VALUES (NEW.server_id);
    INSERT INTO arizona.discord_messages (server_id)
    VALUES (NEW.server_id);
    INSERT INTO arizona.discord_access (server_id, tasks_start, tasks_restart, tasks_stop,
                                            accept, pledge, recovery_fraction,
                                            recovery_account, compensations, off_forms_ao,
                                            off_forms_makeleader, off_forms_unleader, off_forms_makejudge,
                                            off_forms_unjudge, off_forms_setname, off_forms_pay, off_forms_agl,
                                            off_forms_givemydonate, off_forms_giveantijail,
                                            off_forms_giveantimute, off_forms_ungiveantimute,
                                            off_forms_givedemotalon, off_forms_ungivedemotalon, off_forms_notif,
                                            off_forms_votestart, off_forms_votestop, off_forms_famwarban,
                                            off_forms_unfamwarban, off_forms_props, off_forms_apunish,
                                            off_forms_unapunish, off_forms_ban, off_forms_unban,
                                            off_forms_gunban, off_forms_ungunban, off_forms_driverban,
                                            off_forms_undriverban, off_forms_banip, off_forms_unbanip,
                                            off_forms_warn, off_forms_unwarn, off_forms_mute,
                                            off_forms_unmute, off_forms_jail, off_forms_unjail,
                                            off_forms_setmember, off_forms_uval, off_forms_rasform,
                                            off_forms_stopfractionpeace, off_forms_stopfractionwar,
                                            off_forms_cancelfamgz, off_forms_setbizmafia, off_forms_setfamgz,
                                            off_forms_setgangzone, off_forms_rmute, off_forms_unrmute,
                                            off_forms_delhname, off_forms_delbname, off_forms_defmarker)
    VALUES (NEW.server_id, '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]',
            '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]',
            '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]', '[]',
            '[]', '[]', '[]', '[]', '[]', '[]');

    INSERT INTO arizona.judges_system (server_id, judge_id)
    VALUES (NEW.server_id, 1);
    INSERT INTO arizona.judges_system (server_id, judge_id)
    VALUES (NEW.server_id, 2);
    INSERT INTO arizona.judges_system (server_id, judge_id)
    VALUES (NEW.server_id, 3);
    INSERT INTO arizona.judges_system (server_id, judge_id)
    VALUES (NEW.server_id, 4);
    INSERT INTO arizona.judges_system (server_id, judge_id)
    VALUES (NEW.server_id, 5);

    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 1, 'Полиция Лос-Сантоса', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 2, 'Областная полиция', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 3, 'FBI', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 4, 'Полиция Сан-Фиерро', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 5, 'Больница Лос-Сантоса', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 6, 'Правительство Лос-Сантоса', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 7, 'Тюрьма строгого режима', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 8, 'Больница Сан-Фиерро', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 9, 'Центр лицензирования', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 10, 'Радиостудия Лос-Сантоса', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 11, 'Grove Street', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 12, 'Los Santos Vagos', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 13, 'East Side Ballas', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 14, 'Varrios Los Aztecas', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 15, 'The Rifa', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 16, 'Russian Mafia', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 17, 'Yakuza', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 18, 'La Cosa Nostra', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 19, 'Warlock MC', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 20, 'Армия Лос-Сантоса', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 21, 'Центральный банк', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 22, 'Больница Лас-Вентурас', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 23, 'Полиция Лас-Вентурас', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 24, 'Радиостудия Лас-Вентураса', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 25, 'Night Wolves', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 26, 'Радиостудия Сан-Фиерро', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 27, 'Армия Сан-Фиерро', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 28, 'Тёмное братство', '[]', 0, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 29, 'Страховая компания', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 30, 'Tierra Robada Bikers', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 31, 'Больница Jefferson', '[]', 1, '[]');
    INSERT INTO arizona.fractions_system (server_id, fraction_id, fraction_name, members, private, owner_deputies)
    VALUES (NEW.server_id, 32, 'Пожарный департамент', '[]', 0, '[]');

    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 1, 1642, -962, 1770, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 2, 1770, -962, 1898, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 3, 1898, -962, 2026, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 4, 2026, -962, 2154, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 5, 2154, -962, 2282, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 6, 2282, -962, 2410, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 7, 2410, -962, 2538, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 8, 2538, -962, 2666, -861, false, true, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 9, 2666, -962, 2794, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 10, 2794, -962, 2922, -861, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 11, 1642, -1063, 1770, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 12, 1770, -1063, 1898, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 13, 1898, -1063, 2026, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 14, 2026, -1063, 2154, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 15, 2154, -1063, 2282, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 16, 2282, -1063, 2410, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 17, 2410, -1063, 2538, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 18, 2538, -1063, 2666, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 19, 2666, -1063, 2794, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 20, 2794, -1063, 2922, -962, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 21, 1642, -1164, 1770, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 22, 1770, -1164, 1898, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 23, 1898, -1164, 2026, -1063, true, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 24, 2026, -1164, 2154, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 25, 2154, -1164, 2282, -1063, true, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 26, 2282, -1164, 2410, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 27, 2410, -1164, 2538, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 28, 2538, -1164, 2666, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 29, 2666, -1164, 2794, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 30, 2794, -1164, 2922, -1063, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 31, 1642, -1265, 1770, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 32, 1770, -1265, 1898, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 33, 1898, -1265, 2026, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 34, 2026, -1265, 2154, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 35, 2154, -1265, 2282, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 36, 2282, -1265, 2410, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 37, 2410, -1265, 2538, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 38, 2538, -1265, 2666, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 39, 2666, -1265, 2794, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 40, 2794, -1265, 2922, -1164, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 41, 1642, -1366, 1770, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 42, 1770, -1366, 1898, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 43, 1898, -1366, 2026, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 44, 2026, -1366, 2154, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 45, 2154, -1366, 2282, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 46, 2282, -1366, 2410, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 47, 2410, -1366, 2538, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 48, 2538, -1366, 2666, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 49, 2666, -1366, 2794, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 50, 2794, -1366, 2922, -1265, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 51, 1642, -1467, 1770, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 52, 1770, -1467, 1898, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 53, 1898, -1467, 2026, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 54, 2026, -1467, 2154, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 55, 2154, -1467, 2282, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 56, 2282, -1467, 2410, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 57, 2410, -1467, 2538, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 58, 2538, -1467, 2666, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 59, 2666, -1467, 2794, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 60, 2794, -1467, 2922, -1366, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 61, 1642, -1568, 1770, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 62, 1770, -1568, 1898, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 63, 1898, -1568, 2026, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 64, 2026, -1568, 2154, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 65, 2154, -1568, 2282, -1467, false, true, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 66, 2282, -1568, 2410, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 67, 2410, -1568, 2538, -1467, false, true, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 68, 2538, -1568, 2666, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 69, 2666, -1568, 2794, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 70, 2794, -1568, 2922, -1467, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 71, 1642, -1669, 1770, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 72, 1770, -1669, 1898, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 73, 1898, -1669, 2026, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 74, 2026, -1669, 2154, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 75, 2154, -1669, 2282, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 76, 2282, -1669, 2410, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 77, 2410, -1669, 2538, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 78, 2538, -1669, 2666, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 79, 2666, -1669, 2794, -1568, true, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 80, 2794, -1669, 2922, -1568, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 81, 1642, -1770, 1770, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 82, 1770, -1770, 1898, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 83, 1898, -1770, 2026, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 84, 2026, -1770, 2154, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 85, 2154, -1770, 2282, -1669, false, true, true);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 86, 2282, -1770, 2410, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 87, 2410, -1770, 2538, -1669, true, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 88, 2538, -1770, 2666, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 89, 2666, -1770, 2794, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 90, 2794, -1770, 2922, -1669, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 91, 1642, -1871, 1770, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 92, 1770, -1871, 1898, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 93, 1898, -1871, 2026, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 94, 2026, -1871, 2154, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 95, 2154, -1871, 2282, -1770, true, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 96, 2282, -1871, 2410, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 97, 2410, -1871, 2538, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 98, 2538, -1871, 2666, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 99, 2666, -1871, 2794, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 100, 2794, -1871, 2922, -1770, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 101, 1642, -1972, 1770, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 102, 1770, -1972, 1898, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 103, 1898, -1972, 2026, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 104, 2026, -1972, 2154, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 105, 2154, -1972, 2282, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 106, 2282, -1972, 2410, -1871, false, true, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 107, 2410, -1972, 2538, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 108, 2538, -1972, 2666, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 109, 2666, -1972, 2794, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 110, 2794, -1972, 2922, -1871, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 111, 1642, -2073, 1770, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 112, 1770, -2073, 1898, -1972, false, true, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 113, 1898, -2073, 2026, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 114, 2026, -2073, 2154, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 115, 2154, -2073, 2282, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 116, 2282, -2073, 2410, -1972, false, true, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 117, 2410, -2073, 2538, -1972, true, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 118, 2538, -2073, 2666, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 119, 2666, -2073, 2794, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 120, 2794, -2073, 2922, -1972, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 121, 1642, -2174, 1770, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 122, 1770, -2174, 1898, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 123, 1898, -2174, 2026, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 124, 2026, -2174, 2154, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 125, 2154, -2174, 2282, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 126, 2282, -2174, 2410, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 127, 2410, -2174, 2538, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 128, 2538, -2174, 2666, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 129, 2666, -2174, 2794, -2073, false, false, false);
    INSERT INTO arizona.gangzones_ghetto_system (server_id, zone_id, x1, y1, x2, y2, is_respawn, is_drug_den, is_central)
    VALUES (NEW.server_id, 130, 2794, -2174, 2922, -2073, false, false, false);

    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 1, 1222, 2459, 1344, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 2, 1344, 2459, 1467, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 3, 1467, 2459, 1589, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 4, 1589, 2459, 1712, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 5, 1712, 2459, 1834, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 6, 1834, 2459, 1957, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 7, 1957, 2459, 2079, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 8, 2079, 2459, 2202, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 9, 2202, 2459, 2324, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 10, 2324, 2459, 2447, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 11, 2447, 2459, 2569, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 12, 2569, 2459, 2692, 2595, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 13, 1222, 2323, 1344, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 14, 1344, 2323, 1467, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 15, 1467, 2323, 1589, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 16, 1589, 2323, 1712, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 17, 1712, 2323, 1834, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 18, 1834, 2323, 1957, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 19, 1957, 2323, 2079, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 20, 2079, 2323, 2202, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 21, 2202, 2323, 2324, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 22, 2324, 2323, 2447, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 23, 2447, 2323, 2569, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 24, 2569, 2323, 2692, 2459, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 25, 1222, 2187, 1344, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 26, 1344, 2187, 1467, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 27, 1467, 2187, 1589, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 28, 1589, 2187, 1712, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 29, 1712, 2187, 1834, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 30, 1834, 2187, 1957, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 31, 1957, 2187, 2079, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 32, 2079, 2187, 2202, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 33, 2202, 2187, 2324, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 34, 2324, 2187, 2447, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 35, 2447, 2187, 2569, 2323, true);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 36, 2569, 2187, 2692, 2323, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 37, 1222, 2051, 1344, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 38, 1344, 2051, 1467, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 39, 1467, 2051, 1589, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 40, 1589, 2051, 1712, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 41, 1712, 2051, 1834, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 42, 1834, 2051, 1957, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 43, 1957, 2051, 2079, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 44, 2079, 2051, 2202, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 45, 2202, 2051, 2324, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 46, 2324, 2051, 2447, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 47, 2447, 2051, 2569, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 48, 2569, 2051, 2692, 2187, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 49, 1222, 1916, 1344, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 50, 1344, 1916, 1467, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 51, 1467, 1916, 1589, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 52, 1589, 1916, 1712, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 53, 1712, 1916, 1834, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 54, 1834, 1916, 1957, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 55, 1957, 1916, 2079, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 56, 2079, 1916, 2202, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 57, 2202, 1916, 2324, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 58, 2324, 1916, 2447, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 59, 2447, 1916, 2569, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 60, 2569, 1916, 2692, 2051, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 61, 1222, 1780, 1344, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 62, 1344, 1780, 1467, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 63, 1467, 1780, 1589, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 64, 1589, 1780, 1712, 1916, true);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 65, 1712, 1780, 1834, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 66, 1834, 1780, 1957, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 67, 1957, 1780, 2079, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 68, 2079, 1780, 2202, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 69, 2202, 1780, 2324, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 70, 2324, 1780, 2447, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 71, 2447, 1780, 2569, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 72, 2569, 1780, 2692, 1916, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 73, 1222, 1644, 1344, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 74, 1344, 1644, 1467, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 75, 1467, 1644, 1589, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 76, 1589, 1644, 1712, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 77, 1712, 1644, 1834, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 78, 1834, 1644, 1957, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 79, 1957, 1644, 2079, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 80, 2079, 1644, 2202, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 81, 2202, 1644, 2324, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 82, 2324, 1644, 2447, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 83, 2447, 1644, 2569, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 84, 2569, 1644, 2692, 1780, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 85, 1222, 1508, 1344, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 86, 1344, 1508, 1467, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 87, 1467, 1508, 1589, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 88, 1589, 1508, 1712, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 89, 1712, 1508, 1834, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 90, 1834, 1508, 1957, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 91, 1957, 1508, 2079, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 92, 2079, 1508, 2202, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 93, 2202, 1508, 2324, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 94, 2324, 1508, 2447, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 95, 2447, 1508, 2569, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 96, 2569, 1508, 2692, 1644, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 97, 1222, 1372, 1344, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 98, 1344, 1372, 1467, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 99, 1467, 1372, 1589, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 100, 1589, 1372, 1712, 1508, true);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 101, 1712, 1372, 1834, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 102, 1834, 1372, 1957, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 103, 1957, 1372, 2079, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 104, 2079, 1372, 2202, 1508, true);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 105, 2202, 1372, 2324, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 106, 2324, 1372, 2447, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 107, 2447, 1372, 2569, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 108, 2569, 1372, 2692, 1508, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 109, 1222, 1236, 1344, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 110, 1344, 1236, 1467, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 111, 1467, 1236, 1589, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 112, 1589, 1236, 1712, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 113, 1712, 1236, 1834, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 114, 1834, 1236, 1957, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 115, 1957, 1236, 2079, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 116, 2079, 1236, 2202, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 117, 2202, 1236, 2324, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 118, 2324, 1236, 2447, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 119, 2447, 1236, 2569, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 120, 2569, 1236, 2692, 1372, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 121, 1222, 1100, 1344, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 122, 1344, 1100, 1467, 1236, true);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 123, 1467, 1100, 1589, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 124, 1589, 1100, 1712, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 125, 1712, 1100, 1834, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 126, 1834, 1100, 1957, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 127, 1957, 1100, 2079, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 128, 2079, 1100, 2202, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 129, 2202, 1100, 2324, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 130, 2324, 1100, 2447, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 131, 2447, 1100, 2569, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 132, 2569, 1100, 2692, 1236, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 133, 1222, 964, 1344, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 134, 1344, 964, 1467, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 135, 1467, 964, 1589, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 136, 1589, 964, 1712, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 137, 1712, 964, 1834, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 138, 1834, 964, 1957, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 139, 1957, 964, 2079, 1100, true);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 140, 2079, 964, 2202, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 141, 2202, 964, 2324, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 142, 2324, 964, 2447, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 143, 2447, 964, 2569, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 144, 2569, 964, 2692, 1100, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 145, 1222, 828, 1344, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 146, 1344, 828, 1467, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 147, 1467, 828, 1589, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 148, 1589, 828, 1712, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 149, 1712, 828, 1834, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 150, 1834, 828, 1957, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 151, 1957, 828, 2079, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 152, 2079, 828, 2202, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 153, 2202, 828, 2324, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 154, 2324, 828, 2447, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 155, 2447, 828, 2569, 964, false);
    INSERT INTO arizona.gangzones_family_system (server_id, zone_id, x1, y1, x2, y2, is_enterprise)
    VALUES (NEW.server_id, 156, 2569, 828, 2692, 964, false);

    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 0, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 1, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 2, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 3, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 4, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 5, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 6, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 7, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 8, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 9, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 10, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 11, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 12, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 13, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 14, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 15, 'Предприятие');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 16, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 17, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 18, 'Тюнинг салон');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 19, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 20, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 21, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 22, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 23, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 24, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 25, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 26, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 27, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 28, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 29, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 30, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 31, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 32, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 33, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 34, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 35, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 36, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 37, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 38, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 39, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 40, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 41, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 42, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 43, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 44, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 45, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 46, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 47, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 48, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 49, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 50, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 51, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 52, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 53, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 54, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 55, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 56, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 57, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 58, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 59, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 60, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 61, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 62, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 63, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 64, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 65, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 66, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 67, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 68, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 69, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 70, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 71, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 72, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 73, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 74, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 75, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 76, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 77, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 78, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 79, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 80, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 81, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 82, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 83, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 84, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 85, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 86, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 87, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 88, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 89, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 90, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 91, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 92, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 93, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 94, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 95, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 96, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 97, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 98, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 99, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 100, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 101, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 102, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 103, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 104, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 105, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 106, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 107, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 108, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 109, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 110, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 111, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 112, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 113, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 114, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 115, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 116, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 117, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 118, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 119, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 120, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 121, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 122, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 123, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 124, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 125, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 126, 'Предприятие');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 127, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 128, 'Телефонные коммуникации');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 129, 'Предприятие');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 130, 'Телефонные коммуникации');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 131, 'Предприятие');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 132, 'Телефонные коммуникации');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 133, 'Предприятие');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 134, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 135, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 136, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 137, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 138, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 139, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 140, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 141, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 142, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 143, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 144, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 145, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 146, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 147, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 148, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 149, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 150, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 151, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 152, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 153, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 154, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 155, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 156, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 157, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 158, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 159, 'Авто-сервис LS');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 160, 'Авто-сервис SF');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 161, 'Авто-сервис LV');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 162, 'Нет названия');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 163, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 164, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 165, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 166, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 167, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 168, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 169, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 170, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 171, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 172, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 173, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 174, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 175, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 176, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 177, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 178, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 179, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 180, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 181, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 182, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 183, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 184, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 185, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 186, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 187, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 188, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 189, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 190, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 191, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 192, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 193, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 194, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 195, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 196, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 197, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 198, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 199, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 200, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 201, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 202, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 203, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 204, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 205, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 206, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 207, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 208, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 209, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 210, 'Ферма');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 211, 'Шахта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 212, 'Риелторское агентство');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 213, 'Автомастерская');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 214, 'Концертный зал');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 215, 'Аренда транспорта');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 216, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 217, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 218, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 219, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 220, 'Автосалон эконом');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 221, 'Автосалон средний');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 222, 'Автосалон люкс');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 223, 'Магазин тюнинга LS');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 224, 'Магазин тюнинга SF');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 225, 'Магазин тюнинга LV');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 226, 'Sport Club LV');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 227, 'Аукцион контейнеров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 228, 'Автомастерская FC');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 229, 'Казино (4 Дракона)');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 230, 'Центральный Рынок');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 231, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 232, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 233, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 234, 'Школа танцев');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 235, 'Школа танцев');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 236, 'Школа танцев');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 237, 'Мастерская одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 238, 'Мастерская одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 239, 'Мастерская одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 240, 'Мастерская одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 241, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 242, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 243, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 244, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 245, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 246, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 247, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 248, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 249, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 250, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 251, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 252, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 253, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 254, 'Сельскохозяйственный магазин');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 255, 'Сельскохозяйственный магазин');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 256, 'Аренда сельхоз техники');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 257, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 258, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 259, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 260, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 261, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 262, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 263, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 264, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 265, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 266, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 267, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 268, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 269, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 270, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 271, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 272, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 273, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 274, 'Спортивная площадка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 275, 'Автосалон Luxe');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 276, 'Магазин видеокарт');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 277, 'Магазин видеокарт');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 278, 'Магазин видеокарт');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 279, 'Тест-Драйв');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 280, 'Кинотеатр AZMAX');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 281, 'Секонд хенд');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 282, 'Секонд хенд');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 283, 'Секонд хенд');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 284, 'Секонд хенд');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 285, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 286, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 287, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 288, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 289, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 290, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 291, 'Букмекерская компания');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 292, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 293, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 294, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 295, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 296, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 297, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 298, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 299, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 300, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 301, 'Лотерейная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 302, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 303, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 304, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 305, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 306, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 307, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 308, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 309, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 310, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 311, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 312, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 313, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 314, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 315, 'Авто Сервис');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 316, 'Тюнинг салон');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 317, 'Склад Дальнобойщиков');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 318, 'Склад Дальнобойщиков');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 319, 'Склад Дальнобойщиков');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 320, 'Амуниция/Тир');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 321, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 322, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 323, 'Стриптиз Клуб');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 324, 'Рыболовный магазин');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 325, 'Рыболовный магазин');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 326, 'Рыболовный магазин');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 327, 'Рыболовный магазин');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 328, 'Ларек с уличной едой');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 329, 'Ломбард');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 330, 'Ломбард');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 331, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 332, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 333, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 334, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 335, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 336, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 337, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 338, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 339, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 340, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 341, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 342, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 343, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 344, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 345, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 346, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 347, 'Нефтевышка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 348, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 349, 'Отель');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 350, 'Магазин одежды');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 351, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 352, 'Магазин аксессуаров');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 353, 'Магазин 24/7');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 354, 'Эликсир Мастер');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 355, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 356, 'Бар');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 357, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 358, 'Закусочная');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 359, 'АЗС/Магазин механики');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 360, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 361, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 362, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 363, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 364, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 365, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 366, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 367, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 368, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 369, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 370, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 371, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 372, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 373, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 374, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 375, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 376, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 377, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 378, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 379, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 380, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 381, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 382, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 383, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 384, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 385, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 386, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 387, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 388, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 389, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 390, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 391, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 392, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 393, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 394, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 395, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 396, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 397, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 398, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 399, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 400, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 401, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 402, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 403, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 404, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 405, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 406, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 407, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 408, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 409, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 410, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 411, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 412, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 413, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 414, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 415, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 416, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 417, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 418, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 419, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 420, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 421, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 422, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 423, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 424, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 425, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 426, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 427, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 428, 'Бар LUX');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 429, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 430, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 431, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 432, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 433, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 434, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 435, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 436, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 437, 'Киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 438, 'Центр Обмена Имуществом');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 439, 'Электрокомпания');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 440, 'Электрокомпания');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 441, 'Электрокомпания');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 442, 'Электрокомпания');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 443, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 444, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 445, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 446, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 447, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 448, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 449, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 450, 'Парковочное место');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 451, 'Админский киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 452, 'Админский киоск');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 453, 'Админский тест-драйв');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 454, 'Админская палатка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 455, 'Админская палатка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 456, 'Админская палатка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 457, 'Админская палатка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 458, 'Админская палатка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 459, 'Админская палатка');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 460, 'Пункт выдачи');
    INSERT INTO arizona.businesses_mafia_system (server_id, business_id, name)
    VALUES (NEW.server_id, 461, 'Лодочный базар');
END;