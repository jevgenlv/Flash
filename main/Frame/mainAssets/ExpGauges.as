class Frame.mainAssets.ExpGauges extends MovieClip
{
   var _4thExpbar;
   var _Expbar;
   var _FullText;
   var _MasterExpbar;
   var _TooltipData;
   var _TooltipText;
   var _data;
   var _titleText;
   var _tooltipHit;
   var tfCurrentEXP;
   var tfEXPLineNum;
   var tfEXPplusNum;
   var tfNeedEXP;
   function ExpGauges()
   {
      super();
   }
   function onLoad()
   {
      this._Expbar.hitTestDisable = true;
      this._MasterExpbar.hitTestDisable = true;
      this._4thExpbar.hitTestDisable = true;
      this._tooltipHit.addEventListener("rollOver",this,"onExpTooltip");
      this._tooltipHit.addEventListener("releaseOutside",this,"offExpTooltip");
      this._tooltipHit.addEventListener("rollOut",this,"offExpTooltip");
   }
   function InitExpText(info)
   {
      this._titleText = info.titleText;
   }
   function setExpTooltip(info)
   {
      if(this._TooltipData.rate != info.rate)
      {
         this.tfEXPplusNum.text = info.rate;
      }
      this._TooltipData = info;
   }
   function onExpTooltip(e)
   {
      if(this._TooltipText != this._TooltipData.text)
      {
         this._TooltipText = this._TooltipData.text;
         this._FullText = this._titleText + this._TooltipText;
      }
      var _loc2_ = util.localToGlobal(e.comp);
      _loc2_.x += Math.floor(e.comp._width / 2);
      flash.external.ExternalInterface.call("main","onExpTooltip",{text:this._FullText,x:_loc2_.x,y:_loc2_.y});
   }
   function offExpTooltip(e)
   {
      flash.external.ExternalInterface.call("main","offExpTooltip",{});
   }
   function setExpData(info)
   {
      if(this._data.ClassLevel != info.ClassLevel)
      {
         this._Expbar._visible = false;
         this._MasterExpbar._visible = false;
         this._4thExpbar._visible = false;
         switch(info.ClassLevel)
         {
            case 4:
               this._4thExpbar._visible = true;
               break;
            case 3:
               this._MasterExpbar._visible = true;
               break;
            default:
               this._Expbar._visible = true;
         }
      }
      switch(info.ClassLevel)
      {
         case 4:
            this._4thExpbar.setData(Number(info.rate));
            break;
         case 3:
            this._MasterExpbar.setData(Number(info.rate));
            break;
         default:
            this._Expbar.setData(Number(info.rate));
      }
      if(this._data.curExp != info.curExp)
      {
         this.tfCurrentEXP.text = info.curExp;
      }
      if(this._data.maxExp != info.maxExp)
      {
         this.tfNeedEXP.text = info.maxExp;
      }
      if(this._data.page != info.page)
      {
         this.tfEXPLineNum.text = String(info.page);
      }
      this._data = info;
   }
}
