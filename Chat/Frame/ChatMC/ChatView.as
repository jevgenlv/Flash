class Frame.ChatMC.ChatView extends gfx.core.UIComponent
{
   var _arrChats;
   var _arrSizeData;
   var _arrViewChats;
   var _bg;
   var _btScrollDown;
   var _btTitle;
   var _height;
   var _sb;
   var _startHeight;
   var _textTable;
   var _textView;
   var _viewHeightMargin;
   var _y;
   static var ChatTypeNormal = 1;
   static var ChatTypeWhisper = 2;
   static var ChatTypeSystem = 3;
   static var ChatTypeError = 4;
   static var ChatTypeParty = 5;
   static var ChatTypeGuild = 6;
   static var ChatTypeUnion = 7;
   static var ChatTypeGM = 8;
   static var ChatTypeGens = 9;
   static var ChatTypeExitCount = 100;
   static var ChatTypeHtml = 101;
   static var ChatTypeLowSystem = 102;
   static var ChatTypeLowError = 103;
   var _sizeIndex = 0;
   var _boxAlpha = 60;
   var _isEditText = false;
   var ViewModeNormal = 0;
   var ViewModeFilter = 1;
   var ViewModeFilterNonBack = 2;
   var ViewModeNonBack = 3;
   var _viewMode = 0;
   var _filterSystem = false;
   var _filterWhisper = false;
   var _filterNormal = false;
   var _filterParty = false;
   var _filterGuild = false;
   var _filterGens = false;
   var _IsMouseInViewBox = false;
   var _changeSize = false;
   function ChatView()
   {
      super();
   }
   function testChatType()
   {
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeNormal,name:"tester",msg:"테스트문자열 ChatTypeNormal"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeWhisper,name:"tester",msg:"테스트문자열 ChatTypeWhisper"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeSystem,name:"tester",msg:"테스트문자열 ChatTypeSystem"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeError,name:"tester",msg:"테스트문자열 ChatTypeError"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeParty,name:"tester",msg:"테스트문자열 ChatTypeParty"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeGuild,name:"tester",msg:"테스트문자열 ChatTypeGuild"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeUnion,name:"tester",msg:"테스트문자열 ChatTypeUnion"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeGM,name:"tester",msg:"테스트문자열 ChatTypeGM"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeGens,name:"tester",msg:"테스트문자열 ChatTypeGens"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeExitCount,name:"tester",msg:"테스트문자열 ChatTypeExitCount"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeHtml,name:"Count",msg:"테스트문자열 ChatTypeHtml"});
      this.AddChatInfo({type:Frame.ChatMC.ChatView.ChatTypeNormal,name:"longchat",msg:"아주아주아주아주아주아주아주아주아주아주아주아주아주아주아주아주아주아주긴채팅글"});
   }
   function configUI()
   {
      this._startHeight = this._height;
      this._viewHeightMargin = this._startHeight - this._textView._height;
      this._viewMode = this.ViewModeNormal;
      this._arrSizeData = new Array();
      this._arrViewChats = new Array();
      this._arrSizeData.push(91);
      this._arrSizeData.push(192);
      this._arrSizeData.push(308);
      this._arrSizeData.push(427);
      this._btTitle.addEventListener("click",this,"onChangeSize");
      this._sb.addEventListener("scroll",this,"updateScrollPosition");
      this._btScrollDown.addEventListener("click",this,"onScrollDown");
      this._textView.addEventListener("itemClick",this,"onViewClick");
      this._arrChats = new Array();
      Mouse.addListener(this);
      this.updateBoxAlpha();
      this.updateScrollPosition();
      if(gSystem.isClient == false)
      {
         this.testChatType();
      }
   }
   function onViewClick(e)
   {
      trace("View Click : " + e.item);
      if(e.item.name == undefined)
      {
         return undefined;
      }
      flash.external.ExternalInterface.call("chat","checkWhisper",{name:e.item.name});
   }
   function InitTextTable(info)
   {
      this._textTable = info;
   }
   function SetEditText(b)
   {
      this._isEditText = b;
      this._sb._visible = this._isEditText;
      if(this._bg._visible == true)
      {
         this._btTitle._visible = this._isEditText;
      }
      else
      {
         this._btTitle._visible = false;
      }
      this._IsMouseInViewBox = false;
      if(_root.onStreaming == false)
      {
         this._bg.hitTestDisable = !b;
      }
      this._textView.hitTestDisable = !b;
   }
   function onMouseMove()
   {
      if(this._isEditText == true)
      {
         return undefined;
      }
      if(Mouse.getTopMostEntity() != undefined)
      {
         this._textView.CheckMouseOut();
         return undefined;
      }
      var _loc3_ = this._bg.hitTest(_root._xmouse,_root._ymouse);
      if(this._IsMouseInViewBox != _loc3_)
      {
         this._IsMouseInViewBox = _loc3_;
         flash.external.ExternalInterface.call("chat","InMouseViewBox",{hit:this._IsMouseInViewBox});
         this._textView.CheckMouseOver();
         return undefined;
      }
      if(_loc3_ == false)
      {
         return undefined;
      }
      this._textView.CheckMouseOver();
   }
   function onMouseWheel(delta, targetPath)
   {
      if(this._isEditText == true)
      {
         return undefined;
      }
      if(Mouse.getTopMostEntity() != undefined)
      {
         return undefined;
      }
      var _loc3_ = this._bg.hitTest(_root._xmouse,_root._ymouse);
      if(_loc3_ == false)
      {
         return undefined;
      }
      this._textView.setScrollWellDelta(delta);
      this.updateScrollPosition();
   }
   function onScrollDown(e)
   {
      this._textView.scrollPosition = this._arrViewChats.length;
      this.updateScrollPosition();
   }
   function onViewOption(e)
   {
      switch(e.data)
      {
         case "viewMode":
            this.onChangeViewMode();
            return;
         case "alpha":
            this.onChangeAlpha();
            return;
         case "resize":
            this.onChangeSize();
            return;
         default:
            return;
      }
   }
   function SetFilter(info)
   {
      switch(String(info.name))
      {
         case "system":
            this._filterSystem = Boolean(info.enable);
            break;
         case "whisper":
            this._filterWhisper = Boolean(info.enable);
            break;
         case "normal":
            this._filterNormal = Boolean(info.enable);
            break;
         case "party":
            this._filterParty = Boolean(info.enable);
            break;
         case "guild":
            this._filterGuild = Boolean(info.enable);
            break;
         case "gens":
            this._filterGens = Boolean(info.enable);
      }
      this.updateViewTexts();
   }
   function updateViewTexts()
   {
      trace("전체 채팅창 갱신");
      trace("system : " + this._filterSystem);
      trace("whisper : " + this._filterWhisper);
      trace("normal : " + this._filterNormal);
      trace("party : " + this._filterParty);
      trace("guild : " + this._filterGuild);
      trace("gens : " + this._filterGens);
      this._arrViewChats.splice(0);
      var _loc3_ = this._arrChats.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this.IsViewChatInfo(this._arrChats[_loc2_]) == true)
         {
            this._arrViewChats.push(this._arrChats[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      this._textView.dataProvider = this._arrViewChats;
      this._textView.invalidate();
      this._textView.scrollPosition = this._arrViewChats.length;
      this.updateScrollPosition();
   }
   function onChangeViewMode()
   {
      this._viewMode = this._viewMode + 1;
      if(this._viewMode > this.ViewModeNonBack)
      {
         this._viewMode = this.ViewModeNormal;
      }
      this.updateViewMode();
   }
   function updateViewMode()
   {
      this._bg._visible = this._viewMode == this.ViewModeNormal || this._viewMode == this.ViewModeFilter;
      if(this._bg._visible == true)
      {
         this._btTitle._visible = !this._isEditText;
      }
      else
      {
         this._btTitle._visible = false;
      }
      this.updateViewTexts();
   }
   function IsViewChatInfo(info)
   {
      switch(Number(info.type))
      {
         case Frame.ChatMC.ChatView.ChatTypeWhisper:
            return !this._filterWhisper;
         case Frame.ChatMC.ChatView.ChatTypeSystem:
         case Frame.ChatMC.ChatView.ChatTypeError:
         case Frame.ChatMC.ChatView.ChatTypeExitCount:
         case Frame.ChatMC.ChatView.ChatTypeLowSystem:
         case Frame.ChatMC.ChatView.ChatTypeLowError:
            return !this._filterSystem;
         case Frame.ChatMC.ChatView.ChatTypeUnion:
         case Frame.ChatMC.ChatView.ChatTypeGM:
         case Frame.ChatMC.ChatView.ChatTypeHtml:
            return this._viewMode == this.ViewModeNormal || this._viewMode == this.ViewModeNonBack;
         case Frame.ChatMC.ChatView.ChatTypeNormal:
            return (this._viewMode == this.ViewModeNormal || this._viewMode == this.ViewModeNonBack) && !this._filterNormal;
         case Frame.ChatMC.ChatView.ChatTypeParty:
            return (this._viewMode == this.ViewModeNormal || this._viewMode == this.ViewModeNonBack) && !this._filterParty;
         case Frame.ChatMC.ChatView.ChatTypeGuild:
            return (this._viewMode == this.ViewModeNormal || this._viewMode == this.ViewModeNonBack) && !this._filterGuild;
         case Frame.ChatMC.ChatView.ChatTypeGens:
            return (this._viewMode == this.ViewModeNormal || this._viewMode == this.ViewModeNonBack) && !this._filterGens;
         default:
            return true;
      }
   }
   function onEventCallOption()
   {
      flash.external.ExternalInterface.call("chat","Option",{boxSize:this._sizeIndex,boxAlpha:this._bg._alpha});
   }
   function onChangeAlpha()
   {
      this._boxAlpha += 20;
      if(this._boxAlpha > 90)
      {
         this._boxAlpha = 20;
      }
      this.updateBoxAlpha();
      this.onEventCallOption();
   }
   function updateBoxAlpha()
   {
      this._btTitle._alpha = this._boxAlpha;
      this._bg._alpha = this._boxAlpha;
   }
   function SetUIOption(info)
   {
      this._boxAlpha = info.boxAlpha;
      if(this._boxAlpha > 90)
      {
         this._boxAlpha = 80;
      }
      else if(this._boxAlpha < 20)
      {
         this._boxAlpha = 20;
      }
      this._sizeIndex = info.boxSize;
      if(this._sizeIndex < 0)
      {
         this._sizeIndex = 0;
      }
      else if(this._sizeIndex >= this._arrSizeData.length)
      {
         this._sizeIndex = 0;
      }
      this.updateBoxAlpha();
      this.updateBoxSize();
   }
   function onChangeSize(e)
   {
      if(this._changeSize == true)
      {
         return undefined;
      }
      this._changeSize = true;
      this._sizeIndex = this._sizeIndex + 1;
      if(this._sizeIndex >= this._arrSizeData.length)
      {
         this._sizeIndex = 0;
      }
      this.updateBoxSize();
      this.onEventCallOption();
   }
   function updateBoxSize()
   {
      var _loc2_ = this._arrSizeData[this._sizeIndex];
      this._sb.height = _loc2_ - this._viewHeightMargin - 6;
      this._textView.height = _loc2_ - this._viewHeightMargin;
      this._sb.validateNow();
      this._textView.validateNow();
      this._y = - (_loc2_ - this._startHeight);
      this._bg._height = _loc2_ - this._bg._y;
      this._btScrollDown._y = this._bg._y + this._bg._height - 36;
      this.invalidate();
   }
   function draw()
   {
      if(!this.initialized)
      {
         return undefined;
      }
      this._changeSize = false;
      this._textView.scrollPosition = this._arrViewChats.length;
      this._textView.validateNow();
      this.updateScrollPosition();
   }
   function ClearAllChatHistory()
   {
      this._arrChats.splice(0);
      this._arrViewChats.splice(0);
      this._textView.dataProvider = this._arrViewChats;
      this._textView.invalidate();
   }
   function AddChatInfo(obj)
   {
      if(this._arrChats.length > 200)
      {
         this._arrChats.splice(0,1);
      }
      obj.label = this.getChatTextFormat(obj);
      this._arrChats.push(obj);
      if(this.IsViewChatInfo(obj) == true)
      {
         this._arrViewChats.push(obj);
         this._textView.dataProvider = this._arrViewChats;
         this._textView.invalidate();
         if(this._btScrollDown._visible == false || this.isScrollDownType(obj) == true)
         {
            this._textView.scrollPosition = this._arrViewChats.length;
         }
         this.updateScrollPosition();
      }
   }
   function updateScrollPosition()
   {
      if(this._textView.scrollPosition < this._textView.scrollPositionMax)
      {
         this._btScrollDown._visible = true;
      }
      else
      {
         this._btScrollDown._visible = false;
      }
   }
   function isScrollDownType(info)
   {
      switch(info.type)
      {
         case Frame.ChatMC.ChatView.ChatTypeSystem:
         case Frame.ChatMC.ChatView.ChatTypeError:
         case Frame.ChatMC.ChatView.ChatTypeExitCount:
            return true;
         default:
            return false;
      }
   }
   function getChatTextFormat(info)
   {
      var _loc3_;
      switch(info.type)
      {
         case Frame.ChatMC.ChatView.ChatTypeWhisper:
            _loc3_ = "[" + this._textTable.typeFormatWHISPER + "]";
            break;
         case Frame.ChatMC.ChatView.ChatTypeParty:
            _loc3_ = "[" + this._textTable.typeFormatPARTY + "]";
            break;
         case Frame.ChatMC.ChatView.ChatTypeGuild:
            _loc3_ = "[" + this._textTable.typeFormatGUILD + "]";
            break;
         case Frame.ChatMC.ChatView.ChatTypeUnion:
            _loc3_ = "[" + this._textTable.typeFormatUNION + "]";
            break;
         case Frame.ChatMC.ChatView.ChatTypeGens:
            _loc3_ = "[" + this._textTable.typeFormatGENS + "]";
            break;
         case Frame.ChatMC.ChatView.ChatTypeNormal:
         case Frame.ChatMC.ChatView.ChatTypeSystem:
         case Frame.ChatMC.ChatView.ChatTypeError:
         case Frame.ChatMC.ChatView.ChatTypeGM:
         case Frame.ChatMC.ChatView.ChatTypeExitCount:
         case Frame.ChatMC.ChatView.ChatTypeLowSystem:
         case Frame.ChatMC.ChatView.ChatTypeLowError:
         case Frame.ChatMC.ChatView.ChatTypeHtml:
            return info.msg;
      }
      var _loc2_ = "";
      if(_loc3_ != undefined)
      {
         _loc2_ += _loc3_;
      }
      if(info.name != undefined)
      {
         _loc2_ += info.name + " :";
      }
      _loc2_ += info.msg;
      _loc2_ = _loc2_.split("<").join("&lt;");
      _loc2_ = _loc2_.split(">").join("&gt;");
      return "<font size=\'13\' color=\'" + this.getTypeColor(info.type) + "\'>" + _loc2_ + "</font><br>";
   }
   function getTypeColor(type)
   {
      var _loc1_ = "#FFFFFF";
      switch(type)
      {
         case Frame.ChatMC.ChatView.ChatTypeNormal:
            return "#CDCAEF";
         case Frame.ChatMC.ChatView.ChatTypeWhisper:
            return "#FFB7DB";
         case Frame.ChatMC.ChatView.ChatTypeLowSystem:
         case Frame.ChatMC.ChatView.ChatTypeSystem:
            return "#6496FF";
         case Frame.ChatMC.ChatView.ChatTypeLowError:
         case Frame.ChatMC.ChatView.ChatTypeError:
            return "#FF1E00";
         case Frame.ChatMC.ChatView.ChatTypeParty:
            return "#66CCFF";
         case Frame.ChatMC.ChatView.ChatTypeGuild:
            return "#FFCC99";
         case Frame.ChatMC.ChatView.ChatTypeUnion:
            return "#C8C800";
         case Frame.ChatMC.ChatView.ChatTypeGM:
            return "#FAC832";
         case Frame.ChatMC.ChatView.ChatTypeGens:
            return "#AFF47C";
         case Frame.ChatMC.ChatView.ChatTypeExitCount:
            return "#FF1E00";
         default:
            return _loc1_;
      }
   }
}
