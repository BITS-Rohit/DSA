-- Here we will meanwhile practice for our ARCH & SDK DB
# SHOW databases;

-- Creating ARCH Based Plugin Table
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

DROP DATABASE IF EXISTS Architecture;
CREATE DATABASE Architecture;
USE Architecture;

-- =========================
-- Lookup Tables
-- =========================
CREATE TABLE platform
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_platform_name UNIQUE (name)
);

CREATE TABLE plugin_type
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_plugin_type_name UNIQUE (name)
);

CREATE TABLE event_type
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_event_type_name UNIQUE (name)
);

-- =========================
-- Core Plugin Table
-- =========================
CREATE TABLE plugins
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    version      VARCHAR(50)  NOT NULL,
    type_id      INT          NOT NULL,
    platform_id  INT          NOT NULL,
    added_at     DATETIME  DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_plugins_type
        FOREIGN KEY (type_id) REFERENCES plugin_type (id),

    CONSTRAINT fk_plugins_platform
        FOREIGN KEY (platform_id) REFERENCES platform (id),

    INDEX idx_plugins_platform (platform_id)
);

-- =========================
-- Plugin Metadata (1–1)
-- =========================
CREATE TABLE plugin_metadata
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    p_id          INT          NOT NULL,
    active_status BOOLEAN      DEFAULT TRUE,
    description   VARCHAR(255) DEFAULT 'NOT GIVEN',
    tool_count    INT          NOT NULL,
    repo_url      VARCHAR(255),
    file_name     VARCHAR(255) NOT NULL,

    CONSTRAINT uk_plugin_metadata_file UNIQUE (p_id, file_name),

    CONSTRAINT fk_metadata_plugin
        FOREIGN KEY (p_id) REFERENCES plugins (id)
            ON DELETE CASCADE
);

-- =========================
-- Tools
-- =========================
CREATE TABLE tools
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    p_id        INT NOT NULL,
    specifier   VARCHAR(100),
    description TEXT,
    event_id    INT NOT NULL,
    usage_count INT DEFAULT 0,

    CONSTRAINT fk_tools_plugin
        FOREIGN KEY (p_id) REFERENCES plugins (id)
            ON DELETE CASCADE,

    CONSTRAINT fk_tools_event
        FOREIGN KEY (event_id) REFERENCES event_type (id),

    INDEX idx_tools_plugin (p_id)
);

-- =========================
-- Tool Requirements (per-tool security)
-- =========================
CREATE TABLE tool_requirements
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    tool_id       INT NOT NULL,
    api_name      VARCHAR(100),
    encrypted_key TEXT,

    CONSTRAINT fk_requirements_tool
        FOREIGN KEY (tool_id) REFERENCES tools (id)
            ON DELETE CASCADE,

    INDEX idx_requirements_tool (tool_id)
);
