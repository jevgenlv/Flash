class Frame.TopMenuMC.SubTopMenu extends MovieClip
{
   var _EventMapText;
   var _GaugeLv;
   var _MacroGauge;
   var _TooltipInfo;
   var _btAutomaticMacroStart;
   var _btAutomaticMacroStop;
   var _btEmptyButton;
   var _btEventMapMacroStart;
   var _btEventMapMacroStop;
   var _btMacroOption;
   var _btMacroRecord;
   var _btMacroStart;
   var _btMacroStop;
   var _isEventMapMacro;
   var _isPlayAutomaticMacro;
   var _isPlayMacro;
   var _isVisibleEventMapMacro;
   function SubTopMenu()
   {
      super();
      this._isPlayMacro = false;
      this._isPlayAutomaticMacro = false;
      this._isEventMapMacro = false;
      this._isVisibleEventMapMacro = false;
   }
   function onLoad()
   {
      this._btMacroStop.data = "MacroStop";
      this._btMacroStart.data = "MacroStart";
      this._btAutomaticMacroStop.data = "AutomaticMacroStop";
      this._btAutomaticMacroStart.data = "AutomaticMacroStart";
      this._btMacroRecord.data = "MacroRecord";
      this._btMacroOption.data = "MacroOption";
      this._btEmptyButton.data = "MacroGauge";
      this._btEventMapMacroStop.data = "EventMapMacroStop";
      this._btEventMapMacroStart.data = "EventMapMacroStart";
      this._btMacroStop.addEventListener("click",this,"onMacroMenu");
      this._btMacroStart.addEventListener("click",this,"onMacroMenu");
      this._btAutomaticMacroStop.addEventListener("click",this,"onMacroMenu");
      this._btAutomaticMacroStart.addEventListener("click",this,"onMacroMenu");
      this._btMacroRecord.addEventListener("click",this,"onMacroMenu");
      this._btMacroOption.addEventListener("click",this,"onMacroMenu");
      this._btEventMapMacroStop.addEventListener("click",this,"onMacroMenu");
      this._btEventMapMacroStart.addEventListener("click",this,"onMacroMenu");
      this._btMacroStop.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btMacroStart.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btAutomaticMacroStop.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btAutomaticMacroStart.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btMacroRecord.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btMacroOption.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btEmptyButton.addEventListener("rollOver",this,"onTooltipMacroGauge");
      this._btEventMapMacroStop.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this._btEventMapMacroStart.addEventListener("rollOver",this,"onTooltipMacroMenu");
      this.setPlayMacro(false);
      this.setPlayAutomaticMacro(false);
      this.hideEventMapMacro();
   }
   function InitTooltipText(info)
   {
      this._TooltipInfo = info;
      this._TooltipInfo.EventMapMacroStop = "undefined";
      this._TooltipInfo.EventMapMacroStart = "undefined";
   }
   function setPlayMacro(b)
   {
      this._isPlayMacro = b;
      this._btMacroStop._visible = this._isPlayMacro;
      this._btMacroStart._visible = !this._isPlayMacro;
   }
   function setPlayAutomaticMacro(b)
   {
      this._isPlayAutomaticMacro = b;
      this._btAutomaticMacroStop._visible = this._isPlayAutomaticMacro;
      this._btAutomaticMacroStart._visible = !this._isPlayAutomaticMacro;
   }
   function setTooltipText(info)
   {
      if(info.text == undefined)
      {
         return undefined;
      }
      gSystem.Tooltip.SetText(info.text,this._btEmptyButton,"RB");
   }
   function onTooltipMacroGauge(e)
   {
      if(e.comp.data == undefined)
      {
         trace("onTooltipMacroGauge Click Data undefined");
         return undefined;
      }
      flash.external.ExternalInterface.call("topmenu","OverMacroGauge",true);
   }
   function onTooltipMacroMenu(e)
   {
      if(e.comp.data == undefined)
      {
         trace("onTooltipMacroMenu Click Data undefined");
         return undefined;
      }
      var _loc3_ = this._TooltipInfo[e.comp.data];
      gSystem.Tooltip.SetText(_loc3_,e.comp,"RB");
   }
   function onMacroMenu(e)
   {
      if(e.comp.data == undefined)
      {
         trace("onMacroMenu Click Data undefined");
         return undefined;
      }
      var _loc1_ = String(e.comp.data);
      flash.external.ExternalInterface.call("topmenu","MacroMenu",_loc1_);
   }
   function setMacroGauge(info)
   {
      this._GaugeLv.text = info.lv;
      this._MacroGauge.setValue(info.value,info.maxValue);
   }
   function showEventMapMacro(info)
   {
      this._EventMapText.htmlText = info.Text;
      this._TooltipInfo.EventMapMacroStart = info.TooltipText;
      this._TooltipInfo.EventMapMacroStop = info.TooltipText;
      this._isVisibleEventMapMacro = true;
      this._btEventMapMacroStop.visible = this._isVisibleEventMapMacro;
      this._btEventMapMacroStop.disabled = true;
      this._btEventMapMacroStart.visible = this._isVisibleEventMapMacro;
      this._btEventMapMacroStart.disabled = true;
      this._EventMapText.visible = this._isVisibleEventMapMacro;
      this._btMacroStop.disabled = true;
      this._btMacroStart.disabled = true;
   }
   function hideEventMapMacro()
   {
      this._isVisibleEventMapMacro = false;
      this._btEventMapMacroStop.visible = this._isVisibleEventMapMacro;
      this._btEventMapMacroStop.disabled = true;
      this._btEventMapMacroStart.visible = this._isVisibleEventMapMacro;
      this._btEventMapMacroStart.disabled = true;
      this._EventMapText.visible = this._isVisibleEventMapMacro;
      this._btMacroStop.disabled = false;
      this._btMacroStart.disabled = false;
   }
   function setPlayEventMapMacro(b)
   {
      if(!this._isVisibleEventMapMacro)
      {
         return undefined;
      }
      this._isEventMapMacro = b;
      this._btEventMapMacroStop.visible = this._isEventMapMacro;
      this._btEventMapMacroStart.visible = !this._isEventMapMacro;
      this._btEventMapMacroStop.disabled = false;
      this._btEventMapMacroStart.disabled = false;
      this._btMacroStop.disabled = true;
      this._btMacroStart.disabled = true;
   }
   function onEnterFrame()
   {
      if(this._btAutomaticMacroStart.disabled == true && this._btAutomaticMacroStart.hitTest(_root._xmouse,_root._ymouse,false) == true)
      {
         gSystem.Tooltip.SetText(this._TooltipInfo.DisabledAutomaticMacroStart,this._btAutomaticMacroStart,"RB");
      }
   }
}
