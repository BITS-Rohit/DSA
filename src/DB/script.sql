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

# drop database  if exists ARCH ;
CREATE DATABASE Architecture;
USE Architecture;

CREATE TABLE Plugins
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    version      VARCHAR(100) NOT NULL,
    platform     ENUM ('whatsapp', 'arattai', 'instagram', 'telegram'),
    added_at     DATETIME  DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE plugin_Metadata
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    p_id          INT          NOT NULL UNIQUE,
    Active_status ENUM ('1','0'),
    description   VARCHAR(255) DEFAULT 'NOT GIVEN',
    Tool_Count    INT          NOT NULL,
    url           VARCHAR(255) DEFAULT 'NOT GIVEN',
    file_name     VARCHAR(255) NOT NULL,
    UNIQUE (p_id, file_name),
    CONSTRAINT plugin_metadata_to_plugin_id FOREIGN KEY (p_id)
        REFERENCES Plugins (id)
);

CREATE TABLE Tool_data
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    p_id        INT NOT NULL,
    specifier   VARCHAR(100),
    description TEXT,
    EVENT       ENUM ('on_msg') DEFAULT 'on_msg',
    CONSTRAINT tools_pid_to_plugin_id FOREIGN KEY (p_id)
        REFERENCES Plugins (id)
);

CREATE TABLE Tool_Requirement
(
    id      INT AUTO_INCREMENT PRIMARY KEY,
    t_id    INT NOT NULL,
    API_KEY VARCHAR(255) DEFAULT 'NONE',
    CONSTRAINT tool_id_to_Tool_data_id FOREIGN KEY (t_id)
        REFERENCES Tool_data (id)
);
