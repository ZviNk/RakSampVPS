/* IMPORTING LIBRARIES: */
require('dotenv').config(); /* FOR USING .env AS CONFIG */
const {exec} = require('node:child_process');
const {db} = require("./db");
const {readdirSync, unlinkSync, existsSync, mkdirSync} = require("fs");
const {join, resolve} = require("path");

main();
setInterval(checkTasks, 5000);
setInterval(checkLogs, 60 * 60 * 1000);

async function main() {
    const servers = await db(`SELECT * FROM \`arizona\`.servers_raksamp WHERE \`active\` = true AND \`start\` = true;`);

    for (const server of servers) {
        await createLogs(server.server_id);
        await exec(`wine raksamp/arizona.exe -project 1 -server ${server.server_id}`);
        console.log(`[ RakSamp ] Started ${server.server_name} [IP: ${server.server_ip} | PORT: ${server.server_port}].`);
    }
}

async function checkTasks() {
    const tasks = await db(`SELECT * FROM \`arizona\`.tasks_system WHERE \`passed\` = false;`);

    for (const task of tasks) {
        const data = await db(`SELECT * FROM \`arizona\`.servers_raksamp WHERE \`server_id\` = ${task.server_id};`);
        const server = data[0];
        const time_created = new Date(task.time_created + ' UTC');
        const time_half_passed = new Date(task.time_half_passed + ' UTC');
        const time_passed = new Date(task.time_passed + ' UTC');

        if (!server.active) {
            await db(`UPDATE \`arizona\`.tasks_system SET \`error\` = true, \`text_error\` = "Система отключена на данном сервере." WHERE \`server_id\` = ${task.server_id};`);
            continue;
        }

        switch (task.task) {
            case 'restart':
                if (new Date() - time_created >= 10000) {
                    await db(`UPDATE \`arizona\`.tasks_system SET \`error\` = true, \`text_error\` = "Сервер выключен.", \`half_passed\` = true, \`time_half_passed\` = DEFAULT, \`passed\` = true, \`time_passed\` = DEFAULT WHERE \`server_id\` = ${server.server_id} AND \`task_id\` = ${task.task_id};`);
                    break;
                }
                if (!task.half_passed) break;

                await db(`UPDATE \`arizona\`.tasks_system SET \`passed\` = true WHERE \`server_id\` = ${server.server_id};`);
                await exec(`wine raksamp/arizona.exe -project 1 -server ${server.server_id}`);
                console.log(`[ RakSamp ] Restarted ${server.server_name} [IP: ${server.server_ip} | PORT: ${server.server_port}].`);
                break;
            case 'start':
                if (server.started) {
                    await db(`UPDATE \`arizona\`.tasks_system SET \`error\` = true, \`text_error\` = "Сервер уже запущен.", \`half_passed\` = true, \`time_half_passed\` = DEFAULT, \`passed\` = true, \`time_passed\` = DEFAULT WHERE \`server_id\` = ${server.server_id} AND \`task_id\` = ${task.task_id};`);
                    break;
                }

                await db(`UPDATE \`arizona\`.servers_raksamp SET \`start\` = true WHERE \`server_id\` = ${server.server_id};`);
                await db(`UPDATE \`arizona\`.tasks_system SET \`half_passed\` = true, \`time_half_passed\` = DEFAULT, \`passed\` = true, \`time_passed\` = DEFAULT WHERE \`server_id\` = ${server.server_id};`);
                await exec(`wine raksamp/arizona.exe -project 1 -server ${server.server_id}`);
                console.log(`[ RakSamp ] Started ${server.server_name} [IP: ${server.server_ip} | PORT: ${server.server_port}].`);
                break;
            case 'stop':
                if (new Date() - time_created >= 10000) {
                    await db(`UPDATE \`arizona\`.tasks_system SET \`error\` = true, \`text_error\` = "Сервер уже выключен.", \`half_passed\` = true, \`time_half_passed\` = DEFAULT, \`passed\` = true, \`time_passed\` = DEFAULT WHERE \`server_id\` = ${server.server_id} AND \`task_id\` = ${task.task_id};`);
                    break;
                }
                if (!task.half_passed) break;

                await db(`UPDATE \`arizona\`.tasks_system SET \`passed\` = true WHERE \`server_id\` = ${server.server_id};`);
                console.log(`[ RakSamp ] Stopped ${server.server_name} [IP: ${server.server_ip} | PORT: ${server.server_port}].`);
            default:
                break;
        }
    }
}

async function checkLogs() {
    const sixMonthsAgo = new Date();
    sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 6);
    const servers = readdirSync("./logs");

    for (const server of servers) {
        const serverLogsDir = join("./logs", server);
        const logs = readdirSync(`./logs/${server}`);

        for (const log of logs) {
            const logPath = join(serverLogsDir, log);

            const match = log.match(/^(\d{2})\.(\d{2})\.(\d{4})\.log$/);
            if (match) {
                const [_, day, month, year] = match;
                const logDate = new Date(`${year}-${month}-${day}`);

                if (logDate < sixMonthsAgo) {
                    unlinkSync(logPath);
                    console.log(`[ Logs ] Deleted "${log}" from server №${server}.`);
                }
            }
        }
    }
}

async function createLogs(id) {
    const logsPath = resolve(`${process.env.PATH_MAIN}/logs/${id}`);

    if (!existsSync(logsPath)) {
        mkdirSync(logsPath, { recursive: true });
        console.log(`[ Logs ] Created server №${id} logs directory.`);
    }
}