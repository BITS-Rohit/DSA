-- Here we will meanwhile practice for our ARCH & SDK DB
SHOW databases;

-- Creating ARCH Based Plugin Table
CREATE DATABASE IF NOT EXISTS ARCH;
USE ARCH;

-- Main Table PLugin : primary key(id) , p_name , version , platform, added_at, last_updated

-- Helper Metadata :  foreign key (p_id) on plugin(id) ,  active , tool_count , desc , repo_url ,file_name(+ p_id : unique)
-- metadata on delete Cascade/Set Null (plugins history check)

-- Tool Data : Primary(Tool_id) ,  foreign key (p_id) on plugin (id) , desc , Event (on_msg) ,
-- Tool Requirement (Probably API keys Needed by this Tool)
    -- 1. It can have multiple requirements like more than 1 API
    -- Rather than having every tool to have Requirements , we can define like Total Requirements ?
    -- if we do this it can skip the privacy like it will ask for the unncessary Requirements and may send data to its own server too.
    -- we need to ensure the security of the intellect messages so that messages dont get to any other server while maintiaining flexibility and versatability .
    -- Also enforcing every Tool to have the requirements specific would help them for the strict Usefull Schema.
        -- Like if we need ony 2 tools form this module/plugin we can only give the API requirements for thoose tool only.
        -- So we should eventually have this requirement as per every Tool so enforce security + felxibitly

    -- foreign key(T_id) on Tools(Tool_id), id , APIs (:G_key,YT_key)
-- Also we have an DB from SDK as it logs messages, But if they use Devs Preffered architecture there data will be secured
    -- Also if the devs/users create their own Architecture then i think it will be in their own hands that how will they manage that or not.
    -- For our own Architecture(co-herent behaviour) we will Many Modes of Bot in future ( : Co-herent , Only Bot , Agent(advance) )
    -- That way user's can have their own preffered mode at any time + they can change it on runtime too (it will restart with that Mode Preference)



-- Futuristic : Event can be extended with like on_recieve , os_send , like that or other funcitonality as per the API associated with them in SDK
-- for Now SDK will have for now like will work on Message Features rather than other fucntions
    -- Also SDK will compromise all other apps like : arattai , Insta all in 1 sdk. so we can make it to work modular too like if they want only
    -- selected platform then only download those SDK it will save storage space + redundant dependencies
-- Rules and Format about the Messaging : we will define set of rules for users to use it strictly.


-- ---------------
-- First we will have our Bot to run as  :
    -- 1. Self : it will handle all chats byitself . replying by itself no human user need to reply or command based.
    -- 2. Co-op : it will work with the user while maintaining the

CREATE TABLE plugins
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    plugin_name  VARCHAR(50)  NOT NULL UNIQUE,
    description  VARCHAR(200) NOT NULL,
    author       VARCHAR(50)  NOT NULL,
    version      VARCHAR(20)  NOT NULL DEFAULT '1.0.0',
    active       BOOLEAN      NOT NULL DEFAULT FALSE,
    added_at     TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tool_count   INT          NOT NULL DEFAULT 1,
    platform     VARCHAR(30)  NOT NULL, -- Enum('Whatsapp' , 'Instagram', 'Arattai' , '')
    entry_file   VARCHAR(100) NOT NULL,
    repo_url     VARCHAR(100) UNIQUE NOT NULL ,
    Support_Emails VARCHAR(50) UNIQUE NOT NULL,
    CHECK (version REGEXP
           '^[0-9]+\\.[0-9]+\\.[0-9]+(-[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*)?(\\+[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*)?$')
);

CREATE INDEX idx_platform ON plugins (platform);

SELECT *
from plugins;

INSERT INTO plugins
(plugin_name, description, author, version, active, tool_count, platform, entry_file, repo_url, Support_Emails)
VALUES
    ('AutoResponder', 'Automates replies', 'Rohit', '1.0.0', TRUE, 3, 'Whatsapp', 'main.js', 'https://repo/p1', 's1@plug.dev'),
    ('InstaScraper', 'Scrapes Instagram profiles', 'Amit', '1.2.0', FALSE, 2, 'Instagram', 'scraper.py', 'https://repo/p2', 's2@plug.dev'),
    ('TeleBot', 'Telegram bot engine', 'Neha', '2.0.1', TRUE, 4, 'Telegram', 'bot.js', 'https://repo/p3', 's3@plug.dev'),
    ('ArattaiBridge', 'Bridge between platforms', 'Karan', '0.9.0', FALSE, 1, 'Arattai', 'bridge.ts', 'https://repo/p4', 's4@plug.dev'),
    ('FormFiller', 'Auto fills forms', 'Rohit', '1.3.0', TRUE, 5, 'Whatsapp', 'filler.py', 'https://repo/p5', 's5@plug.dev'),
    ('InstaUploader', 'Uploads reels', 'Priya', '1.1.0', TRUE, 2, 'Instagram', 'upload.js', 'https://repo/p6', 's6@plug.dev'),
    ('MessageLogger', 'Logs messages', 'Divya', '1.0.5', TRUE, 1, 'Whatsapp', 'logger.go', 'https://repo/p7', 's7@plug.dev'),
    ('TeleScheduler', 'Schedules messages', 'Farhan', '2.4.3', FALSE, 3, 'Telegram', 'schedule.rb', 'https://repo/p8', 's8@plug.dev'),
    ('AIInsights', 'AI insights engine', 'Simran', '3.0.0-beta', TRUE, 4, 'Whatsapp', 'ai.mjs', 'https://repo/p9', 's9@plug.dev'),
    ('UnifiedBot', 'Unified bot system', 'Mohit', '1.0.0', TRUE, 6, 'Whatsapp', 'entry.mjs', 'https://repo/p10', 's10@plug.dev'),
    ('SpamShield', 'Blocks spam', 'Aisha', '1.2.1', TRUE, 2, 'Whatsapp', 'shield.py', 'https://repo/p11', 's11@plug.dev'),
    ('LinkPreviewer', 'Shows link previews', 'Rakesh', '1.1.0', FALSE, 1, 'Instagram', 'preview.js', 'https://repo/p12', 's12@plug.dev'),
    ('AutoGreetings', 'Greets users', 'Kabir', '1.4.0', TRUE, 3, 'Whatsapp', 'greet.js', 'https://repo/p13', 's13@plug.dev'),
    ('MediaDownloader', 'Downloads media', 'Pooja', '0.8.1', FALSE, 2, 'Instagram', 'media.py', 'https://repo/p14', 's14@plug.dev'),
    ('TeleMonitor', 'Monitors groups', 'Farhan', '2.0.0', TRUE, 3, 'Telegram', 'monitor.js', 'https://repo/p15', 's15@plug.dev'),
    ('ChatCleaner', 'Cleans chats', 'Neha', '1.0.0', TRUE, 1, 'Whatsapp', 'cleaner.go', 'https://repo/p16', 's16@plug.dev'),
    ('ReelCollector', 'Collects reels', 'Priya', '1.2.0', FALSE, 2, 'Instagram', 'collect.js', 'https://repo/p17', 's17@plug.dev'),
    ('AutoBackup', 'Backs up chats', 'Rohit', '1.0.1', TRUE, 1, 'Whatsapp', 'backup.py', 'https://repo/p18', 's18@plug.dev'),
    ('TeleForwarder', 'Forwards msgs', 'Amit', '2.1.0', FALSE, 2, 'Telegram', 'forward.js', 'https://repo/p19', 's19@plug.dev'),
    ('ArattaiBot', 'Basic Arattai bot', 'Karan', '0.7.2', TRUE, 2, 'Arattai', 'bot.ts', 'https://repo/p20', 's20@plug.dev'),
    ('StoryDownloader', 'Downloads stories', 'Simran', '1.1.5', TRUE, 2, 'Instagram', 'story.py', 'https://repo/p21', 's21@plug.dev'),
    ('QuickReply', 'Quick reply templates', 'Aisha', '1.0.2', TRUE, 1, 'Whatsapp', 'quick.js', 'https://repo/p22', 's22@plug.dev'),
    ('MessageHighlighter', 'Highlights messages', 'Mohit', '1.0.0', FALSE, 1, 'Whatsapp', 'highlight.ts', 'https://repo/p23', 's23@plug.dev'),
    ('InstaAnalyzer', 'Analyzes profiles', 'Neha', '2.0.1', TRUE, 2, 'Instagram', 'analyze.py', 'https://repo/p24', 's24@plug.dev'),
    ('TeleReminder', 'Sends reminders', 'Rakesh', '2.2.0', TRUE, 2, 'Telegram', 'remind.mjs', 'https://repo/p25', 's25@plug.dev'),
    ('DataExporter', 'Exports data', 'Divya', '1.0.0', TRUE, 1, 'Whatsapp', 'export.js', 'https://repo/p26', 's26@plug.dev'),
    ('AutoTranslator', 'Translates messages', 'Kabir', '1.3.1', TRUE, 3, 'Whatsapp', 'translate.py', 'https://repo/p27', 's27@plug.dev'),
    ('ArattaiUploader', 'Uploads to Arattai', 'Karan', '1.0.0', FALSE, 1, 'Arattai', 'upload.ts', 'https://repo/p28', 's28@plug.dev'),
    ('StoryNotifier', 'Notifies updates', 'Amit', '1.1.0', TRUE, 2, 'Instagram', 'notify.js', 'https://repo/p29', 's29@plug.dev'),
    ('PluginValidator', 'Validates plugins', 'Rohit', '1.0.0', TRUE, 1, 'Whatsapp', 'validate.js', 'https://repo/p30', 's30@plug.dev'),
    ('ChatStats', 'Generates chat stats', 'Simran', '1.0.0', TRUE, 2, 'Whatsapp', 'stats.js', 'https://repo/p31', 's31@plug.dev'),
    ('InstaScheduler', 'Schedules posts', 'Priya', '1.4.1', FALSE, 2, 'Instagram', 'scheduler.py', 'https://repo/p32', 's32@plug.dev'),
    ('TeleTracker', 'Tracks activity', 'Farhan', '2.3.0', TRUE, 2, 'Telegram', 'tracker.rb', 'https://repo/p33', 's33@plug.dev'),
    ('BotRegistry', 'Lists bots', 'Rakesh', '1.1.0', TRUE, 1, 'Whatsapp', 'registry.js', 'https://repo/p34', 's34@plug.dev'),
    ('AutoTyper', 'Simulates typing', 'Neha', '1.0.3', TRUE, 1, 'Whatsapp', 'typer.mjs', 'https://repo/p35', 's35@plug.dev'),
    ('ReelNotifier', 'Reel alerts', 'Aisha', '1.0.0', FALSE, 1, 'Instagram', 'reel.js', 'https://repo/p36', 's36@plug.dev'),
    ('TeleArchiver', 'Archives chats', 'Amit', '2.5.0', TRUE, 2, 'Telegram', 'archive.js', 'https://repo/p37', 's37@plug.dev'),
    ('ArattaiSync', 'Sync messages', 'Karan', '1.1.0', TRUE, 2, 'Arattai', 'sync.ts', 'https://repo/p38', 's38@plug.dev'),
    ('UserProfiler', 'Profiles users', 'Divya', '1.2.0', TRUE, 2, 'Whatsapp', 'profile.py', 'https://repo/p39', 's39@plug.dev'),
    ('StoryMirror', 'Clones stories', 'Priya', '1.0.1', FALSE, 1, 'Instagram', 'mirror.js', 'https://repo/p40', 's40@plug.dev'),
    ('TeleDigest', 'Daily summary', 'Simran', '3.0.0', TRUE, 3, 'Telegram', 'digest.rb', 'https://repo/p41', 's41@plug.dev'),
    ('ChatAlerts', 'Alert system', 'Rohit', '1.0.4', TRUE, 2, 'Whatsapp', 'alert.js', 'https://repo/p42', 's42@plug.dev'),
    ('ArattaiReporter', 'Reports activity', 'Aisha', '1.0.0', TRUE, 1, 'Arattai', 'report.ts', 'https://repo/p43', 's43@plug.dev'),
    ('MediaCompressor', 'Compresses media', 'Mohit', '1.2.0', TRUE, 2, 'Whatsapp', 'compress.py', 'https://repo/p44', 's44@plug.dev'),
    ('InstaInsights', 'Insights tool', 'Neha', '2.1.1', FALSE, 2, 'Instagram', 'insights.mjs', 'https://repo/p45', 's45@plug.dev'),
    ('TeleAudit', 'Audit tool', 'Farhan', '2.0.0', TRUE, 3, 'Telegram', 'audit.js', 'https://repo/p46', 's46@plug.dev'),
    ('ChatGuard', 'Security guard', 'Rakesh', '1.2.2', TRUE, 2, 'Whatsapp', 'guard.ts', 'https://repo/p47', 's47@plug.dev'),
    ('ArattaiCleaner', 'Cleans Arattai chats', 'Karan', '1.0.5', TRUE, 1, 'Arattai', 'clean.ts', 'https://repo/p48', 's48@plug.dev'),
    ('FeedCollector', 'Collects feeds', 'Priya', '1.3.0', TRUE, 2, 'Instagram', 'feed.py', 'https://repo/p49', 's49@plug.dev'),
    ('TeleNotifier', 'Notification system', 'Amit', '2.0.3', TRUE, 2, 'Telegram', 'notify.rb', 'https://repo/p50', 's50@plug.dev');


-- DROP TABLE plugins;

CREATE TABLE commands(
    id int AUTO_INCREMENT PRIMARY KEY ,
    plugin_id INT ,
    handleName varchar(20) NOT NULL
)