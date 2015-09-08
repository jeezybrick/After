-- phpMyAdmin SQL Dump
-- version 4.0.10.6
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 08 2015 г., 05:45
-- Версия сервера: 5.6.22-log
-- Версия PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `django_light`
--

-- --------------------------------------------------------

--
-- Структура таблицы `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_e2548d6_fk_auth_permission_id` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Дамп данных таблицы `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can add permission', 2, 'add_permission'),
(5, 'Can change permission', 2, 'change_permission'),
(6, 'Can delete permission', 2, 'delete_permission'),
(7, 'Can add group', 3, 'add_group'),
(8, 'Can change group', 3, 'change_group'),
(9, 'Can delete group', 3, 'delete_group'),
(10, 'Can add content type', 4, 'add_contenttype'),
(11, 'Can change content type', 4, 'change_contenttype'),
(12, 'Can delete content type', 4, 'delete_contenttype'),
(13, 'Can add session', 5, 'add_session'),
(14, 'Can change session', 5, 'change_session'),
(15, 'Can delete session', 5, 'delete_session'),
(16, 'Can add my user', 6, 'add_myuser'),
(17, 'Can change my user', 6, 'change_myuser'),
(18, 'Can delete my user', 6, 'delete_myuser'),
(19, 'Can add color of note', 7, 'add_colorofnote'),
(20, 'Can change color of note', 7, 'change_colorofnote'),
(21, 'Can delete color of note', 7, 'delete_colorofnote'),
(22, 'Can add category', 8, 'add_category'),
(23, 'Can change category', 8, 'change_category'),
(24, 'Can delete category', 8, 'delete_category'),
(25, 'Can add label default', 9, 'add_labeldefault'),
(26, 'Can change label default', 9, 'change_labeldefault'),
(27, 'Can delete label default', 9, 'delete_labeldefault'),
(28, 'Can add note', 10, 'add_note'),
(29, 'Can change note', 10, 'change_note'),
(30, 'Can delete note', 10, 'delete_note'),
(31, 'Can add label custom', 11, 'add_labelcustom'),
(32, 'Can change label custom', 11, 'change_labelcustom'),
(33, 'Can delete label custom', 11, 'delete_labelcustom');

-- --------------------------------------------------------

--
-- Структура таблицы `django_admin_log`
--

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_621c120f_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_31a3beee_fk_notes_myuser_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_5d32dd50_uniq` (`app_label`,`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп данных таблицы `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(8, 'notes', 'category'),
(7, 'notes', 'colorofnote'),
(11, 'notes', 'labelcustom'),
(9, 'notes', 'labeldefault'),
(6, 'notes', 'myuser'),
(10, 'notes', 'note'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура таблицы `django_migrations`
--

CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп данных таблицы `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2015-09-08 02:32:06.386215'),
(2, 'contenttypes', '0002_remove_content_type_name', '2015-09-08 02:32:07.207771'),
(3, 'auth', '0001_initial', '2015-09-08 02:32:10.334711'),
(4, 'auth', '0002_alter_permission_name_max_length', '2015-09-08 02:32:11.685148'),
(5, 'auth', '0003_alter_user_email_max_length', '2015-09-08 02:32:11.785212'),
(6, 'auth', '0004_alter_user_username_opts', '2015-09-08 02:32:11.811234'),
(7, 'auth', '0005_alter_user_last_login_null', '2015-09-08 02:32:11.832243'),
(8, 'auth', '0006_require_contenttypes_0002', '2015-09-08 02:32:11.841248'),
(9, 'notes', '0001_initial', '2015-09-08 02:32:27.349672'),
(10, 'admin', '0001_initial', '2015-09-08 02:32:29.314007'),
(11, 'sessions', '0001_initial', '2015-09-08 02:32:29.998445');

-- --------------------------------------------------------

--
-- Структура таблицы `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_category`
--

CREATE TABLE IF NOT EXISTS `notes_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notes_category_parent_category_id_3313922c_fk_notes_category_id` (`parent_category_id`),
  KEY `notes_category_user_id_482c9760_fk_notes_myuser_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_colorofnote`
--

CREATE TABLE IF NOT EXISTS `notes_colorofnote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `color` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `notes_colorofnote`
--

INSERT INTO `notes_colorofnote` (`id`, `name`, `color`) VALUES
(1, 'Без цвета', '#FFFFFF'),
(2, 'Синий', '#0000FF'),
(3, 'Красный', '#FF0000'),
(4, 'Зеленый', '#1F7A1F'),
(5, 'Желтый', '#FFFF00'),
(6, 'Серый', 'gray');

-- --------------------------------------------------------

--
-- Структура таблицы `notes_labelcustom`
--

CREATE TABLE IF NOT EXISTS `notes_labelcustom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `note_id` int(11),
  PRIMARY KEY (`id`),
  KEY `notes_labelcustom_2115813b` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_labeldefault`
--

CREATE TABLE IF NOT EXISTS `notes_labeldefault` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `notes_labeldefault`
--

INSERT INTO `notes_labeldefault` (`id`, `name`) VALUES
(1, 'Blogger.png'),
(2, 'Calculator.png'),
(3, 'Camera.png'),
(4, 'Youtube.png'),
(5, 'Movie Studio.png');

-- --------------------------------------------------------

--
-- Структура таблицы `notes_myuser`
--

CREATE TABLE IF NOT EXISTS `notes_myuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `date_of_birth` date NOT NULL,
  `phone` varchar(40) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `notes_myuser_email_4fdc01a9_uniq` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_myuser_groups`
--

CREATE TABLE IF NOT EXISTS `notes_myuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`group_id`),
  KEY `notes_myuser_groups_group_id_506f91da_fk_auth_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_myuser_user_permissions`
--

CREATE TABLE IF NOT EXISTS `notes_myuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`permission_id`),
  KEY `notes_myuser_user_p_permission_id_1548094b_fk_auth_permission_id` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_note`
--

CREATE TABLE IF NOT EXISTS `notes_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `file` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `color_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notes_note_color_id_44d392ae_fk_notes_colorofnote_id` (`color_id`),
  KEY `notes_note_user_id_57541da_fk_notes_myuser_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_note_categories`
--

CREATE TABLE IF NOT EXISTS `notes_note_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `note_id` (`note_id`,`category_id`),
  KEY `notes_note_categories_category_id_1bf7350f_fk_notes_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `notes_note_labels`
--

CREATE TABLE IF NOT EXISTS `notes_note_labels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note_id` int(11) NOT NULL,
  `labeldefault_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `note_id` (`note_id`,`labeldefault_id`),
  KEY `notes_note_lab_labeldefault_id_3dded875_fk_notes_labeldefault_id` (`labeldefault_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_e2548d6_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_1c218838_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения внешнего ключа таблицы `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permissi_content_type_id_6f10d508_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin__content_type_id_621c120f_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_31a3beee_fk_notes_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `notes_myuser` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_category`
--
ALTER TABLE `notes_category`
  ADD CONSTRAINT `notes_category_parent_category_id_3313922c_fk_notes_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `notes_category` (`id`),
  ADD CONSTRAINT `notes_category_user_id_482c9760_fk_notes_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `notes_myuser` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_labelcustom`
--
ALTER TABLE `notes_labelcustom`
  ADD CONSTRAINT `notes_labelcustom_note_id_6ca6ede8_fk_notes_note_id` FOREIGN KEY (`note_id`) REFERENCES `notes_note` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_myuser_groups`
--
ALTER TABLE `notes_myuser_groups`
  ADD CONSTRAINT `notes_myuser_groups_group_id_506f91da_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `notes_myuser_groups_myuser_id_249cc6a8_fk_notes_myuser_id` FOREIGN KEY (`myuser_id`) REFERENCES `notes_myuser` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_myuser_user_permissions`
--
ALTER TABLE `notes_myuser_user_permissions`
  ADD CONSTRAINT `notes_myuser_user_p_permission_id_1548094b_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `notes_myuser_user_permissi_myuser_id_5cc75f79_fk_notes_myuser_id` FOREIGN KEY (`myuser_id`) REFERENCES `notes_myuser` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_note`
--
ALTER TABLE `notes_note`
  ADD CONSTRAINT `notes_note_color_id_44d392ae_fk_notes_colorofnote_id` FOREIGN KEY (`color_id`) REFERENCES `notes_colorofnote` (`id`),
  ADD CONSTRAINT `notes_note_user_id_57541da_fk_notes_myuser_id` FOREIGN KEY (`user_id`) REFERENCES `notes_myuser` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_note_categories`
--
ALTER TABLE `notes_note_categories`
  ADD CONSTRAINT `notes_note_categories_category_id_1bf7350f_fk_notes_category_id` FOREIGN KEY (`category_id`) REFERENCES `notes_category` (`id`),
  ADD CONSTRAINT `notes_note_categories_note_id_1ff7915c_fk_notes_note_id` FOREIGN KEY (`note_id`) REFERENCES `notes_note` (`id`);

--
-- Ограничения внешнего ключа таблицы `notes_note_labels`
--
ALTER TABLE `notes_note_labels`
  ADD CONSTRAINT `notes_note_lab_labeldefault_id_3dded875_fk_notes_labeldefault_id` FOREIGN KEY (`labeldefault_id`) REFERENCES `notes_labeldefault` (`id`),
  ADD CONSTRAINT `notes_note_labels_note_id_20c36f19_fk_notes_note_id` FOREIGN KEY (`note_id`) REFERENCES `notes_note` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
