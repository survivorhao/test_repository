import Song from "./Song";

export default class SongSearcResult{
  songs:Song[] = []
  hasMore:boolean = false
  songCount:number = 0

  constructor(songs: Song[], hasMore: boolean, songCount: number) {
    this.songs = songs;
    this.hasMore = hasMore;
    this.songCount = songCount;
  }

}