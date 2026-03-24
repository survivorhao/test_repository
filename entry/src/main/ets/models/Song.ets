import Album from "./Album"
import Artist from "./Artist"

export default class Song{
  id:number = 0
  name:string=''
  artists: Artist[] = []
  album: Album | null = null
  duration:number = 0
  copyrightId:number = 0
  status:number = 0
  alias:string[] = []
  rtype:number = 0
  ftype:number = 0
  mvid:number = 0
  fee:number = 0
  rUrl:string|null = null
  mark:number = 0
}