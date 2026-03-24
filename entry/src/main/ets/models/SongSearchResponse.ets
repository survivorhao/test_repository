import SongSearcResult from "./SongSearchResult";

export default  class SongSearchResponse{
  result:SongSearcResult|null = null
  code:number = 0

  constructor(result: SongSearcResult | null, code: number) {
    this.result = result;
    this.code = code;
  }

}