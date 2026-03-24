export default  class Artist{
  id:number = 0
  name:string =''
  picUrl:string =''
  alias:string[] = []
  albumSize:number = 0
  picId:number = 0
  fansGroup:string =''
  img1v1Url:string =''
  img1v1:number = 0
  trans:string =''

  //右键---Generate---Constructor---select all -- OK
  constructor(id: number, name: string, picUrl: string, alias: string[], albumSize: number, picId: number,
    fansGroup: string, img1v1Url: string, img1v1: number, trans: string) {
    this.id = id
    this.name = name
    this.picUrl = picUrl
    this.alias = alias
    this.albumSize = albumSize
    this.picId = picId
    this.fansGroup = fansGroup
    this.img1v1Url = img1v1Url
    this.img1v1 = img1v1
    this.trans = trans
  }

}