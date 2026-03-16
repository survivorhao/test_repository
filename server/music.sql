/*
 Navicat Premium Dump SQL

 Source Server         : User-use
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : whumusic

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 24/12/2025 11:04:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for artists
-- ----------------------------
DROP TABLE IF EXISTS `artists`;
CREATE TABLE `artists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '歌手ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌手名',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌手头像URL',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '歌手简介',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '歌手表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of artists
-- ----------------------------
INSERT INTO `artists` VALUES (1, '李荣浩', NULL, NULL, '2025-12-23 13:16:29');
INSERT INTO `artists` VALUES (2, '郑润泽', NULL, NULL, '2025-12-23 13:16:29');
INSERT INTO `artists` VALUES (3, '梨冻紧', NULL, NULL, '2025-12-23 13:16:29');
INSERT INTO `artists` VALUES (4, 'G.E.M.邓紫棋', NULL, NULL, '2025-12-23 13:16:29');
INSERT INTO `artists` VALUES (5, '队长', NULL, NULL, '2025-12-23 13:16:29');
INSERT INTO `artists` VALUES (6, '余翊', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (7, '王力宏', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (8, '王艳薇', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (9, '派伟俊', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (10, '加木', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (11, '颜人中', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (12, '茜拉', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (13, '孙燕姿', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (14, 'h3R3', NULL, NULL, '2025-12-23 13:16:30');
INSERT INTO `artists` VALUES (15, 'Gareth.T', NULL, NULL, '2025-12-23 13:16:31');
INSERT INTO `artists` VALUES (16, 'Disney', NULL, NULL, '2025-12-23 13:16:31');
INSERT INTO `artists` VALUES (17, '徐明浩', NULL, NULL, '2025-12-23 13:16:31');
INSERT INTO `artists` VALUES (18, '林达浪', NULL, NULL, '2025-12-23 13:16:31');
INSERT INTO `artists` VALUES (19, '方大同', NULL, NULL, '2025-12-23 13:16:31');
INSERT INTO `artists` VALUES (20, '郭静', NULL, NULL, '2025-12-23 13:40:44');
INSERT INTO `artists` VALUES (21, '陈奕迅', NULL, NULL, '2025-12-23 13:40:44');
INSERT INTO `artists` VALUES (22, '颜人中', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (23, '颜人中', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (24, '汪苏泷', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (25, '汪苏泷', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (26, 'TINY7', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (27, '陈粒', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (28, 'TINY7', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (29, '林俊杰', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (30, '薛之谦', NULL, NULL, '2025-12-23 13:40:45');
INSERT INTO `artists` VALUES (31, '林俊杰', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (32, '梁静茹', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (33, '郑润泽', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (34, '曹格', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (35, '颜人中', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (36, '胡彦斌', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (37, '汪苏泷', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (38, '郭一凡', NULL, NULL, '2025-12-23 13:40:46');
INSERT INTO `artists` VALUES (39, '王唯旖', NULL, NULL, '2025-12-23 13:40:47');
INSERT INTO `artists` VALUES (40, 'Starling8', NULL, NULL, '2025-12-23 15:24:04');
INSERT INTO `artists` VALUES (41, 'TC', NULL, NULL, '2025-12-23 15:24:04');
INSERT INTO `artists` VALUES (42, '郑润泽', NULL, NULL, '2025-12-23 15:24:04');
INSERT INTO `artists` VALUES (43, '李荣浩', NULL, NULL, '2025-12-23 15:24:04');
INSERT INTO `artists` VALUES (44, 'h3R3', NULL, NULL, '2025-12-23 15:24:04');
INSERT INTO `artists` VALUES (45, '颜人中', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (46, '罗言', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (47, 'G.E.M.邓紫棋', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (48, '王贰浪', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (49, '梁博', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (50, '蔡健雅', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (51, '赵紫骅', NULL, NULL, '2025-12-23 15:24:05');
INSERT INTO `artists` VALUES (52, '陈奕迅', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (53, '队长', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (54, '杨丞琳', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (55, '蔡健雅', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (56, 'ET', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (57, '罗森涛', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (58, '孙燕姿', NULL, NULL, '2025-12-23 15:24:06');
INSERT INTO `artists` VALUES (59, '赵雷', NULL, NULL, '2025-12-23 15:24:07');
INSERT INTO `artists` VALUES (60, 'Gareth.T', NULL, NULL, '2025-12-23 15:28:38');
INSERT INTO `artists` VALUES (61, '陶喆', NULL, NULL, '2025-12-23 15:28:38');
INSERT INTO `artists` VALUES (62, '韦礼安', NULL, NULL, '2025-12-23 15:28:38');
INSERT INTO `artists` VALUES (63, '陈奕迅', NULL, NULL, '2025-12-23 15:28:38');
INSERT INTO `artists` VALUES (64, '金海心', NULL, NULL, '2025-12-23 15:28:38');
INSERT INTO `artists` VALUES (65, '国风堂', NULL, NULL, '2025-12-23 15:28:38');
INSERT INTO `artists` VALUES (66, '方大同', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (67, '关喆', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (68, '郑润泽', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (69, '林忆莲', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (70, '张紫豪', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (71, '杜宣达', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (72, '阿冗', NULL, NULL, '2025-12-23 15:28:39');
INSERT INTO `artists` VALUES (73, '郑润泽', NULL, NULL, '2025-12-23 15:28:40');
INSERT INTO `artists` VALUES (74, 'G.E.M.邓紫棋', NULL, NULL, '2025-12-23 15:28:40');
INSERT INTO `artists` VALUES (75, '毛不易', NULL, NULL, '2025-12-23 15:28:40');
INSERT INTO `artists` VALUES (76, '菲菲公主（陆绮菲）', NULL, NULL, '2025-12-23 15:28:40');
INSERT INTO `artists` VALUES (77, '单依纯', NULL, NULL, '2025-12-23 15:28:40');
INSERT INTO `artists` VALUES (78, '卢广仲', NULL, NULL, '2025-12-23 15:28:40');
INSERT INTO `artists` VALUES (79, '梁博', NULL, NULL, '2025-12-23 15:28:40');

-- ----------------------------
-- Table structure for playlist_songs
-- ----------------------------
DROP TABLE IF EXISTS `playlist_songs`;
CREATE TABLE `playlist_songs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint UNSIGNED NOT NULL,
  `song_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_playlist_song`(`playlist_id` ASC, `song_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '歌单歌曲关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of playlist_songs
-- ----------------------------
INSERT INTO `playlist_songs` VALUES (1, 1, 17, '2025-12-23 13:16:29');
INSERT INTO `playlist_songs` VALUES (2, 1, 18, '2025-12-23 13:16:29');
INSERT INTO `playlist_songs` VALUES (3, 1, 19, '2025-12-23 13:16:29');
INSERT INTO `playlist_songs` VALUES (4, 1, 20, '2025-12-23 13:16:29');
INSERT INTO `playlist_songs` VALUES (5, 1, 21, '2025-12-23 13:16:29');
INSERT INTO `playlist_songs` VALUES (6, 1, 22, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (7, 1, 23, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (8, 1, 24, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (9, 1, 25, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (10, 1, 26, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (11, 1, 27, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (12, 1, 28, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (13, 1, 29, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (14, 1, 30, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (15, 1, 31, '2025-12-23 13:16:30');
INSERT INTO `playlist_songs` VALUES (16, 1, 32, '2025-12-23 13:16:31');
INSERT INTO `playlist_songs` VALUES (17, 1, 33, '2025-12-23 13:16:31');
INSERT INTO `playlist_songs` VALUES (18, 1, 34, '2025-12-23 13:16:31');
INSERT INTO `playlist_songs` VALUES (19, 1, 35, '2025-12-23 13:16:31');
INSERT INTO `playlist_songs` VALUES (20, 1, 36, '2025-12-23 13:16:31');
INSERT INTO `playlist_songs` VALUES (21, 3, 37, '2025-12-23 13:40:44');
INSERT INTO `playlist_songs` VALUES (22, 3, 38, '2025-12-23 13:40:44');
INSERT INTO `playlist_songs` VALUES (23, 3, 39, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (24, 3, 40, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (25, 3, 41, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (26, 3, 42, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (27, 3, 43, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (28, 3, 44, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (29, 3, 45, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (30, 3, 46, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (31, 3, 47, '2025-12-23 13:40:45');
INSERT INTO `playlist_songs` VALUES (32, 3, 48, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (33, 3, 49, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (34, 3, 50, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (35, 3, 51, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (36, 3, 52, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (37, 3, 53, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (38, 3, 54, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (39, 3, 55, '2025-12-23 13:40:46');
INSERT INTO `playlist_songs` VALUES (40, 3, 56, '2025-12-23 13:40:47');
INSERT INTO `playlist_songs` VALUES (41, 4, 57, '2025-12-23 15:24:04');
INSERT INTO `playlist_songs` VALUES (42, 4, 58, '2025-12-23 15:24:04');
INSERT INTO `playlist_songs` VALUES (43, 4, 59, '2025-12-23 15:24:04');
INSERT INTO `playlist_songs` VALUES (44, 4, 60, '2025-12-23 15:24:04');
INSERT INTO `playlist_songs` VALUES (45, 4, 61, '2025-12-23 15:24:04');
INSERT INTO `playlist_songs` VALUES (46, 4, 62, '2025-12-23 15:24:05');
INSERT INTO `playlist_songs` VALUES (47, 4, 63, '2025-12-23 15:24:05');
INSERT INTO `playlist_songs` VALUES (48, 4, 64, '2025-12-23 15:24:05');
INSERT INTO `playlist_songs` VALUES (49, 4, 65, '2025-12-23 15:24:05');
INSERT INTO `playlist_songs` VALUES (50, 4, 66, '2025-12-23 15:24:05');
INSERT INTO `playlist_songs` VALUES (51, 4, 67, '2025-12-23 15:24:05');
INSERT INTO `playlist_songs` VALUES (52, 4, 68, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (53, 4, 69, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (54, 4, 70, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (55, 4, 71, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (56, 4, 72, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (57, 4, 73, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (58, 4, 74, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (59, 4, 75, '2025-12-23 15:24:06');
INSERT INTO `playlist_songs` VALUES (60, 4, 76, '2025-12-23 15:24:07');
INSERT INTO `playlist_songs` VALUES (61, 5, 77, '2025-12-23 15:28:38');
INSERT INTO `playlist_songs` VALUES (62, 5, 78, '2025-12-23 15:28:38');
INSERT INTO `playlist_songs` VALUES (63, 5, 79, '2025-12-23 15:28:38');
INSERT INTO `playlist_songs` VALUES (64, 5, 80, '2025-12-23 15:28:38');
INSERT INTO `playlist_songs` VALUES (65, 5, 81, '2025-12-23 15:28:38');
INSERT INTO `playlist_songs` VALUES (66, 5, 82, '2025-12-23 15:28:38');
INSERT INTO `playlist_songs` VALUES (67, 5, 83, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (68, 5, 84, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (69, 5, 85, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (70, 5, 86, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (71, 5, 87, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (72, 5, 88, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (73, 5, 89, '2025-12-23 15:28:39');
INSERT INTO `playlist_songs` VALUES (74, 5, 90, '2025-12-23 15:28:40');
INSERT INTO `playlist_songs` VALUES (75, 5, 91, '2025-12-23 15:28:40');
INSERT INTO `playlist_songs` VALUES (76, 5, 92, '2025-12-23 15:28:40');
INSERT INTO `playlist_songs` VALUES (77, 5, 93, '2025-12-23 15:28:40');
INSERT INTO `playlist_songs` VALUES (78, 5, 94, '2025-12-23 15:28:40');
INSERT INTO `playlist_songs` VALUES (79, 5, 95, '2025-12-23 15:28:40');
INSERT INTO `playlist_songs` VALUES (80, 5, 96, '2025-12-23 15:28:40');

-- ----------------------------
-- Table structure for playlists
-- ----------------------------
DROP TABLE IF EXISTS `playlists`;
CREATE TABLE `playlists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cover_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '创建者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '歌单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of playlists
-- ----------------------------
INSERT INTO `playlists` VALUES (1, '热歌榜', 'https://p1.music.126.net/0SUEG8yDACfx0Bw2MYFv4Q==/109951170048519512.jpg', '云音乐热歌榜：云音乐用户一周内收听所有线上歌曲官方TOP排行榜，每日更新。', NULL, '2025-12-23 13:16:29');
INSERT INTO `playlists` VALUES (2, '热歌榜', 'https://p1.music.126.net/0SUEG8yDACfx0Bw2MYFv4Q==/109951170048519512.jpg', '云音乐热歌榜：云音乐用户一周内收听所有线上歌曲官方TOP排行榜，每日更新。', NULL, '2025-12-23 13:40:01');
INSERT INTO `playlists` VALUES (3, '热歌榜', 'https://p1.music.126.net/0SUEG8yDACfx0Bw2MYFv4Q==/109951170048519512.jpg', '云音乐热歌榜：云音乐用户一周内收听所有线上歌曲官方TOP排行榜，每日更新。', NULL, '2025-12-23 13:40:44');
INSERT INTO `playlists` VALUES (4, '热歌榜', 'https://p1.music.126.net/0SUEG8yDACfx0Bw2MYFv4Q==/109951170048519512.jpg', '云音乐热歌榜：云音乐用户一周内收听所有线上歌曲官方TOP排行榜，每日更新。', NULL, '2025-12-23 15:24:04');
INSERT INTO `playlists` VALUES (5, '热歌榜', 'https://p1.music.126.net/0SUEG8yDACfx0Bw2MYFv4Q==/109951170048519512.jpg', '云音乐热歌榜：云音乐用户一周内收听所有线上歌曲官方TOP排行榜，每日更新。', NULL, '2025-12-23 15:28:38');

-- ----------------------------
-- Table structure for songs
-- ----------------------------
DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '歌曲ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲标题',
  `artist_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '歌手ID',
  `artist_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌手名(冗余字段，方便查询)',
  `album_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专辑名',
  `duration` int NULL DEFAULT NULL COMMENT '时长(毫秒)',
  `cover_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片URL',
  `audio_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '音频文件URL',
  `is_local` tinyint NULL DEFAULT 0 COMMENT '是否为本地资源 0:网络 1:本地',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `netease_id` bigint NULL DEFAULT NULL COMMENT '网易云歌曲ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_artist_id`(`artist_id` ASC) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '歌曲表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of songs
-- ----------------------------
INSERT INTO `songs` VALUES (1, '直到世界的尽头', NULL, 'WANDS', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (2, '画', NULL, '赵磊', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.mp3', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (3, 'Sweet Dreams', NULL, 'TPaul Sax / Eurythmics', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.mp3', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (4, '奢香夫人', NULL, '凤凰传奇', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (5, '空心', NULL, '光泽', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.mp3', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (6, '反转地球', NULL, '潘玮柏', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.mp3', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (7, 'No.9', NULL, 'T-ara', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (8, '孤独', NULL, 'G.E.M.邓紫棋', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (9, 'Lose Control', NULL, 'Hedley', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (10, '倩女幽魂', NULL, '张国荣', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (11, '北京北京', NULL, '汪峰', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (12, '苦笑', NULL, '汪苏泷', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (13, '一生所爱', NULL, '卢冠廷 / 莫文蔚', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (14, '月半小夜曲', NULL, '李克勤', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (15, 'Rolling in the Deep', NULL, 'Adele', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (16, '海阔天空', NULL, 'Beyond', NULL, NULL, 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.jpg', 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.m4a', 0, '2025-12-23 13:00:15', NULL);
INSERT INTO `songs` VALUES (17, '恋人', 1, '李荣浩', '黑马', 275912, 'http://p3.music.126.net/0bk3Iqe2OZGBH2Iuyx7RzA==/109951170045577565.jpg', 'http://m802.music.126.net/20251223134132/9e15376ceb9451f9502936a98d2f57c8/jd-musicrep-ts/403e/8251/6cab/b0a76feebf84ae67a99c37a38f950fd6.mp3?vuutv=VQAV/T4Y3lL8pcLSE3r912chz95npTn4XjWjcu1puBBjh4DrtwGG58PseQwyA6MZjQJ51r4dG0VEpDcQeTEamQu/BiZrSwmoqoJOLsrRkaI=', 0, '2025-12-23 13:16:29', 2600493765);
INSERT INTO `songs` VALUES (18, '如果呢', 2, '郑润泽', '如果呢', 257532, 'http://p3.music.126.net/-xMsNLpquZTmMZlIztTgHg==/109951165953469081.jpg', 'http://m801.music.126.net/20251223134132/cfac63d1a4aba0a979ee08d8e4ffe170/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/34872776288/2a86/1d5c/dd56/58c1c8954ede8c3339aaf5f99850b667.mp3?vuutv=tF44xFlsdFq7f5Z9BRuorxioypaV54KBxUvLwiUU3ABbIQXkD3kh0LBJ4z9GJ6Abi44knJ4TIdBd3Qdh+fWE8M3svcozz5hTgLCIjnwEqNY=', 0, '2025-12-23 13:16:29', 1842728629);
INSERT INTO `songs` VALUES (19, '罗生门（Follow）', 3, '梨冻紧', '罗生门（Follow）', 243754, 'http://p3.music.126.net/yN1ke1xYMJ718FiHaDWtYQ==/109951165076380471.jpg', 'http://m801.music.126.net/20251223134133/c7cd2c1a0e0c21540c580a59f4c39f03/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096444297/c5a0/2580/a9e4/999a4f077c17e140ff120c643b5deb74.mp3?vuutv=GvLf5d0CCg3g7zFSnO24gw9AIxVl4N9KIlgdxZI+0UkaB6D+DsEsCl7g0HNcLnPx3I5XPnHsMHsrVaZegUNivA8E1nF4DVh5+/cuyv7+yzI=', 0, '2025-12-23 13:16:29', 1456890009);
INSERT INTO `songs` VALUES (20, '唯一', 4, 'G.E.M.邓紫棋', 'T.I.M.E.', 253735, 'http://p4.music.126.net/aJWtwvdYRXvKUpAE2C6NoA==/109951168919708423.jpg', 'http://m802.music.126.net/20251223134133/0017cbb1c54a58ca46113001444e4d05/jd-musicrep-ts/c313/f818/d691/ebbb696ac3a70704cd8cab4489fa0acd.mp3?vuutv=H+cD65KDN0eXfaQI9aX04X4EsbH5btukJWMM3Xo11/ysBzEnT5wovNnGtwLx73aiPBBZxmeqxPoVYSXeyT1OBKlGS5BO68tO60b6GAPS+fw=', 0, '2025-12-23 13:16:29', 2083785152);
INSERT INTO `songs` VALUES (21, '碎碎念', 5, '队长', '碎碎念', 132748, 'http://p4.music.126.net/RYIrCEYzgeAD85DJ0rgOQA==/109951169256300966.jpg', 'http://m701.music.126.net/20251223134133/248fbb1af5ae07eef17c7796550bb835/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/34902017066/2ecc/bcee/130b/d46498b2acd033ed0c20472ae4119f73.mp3?vuutv=HuL5VnV10CvNDPlFpKNumtO14bDma0bep59o251qlgMEny4ugXJY0VciUP7RVMO45h9leWdAH2+ORX3gKyaXI/2VoYIK+FhBXnPauB2+g+4=', 0, '2025-12-23 13:16:29', 2097443876);
INSERT INTO `songs` VALUES (22, '给未来的自己', 6, '余翊', '给未来的自己', 244279, 'http://p4.music.126.net/Ke8Pljuxyshpx55cMIuWNA==/109951172459509491.jpg', 'http://m701.music.126.net/20251223134133/ac0f2ea348180c52adabba4380a9af67/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/77075759825/427b/cbd1/ed44/8e05a08cabffb46f411c5608d11a5dae.mp3?vuutv=8xJe6nUMaQybz/6abi1m1hK+R/IBFVUgnesm4EZDrcQTgLtJMe01enhI515Auf4wy6gReLtUpc3RcBsyYzSo1cIjqqhSaUVXh5idwRqTIG4=', 0, '2025-12-23 13:16:30', 3327521028);
INSERT INTO `songs` VALUES (23, '于是', 2, '郑润泽', '于是', 232835, 'http://p3.music.126.net/PEGvmO3OqgGOkx4m9qxAJA==/109951163478499713.jpg', 'http://m801.music.126.net/20251223134133/ea306690df0429dfb069b6cb91b16f05/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/28481678614/2094/46e7/24de/730c852430e4dbf18323701b1e5a49b6.mp3?vuutv=CJVLyqQIqeZ7ThbDaXdbqbD8NjxAt+kiChIl4aJTzYp53/B0hpMBnKuSLYJjCQWjOlahT9YqcP6oAV9Sy0qqF3ExRMsAOqbSNE8pYC9nke8=', 0, '2025-12-23 13:16:30', 1303464858);
INSERT INTO `songs` VALUES (24, '爱错', 7, '王力宏', '恋爱占星音乐全精选', 238826, 'http://p3.music.126.net/febOkiCikU5OcjVLqGNLlg==/109951165994484307.jpg', 'http://m802.music.126.net/20251223134133/35f414cf90ca7c8e0d7a58a9b0d7c2f8/jd-musicrep-ts/b2ab/c4a0/91e2/6ce05d5111a2c10ba59c71e983fae4be.mp3?vuutv=dZ5Pp0q2e8dRumfhR0LIcAmR+xyNJl7Wo5AY0lHaoZPVNPR0UcEIdNP9Hy3n7/Mzk9OdPuSCJaxGtEGPlqJY/hOOeAaWWKRWS/sWEItZCBw=', 0, '2025-12-23 13:16:30', 1301736461);
INSERT INTO `songs` VALUES (25, '离开我的依赖', 8, '王艳薇', '离开我的依赖', 233882, 'http://p3.music.126.net/btYBbFLd5mf9w0lDpfNs6w==/109951171506809884.jpg', 'http://m802.music.126.net/20251223134133/f24dc069b23d478328648df5d2e627c1/jd-musicrep-ts/12f0/4b06/5839/94c5decc5866002163333e64db2debdd.mp3?vuutv=HlBj9CgUCc4guxbebMTKhxVZEVvaG4eKNHDFebuJSKt2C5+xfoYmvw0cUh70oZIe/0qtgUM9iq9HqRv6pyuHngztH5ei+97Rp+sSrwatBas=', 0, '2025-12-23 13:16:30', 1420706073);
INSERT INTO `songs` VALUES (26, '左转灯 (1000 Times +1)', 9, '派伟俊', '左转灯 (1000 Times +1)', 197384, 'http://p3.music.126.net/ODlrxB8b_86bDZTuCXGK1w==/109951172153456358.jpg', 'http://m702.music.126.net/20251223134133/b347b989102a0e3ebc855755c95e41ab/jd-musicrep-ts/829d/003e/c218/e4ae0dd176f2b7e882825fdbbffac65d.mp3?vuutv=gLRucw06pfxW6tsou8IXomG+582QOZHyyG8R4bW4M33fdOHWzlLve2in3litwRgPcHZ5G0YJmdgchaF6MsYDmcUT3q1zQxOlos29HZmNBF4=', 0, '2025-12-23 13:16:30', 2755710644);
INSERT INTO `songs` VALUES (27, '两 难', 10, '加木', '两 难', 170000, 'http://p3.music.126.net/Qvenb5t_hL37b7hRfscjaw==/109951169686160429.jpg', 'http://m701.music.126.net/20251223134133/2c9826660de0d6649c6bccdbd1c38c98/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/36433243748/4e0f/6d75/1fc4/8d0d2b4eb9bc897f1b7a847963b9df15.mp3?vuutv=TrsoE6E0SnRZAyzGNWbNcoJj30MWvFhWhvsX6mnlA/NabBpnWrXwty/Wr6GeIEyEuH1XUj4vWwelAzAHDB/gtDK3JIZtE3HcQNp6NMlWLII=', 0, '2025-12-23 13:16:30', 2163210456);
INSERT INTO `songs` VALUES (28, '嗜好', 11, '颜人中', '嗜好', 284113, 'http://p3.music.126.net/J6HaJjtgv-yVVjyUm-h-AA==/109951164373633387.jpg', 'http://m701.music.126.net/20251223134133/6443ae365491492fc9f29cc10ab2539c/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096495903/2678/762c/f570/9079e87d1bcd7d7538470f9975a0fb1e.mp3?vuutv=OZcDgSz3UdH/EkfgFRpYdJBp6GadtV0fL+Llzzd/5ZXUIpZqwWFc5f6qNF1DIA0AtRwGDbdQZJMIJ1rday2ACKDFIhsNZxtF6xk5kFMtWVM=', 0, '2025-12-23 13:16:30', 1391891631);
INSERT INTO `songs` VALUES (29, '到时说爱我', 12, '茜拉', '心旅', 201564, 'http://p3.music.126.net/z3O2gmFh11wh9N6SxCBopQ==/109951172233412510.jpg', 'http://m702.music.126.net/20251223134134/39c135b73e1fe3ed83120dff52f90535/jd-musicrep-ts/212a/749b/1869/99f406736ca0aa7b6404a19c8444cb31.mp3?vuutv=AaAmgsKlP9Fkq/zjEIXX0B8UbzVYtBPCACqJpaVF6ATvtRCmVDNthX8TJc8RAHiGfRde295P3ONuELb7hk/OBlekW0+g6ReG0QDMJKvGedQ=', 0, '2025-12-23 13:16:30', 1410633323);
INSERT INTO `songs` VALUES (30, '我怀念的', 13, '孙燕姿', '逆光', 289066, 'http://p3.music.126.net/hIOFATG-3vNyYHOj31Tyew==/109951169829283327.jpg', 'http://m802.music.126.net/20251223134134/99249c8b99be10f2795c1314ddfd41c3/jd-musicrep-ts/9242/19de/66fa/e16ee84d29e271e1fe88fb7350587fda.mp3?vuutv=RldhLegDVZYf+M+R1/uOXjts25A0Dk1YMWCZ0BFoZcR1H3mtZ8bfeELfaAMBe8zJGdToJ3eXdr0OZSFyOZNJcWYSvzsj9RkMwcLs+lHtEs8=', 0, '2025-12-23 13:16:30', 287063);
INSERT INTO `songs` VALUES (31, '再等冬天(Memories)', 14, 'h3R3', '故事商铺·上', 168000, 'http://p3.music.126.net/JBe7AwcGkYHhleOfQvY2hg==/109951169798343077.jpg', 'http://m801.music.126.net/20251223134134/6f07e5a8c96fed1ff32400ef02216936/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/13561868586/3efb/ae0d/1137/50677f63be0abeab4c20f5621021a416.mp3?vuutv=tEBwVh2o8+3Zb8Y+rme3CTTwoFn6J6LKQtu6o4xd7OLm29RszOpzfOz8BiCLTLzGgj/Q25UVe5ejiWhsXzaewRm1JGGbmudFusIeq6vTM0A=', 0, '2025-12-23 13:16:30', 1927693793);
INSERT INTO `songs` VALUES (32, '去北极忘记你', 15, 'Gareth.T', '去北极忘记你', 251175, 'http://p3.music.126.net/5bZYAmUKMqiUK9K7kDi5Jg==/109951169718000739.jpg', 'http://m802.music.126.net/20251223134134/d2b932ea840415e5d11b8a2651393611/jd-musicrep-ts/25c5/42be/a305/fa9ae9e9769e6301be62006b96089576.mp3?vuutv=3MZL7UdSr51OGMgCj0+r6URYSobMiMmzBy9MaeuwOoYISghCZW5x9jT4vldUaleTMZCwBwYoBjCej/7qzP2UU54Bbwh3Z8jjwsqDx6c5chE=', 0, '2025-12-23 13:16:31', 2601622789);
INSERT INTO `songs` VALUES (33, 'Zoo (From \"Zootopia 2\"/Soundtrack Version)', 16, 'Disney', 'Zoo (From \"Zootopia 2\")', 190822, 'http://p4.music.126.net/5cOEn3EiZcz4liPnXJ6p6g==/109951172132165756.jpg', 'http://m801.music.126.net/20251223134134/52c9b5e9cc7fec9e4bc1acb210051d8d/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/63270263003/f4dc/50c4/c9c9/2bdfb02c5da308d66f20ef77df39ae80.mp3?vuutv=99rLEVgDhU6afirz2vEepTZNhwIndamL4SytVEmNSVfEcJ9d3DD/kEZswEbxy1EDgMF0DWNYx96OS/rNfICxH5bMmoqXEgJUV3OTVCsevj0=', 0, '2025-12-23 13:16:31', 3320292186);
INSERT INTO `songs` VALUES (34, 'Star Crossing Night (feat. GALI)', 17, '徐明浩', 'Star Crossing Night (feat. GALI)', 205000, 'http://p3.music.126.net/fsz6GAKO1-khteFArDidjA==/109951171942679749.jpg', 'http://m702.music.126.net/20251223134134/9129e24c81ef15e4657cefc896d6fced/jd-musicrep-ts/23e1/6e58/624f/c9c7637f0301621a0567b3533db10ba1.mp3?vuutv=yz5UL+CVyDMvn2P/VuHEJT1hlQoVsueo4T4OpFmrSmJBiPrUV5OUpXyTKAU2I42GOCvncwsVaXi4Twiom/gqbcmS79cWWyhXlm5qgm12a8U=', 0, '2025-12-23 13:16:31', 2740858325);
INSERT INTO `songs` VALUES (35, '还是会想你', 18, '林达浪', '还是会想你', 190063, 'http://p4.music.126.net/9FhSEQtMhP-JP3_U84YfWQ==/109951165798773745.jpg', 'http://m701.music.126.net/20251223134134/620665d1469f6dc461cd01b1e88d2eab/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096416209/b79a/d1b3/3491/22cf5ca1b4a21659c20ade20c1ada608.mp3?vuutv=O7i3a68fVxbiFno/pWewg8ITDrVUb1ZuTMzQYFWWHxpA2mHdd5t7FFXjbiMoE1IeI4lZfmmEbtsh1HxPeMWHaEJyoAZ/UGawfErF72vY5/g=', 0, '2025-12-23 13:16:31', 1827600686);
INSERT INTO `songs` VALUES (36, '特别的人', 19, '方大同', '危险世界', 259064, 'http://p3.music.126.net/FtAvIYLF3qwqohQhwycVDg==/109951171386379124.jpg', 'http://m702.music.126.net/20251223134134/322f84dcc1bd7631da82a82d829e034b/jd-musicrep-ts/e6d2/5e82/fe47/e79ce813bd7c29026780b738bfe855ee.?vuutv=qwAoGuupVRE9l6fiHC44dgAFUjVnKazQOAZ95n8CxMvJ87aVrdgGLJEmSdm2JUCPP/UypVBIQ1KVDRgPLhtJZOUZf7GXHvE7BhYG+H3eeI4=', 0, '2025-12-23 13:16:31', 28403111);
INSERT INTO `songs` VALUES (37, '爱情讯息', 20, '郭静', '下一个天亮', 280680, 'http://p4.music.126.net/-ccXZvLLbvLQc99YEbylUA==/109951171316025348.jpg', 'http://m802.music.126.net/20251223140548/aced117e7a63a1540f9e0563dd411f30/jd-musicrep-ts/30ce/a945/a340/6a98ce4819764a3b4c09a97d2888fc82.mp3?vuutv=N16/W8ccz5ym1TfXlDDrE5U/bKafW2RyNeFn5wS+JEjiptUYJ6pWcCmDsk99934H/kigvBWfI0TZVD+LLFQiw4buutPmoNLA84yASpRUdbw=', 0, '2025-12-23 13:40:44', 233888);
INSERT INTO `songs` VALUES (38, '葡萄成熟时', 21, '陈奕迅', 'U87', 279846, 'http://p3.music.126.net/W9imJx0w_JeCGGs43dfjFg==/109951171529987110.jpg', 'http://m702.music.126.net/20251223140548/6e34b79007767ef6f70d38f9415d11ae/jd-musicrep-ts/02a7/354e/c187/21839c330fd0ef7c32fa02cd07e7df1a.mp3?vuutv=UYb2W7djcGP0z+hK/djt/5zJN1ZfrAzJ/fSoFOeg68prSZSUfIudB0IJzmlSQW83jLqwEhL/9gOk2xrp01J88+WTD0qnoboPzD5L+ks6ffw=', 0, '2025-12-23 13:40:44', 66285);
INSERT INTO `songs` VALUES (39, '晚安', 11, '颜人中', '晚安', 289184, 'http://p4.music.126.net/-rC55JsnmEWvafJQsAZaWw==/109951170473693123.jpg', 'http://m801.music.126.net/20251223140548/97b3d4b1a8d02e668197e6a5a4421b49/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096444706/fc30/11f6/37e9/1b5e499e00839398358feee4103f884b.mp3?vuutv=SHT3hu0w4/q9mnYXcIItKy/7jRSGbgtaPleEy3/yrOXqlIH6hFMw65W1ZDpHPOxoFm/f+kiYWeejy9cqvj6ycewUZfo2JfvkeA8KVlXTCMg=', 0, '2025-12-23 13:40:45', 1359356908);
INSERT INTO `songs` VALUES (40, '我只能离开', 11, '颜人中', '初恋那件小事 电视剧原声带', 230000, 'http://p3.music.126.net/5GPFbTQU-kW57PGv_7LeBw==/109951164440649436.jpg', 'http://m8.music.126.net/20251223140548/165ad0173e1c4215ae3af39008427309/ymusic/obj/w5zDlMODwrDDiGjCn8Ky/14054115241/7c52/0ce5/b5a1/2fdceee8e7b13de471b2013dd67718ad.mp3?vuutv=+yjb9jNahf+qSa/IOV6zV4df3VIatrwFcnLJ/V+CqPR18F0XFnb8uRUTQxcODKm6bc1c3PAwIWn/FUewGo+wZ5o4Kle5Yf9ONSHFp9QU0b8=', 0, '2025-12-23 13:40:45', 1398283847);
INSERT INTO `songs` VALUES (41, '如果爱忘了 (live)', 24, '汪苏泷', '声生不息·家年华 第12期', 245394, 'http://p3.music.126.net/3nL__2mV7k65XMoUw6Gu-g==/109951169721390560.jpg', 'http://m802.music.126.net/20251223140548/b348dff8562ac1739577f887541d95a0/jd-musicrep-ts/5a26/56c7/b49b/f023359d3efc5253e32dcfe35e565736.mp3?vuutv=kMeEuBLqnVrx1XHwz/yUaxZU9mfUWpbuawW+8yoYQxv9NKuq3eGjuaSoqIgij1wxKRL+81jtw8lC0bdCBC6q9/uFOmt7jnCiqzhXkg/n5Xw=', 0, '2025-12-23 13:40:45', 2124385868);
INSERT INTO `songs` VALUES (42, '左转灯 (1000 Times +1)(live)', 24, '汪苏泷', '声生不息·华流季 第4期', 194760, 'http://p4.music.126.net/b0ESPn1IhiOTnRS0Er7Daw==/109951172418600908.jpg', 'http://m801.music.126.net/20251223140548/589c74f7df54f3e3c53800bf261cf411/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/77095809704/7fc3/8357/6bd2/7efd7a3e07e019e7814b7a3849010c2c.mp3?vuutv=VCtvy65/vH9NWXeKNImAKxt7rCWJQFuGTt7hjcGBOhd4gdvZlWwEJvJsKNVs8k6T0fMh0kwTygTncJq0oDEPDzJZtM6VLunsgp77sSGjyLo=', 0, '2025-12-23 13:40:45', 3327859061);
INSERT INTO `songs` VALUES (43, '零距离的思念', 26, 'TINY7', 'Chose one me', 186121, 'http://p4.music.126.net/ClYJh1zEl6o6-9hWxhPiJw==/109951170464257454.jpg', 'http://m802.music.126.net/20251223140548/f7b797a99ad1063ab707e64e33e604fd/jd-musicrep-ts/5cce/85a6/f348/391a5c7632ad1b64674cd106b164737f.mp3?vuutv=vNXkgNXD78bpZUPKXt234+Cg14Bvs9Q5aI/ecyrnVGZHJ6XuWiJ/xbfnJac2ipq62TQbmV/BzGfSW5a9v7vEicFef0FWurBNhXUbCQ43EnU=', 0, '2025-12-23 13:40:45', 2673175226);
INSERT INTO `songs` VALUES (44, '小半', 27, '陈粒', '小梦大半', 297240, 'http://p3.music.126.net/HQxTggMCB7AHUXN-ZFEtmA==/1371091013186741.jpg', 'http://m802.music.126.net/20251223140548/81fea96b5696d461c28922ec6ecdc3f1/jd-musicrep-ts/eb4b/6631/7120/139aed98d4b6453d2cb2bb6531dbf091.mp3?vuutv=xplz4yczF96IuIsMXSvcLGZKlQPdSvtWO95eIfrahQKooN2p9u8NmuURxvu2sNyXylOquJdbOlmI9Yt8cY8XFvp5EONKilco84cDWsTL0XA=', 0, '2025-12-23 13:40:45', 421423806);
INSERT INTO `songs` VALUES (45, '浆果', 26, 'TINY7', '浆果', 267999, 'http://p4.music.126.net/BQAY8w9XzOj_j1wZgIsczQ==/109951168247366566.jpg', 'http://m801.music.126.net/20251223140549/c48e0ac701a4f2d7e84a28cf62e33d5c/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/24189603835/2cec/49db/7cd4/0ed28ceb5875a7a94f600862f6abd30b.mp3?vuutv=uGjgxTRsjpgHMN7/nMdoug1qoGu2gcFDA9OMlT+ELN5I6y3tV9ZZiXrx3SsxIKOvYzi6JC3yiSVOVhOcDbIGeRN3cGaho9niPEH4vmrMEYw=', 0, '2025-12-23 13:40:45', 2015896805);
INSERT INTO `songs` VALUES (46, '愿与愁', 29, '林俊杰', '愿与愁', 231586, 'http://p3.music.126.net/vtnI8JpimWnZSzkXdmIB3w==/109951168558210782.jpg', 'http://m702.music.126.net/20251223140549/442f608629552e47fd8878642d2e06ce/jd-musicrep-ts/2826/e83c/d5e0/2bc2f6eea617b13539735ee13b961b57.mp3?vuutv=1Wgsv2nu2pqEmK/LaFZmJ3xzVQLaUqEgKuzDp0Z5qKPRslXQpJFAI1IZKTmIrZI77IMfOfnerBiA+H3io2cXitNt4+BMA+CGoGQPulg4hws=', 0, '2025-12-23 13:40:45', 2041026502);
INSERT INTO `songs` VALUES (47, '其实', 30, '薛之谦', '意外', 242146, 'http://p4.music.126.net/ywVjRpbu9KpcBQh9KJz2HA==/109951164499974026.jpg', 'http://m702.music.126.net/20251223140549/789f49e90b9db2ac2e18f6a6ab058097/jd-musicrep-ts/9b78/d28c/13a6/748d62c1e57d1f85ea8c9db105224219.mp3?vuutv=uTvUJxj2/qxDZa4dUhOGtB0ctH7EJkAd2LeBfJw/BcPq4Iu9cpY9hq68XjNmcx2v4+C/Xyq9/dtWi3BvHBNQlBoOwxqLJQ0qapCI2Rkl73E=', 0, '2025-12-23 13:40:45', 27955654);
INSERT INTO `songs` VALUES (48, 'Always Online', 29, '林俊杰', 'JJ陆', 225044, 'http://p3.music.126.net/q8RW-c9LY27XNVEaqAa3NA==/109951170565907820.jpg', 'http://m802.music.126.net/20251223140549/6a28452cc779fb18e1fe3f2f35d63d3e/jd-musicrep-ts/775d/7ec4/10dc/a8524539b3659c65d3248af24a593a91.mp3?vuutv=7vSkbFeC1YltsQiWiSccvO1Vl5oeLsAujyhHQm/dKGB4Ev3SO2ohFlKYfYl1Vb+pBR58R24UDoSVbIeIqfbM4yMsqqlLwg+Pr0Vt+aTBMLg=', 0, '2025-12-23 13:40:46', 108485);
INSERT INTO `songs` VALUES (49, '给未来的自己', 32, '梁静茹', '崇拜', 250173, 'http://p3.music.126.net/8E9NHOTIf6V6Vv45_Taxdg==/109951168163299080.jpg', 'http://m802.music.126.net/20251223140549/4038041fda6b25eef6b88040f18f93e1/jd-musicrep-ts/9cb5/4b40/37ef/fbea612e950334ba41511db01f9c12a7.mp3?vuutv=iTYA3jPfvgoZOFOgs7Sl0ACy+OlX/di+xs5zvZW2FvTVAYdNuOyqOwdD7I1RnL0X5hXZSfm7drrZREVZKhKWutl8djBh9sZXBuPsElxvBIU=', 0, '2025-12-23 13:40:46', 254135);
INSERT INTO `songs` VALUES (50, '小胡同', 2, '郑润泽', '小胡同', 276588, 'http://p4.music.126.net/QsebYbDgQtKelH6r1iE2Fg==/109951167129280730.jpg', 'http://m8.music.126.net/20251223140549/e7e2c9aa70d253559622d05052b216af/ymusic/obj/w5zDlMODwrDDiGjCn8Ky/14055028519/895a/3506/31b7/a19900c487e8ba1872f325d7f805f2fe.mp3?vuutv=allUDmEyIg7RWSNcNfbYtFA5YNIicCiRHE+SUpbYy5Y1iWMGlhWRKatCLOXVMhIh2w0g0Uan9cd+Jgkz5ofkdS78F0nMFCRbs7ghq3dzJAQ=', 0, '2025-12-23 13:40:46', 1926623288);
INSERT INTO `songs` VALUES (51, '寂寞寂寞不好', 34, '曹格', '寂寞寂寞不好', 242953, 'http://p4.music.126.net/kHq7K_Nv0-GkaW4ITg0gMA==/109951163967345354.jpg', 'http://m702.music.126.net/20251223140549/d4e39b378a04ebcf557000ee7adb95d3/jd-musicrep-ts/fc9e/9e1b/e95d/f3744e27d26f32f420ca13963ce905bc.mp3?vuutv=PClf9/C/O4kUNNDt1wdZYgoLIe90RX8S6gSIP2N7weNZ2Bwt0vj1pO11Gx7ofyJstWKF9FJyXNC7B2lKOD+BTR8bJgM73EMwjY6ukFrY28g=', 0, '2025-12-23 13:40:46', 1355860112);
INSERT INTO `songs` VALUES (52, '有些', 11, '颜人中', '失眠症候群', 229523, 'http://p3.music.126.net/8DkTnzi7jdjWGYl4qbwLCg==/109951164517295956.jpg', 'http://m801.music.126.net/20251223140549/b62e22ea06a25c74ca566ecca957f101/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096437703/c585/8a1e/0ca4/4e2c6a214c3a5dd9b2d8fa2dde49c89a.mp3?vuutv=6Z7TuBDS8fDgKzZBiNQM2fWJjoEdeZrF91myCHCVOKwuI4bKyT9Q0Ex+97g5PTAW42pftkzciw+AR2weKOW5JakW5C9morlYJigVaULHDcE=', 0, '2025-12-23 13:40:46', 1406649619);
INSERT INTO `songs` VALUES (53, '你要的全拿走', 36, '胡彦斌', '覅忒好', 299346, 'http://p3.music.126.net/um599QnnJiNQhZgWLtgmXw==/109951168111322942.jpg', 'http://m702.music.126.net/20251223140550/fb70016a6d9aa3dfd9e09c8e77af92c6/jd-musicrep-ts/c294/69b4/5dd8/8508fdb24345c0b0860af81f58ca3a3d.mp3?vuutv=b+Uh8Zn5+0ShAKOgnCD7+s9R/7ol15oLskZ+xLPmRm3T4127ILR4GId81SEPLUTVwjOeAJZJp9Z9N6VIQoAg3hbOW9KhsiIZtdXJZz0Mihs=', 0, '2025-12-23 13:40:46', 529668356);
INSERT INTO `songs` VALUES (54, '我想念', 24, '汪苏泷', '我想念', 224516, 'http://p4.music.126.net/MIWMnBEedpJ8IpOau5D7PA==/109951168829804653.jpg', 'http://m702.music.126.net/20251223140550/bb133442f96700b802fa30e020853785/jd-musicrep-ts/f59c/c1f6/907d/79307d6e974e7112b579b36d65ab171e.mp3?vuutv=CUVsoHa0x8l7Nco1tCbBOlxM6ViASXPYKpqu6Z/xYZDSzEzfRMUEPwSUOvauaqxWGvUA8Ynh/BiwGr2P4qY74nwdDqGwO3mTG1ogEKSvvGA=', 0, '2025-12-23 13:40:46', 2071935674);
INSERT INTO `songs` VALUES (55, '有我呢', 38, '郭一凡', '重返地球', 274568, 'http://p3.music.126.net/zNdiECjTFkKoZIObqDqzWQ==/109951168870199828.jpg', 'http://m802.music.126.net/20251223140550/49557727ea5f0483de480040f339e890/jd-musicrep-ts/ca04/f56d/8c0e/8ac6024522d002301458b353e9cf5e7d.mp3?vuutv=NG4Oui3QjBHsyKWrXG/DuP8YvjBDsoVftdRwM8wCCNKjfvcfcnn2v+cm4VRBYg1KTVPNgQITNuK4HL5EUvrXxspsorosAOqcTGQIUlwkK40=', 0, '2025-12-23 13:40:46', 1400259397);
INSERT INTO `songs` VALUES (56, '舍得', 39, '王唯旖', '哈NI，非WO陌属', 262068, 'http://p3.music.126.net/Y2caOTiYFLIK1uAaz1hr4w==/18746673255294451.jpg', 'http://m702.music.126.net/20251223140550/ccc47ded7948cfe47fbd09bfffa15fd7/jd-musicrep-ts/62a8/1c59/c89b/786ddc2df933d05a8fd8301121df5ff0.mp3?vuutv=P69Hc8Du9r2+78GRTbwoX3y7c2gqrz+0nzkQ5x5ogIxPU/O0GyJb6+4CMWXsPX2MoM4faXGWB6aKCJqL5tWe76eRI7q4O3AtadZHLuuFPYU=', 0, '2025-12-23 13:40:47', 453268268);
INSERT INTO `songs` VALUES (57, '苦茶子', 40, 'Starling8', '埋汰', 170796, 'http://p4.music.126.net/VjXYNoGC3lXajZDs0r35XQ==/109951167852652412.jpg', 'http://m801.music.126.net/20251223154907/6487bea3137b2a25a329a9b221138043/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096434151/337f/5d05/2684/786f1dc4c7128ab2d8bebb0c402d624b.mp3?vuutv=FrT8jdkNtBcNe31NOqcYIy/qqnPY0kfWV++afWLo4EHt5bQbiG3m5y5UEpYBf0AGdfSrer6W5G1KPV6B5bTbVx9nrp7ONQbc0stZAkwcbvs=', 0, '2025-12-23 15:24:04', 1922888354);
INSERT INTO `songs` VALUES (58, '熄灭', 41, 'TC', '熄灭', 148611, 'http://p4.music.126.net/sNOy5UAdfk_OYumV4qF-0g==/109951168551205771.jpg', 'http://m701.music.126.net/20251223154908/596ece2931368c3886ccf09538b79fe1/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/26877152127/48a1/f55b/3d7b/02a7e9ad4b4bb1962e4328f18bcce68e.mp3?vuutv=6lwyWybbMriIAv85RoGhhXgVEAvmQSGgdRVDQnTOWKRwU6XHmgVIrX0f//GcJcgakJvSfQWVCEwxJKif9XVnf0zqvuGMcCvK+KphSc6oT3Q=', 0, '2025-12-23 15:24:04', 2040015902);
INSERT INTO `songs` VALUES (59, '你', 2, '郑润泽', '你', 254781, 'http://p3.music.126.net/OvnvQlFc8QSD7UnqtM9YYw==/109951164512103081.jpg', 'http://m8.music.126.net/20251223154908/4d7ff064168da1584d646e142cdaf576/ymusic/0659/0659/5659/132fa74aa11345b74e9aa3003b3d109a.mp3?vuutv=1HINIUpf1iYGevvrEb6QvU0jRgYei3psF8tui1JRcyrqZ7U0BZUyhS232/8t+O9LuqXOzqxxPkeOd8fT9z316C6h/cRrENKVuoud5bZAONo=', 0, '2025-12-23 15:24:04', 1406083061);
INSERT INTO `songs` VALUES (60, '不将就', 1, '李荣浩', '有理想', 312997, 'http://p4.music.126.net/e-Uc6W3Kug-HFHJ5nvCUPg==/109951166562828988.jpg', 'http://m801.music.126.net/20251223154908/83044224cfecf5b58dafc9ba456cd465/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/17225467312/1a4b/0cf0/4fdd/e7909ca1f2d68e3aa249fe0b842914d1.mp3?vuutv=snzphr65Q/GG8I8T7svGuS7w94CMRWKAURUaX5HFfTsRhLROauk9MotQreNbT1fsGc08cSJ6J1RZ1LHJpYrchEQ+50an5ltyAMy6CImD+Vk=', 0, '2025-12-23 15:24:04', 31654343);
INSERT INTO `songs` VALUES (61, '忘不掉的你', 14, 'h3R3', '忘不掉的你', 172173, 'http://p4.music.126.net/4BCskpY6Rmm-QReHnY8W6Q==/109951166071009318.jpg', 'http://m701.music.126.net/20251223154908/58a9a992de78223de443b0839c8de113/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096412136/2215/d4c8/1d4b/1b76d409a8afc46f4b2c86969f4af8b2.mp3?vuutv=ZqypBeRx6q/QSQCYqHJZ7ICwzd4uOo+2kclbFLeh64DJ3yZVCrrbnf5zzmXyQLgGHz4QmdfYY7LN57w/GHzkZGwU004B23WO+gmSn/KT/28=', 0, '2025-12-23 15:24:04', 1851652156);
INSERT INTO `songs` VALUES (62, '夏夜最后的烟火', 11, '颜人中', '夏夜最后的烟火', 279587, 'http://p3.music.126.net/i1p1CCz6PaDF2Gs0RqKJBQ==/109951165349625690.jpg', 'http://m801.music.126.net/20251223154908/0c19085810855f72e61adb8a85568350/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096566711/ac44/46c6/814b/13cb362f5975f35de4b3a4c483d83ddb.mp3?vuutv=JLGjP7vcXg4iPTepRn6pJCHVfwS+iYvT+EK26Yekv/vMB2nO/yiCg3hp3A3Fk9MmxSAJwdl33ECCxV8kCq30UeibwK099CGjEvMXA70apV0=', 0, '2025-12-23 15:24:05', 1482867143);
INSERT INTO `songs` VALUES (63, '红', 46, '罗言', 'When the world is came，take it！', 161585, 'http://p4.music.126.net/G-inyKjA-jO5MuOuV3g7Pg==/109951167027986653.jpg', 'http://m801.music.126.net/20251223154908/b15f4c28645afeebb352b237c5a39dfd/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14121054117/adc8/d947/eed4/8d9bdd6c85f16704495c6c1561e4975e.mp3?vuutv=z1Ewc3B4GkvBthbOHWl7NdjlUSxQP7Xx9bB3/eqDdN7zPxcPcw9wmYQZhLEaj5Lb/BTtPKo7JItU/F8fOjzMq3oUYKmE3ysRKSR58SHRh3I=', 0, '2025-12-23 15:24:05', 1918576268);
INSERT INTO `songs` VALUES (64, '多远都要在一起', 4, 'G.E.M.邓紫棋', '新的心跳', 216880, 'http://p3.music.126.net/kVwk6b8Qdya8oDyGDcyAVA==/1364493930777368.jpg', 'http://m801.music.126.net/20251223154908/8e01049220993ee5293986129ebeaa63/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096602385/1136/33a8/dd9a/e6c4dbb01c8c78843d43a134048bc400.mp3?vuutv=1E/goAFJLjmXWGxBbbHVQ5+2b0y1nN6uMUFkACjHEXxABse5VIvMNEE3adbJpyftP35mS1e88I9HTuzYRzxL45QvwIdlQlLkcIpPUJaKq1Q=', 0, '2025-12-23 15:24:05', 30612793);
INSERT INTO `songs` VALUES (65, '把回忆拼好给你', 48, '王贰浪', '把回忆拼好给你', 381000, 'http://p4.music.126.net/CBx2K_jEN3SNWwYztagPPw==/109951164485969446.jpg', 'http://m701.music.126.net/20251223154908/3d4c7dc8bfdac7f33121579e4f5ed994/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096426425/36e7/1b7a/21db/c3aa221bd5b7c204455a1f65c65633ee.mp3?vuutv=4cNGeeCJ1p9ARlI+q23H5koS68Jkpv+jkv9RAbHb2S28arBLRRAxOL0VKGpIV5JR2GeVvb9rjKO5GOmaUHq12JYktSZfDGXUTLQPvei/dro=', 0, '2025-12-23 15:24:05', 1403318151);
INSERT INTO `songs` VALUES (66, '出现又离开 (Live)', 49, '梁博', '我是唱作人 第2期', 403968, 'http://p3.music.126.net/mAV2OH6nPJd4XLwn80kwpA==/109951164054054313.jpg', 'http://m801.music.126.net/20251223154909/a63c8b72ff4b9b8bc79e2fc0e363b673/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/23733347505/0e26/d541/9fc7/ed7472269e7b67524bc639371d5b7d31.mp3?vuutv=OMFoV28o40XDdlQbBRTfc5YamxEvR9TyXSn+bBDCb1Pe9H0aJjQT3eg16FWFcG4q8SBdzoHBBcDvOeexSRaCBWc5Nyne59zC5O4M/gDy9+I=', 0, '2025-12-23 15:24:05', 1363553440);
INSERT INTO `songs` VALUES (67, '红色高跟鞋', 50, '蔡健雅', '若你碰到他', 206586, 'http://p4.music.126.net/jJOaqlez9x5VofjgB7B_Bw==/109951166195459631.jpg', 'http://m801.music.126.net/20251223154909/a8d69c6705a596fc61d932c6d80eec45/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096419692/ce3d/27ee/6b7f/95fd39d72e4a19b265db45af50cf9061.mp3?vuutv=LFzL3hDKr3FeayLtXCd3sF6e7NTDnmkEAdX60aFu48EAiUQyiOPEGFevhzaORIGZJI2sDWzL8n+hc4Y5lCxpPxXQ4llIKpUM37sWy+ZdSQ4=', 0, '2025-12-23 15:24:05', 208902);
INSERT INTO `songs` VALUES (68, '一滴泪的时间 (L)', 51, '赵紫骅', '一滴泪的时间 (L)', 269088, 'http://p4.music.126.net/N0Ba2-7u8rQaD55y9VghlQ==/109951164594400176.jpg', 'http://m701.music.126.net/20251223154909/e6d23d2a9995d63d89580ed8f85adec1/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096560462/17f6/80c3/48d6/2914b6ba9c71c105ab3c465d65f5d8b3.mp3?vuutv=YEQsbDAndzw/yIS3DY8LWyBjCQpRzwkJxNJ6/fdbtg61Rb2uIOEb1YoiNXIX5vZemKzfEsHvNVl9A1sHyhD2KurEAsZiBtFajPqAJDM/228=', 0, '2025-12-23 15:24:05', 1413374550);
INSERT INTO `songs` VALUES (69, '富士山下', 21, '陈奕迅', 'What\'s Going On…?', 258902, 'http://p4.music.126.net/oSMs7RzJFx0TgWCqRC8XjA==/109951171844247587.jpg', 'http://m701.music.126.net/20251223154909/ad7a3485a5d21221469f7e2c92a56da5/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/32385808972/aa2f/d21e/998b/f15db921905b7dc7be3b5c8ab28f49d4.mp3?vuutv=XNTzOB9apqpaz1ljMOYQ1n9x6vqXt73drHGyP5EWXq14UeN2wGttleTijDwZGCMI6b6IxhABbNZmVDdPyGwCz9PHS2qBq8h/wbO+6pdgJnU=', 0, '2025-12-23 15:24:06', 65766);
INSERT INTO `songs` VALUES (70, '予你', 5, '队长', '予你', 231349, 'http://p3.music.126.net/yxVm_vRFOode6yP67NmMcA==/109951166625738075.jpg', 'http://m701.music.126.net/20251223154909/4713fbb781a3161db3c2c9d83d0e1d29/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096415192/1c2a/80eb/517e/56e8202200698a8074d3cdec2442c65a.mp3?vuutv=dVg7ef44QX9yf30johsW/2OchSWJOE5aGKs4qZgYWqJtEhFgDn9so3UmJ4jrw9mHc7SjQDkbctW10fPoe0yJl7fKM93BiACFGX6HDU3EuoA=', 0, '2025-12-23 15:24:06', 1895330088);
INSERT INTO `songs` VALUES (71, '雨爱', 54, '杨丞琳', '雨爱', 260480, 'http://p3.music.126.net/Qt6sfLxRCscFZVXhbQ4bfg==/109951172020385959.jpg', 'http://m701.music.126.net/20251223154909/3ab8ef5a130f95b0afcc0bcd5e86a168/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096607845/1948/5626/ec9b/171c98d59af296b5c8ae7e09dcf2ba12.mp3?vuutv=vvVS4UNAKybTIQK/CPmRnSVMv0rH96PVP4Z2ZYzzNz8ucqeMxohgUZRVBiOF06zKBBBApBA9kbbKTcfgmF082uvaERECKjKSDHjPuIMu4I8=', 0, '2025-12-23 15:24:06', 316100);
INSERT INTO `songs` VALUES (72, '坠落', 50, '蔡健雅', '天使与魔鬼的对话', 250118, 'http://p3.music.126.net/RLrFydREIra5P5rTzIpybQ==/109951166118886951.jpg', 'http://m801.music.126.net/20251223154909/52c01f5942db87e2057ad4506394d406/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/9554566202/790c/0152/50b4/481c7e83f68730b25480e3a67bb7c386.mp3?vuutv=hoU+utsOfDx2ttykw7cLNmpSGThJM7GJVdo3xHGfrtVm3VwlLmvXVtKf8ZLKBwfeirsYBhdljqKkDx3oa7nPDe0uDt8nPlXzjuWnGRRiMu4=', 0, '2025-12-23 15:24:06', 27747329);
INSERT INTO `songs` VALUES (73, '我爱你但是我要回家', 56, 'ET', '我爱你但是我要回家', 194218, 'http://p4.music.126.net/VZe8WHdF3L9A2oEVVVmh1g==/109951170165615900.jpg', 'http://m801.music.126.net/20251223154910/d6e6e70a7aa9578eb3281183465f1a20/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/56572092506/4b10/0f8e/9116/87e40059da1fdf59e3c0697424e757c1.mp3?vuutv=quIU6U2Ewt2r/TXVu8+4FtQ4FOcM7Eb6udXoEDmKE5Q+wZoI2w43ai+XtKKAKeJgZliBElmyNNuLHf17JVWWBzrMHCY3NwrBY8bgQHX8Bxk=', 0, '2025-12-23 15:24:06', 2647831829);
INSERT INTO `songs` VALUES (74, '小孩', 57, '罗森涛', '为何离开', 219865, 'http://p3.music.126.net/5zAv9nKlwj80OearK5Vrjw==/109951169686963932.jpg', 'http://m801.music.126.net/20251223154910/0dd513563014e7c41d97cfcc95e28d73/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/36667007758/dada/7fc4/768b/9fa11f0f51fcb599b23a6b16f8cc01ac.mp3?vuutv=cI1r3moy5vb3hpfnJPc9uOwz/SF54HhRaLSKdBVTQwqnKqS5zTjH5fkDPR+34S9ES9z1tD0nOqXBhkC9HJUxsETlp03P1RGKZnGN9UFc85E=', 0, '2025-12-23 15:24:06', 2166584564);
INSERT INTO `songs` VALUES (75, '开始懂了', 13, '孙燕姿', '我要的幸福', 271493, 'http://p4.music.126.net/1HJILQwc62AfvcXkGgVJHQ==/109951165549820772.jpg', 'http://m701.music.126.net/20251223154910/0af82be8eede9a3c2d7a9b8ceb4b6d53/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/18740334546/be11/ba2b/ca2f/9b83535ce26d13390cf630df1fb56fb9.mp3?vuutv=OK9dWrXXkNyPqU5+uQL3DfCtTwsTSQjLOzDrV6hAmyxYLYdPmezpq5vj2NfvG4KSRS2SuuiGp3IPvdnCqy92sFkOFzcVa6jzSm3h8ztQYIk=', 0, '2025-12-23 15:24:06', 287719);
INSERT INTO `songs` VALUES (76, '我记得', 59, '赵雷', '署前街少年', 329891, 'http://p3.music.126.net/9bVOooAY6U6EJLzpv1Fikw==/109951169682871673.jpg', 'http://m701.music.126.net/20251223154910/4b04d889d757a16393f9bd19d3fa1af7/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/17718439149/44a7/5592/7271/b58b2979b640d886d829e1c6647f8d8a.mp3?vuutv=PO8daIIlkVsoIGoXoPPTDZdidhUSYsq3VHTeYPsfDGAgyUPGz11uy/vCVKxaeNQPGl9NEXD7DfrvrsrRditPEqk0l5OXYLwZ8DgqLbQBEY0=', 0, '2025-12-23 15:24:07', 1974443814);
INSERT INTO `songs` VALUES (77, '遇上你之前的我', 15, 'Gareth.T', '遇上你之前的我', 215947, 'http://p4.music.126.net/nmObDg4QpFxM_U8Fqap-Wg==/109951169481923010.jpg', 'http://m801.music.126.net/20251223155341/b9d5e66c243168328ab3925990a70c16/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/35095537084/ad5c/86fb/27f7/49be49756f93e5e6cb3e76a6865686ed.mp3?vuutv=eGY3K4ZH2vhxiW9VEwINlGsJwPAhO3R84+eGVn/aHZxvtJPm/rvCEaRa1omldAOYHIKb1xz99/M9hXCNGNP9RzgHPFcK6BziPrcRNFBMwro=', 0, '2025-12-23 15:28:38', 2143932459);
INSERT INTO `songs` VALUES (78, '爱我还是他', 61, '陶喆', '太平盛世', 292666, 'http://p3.music.126.net/ZR6QuByWgej9-aRhZjLqHw==/109951163803188844.jpg', 'http://m701.music.126.net/20251223155341/ead7ac31cf1dff16e57b521e34927969/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/18743090577/beb0/d09a/e811/1d84cf476af9a08c001d18d96d2dd26a.mp3?vuutv=rSsYt6y+W7nFICGlDyVRtcUx5DLltl35Z+kIT8UoEJrF5COyL+Igs8etufkTbLZLqRL9BNBrLkHSHIx7/xxJ5/VjzdNJi3i9DcMvkXhj6tM=', 0, '2025-12-23 15:28:38', 150432);
INSERT INTO `songs` VALUES (79, '如果可以', 62, '韦礼安', '如果可以', 274599, 'http://p3.music.126.net/znTzn19zZvZ4IdlKEOhWRg==/109951166564931690.jpg', 'http://m701.music.126.net/20251223155342/44cbaea64bd1e93e7b79db1fd503c78a/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/32047898943/42db/e401/1f96/ec10d216a70cd65ffa3b62b70a175ef0.mp3?vuutv=SgYVJzCQ39YzDWuZlGVpqmUF6RDNWbgpSlL9kkOlkxoMmExkZkSsFmO8Co7WBTUhmIo96x9/+oTS8rGXqwYkucwnZH14g5scixYZbHDXIHY=', 0, '2025-12-23 15:28:38', 1890530891);
INSERT INTO `songs` VALUES (80, '孤独患者', 21, '陈奕迅', '？', 271226, 'http://p3.music.126.net/Po0tJTtv4aBaYozWlnojHg==/18546562139313276.jpg', 'http://m701.music.126.net/20251223155342/d737a204ea79f76a23a41acd27e7942f/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/28481793823/892c/9921/97d5/51c7a3de51362e9f58268a6de552aa05.mp3?vuutv=YrWaTythG6guKZmehECi+N+yUAFhtGfITcxwv6K9dfjwum9pOze2SoQCzGRLPsNFTQ4DXRUeKjWkXotfqJY3i1DgavrCZwQyHtpjbnLf4KM=', 0, '2025-12-23 15:28:38', 64093);
INSERT INTO `songs` VALUES (81, '阳光下的星星', 64, '金海心', '独立日', 283520, 'http://p3.music.126.net/qx1f3oMS-vPSrfdvYZMl8A==/109951167193041941.jpg', 'http://m701.music.126.net/20251223155342/19e3bfb6990728217d2f334136402262/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/17200064364/f325/acfb/e3fd/d7d99175f2b577f975e4bb52f1f7eaa4.mp3?vuutv=MoMjN4bXebqOaYKimnTtcIJWRJKkfQFsZ/l8x5fHWr7zS6nl8CEcVkpOik1rA1TAuApNblMS+49n4cUdkXVZ/j6ZWWpHg9/3t0u+r0Yy1P8=', 0, '2025-12-23 15:28:38', 247821);
INSERT INTO `songs` VALUES (82, '知我', 65, '国风堂', '知我', 277321, 'http://p4.music.126.net/_etyUh1ofScyTMFArsJXWg==/109951164415301539.jpg', 'http://m701.music.126.net/20251223155342/f44b8990b47e83ec0ab2a2ea64c95c3a/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/45265667248/812b/75d3/daf7/680ab2bc6ced8eb8d489c4f4a3f4681a.mp3?vuutv=pdi3ucPUe1cbdIU9eIldWQBWng77rYOSWkvufOGviTiNCILhtbEsKDbEqX+2UGfvW5Ln1znZwinf4mN3ZgzaGENaQqc+ALeaYyZkBJxrTi8=', 0, '2025-12-23 15:28:38', 1394167216);
INSERT INTO `songs` VALUES (83, '麦恩莉', 19, '方大同', '回到未来', 288360, 'http://p3.music.126.net/8I4zvpNSsj--wGNg-mE2kw==/109951168870428045.jpg', 'http://m701.music.126.net/20251223155342/6146053e2aa8f0bf4b522a2e2a29b84d/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/18747268489/b6a6/668e/a953/76959252abb60fce6b94b4f6a747e0c6.mp3?vuutv=d6YaKjstS6ZEukJ6AT0OSylMo5BDbfr1oPI9tHHMAcZu3ZFBjtd/T0DEmXwB3Rgs0RHbZcrLQNslqhalLnSF7FrgpBbh2+MQ2z5tvjfWPvg=', 0, '2025-12-23 15:28:39', 25648006);
INSERT INTO `songs` VALUES (84, '想你的夜', 67, '关喆', '永远的永远', 265960, 'http://p3.music.126.net/zu9MjBERozqTv_0NpM91Rg==/109951164094037727.jpg', 'http://m8.music.126.net/20251223155342/a5e2044c7291d2646d197f15659e039d/ymusic/010f/0f0b/030c/6e4993949f8a9790d6244fa98579cec9.mp3?vuutv=nAnW/pbJxJGMR1fQFsfQnyD/1PCszBj8ye+fzLuJKaK7X6AzGAEmZ3uKpFg5wr3XOdOlZaXKFpoKJdtf7qtGv6rk22ClmJNij7GeK8Bmovs=', 0, '2025-12-23 15:28:39', 88926);
INSERT INTO `songs` VALUES (85, '绽放', 2, '郑润泽', '梦游', 240116, 'http://p4.music.126.net/Ws93IUrJGR_lK-QEsdKTWw==/109951168408373477.jpg', 'http://m801.music.126.net/20251223155342/b33b7e61d505c20f2594be587d168541/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/25461508568/f6f1/9f83/ef16/7a488fe8b0686a0c3729249fb22f5cdb.mp3?vuutv=Ns8uWAZdcVsK9c3iQxkgOcsUJ281MTH3c2/E8kzBRQeBNqozHHCoDFHXB1zdFFjwbTrO2QekQcGBIi5Xz617KLFZuUk2AaYlnmYcp+xVHJ4=', 0, '2025-12-23 15:28:39', 2025186889);
INSERT INTO `songs` VALUES (86, '至少还有你', 69, '林忆莲', '林忆莲\'s', 274800, 'http://p3.music.126.net/Tpkxzsv2OA_4NrFjaYP1qA==/109951163829570820.jpg', 'http://m801.music.126.net/20251223155342/e67eea551a989e328216c1d471e655c7/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/18753588073/f188/d356/cb85/271c8b253839940daeee5918b9107ff1.mp3?vuutv=6Jgdd/WwQNSEzKKBNWklsaBE5CV2wGm2yRzlCzmBLGW+hN6gg8YjyeeSGKkbu1/p+of/E0yLizlrR38tlHYs7YnFZOZke9ULhoOXkAn7wdk=', 0, '2025-12-23 15:28:39', 256621);
INSERT INTO `songs` VALUES (87, '可不可以', 70, '张紫豪', '可不可以', 240889, 'http://p4.music.126.net/WafK2OQfEtqXitdDXJ772Q==/109951163252847249.jpg', 'http://m701.music.126.net/20251223155343/aaa037ecba63668e685580693dd3cbfa/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/28481671527/c373/851f/c825/2f4ff875f1bd90b7a5db0fa42e5dae8d.mp3?vuutv=sqh0G0AKLTYfmSW5LsArVMm/fA6jKOjTPIsLYCO5aDZZFfiraf1YqhPeh8kRJjNgj4zijQuPDzW0dPagoTmu8nSqn5+vw3Vi9dWo6LZ14Is=', 0, '2025-12-23 15:28:39', 553755659);
INSERT INTO `songs` VALUES (88, '指纹', 71, '杜宣达', '指纹', 240272, 'http://p3.music.126.net/kT4AECoc13oVKLEg_-eFMA==/109951166578436098.jpg', 'http://m701.music.126.net/20251223155343/04a31dbaace49176f6930fb40691417f/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/27703438765/5989/f6d7/4210/2962d2339fbd854c359256c452ba5fb1.mp3?vuutv=B+vEa0NJm8UcMRBT4nf7nj9Dn5yw29capStyORUaV4LNNLFpb9WfOZbLBUlRz2CHHJfgSpDfy46wnhipTZVBn8vhnQjRvDOYlLb54DtF6hg=', 0, '2025-12-23 15:28:39', 1887139866);
INSERT INTO `songs` VALUES (89, '与我无关', 72, '阿冗', '与我无关', 240000, 'http://p4.music.126.net/x-jReyGkM5OTKUEtTqXGoA==/109951164597332931.jpg', 'http://m801.music.126.net/20251223155343/68fa83fe18fd337c8bcb628bf920f6c2/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096426135/4974/2ce7/a751/bcd40908be84116ddb0bdc1c4879c44c.mp3?vuutv=PnU8coh+MISrSfqkLpVVfY0x4EPKU6fHHeBXhT1CHcqqAEBxTR+wYdzuwYE0XpDZrZxtdyAz2FkzycJEHv6ZF0Yp6b9xTDGwMQL56bPWG/U=', 0, '2025-12-23 15:28:39', 1413585838);
INSERT INTO `songs` VALUES (90, '遐想', 2, '郑润泽', '梦游', 189719, 'http://p3.music.126.net/Ws93IUrJGR_lK-QEsdKTWw==/109951168408373477.jpg', 'http://m701.music.126.net/20251223155343/be9657baddf55c5307e75e845c68c9e0/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/24446587792/0301/6b71/c110/2ad8ed64708568ee326f9f09d12ac058.mp3?vuutv=hy7K2QfzX6ZAtnE/clj7QZwPlWhFx5iAG3l79htDpvG7/QSny6uLXw6ByEgXDLi1R4Ie0ri+2bjKMffVqqrkxd5zOy0WJCLYrkar9kUiWZo=', 0, '2025-12-23 15:28:40', 2018733994);
INSERT INTO `songs` VALUES (91, '句号', 4, 'G.E.M.邓紫棋', '摩天动物园', 235632, 'http://p3.music.126.net/KTo5oSxH3CPA5PBTeFKDyA==/109951164581432409.jpg', 'http://m701.music.126.net/20251223155343/833fce12888c80045a261780252d5b9e/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/14096458792/877b/941c/faf5/9bf6342db792481bbf8bc391527d853c.mp3?vuutv=R6uF+qMDW1vCMRaBB/6hmIRuDmWvkf6XJmpWeBoBJtTV/QJLfLaSokfxpC8KhIxciMdM8IxFWagGmpoCsJkv43lVsqejd6lwHzSblKvbjsE=', 0, '2025-12-23 15:28:40', 1405283464);
INSERT INTO `songs` VALUES (92, '无名的人', 75, '毛不易', '无名的人', 282181, 'http://p3.music.126.net/MlbszYGB_n-vdDbjtSsr7w==/109951170480122368.jpg', 'http://m801.music.126.net/20251223155343/059fc76ca99340abe2ab104f2ec31867/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/34630804454/3f24/a73e/819e/7554f36c2dd1f6d1addd1c018c7a43f9.mp3?vuutv=hJXkXMGCJura3R3rJUvRBxbcvCROHmwziaStBqlFz+i9pozXRXe2fIUz4iWfJNs6SueS+fCiS5zSGEaaX8gbb5F2LelebXK8Sm9hSx40/mk=', 0, '2025-12-23 15:28:40', 1903149553);
INSERT INTO `songs` VALUES (93, '第57次取消发送', 76, '菲菲公主（陆绮菲）', '第57次取消发送', 180560, 'http://p3.music.126.net/urn8LGHXlT4XLnpliFBXLQ==/109951171482450403.jpg', 'http://m801.music.126.net/20251223155343/d4357934352fbe7a9e5213706a2eaa8c/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/62435249995/b578/73e6/3775/a885308b1e0db14fa1081d70f663c207.mp3?vuutv=DMs09yE/0fUpaAsvgoaMiEsVLMReuyXvZXf5aPrnVutTwpGHNCst2jvoMAAqM2VZYwzwofj4xOP3ztdeMFYD9U4r34DiwUSWg9SC8rh2F+I=', 0, '2025-12-23 15:28:40', 2692390754);
INSERT INTO `songs` VALUES (94, '想你时风起', 77, '单依纯', '我的人间烟火 电视剧原声带', 276519, 'http://p3.music.126.net/jdtkAVxASgsZtN243m19NA==/109951168728196721.jpg', 'http://m801.music.126.net/20251223155344/2133c5a6888e8ea6fe7d0755af1fa803/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/29281109458/e0a3/94e3/81ac/19ddea61d2416a93ad25ba57a86f2a69.mp3?vuutv=QOXBizshEdpswNDNcWfx+7BtwxXtnlmBrhdYFJNih9lYQrodEk0IU0T0YeFCkmABpepuQCerz1FmWAsA69Y6v2P7CjSw6oxRknEL39X4orc=', 0, '2025-12-23 15:28:40', 2062623445);
INSERT INTO `songs` VALUES (95, '几分之几 (You Complete Me)', 78, '卢广仲', '几分之几', 228570, 'http://p4.music.126.net/fWpX1LILPAyiOacF96REww==/109951163191952149.jpg', 'http://m7.music.126.net/20251223155344/b9dd5786673dc287d77e9290da8a43ab/ymusic/30dc/39f8/239e/f351654323f5ce55565c6947a1268bac.mp3?vuutv=SnSlGfjHLeUPbThHVAFphE819S+4sjoX39UTHP/UGObas1J5VvdjtUaeh/fK9QT+kjkRvc0djt2VDpCer/+z2zFbbjKzB+3I8PZ73lsVOds=', 0, '2025-12-23 15:28:40', 530995517);
INSERT INTO `songs` VALUES (96, '曾经是情侣 (Live)', 49, '梁博', '我是唱作人 第4期', 403003, 'http://p3.music.126.net/GLiLYkBs9Gq7TXOkMz1g0w==/109951164137683554.jpg', 'http://m801.music.126.net/20251223155344/aa690b6d90abdf8588198af79cb152c3/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/23733231609/1d6a/c449/ff8d/1bee6d7ad965ab4c5cb2daaf1cec0644.mp3?vuutv=yyBHhApFWeNdWrvIeIi/OkwP/jf0JWFERZoq5+ibBIuZncmgtlKyx87D1L46SY+OhrCUmeaPwklNj8xc3We+t5Nnx8C/PdW6byQVgGCv7qk=', 0, '2025-12-23 15:28:40', 1370880017);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键标识数据',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户密码(非加密)',
  `status` tinyint NULL DEFAULT NULL COMMENT '0：正常 1：禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '$2a$10$KtLsCQZTrx/s6vRCsBPXN.JUxeWEmy2Z2ynyv/hSrDENVetjHxKcK', 0);
INSERT INTO `users` VALUES (2, '陈猪猪', '$2a$10$OE4Oivb76KcEIDZ8hRwph.JFLnRd6BWmkme40X.P0PII5pu55/rAm', 0);
INSERT INTO `users` VALUES (3, '张哞哞', '$2a$10$UsZBcTgeyrCw.cNNLuo6TOo08jY6WYSSdMUvNkoSzWDO2suxDrksS', 0);
INSERT INTO `users` VALUES (4, 'mineuser2', '$2a$10$YwuV6RE6rpKJ571ykNWAvOZYjtVoqJsrZnN8UNbskfKy2vazuv5sO', 0);

SET FOREIGN_KEY_CHECKS = 1;
