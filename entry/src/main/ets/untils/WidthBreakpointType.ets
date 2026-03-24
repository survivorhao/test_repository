
export class WidthBreakpointType<T>{
  xs:T
  sm:T
  md:T
  lg:T
  xl:T
  constructor(xs: T, sm: T, md: T, lg: T, xl: T) {
    this.xs = xs
    this.sm = sm
    this.md = md
    this.lg = lg
    this.xl = xl
  }
  getValue(widthBreakpoint:WidthBreakpoint):T{
    if(widthBreakpoint === WidthBreakpoint.WIDTH_XS){
      return this.xs
    }
    if(widthBreakpoint === WidthBreakpoint.WIDTH_SM){
      return this.sm
    }
    if(widthBreakpoint === WidthBreakpoint.WIDTH_MD){
      return this.md
    }
    if(widthBreakpoint === WidthBreakpoint.WIDTH_LG){
      return this.lg
    }
    if(widthBreakpoint === WidthBreakpoint.WIDTH_XL){
      return this.xl
    }
    return this.sm
  }
}