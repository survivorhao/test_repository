import Artist from "./Artist"

export default class Album{
  id:number = 0
  name:string=''
  artist:Artist
  publishTime:number = 0
  size:number = 0
  copyrightId:number = 0
  status:number = 0
  picId:number = 0
  alia:string[]=[]
  mark:number = 0

  constructor(id: number, name: string, artist: Artist, publishTime: number, size: number, copyrightId: number,
    status: number, picId: number, alia: string[], mark: number) {
    this.id = id
    this.name = name
    this.artist = artist
    this.publishTime = publishTime
    this.size = size
    this.copyrightId = copyrightId
    this.status = status
    this.picId = picId
    this.alia = alia
    this.mark = mark
  }

}