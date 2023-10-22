module.exports = {
    apps: [{
        name: "nextcloud-cron",
        script: "/var/www/nextcloud/releases/current/cron.php",
        cron_restart: "*/5  *  *  *  *",
        autorestart: false,
        watch: true
    }]
}
