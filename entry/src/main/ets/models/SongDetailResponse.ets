import Artist from "./Artist"

export class SongDetailResponse{
    songs:SongDetail[] = []
    equalizers:Equalizers = new Equalizers()
    code:number = 0
}

export class SongDetail{
    name: string = ''
    id: number = 0
    status:number = 0
    duration:number = 0
    fee: number = 0
    mvid:number = 0
    artists:Artist[] = []
    album:AlbumDetail|undefined
}

export class Equalizers{

}

export default class AlbumDetail{
    id:number = 0
    name:string=''
    picId:number = 0
    blurPicUrl:string = ''
}