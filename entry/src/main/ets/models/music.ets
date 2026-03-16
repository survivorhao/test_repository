export interface SongItemType {
  img: string
  name: string
  author: string
  url: string
  id:string
}
export interface SongUrl {
  url: string
}
export interface PlaylistSummary {
  id: string
  name: string
  cover_url: string
}
export interface PlaylistNavParams {
  id: string
  name: string
}
@ObservedV2
export class PlaylistNav {
  @Trace id: string = ''
  @Trace name: string = ''
}
