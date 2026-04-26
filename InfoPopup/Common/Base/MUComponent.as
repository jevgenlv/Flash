class Common.Base.MUComponent extends gfx.core.UIComponent
{
   var _name;
   var _visible;
   var btnClose;
   var btnDrag;
   var createEmptyMovieClip;
   var m_aHit;
   var m_bCurOver;
   var m_mcMovie;
   var m_strUID;
   var mcIcon;
   var mcLoader;
   var onMouseMove;
   var removeAllEventListeners;
   var startDrag;
   var stopDrag;
   var m_bVisibleState = false;
   var m_bTweenVisibleState = false;
   var m_iWidth = Stage.width;
   var m_iHeight = Stage.height;
   var m_iAlignType = Common.Global.MUDefines.Align_None;
   var m_iLastPosX = 0;
   var m_iLastPosY = 0;
   var m_iAddWidth = 0;
   var m_iAddHeight = 0;
   var TEXT_HTML_ALIGN_CENTER = 1;
   var TEXT_HTML_ALIGN_RIGHT = 2;
   var TEXT_HTML_BOLD = 4;
   var TWEENSTATE_VISIBLE_ON = 0;
   var TWEENSTATE_VISIBLE_ON_DONE = 1;
   var TWEENSTATE_VISIBLE_OFF = 2;
   var TWEENSTATE_VISIBLE_OFF_DONE = 3;
   var m_curTweenState = Common.Base.MUComponent.prototype.TWEENSTATE_VISIBLE_OFF_DONE;
   var m_iFromMoveY = 0;
   var m_iFromMoveX = 0;
   var m_fTweenUsedTime = 0;
   var m_fTweenLeftTime = 0;
   var m_fTweenSetTime = 0;
   var m_iFromAlpha = 0;
   var m_iFromXscale = 100;
   var m_iFromYscale = 100;
   var m_bTweenFadeIn = false;
   var m_bTweenFadeOut = false;
   var m_bIconLoaded = false;
   function MUComponent()
   {
      super();
      this.m_bCurOver = false;
      this._visible = true;
   }
   function SetAddDragSize(_iWidth, _iHeight)
   {
      this.m_iAddWidth = _iWidth;
      this.m_iAddHeight = _iHeight;
   }
   function GetWidth()
   {
      return this.m_mcMovie._width + this.m_iAddWidth;
   }
   function GetHeight()
   {
      return this.m_mcMovie._height + this.m_iAddHeight;
   }
   function GetWindowWidth()
   {
      return this.m_iWidth;
   }
   function GetWindowHeight()
   {
      return this.m_iHeight;
   }
   function SetScale(_fScale)
   {
      this.m_mcMovie._xscale = _fScale;
      this.m_mcMovie._yscale = _fScale;
   }
   function SetWindowSize(_iWidth, _iHeight)
   {
      var _loc4_ = _iWidth / this.m_iWidth;
      var _loc5_ = _iHeight / this.m_iHeight;
      this.m_iWidth = _iWidth;
      this.m_iHeight = _iHeight;
      this.SetAlign(this.m_iAlignType);
      var _loc3_;
      var _loc2_;
      switch(this.m_iAlignType)
      {
         case Common.Global.MUDefines.Align_None:
            _loc3_ = (this.m_mcMovie._x + this.GetWidth() / 2) * _loc4_ - this.GetWidth() / 2;
            _loc2_ = (this.m_mcMovie._y + this.GetHeight() / 2) * _loc5_ - this.GetHeight() / 2;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.SetPos(_loc3_,_loc2_);
            break;
         case Common.Global.MUDefines.Align_Left:
            _loc3_ = 0;
            _loc2_ = (this.m_mcMovie._y + this.GetHeight() / 2) * _loc5_ - this.GetHeight() / 2;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.SetPos(_loc3_,_loc2_);
            break;
         case Common.Global.MUDefines.Align_Right:
            _loc3_ = _iWidth - this.GetWidth();
            _loc2_ = (this.m_mcMovie._y + this.GetHeight() / 2) * _loc5_ - this.GetHeight() / 2;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.SetPos(_loc3_,_loc2_);
            break;
         case Common.Global.MUDefines.Align_Top:
            _loc3_ = (this.m_mcMovie._x + this.GetWidth() / 2) * _loc4_ - this.GetWidth() / 2;
            _loc2_ = 0;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.SetPos(_loc3_,_loc2_);
            break;
         case Common.Global.MUDefines.Align_Bottom:
            _loc3_ = (this.m_mcMovie._x + this.GetWidth() / 2) * _loc4_ - this.GetWidth() / 2;
            _loc2_ = _iHeight - this.GetHeight();
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.SetPos(_loc3_,_loc2_);
            break;
         case Common.Global.MUDefines.Align_Center:
            this.SetPosCenter();
            break;
         case Common.Global.MUDefines.Align_CenterTop:
            this.SetPosCenterTop();
            break;
         case Common.Global.MUDefines.Align_CenterBottom:
            this.SetPosCenterBottom();
            break;
         case Common.Global.MUDefines.Align_LeftCenter:
            this.SetPosLeftCenter();
            break;
         case Common.Global.MUDefines.Align_RightCenter:
            this.SetPosRightCenter();
            break;
         case Common.Global.MUDefines.Align_LeftTop:
            this.SetPosLeftTop();
            break;
         case Common.Global.MUDefines.Align_RightTop:
            this.SetPosRightTop();
            break;
         case Common.Global.MUDefines.Align_LeftBottom:
            this.SetPosLeftBottom();
            break;
         case Common.Global.MUDefines.Align_RightBottom:
            this.SetPosRightBottom();
            break;
         case Common.Global.MUDefines.Align_CenterX:
            this.SetPosCenterX();
            break;
         case Common.Global.MUDefines.Align_CenterY:
            this.SetPosCenterY();
         default:
            return;
      }
   }
   function SetAlign(_iAlign)
   {
      this.m_iAlignType = _iAlign;
   }
   function get TweenSetTime()
   {
      return this.m_fTweenSetTime;
   }
   function set TweenSetTime(_fTime)
   {
      this.m_fTweenSetTime = _fTime;
      flash.external.ExternalInterface.call("TweenTimeSet",this.m_fTweenSetTime);
   }
   function get FromMoveX()
   {
      return this.m_iFromMoveX;
   }
   function set FromMoveX(_iX)
   {
      this.m_iFromMoveX = _iX;
   }
   function get FromMoveY()
   {
      return this.m_iFromMoveY;
   }
   function set FromMoveY(_iY)
   {
      this.m_iFromMoveY = _iY;
   }
   function get FromAlpha()
   {
      return this.m_iFromAlpha;
   }
   function set FromAlpha(_iAlpha)
   {
      this.m_iFromAlpha = _iAlpha;
   }
   function get FromXscale()
   {
      return this.m_iFromXscale;
   }
   function set FromXscale(_iScale)
   {
      this.m_iFromXscale = _iScale;
   }
   function get FromYscale()
   {
      return this.m_iFromYscale;
   }
   function set FromYscale(_iScale)
   {
      this.m_iFromYscale = _iScale;
   }
   function get FadeIn()
   {
      return this.m_bTweenFadeIn;
   }
   function set FadeIn(_bFadeIn)
   {
      this.m_bTweenFadeIn = _bFadeIn;
   }
   function get FadeOut()
   {
      return this.m_bTweenFadeOut;
   }
   function set FadeOut(_bFadeOut)
   {
      this.m_bTweenFadeOut = _bFadeOut;
   }
   function appearAdvance()
   {
      this.onAppearAdvance();
   }
   function appearComplete()
   {
      this.onAppearComplete();
   }
   function leaveAdvance()
   {
      this.onLeaveAdvance();
   }
   function leaveComplete()
   {
      this.onLeaveComplete();
      flash.external.ExternalInterface.call("LeaveComplete",this.m_strUID);
   }
   function onAppearAdvance()
   {
   }
   function onAppearComplete()
   {
      flash.external.ExternalInterface.call("AppearComplete",this.m_strUID);
   }
   function onLeaveAdvance()
   {
   }
   function onLeaveComplete()
   {
   }
   function onAddEvent()
   {
   }
   function onRemoveEvent()
   {
   }
   function onLoadUI()
   {
   }
   function onInitGFx()
   {
   }
   function onUnloadUI()
   {
   }
   function onWndRollOver()
   {
   }
   function onWndRollOut()
   {
   }
   function onWndMouseMove()
   {
   }
   function onPressLButton()
   {
   }
   function onPressRButton()
   {
   }
   function onReleaseLButton()
   {
   }
   function onReleaseRButton()
   {
   }
   function set UID(strUID)
   {
      this.m_strUID = strUID;
   }
   function get UID()
   {
      return this.m_strUID;
   }
   function SetBtnDrag(_btnDrag)
   {
      this.btnDrag = _btnDrag;
   }
   function GetBtnDrag()
   {
      return this.btnDrag;
   }
   function SetBtnClose(_btnClose)
   {
      this.btnClose = _btnClose;
   }
   function GetBtnClose()
   {
      return this.btnClose;
   }
   function SetIconFile(strUrl)
   {
      this.mcIcon = this.createEmptyMovieClip("mcIcon",1);
      this.mcLoader = new MovieClipLoader();
      this.mcLoader.addListener(this);
      this.mcLoader.loadClip(strUrl,this.mcIcon);
   }
   function IsIconFileLoaded()
   {
      return this.m_bIconLoaded;
   }
   function GetIconMovieClip()
   {
      return this.mcIcon;
   }
   function GetIconBitmapData(strName)
   {
      return this.mcIcon.loadBitmapFromLib(strName);
   }
   function onLoad()
   {
      super.onLoad();
      this.m_mcMovie = this;
      this.m_aHit = [];
      gfx.motion.Tween.init();
      this.m_strUID = this._name;
      flash.external.ExternalInterface.call("UIInit",this.m_strUID);
      trace(this.m_strUID);
      this.onLoadUI();
      flash.external.ExternalInterface.call(Common.Global.MUDefines.EXTERNAL_WINDOWPOS,this.m_mcMovie._x,this.m_mcMovie._y);
   }
   function onUnload()
   {
      super.onUnload();
      delete this.m_aHit;
      this.removeAllEventListeners();
      if(this.btnClose != undefined)
      {
         this.btnClose.removeAllEventListeners();
      }
      if(this.btnDrag != undefined)
      {
         this.btnDrag.removeAllEventListeners();
      }
      if(this.mcIcon != undefined || this.m_bIconLoaded == true)
      {
         this.mcLoader.unloadClip(this.mcIcon);
         this.mcIcon.removeMovieClip();
         this.mcIcon = null;
         this.m_bIconLoaded = false;
      }
      this.onUnloadUI();
   }
   function onEnterFrame()
   {
      super.onEnterFrame();
      if(this.m_iLastPosX != this.m_mcMovie._x || this.m_iLastPosY != this.m_mcMovie._y)
      {
         this.m_iLastPosX = this.m_mcMovie._x;
         this.m_iLastPosY = this.m_mcMovie._y;
         flash.external.ExternalInterface.call(Common.Global.MUDefines.EXTERNAL_WINDOWPOS,this.m_mcMovie._x,this.m_mcMovie._y);
      }
   }
   function handleInput(details, pathToFocus)
   {
      if(!(details.code == 27 && Key.isDown(27)))
      {
         if(details.code == 32 || details.code == 37 || details.code == 39 || details.code == 38 || details.code == 40 || details.code == 35 || details.code == 36 || details.code == 33 || details.code == 34)
         {
            return true;
         }
      }
      return super.handleInput(details,pathToFocus);
   }
   function get VisibleAction()
   {
      return this.m_bVisibleState;
   }
   function set VisibleAction(_bVisible)
   {
      this.m_bVisibleState = _bVisible;
   }
   function SetVisible(_bVisible)
   {
      Selection.setFocus(null);
      this.SetVisibleAction(_bVisible);
   }
   function SetVisibleAction(_bVisible)
   {
      if(this.m_bVisibleState == _bVisible)
      {
         return undefined;
      }
      this.m_bVisibleState = _bVisible;
      if(this.m_bVisibleState == true)
      {
         this.Appear();
      }
      else
      {
         this.Leave();
      }
   }
   function Appear()
   {
      this.appearAdvance();
      this.m_curTweenState = this.TWEENSTATE_VISIBLE_ON;
      this.TweenActionSet(true);
   }
   function Leave()
   {
      this.leaveAdvance();
      this.removeEvent();
      this.m_curTweenState = this.TWEENSTATE_VISIBLE_OFF;
      this.TweenActionSet(false);
   }
   function addEvent()
   {
      this.onMouseMove = mx.utils.Delegate.create(this,this.wndMouseMove);
      if(this.btnClose != undefined)
      {
         this.btnClose.addEventListener("click",this,"onCloseBtnClick");
      }
      if(this.btnDrag != undefined)
      {
         this.btnDrag.addEventListener("press",this,"onDragStart");
         this.btnDrag.addEventListener("release",this,"onDragStop");
         this.btnDrag.addEventListener("releaseOutside",this,"onDragStop");
         this.btnDrag.addEventListener("stateChange",this,"onChangeState");
      }
      this.onAddEvent();
   }
   function removeEvent()
   {
      if(this.btnClose != undefined)
      {
         this.btnClose.removeAllEventListeners();
      }
      this.m_aHit.splice(0,this.m_aHit.length);
      this.onRemoveEvent();
   }
   function onCloseBtnClick()
   {
      if(this.btnClose == undefined)
      {
         return undefined;
      }
      flash.external.ExternalInterface.call("CloseWindow");
   }
   function onChangeState()
   {
      var _loc0_;
      if((_loc0_ = this.btnDrag.state) === "release")
      {
         this.onDragStop();
      }
   }
   function TweenActionSet(_bVisible)
   {
      if(this.m_bTweenVisibleState == _bVisible)
      {
         return undefined;
      }
      this.m_bTweenVisibleState = _bVisible;
      switch(this.m_curTweenState)
      {
         case this.TWEENSTATE_VISIBLE_ON:
            if(this.m_fTweenSetTime != 0)
            {
               this.m_mcMovie._alpha = 0;
               this.m_mcMovie.tweenTo(this.m_fTweenSetTime,{_alpha:100},mx.transitions.easing.Strong.easeIn);
               this.m_mcMovie.onTweenComplete = function()
               {
                  this.onTweenVisibleOnDone();
               };
            }
            else
            {
               this.onTweenVisibleOnDone();
            }
            if(this.m_bTweenVisibleState == false)
            {
               this.m_curTweenState = this.TWEENSTATE_VISIBLE_OFF;
            }
            break;
         case this.TWEENSTATE_VISIBLE_OFF:
            if(this.m_fTweenSetTime != 0)
            {
               this.m_mcMovie._alpha = 100;
               this.m_mcMovie.tweenTo(this.m_fTweenSetTime,{_alpha:0},mx.transitions.easing.Strong.easeIn);
               this.m_mcMovie.onTweenComplete = function()
               {
                  this.onTweenVisibleOffDone();
               };
            }
            else
            {
               this.onTweenVisibleOffDone();
            }
         case this.TWEENSTATE_VISIBLE_ON_DONE:
         case this.TWEENSTATE_VISIBLE_OFF_DONE:
         default:
            return;
      }
   }
   function onTweenVisibleOnDone(_this)
   {
      if(this.m_bTweenVisibleState == false)
      {
         return undefined;
      }
      if(this.m_curTweenState != this.TWEENSTATE_VISIBLE_ON)
      {
         return undefined;
      }
      this.m_curTweenState = this.TWEENSTATE_VISIBLE_ON_DONE;
      this.appearComplete();
      this.addEvent();
   }
   function onTweenVisibleOffDone(_this)
   {
      if(this.m_bTweenVisibleState == true)
      {
         return undefined;
      }
      if(this.m_curTweenState != this.TWEENSTATE_VISIBLE_OFF)
      {
         return undefined;
      }
      this.m_curTweenState = this.TWEENSTATE_VISIBLE_OFF_DONE;
      this.leaveComplete();
   }
   function HitAdd(mcMovie)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_aHit.length)
      {
         if(this.m_aHit[_loc2_] == mcMovie)
         {
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(mcMovie != undefined)
      {
         this.m_aHit.push(mcMovie);
      }
   }
   function HitDelete(mcMovie)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_aHit.length)
      {
         if(this.m_aHit[_loc2_] == mcMovie)
         {
            this.m_aHit.splice(_loc2_,1);
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function wndMouseMove()
   {
      var _loc5_ = false;
      var _loc4_ = 0;
      var _loc3_;
      while(_loc4_ < this.m_aHit.length)
      {
         _loc3_ = this.m_aHit[_loc4_];
         if(_loc3_ != undefined && _loc3_._visible && _loc3_.hitTest(_root._xmouse,_root._ymouse,false) == true)
         {
            _loc5_ = true;
            break;
         }
         _loc4_ = _loc4_ + 1;
      }
      if(_loc5_)
      {
         if(this.m_bCurOver == false)
         {
            this.m_bCurOver = true;
            flash.external.ExternalInterface.call("RollOver",this.m_strUID);
            this.onWndRollOver();
         }
      }
      else if(this.m_bCurOver == true)
      {
         this.m_bCurOver = false;
         flash.external.ExternalInterface.call("RollOut",this.m_strUID);
         this.onWndRollOut();
      }
      this.onWndMouseMove();
   }
   function HitCheck()
   {
      var _loc4_ = 0;
      var _loc3_;
      while(_loc4_ < this.m_aHit.length)
      {
         _loc3_ = this.m_aHit[_loc4_];
         if(_loc3_ != undefined && _loc3_._visible && _loc3_.hitTest(_root._xmouse,_root._ymouse,true) == true)
         {
            return true;
         }
         _loc4_ = _loc4_ + 1;
      }
      return false;
   }
   function onDragStart()
   {
      this.startDrag(false,0,0,this.m_iWidth - this.GetWidth(),this.m_iHeight - this.GetHeight());
   }
   function onDragStop()
   {
      this.stopDrag();
      flash.external.ExternalInterface.call(Common.Global.MUDefines.EXTERNAL_WINDOWPOS,this.m_mcMovie._x,this.m_mcMovie._y);
   }
   function onLoadError()
   {
      trace("[ ioError : " + this.m_strUID + " ]");
   }
   function onLoadComplete()
   {
      this.m_bIconLoaded = true;
   }
   function SetDragArea(_iSizeX, _iSizeY)
   {
      this.m_iWidth = _iSizeX;
      this.m_iHeight = _iSizeY;
   }
   function SetPos(_iPosX, _iPosY)
   {
      this.m_mcMovie._x = _iPosX;
      this.m_mcMovie._y = _iPosY;
      flash.external.ExternalInterface.call(Common.Global.MUDefines.EXTERNAL_WINDOWPOS,this.m_mcMovie._x,this.m_mcMovie._y);
   }
   function SetPosCenterTop()
   {
      var _loc2_ = this.GetWidth();
      var _loc3_ = this.GetHeight();
      this.SetPos((this.m_iWidth - _loc2_) / 2,0);
   }
   function SetPosCenter()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos((this.m_iWidth - _loc3_) / 2,(this.m_iHeight - _loc2_) / 2);
   }
   function SetPosCenterBottom()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos((this.m_iWidth - _loc3_) / 2,this.m_iHeight - _loc2_);
   }
   function SetPosLeftTop()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos(0,0);
   }
   function SetPosLeftCenter()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos(0,(this.m_iHeight - _loc2_) / 2);
   }
   function SetPosLeftBottom()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos(0,this.m_iHeight - _loc2_);
   }
   function SetPosRightTop()
   {
      var _loc2_ = this.GetWidth();
      var _loc3_ = this.GetHeight();
      this.SetPos(this.m_iWidth - _loc2_,0);
   }
   function SetPosRightCenter()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos(this.m_iWidth - _loc3_,(this.m_iHeight - _loc2_) / 2);
   }
   function SetPosRightBottom()
   {
      var _loc3_ = this.GetWidth();
      var _loc2_ = this.GetHeight();
      this.SetPos(this.m_iWidth - _loc3_,this.m_iHeight - _loc2_);
   }
   function SetPosCenterX()
   {
      var _loc2_ = this.GetWidth();
      this.SetPos((this.m_iWidth - _loc2_) / 2,this.m_mcMovie._y);
   }
   function SetPosCenterY()
   {
      var _loc2_ = this.GetHeight();
      this.SetPos(this.m_mcMovie._x,(this.m_iHeight - _loc2_) / 2);
   }
   function TextToHTMLOption(_strNotice, _dwOption)
   {
      var _loc2_ = "";
      if((_dwOption & this.TEXT_HTML_ALIGN_CENTER) == this.TEXT_HTML_ALIGN_CENTER)
      {
         _loc2_ += "<CENTER>";
      }
      else if((_dwOption & this.TEXT_HTML_ALIGN_RIGHT) == this.TEXT_HTML_ALIGN_RIGHT)
      {
         _loc2_ += "<RIGHT>";
      }
      if((_dwOption & this.TEXT_HTML_BOLD) == this.TEXT_HTML_BOLD)
      {
         _loc2_ += "<B>";
      }
      _loc2_ += _strNotice;
      if((_dwOption & this.TEXT_HTML_BOLD) == this.TEXT_HTML_BOLD)
      {
         _loc2_ += "</B>";
      }
      if((_dwOption & this.TEXT_HTML_ALIGN_CENTER) == this.TEXT_HTML_ALIGN_CENTER)
      {
         _loc2_ += "</CENTER>";
      }
      else if((_dwOption & this.TEXT_HTML_ALIGN_RIGHT) == this.TEXT_HTML_ALIGN_RIGHT)
      {
         _loc2_ += "</RIGHT>";
      }
      return _loc2_;
   }
   function TextToHTML(_strNotice, _strColor, _dwOption)
   {
      var _loc2_ = "";
      _loc2_ = "<FONT color=\"" + _strColor + "\">";
      _loc2_ += this.TextToHTMLOption(_strNotice,_dwOption);
      _loc2_ += "</FONT>";
      return _loc2_;
   }
   function TextToHTMLex(_strNotice, _dwColor, _dwOption)
   {
      var _loc2_ = "";
      _loc2_ = "<FONT color=\"#" + int(_dwColor).toString(16) + "\">";
      _loc2_ += this.TextToHTMLOption(_strNotice,_dwOption);
      _loc2_ += "</FONT>";
      return _loc2_;
   }
}
