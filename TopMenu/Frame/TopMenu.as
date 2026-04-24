class Frame.TopMenu extends core.KeyMovieClip
{
   var _FreeChannelList;
   var _MenuType;
   var _SServerMenu;
   var _arrHelpTexts;
   var _helpText;
   var _keyName;
   var _mapNameOrigPosX;
   var _mapNameOrigWidth;
   var _subMenu;
   var _txtMapName;
   var _txtPosition;
   var _x;
   var _xscale;
   var _y;
   var _yscale;
   var intervalID;
   var intervalTickCount;
   var _helpTextIdx = 0;
   var bUseFreeChanelMove = false;
   var _origScaleX = 100;
   var _origScaleY = 100;
   function TopMenu()
   {
      super();
      this._MenuType = 0;
      this._keyName = "topmenu";
      this._txtMapName.textAutoSize = "shrink";
      this._txtPosition.textAutoSize = "shrink";
   }
   function devFunTest(devFunTest)
   {
      devFunTest.setUIName("상단 프레임");
      devFunTest.addFunInfo("useSubMenu",0);
      devFunTest.addFunInfo("useHelpText",true);
      devFunTest.addFunInfo("setMacroGauge",{lv:99,value:50,maxValue:100});
      devFunTest.addFunInfo("setPosition",{x:99,y:500});
      devFunTest.addFunInfo("setMapName","테스트 맵 이름");
      devFunTest.addFunInfo("setTooltipText",{member:"MacroRecord",text:"변경될 툴팁"});
      devFunTest.addFunInfo("InitTooltipText",{MacroStop:"MacroStop",MacroStart:"MacroStart",MacroRecord:"MacroRecord",MacroOption:"MacroOption",MacroGauge:"MacroGauge"});
   }
   function onLoad()
   {
      this.onResize();
      Stage.addListener(this);
      this._helpText.textField.textAutoSize = "shrink";
      this.useHelpText(false);
      this.useSubMenu(0);
      if(undefined != this._FreeChannelList)
      {
         this._FreeChannelList.Init();
         this.bUseFreeChanelMove = true;
      }
      this._mapNameOrigPosX = this._txtMapName._x;
      this._mapNameOrigWidth = this._txtMapName._width;
      if(this.bUseFreeChanelMove == true)
      {
         this.ableFreeChannelMove();
      }
      else
      {
         this.disableFreeChannelMove();
      }
   }
   function onResize()
   {
      var _loc2_;
      if(Stage.height < gStandard.ResizeStageHeight)
      {
         this._xscale = 83;
         this._yscale = 83;
         this._origScaleX = this._xscale;
         this._origScaleY = this._yscale;
         _loc2_ = (Stage.width - this._helpText._x * 0.83) / 0.83;
         this._helpText.setSize(_loc2_,this._helpText.height);
      }
      else
      {
         this._xscale = 100;
         this._yscale = 100;
         this._origScaleX = this._xscale;
         this._origScaleY = this._yscale;
         this._helpText.setSize(Stage.width - this._helpText._x - this._x,this._helpText.height);
      }
      this._x = 0;
      this._y = 0;
   }
   function SetSimpleUIMode(info)
   {
      if(info.bSimple)
      {
         this.OnChangeScale(info.rate);
         this._subMenu._visible = false;
         this._helpText._visible = false;
      }
      else
      {
         this.OnRestoreScale();
         this._subMenu._visible = true;
      }
   }
   function OnChangeScale(rate)
   {
      this._xscale = rate;
      this._yscale = rate;
   }
   function OnRestoreScale()
   {
      this._xscale = this._origScaleX;
      this._yscale = this._origScaleY;
   }
   function setPlayMacro(b)
   {
      this._subMenu.setPlayMacro(b);
   }
   function disabledAutomaticMacro(b)
   {
      this._subMenu._btAutomaticMacroStart.disabled = b;
   }
   function setPlayAutomaticMacro(b)
   {
      this._subMenu.setPlayAutomaticMacro(b);
   }
   function showEventMapMacro(info)
   {
      this._subMenu.showEventMapMacro(info);
   }
   function hideEventMapMacro()
   {
      this._subMenu.hideEventMapMacro();
   }
   function setPlayEventMapMacro(b)
   {
      this._subMenu.setPlayEventMapMacro(b);
   }
   function setTooltipText(info)
   {
      this._subMenu.setTooltipText(info);
   }
   function InitTooltipText(info)
   {
      this._subMenu.InitTooltipText(info);
   }
   function setMapName(mapName)
   {
      this._txtMapName.text = mapName;
   }
   function setPosition(info)
   {
      this._txtPosition.text = String(info.x + "," + info.y);
   }
   function setMacroGauge(info)
   {
      this._subMenu.setMacroGauge(info);
   }
   function setHelpText(arrTexts)
   {
      this._arrHelpTexts = arrTexts;
   }
   function useHelpText(b)
   {
      if(b == false)
      {
         if(this.intervalID != undefined)
         {
            clearInterval(this.intervalID);
         }
         this.intervalID = undefined;
         this._helpText._visible = false;
         return undefined;
      }
      if(this.intervalID == undefined)
      {
         this.intervalID = setInterval(this,"onTickHelpText",2000);
      }
      this.intervalTickCount = 0;
      this.onTickHelpText();
   }
   function disableFreeChannelMove()
   {
      this.bUseFreeChanelMove = false;
      if(this._FreeChannelList != undefined)
      {
         this._FreeChannelList._visible = false;
      }
      this._txtMapName._x = this._mapNameOrigPosX - 50;
      this._txtMapName._width = this._mapNameOrigWidth + 50;
   }
   function ableFreeChannelMove()
   {
      this.bUseFreeChanelMove = true;
      if(this._FreeChannelList != undefined)
      {
         this._FreeChannelList._visible = true;
      }
      this._txtMapName._x = this._mapNameOrigPosX;
      this._txtMapName._width = this._mapNameOrigWidth;
   }
   function getNextHelpText()
   {
      this._helpTextIdx = this._helpTextIdx + 1;
      if(this._arrHelpTexts == undefined)
      {
         if(gSystem.isClient == false)
         {
            return "<font color=\'#ff0000\'>undefined</font> <B>HELP</B> 길다란 글씨가 어케 나오는지 봅시다.  길다란 글씨가 어케 나오는지 봅시다. 길다란 글씨가 어케 나오는지 봅시다. Text " + this._helpTextIdx;
         }
         return "";
      }
      if(this._helpTextIdx >= this._arrHelpTexts.length)
      {
         this._helpTextIdx = 0;
      }
      return this._arrHelpTexts[this._helpTextIdx];
   }
   function onTickHelpText()
   {
      if(this._helpText.hitTest(_root._xmouse,_root._ymouse) == true)
      {
         return undefined;
      }
      var _loc3_;
      switch(this.intervalTickCount)
      {
         case 0:
            _loc3_ = this.getNextHelpText();
            if(_loc3_ == "" || _loc3_ == undefined || this._subMenu._visible == false)
            {
               return undefined;
            }
            this._helpText._visible = true;
            this._helpText._y = 0;
            this._helpText._alpha = 100;
            this._helpText.htmlText = _loc3_;
            break;
         case 3:
            caurina.transitions.Tweener.addTween(this._helpText,{time:0.5,transition:"linear",_alpha:0,_y:- this._helpText.height});
      }
      this.intervalTickCount = this.intervalTickCount + 1;
      if(this.intervalTickCount >= 15)
      {
         this.intervalTickCount = 0;
      }
   }
   function useSubMenu(n)
   {
      switch(Number(n))
      {
         case 0:
            this._subMenu._visible = true;
            this._SServerMenu._visible = false;
            this._helpText._x = 180;
            break;
         case 1:
            this._subMenu._visible = false;
            this._SServerMenu._visible = true;
            this._helpText._x = 180;
            break;
         case 2:
            this._subMenu._visible = false;
            this._SServerMenu._visible = false;
            this._helpText._x = 60;
      }
      this.onResize();
   }
   function OnMouseOverList(Info)
   {
      this.EventCall("MouseOverFreeChannelList",Info);
   }
   function OnMouseOutList()
   {
      this.EventCall("MouseOutFreeChannelList",{});
   }
   function OnClickList(SelectIndex)
   {
      this.EventCall("CLKFreeChannelList",SelectIndex);
      this.UpdateIsOpenChannelList();
   }
   function OnClickUpdateButton()
   {
      this.EventCall("CLKFreeChannelOpenBtn",{});
      this.UpdateIsOpenChannelList();
   }
   function ListOnClickUpdateButton()
   {
      this._FreeChannelList.OnClickUpdateButton();
   }
   function CallUpdateClient()
   {
      this.EventCall("CallUpdateClient",{});
   }
   function UpdateIsOpenChannelList()
   {
      var _loc2_ = new Object();
      _loc2_.IsOpenChannelList = this._FreeChannelList.list._visible;
      this.EventCall("IsOpenChannelList",_loc2_);
   }
}
