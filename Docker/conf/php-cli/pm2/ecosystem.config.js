module.exports = {
    apps: [{
        name: "nextcloud-cron",
        script: "/var/www/nextcloud/releases/current/cron.php --define apc.enable_cli=1",
        cron_restart: "*/5  *  *  *  *",
        autorestart: false,
        watch: true
    }]
}
