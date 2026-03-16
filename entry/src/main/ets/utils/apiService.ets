 import { http } from '@kit.NetworkKit'
 import { LoginRequest, RegisterRequest, ApiResponse, LoginResponse, UpdateUsernameRequest, UpdatePasswordRequest } from '../models/user'
 import { SongItemType, SongUrl, PlaylistSummary } from '../models/music'
 
 // API基础URL - 请根据实际后端地址修改
 const BASE_URL = 'http://10.21.236.94:3000/api'

interface ErrorResponse {
  code: number
  message: string
  data: null
}

class ApiService {
  // 通用HTTP请求方法
  private async request<T>(
    url: string,
    method: http.RequestMethod,
    data?: Object
  ): Promise<ApiResponse<T>> {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp()
      
      const requestOptions: http.HttpRequestOptions = {
        method: method,
        header: {
          'Content-Type': 'application/json'
        },
        readTimeout: 30000,
        connectTimeout: 30000
      }

      if (data && (method === http.RequestMethod.POST || method === http.RequestMethod.PUT)) {
        requestOptions.extraData = JSON.stringify(data)
      }

      httpRequest.request(`${BASE_URL}${url}`, requestOptions)
        .then((response: http.HttpResponse) => {
          if (response.responseCode === 200) {
            try {
              const result = JSON.parse(response.result.toString()) as ApiResponse<T>
              resolve(result)
            } catch (e) {
              const errorResult: ErrorResponse = { code: -1, message: '解析响应数据失败', data: null }
              reject(errorResult)
            }
          } else {
            console.error(`HTTP Error: ${response.responseCode} - ${response.result}`)
            let errorMessage = `网络请求失败: ${response.responseCode}`
            try {
              const resultStr = response.result.toString()
              const resultObj = JSON.parse(resultStr) as ApiResponse<null>
              if (resultObj && resultObj.message) {
                errorMessage = resultObj.message
              }
            } catch (e) {
              console.error('Parse error response failed:', e)
            }
            const errorResult: ErrorResponse = { code: response.responseCode, message: errorMessage, data: null }
            reject(errorResult)
          }
        })
      .catch((err: Error) => {
        console.error(`Network Error: ${JSON.stringify(err)}`)
        const errorResult: ErrorResponse = { code: -1, message: err.message || '网络请求异常', data: null }
        reject(errorResult)
      })
      .finally(() => {
        httpRequest.destroy()
      })
    })
  }

  // 注册接口
  async register(params: RegisterRequest): Promise<ApiResponse<RegisterResponse>> {
    return this.request<RegisterResponse>('/user/register', http.RequestMethod.POST, params)
  }

  // 登录接口
  async login(params: LoginRequest): Promise<ApiResponse<LoginResponse>> {
    return this.request<LoginResponse>('/user/login', http.RequestMethod.POST, params)
  }

  // 修改用户名
  async updateUsername(userId: number, username: string): Promise<ApiResponse<null>> {
    const params: UpdateUsernameRequest = { userId, username }
    return this.request<null>('/user/update', http.RequestMethod.POST, params)
  }

  // 修改密码
  async updatePassword(userId: number, oldPassword: string, newPassword: string): Promise<ApiResponse<null>> {
    const params: UpdatePasswordRequest = { userId, oldPassword, newPassword }
    return this.request<null>('/user/password', http.RequestMethod.POST, params)
  }

   // 获取歌曲列表
   async getSongList(): Promise<ApiResponse<SongItemType[]>> {
     return this.request<SongItemType[]>('/music/list', http.RequestMethod.GET)
   }
 
   // 获取歌曲播放链接
   async getSongUrl(songId: string): Promise<ApiResponse<SongUrl>> {
     return this.request<SongUrl>(`/music/url/${songId}`, http.RequestMethod.GET)
   }

   // 获取网易云推荐歌单
   async getRecommendPlaylists(): Promise<ApiResponse<PlaylistSummary[]>> {
     return this.request<PlaylistSummary[]>('/music/netease/recommend', http.RequestMethod.GET)
   }

   // 获取网易云歌单详情（歌曲列表）
   async getNetEasePlaylistDetail(id: string): Promise<ApiResponse<SongItemType[]>> {
     return this.request<SongItemType[]>(`/music/netease/playlist/${id}`, http.RequestMethod.GET)
   }

   // 获取网易云歌曲播放链接
  async getNetEaseSongUrl(id: string): Promise<ApiResponse<SongUrl>> {
    // 直接构造网易云外链地址
    const url = `https://music.163.com/song/media/outer/url?id=${id}.mp3`
    const response: ApiResponse<SongUrl> = {
      code: 200,
      message: 'Success',
      data: { url: url }
    }
    return Promise.resolve(response)
  }

  // 搜索网易云歌曲（按关键词）
  async searchNetEaseSongs(keywords: string, retryCount: number = 0): Promise<ApiResponse<SongItemType[]>> {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp()
      const url = 'https://music.163.com/api/search/get/web'
      const requestBody = `s=${encodeURIComponent(keywords)}&type=1&offset=0&total=true&limit=20`
      
      console.info(`[MusicApp] Search Request: ${url} with body ${requestBody} (Attempt ${retryCount + 1})`)

      httpRequest.request(url, {
        method: http.RequestMethod.POST,
        extraData: requestBody,
        header: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          'Referer': 'https://music.163.com/',
          'Cookie': 'os=pc'
        },
        expectDataType: http.HttpDataType.STRING,
        connectTimeout: 30000,
        readTimeout: 30000
      })
      .then((response: http.HttpResponse) => {
        httpRequest.destroy()
        console.info(`[MusicApp] Search Response Code: ${response.responseCode}`)
        if (response.responseCode === 200) {
          try {
            let resultStr = ''
            if (typeof response.result === 'string') {
              resultStr = response.result
            } else {
              resultStr = JSON.stringify(response.result)
            }
            
            const result = JSON.parse(resultStr) as NeteaseSearchResponse
            const songs = result.result?.songs
            
            if (songs && songs.length > 0) {
              console.info(`[MusicApp] Found ${songs.length} songs`)
              const songList: SongItemType[] = songs.map((item: NeteaseSong) => {
                const song: SongItemType = {
                  id: item.id.toString(),
                  name: item.name,
                  author: item.artists && item.artists.length > 0 ? item.artists[0].name : 'Unknown',
                  img: (item.album?.picUrl || '').replace(/^http:/, 'https:'), 
                  url: `https://music.163.com/song/media/outer/url?id=${item.id}.mp3`
                }
                return song
              })
              const successResponse: ApiResponse<SongItemType[]> = {
                code: 200,
                message: 'Success',
                data: songList
              }
              resolve(successResponse)
            } else {
              console.warn('[MusicApp] Netease search returned no songs')
              const emptyResponse: ApiResponse<SongItemType[]> = {
                code: 200,
                message: 'No results',
                data: []
              }
              resolve(emptyResponse)
            }
          } catch (e) {
            console.error('[MusicApp] Netease search parse error:', JSON.stringify(e))
            const errorResponse: ApiResponse<null> = { code: -1, message: 'Parse error', data: null }
            reject(errorResponse)
          }
        } else {
          console.error('[MusicApp] Netease search HTTP error:', response.responseCode)
          const errorResponse: ApiResponse<null> = { code: response.responseCode, message: 'Network error', data: null }
          reject(errorResponse)
        }
      })
      .catch((err: Error) => {
        console.error('[MusicApp] Netease search request failed:', err.message)
        httpRequest.destroy()
        
        if (retryCount < 2) {
           console.warn(`[MusicApp] Search failed, retrying (${retryCount + 1})...`)
           setTimeout(() => {
             this.searchNetEaseSongs(keywords, retryCount + 1)
               .then(resolve)
               .catch(reject)
           }, 1000)
        } else {
           const errorResponse: ApiResponse<null> = { code: -1, message: err.message, data: null }
           reject(errorResponse)
        }
      })
    })
  }
 }

interface RegisterResponse {
  userId: number
}

// 网易云API接口定义
interface NeteaseArtist {
  name: string
}

interface NeteaseAlbum {
  picUrl: string
}

interface NeteaseSong {
  id: number
  name: string
  artists: NeteaseArtist[]
  album: NeteaseAlbum
}

interface NeteaseSearchResult {
  songs?: NeteaseSong[]
}

interface NeteaseSearchResponse {
  result?: NeteaseSearchResult
}

export const apiService = new ApiService()
