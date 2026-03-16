const express = require('express');
const router = express.Router();
const musicController = require('../controllers/musicController');

// 获取歌曲列表
router.get('/list', musicController.getList);

// 搜索歌曲
router.get('/search', musicController.searchMusic);

// 获取歌曲详情
router.get('/:id', musicController.getDetail);

// 获取歌曲最新播放链接
router.get('/url/:id', musicController.getSongUrl);

// 获取网易云推荐歌单
router.get('/netease/recommend', musicController.getRecommendPlaylists);

// 获取网易云歌单详情（歌曲列表）
router.get('/netease/playlist/:id', musicController.getNetEasePlaylistDetail);

// 获取网易云歌曲播放链接
router.get('/netease/song_url/:id', musicController.getNetEaseSongUrl);

module.exports = router;
