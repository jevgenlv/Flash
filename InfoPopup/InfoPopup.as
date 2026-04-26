class InfoPopup extends Common.Base.MUComponent
{
   var GetWindowHeight;
   var GetWindowWidth;
   var SetPos;
   var devText;
   var m_iBuffTime;
   var m_iStarTime;
   var m_mcMovie;
   var m_strD;
   var m_strH;
   var m_strHead;
   var m_strLessThanM;
   var m_strM;
   var mcBg;
   var mcBg2;
   var mcBg2Ex;
   var mcBg2Ex2;
   var mcBg2Ex3;
   var mcBgEx;
   var mcBgEx2;
   var mcBgEx3;
   var mcInfoPopup;
   var mcInfoPopupEx;
   var mcInfoPopupEx2;
   var mcInfoPopupEx3;
   var mcTooltip1;
   var mcTooltip2;
   var taInfo;
   var taInfoEx;
   var taInfoEx2;
   var taInfoEx3;
   var tfHotkey1;
   var tfHotkey2;
   var tfInfo1;
   var tfInfo2;
   var m_iBuffTimerID = 0;
   var INFO_BACKGROUND_INTERVAL = 10;
   var m_bSetEquippedItemInfo = false;
   var m_bCompareItemSetOption = false;
   function InfoPopup()
   {
      super();
   }
   function onLoadUI()
   {
      super.onLoadUI();
      this.mcInfoPopup = this.m_mcMovie.mcInfoPopup;
      this.mcBg = this.mcInfoPopup.mcBg;
      this.mcBg2 = this.mcInfoPopup.mcBg2;
      this.taInfo = this.mcInfoPopup.taInfo;
      this.taInfo.textField.autoSize = "left";
      this.taInfo.textField.wordWrap = false;
      this.mcInfoPopupEx = this.m_mcMovie.mcInfoPopupEx;
      this.mcBgEx = this.mcInfoPopupEx.mcBg;
      this.mcBg2Ex = this.mcInfoPopupEx.mcBg2;
      this.taInfoEx = this.mcInfoPopupEx.taInfo;
      this.taInfoEx.textField.autoSize = "left";
      this.taInfoEx.textField.wordWrap = false;
      this.mcInfoPopupEx2 = this.m_mcMovie.mcInfoPopupEx2;
      this.mcBgEx2 = this.mcInfoPopupEx2.mcBg;
      this.mcBg2Ex2 = this.mcInfoPopupEx2.mcBg2;
      this.taInfoEx2 = this.mcInfoPopupEx2.taInfo;
      this.taInfoEx2.textField.autoSize = "left";
      this.taInfoEx2.textField.wordWrap = false;
      this.mcInfoPopupEx3 = this.m_mcMovie.mcInfoPopupEx3;
      this.mcBgEx3 = this.mcInfoPopupEx3.mcBg;
      this.mcBg2Ex3 = this.mcInfoPopupEx3.mcBg2;
      this.taInfoEx3 = this.mcInfoPopupEx3.taInfo;
      this.taInfoEx3.textField.autoSize = "left";
      this.taInfoEx3.textField.wordWrap = false;
      this.mcTooltip1 = this.m_mcMovie.mcTooltip1;
      this.tfHotkey1 = this.mcTooltip1.tfHotkey1;
      this.tfInfo1 = this.mcTooltip1.tfInfo1;
      this.mcTooltip2 = this.m_mcMovie.mcTooltip2;
      this.tfHotkey2 = this.mcTooltip2.tfHotkey2;
      this.tfInfo2 = this.mcTooltip2.tfInfo2;
      this.SetInfoPopupClose();
   }
   function onUnLoadUI()
   {
      super.onUnloadUI();
   }
   function SetInfoPopup(_fX, _fY, _fWidth, _fHeight, _strText)
   {
      this.mcInfoPopup._visible = true;
      this.mcInfoPopupEx._visible = false;
      this.mcInfoPopupEx2._visible = false;
      this.mcInfoPopupEx3._visible = false;
      this.mcTooltip1._visible = false;
      this.mcTooltip2._visible = false;
      this.ClearInfoPopupBuffTime();
      this.taInfo.htmlText = _strText;
      var _loc4_ = Math.ceil(this.taInfo._width);
      var _loc7_ = Math.ceil(this.taInfo._height);
      this.taInfo._width = _loc4_;
      this.taInfo._height = _loc7_;
      this.taInfo.width = _loc4_;
      this.taInfo.height = _loc7_;
      this.mcInfoPopup.tfTime._width = _loc4_;
      this.mcInfoPopup.tfTime.width = _loc4_;
      this.mcBg._width = this.taInfo._width + 6;
      this.mcBg._height = this.taInfo._height + 8;
      this.mcBg2._width = this.taInfo._width + 6;
      this.mcBg2._height = this.taInfo._height + 8;
      var _loc6_ = this.mcInfoPopup._width;
      var _loc5_ = this.mcInfoPopup._height;
      var _loc3_ = _fX + _fWidth / 2;
      var _loc2_ = _fY + _fHeight / 2;
      _loc3_ -= _loc6_ / 2;
      if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      else if(_loc3_ + _loc6_ > this.GetWindowWidth())
      {
         _loc3_ = this.GetWindowWidth() - _loc6_;
      }
      if(_loc2_ > this.GetWindowHeight() / 2)
      {
         _loc2_ = _fY - _loc5_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
      }
      else
      {
         _loc2_ = _fY + _fHeight;
         if(_loc2_ + _loc5_ > this.GetWindowHeight())
         {
            _loc2_ = this.GetWindowHeight() - _loc5_;
         }
      }
      this.SetPos(_loc3_,_loc2_);
   }
   function SetInfoPopupDirection(_strText, _fX, _fY, _fWidth, _fHeight, _iHorizontal, _iVertical)
   {
      this.mcInfoPopup._visible = true;
      this.mcInfoPopupEx._visible = false;
      this.mcInfoPopupEx2._visible = false;
      this.mcInfoPopupEx3._visible = false;
      this.mcTooltip1._visible = false;
      this.mcTooltip2._visible = false;
      this.ClearInfoPopupBuffTime();
      this.taInfo.htmlText = _strText;
      var _loc4_ = Math.ceil(this.taInfo._width);
      var _loc9_ = Math.ceil(this.taInfo._height);
      this.taInfo._width = _loc4_;
      this.taInfo._height = _loc9_;
      this.taInfo.width = _loc4_;
      this.taInfo.height = _loc9_;
      this.mcInfoPopup.tfTime._width = _loc4_;
      this.mcInfoPopup.tfTime.width = _loc4_;
      this.mcBg._width = this.taInfo._width + 6;
      this.mcBg._height = this.taInfo._height + 8;
      this.mcBg2._width = this.taInfo._width + 6;
      this.mcBg2._height = this.taInfo._height + 8;
      var _loc6_ = this.mcInfoPopup._width;
      var _loc5_ = this.mcInfoPopup._height;
      var _loc2_ = 0;
      var _loc3_ = 0;
      switch(_iHorizontal)
      {
         case 0:
            _loc2_ = _fX + _fWidth / 2;
            _loc2_ -= _loc6_ / 2;
            break;
         case 1:
            _loc2_ = _fX - _loc6_;
            break;
         case 2:
            _loc2_ = _fX + _fWidth;
            break;
         default:
            _loc2_ = _fX + _fWidth / 2;
            _loc2_ -= _loc6_ / 2;
      }
      switch(_iVertical)
      {
         case 0:
            _loc3_ = _fY + _fHeight / 2;
            _loc3_ -= _loc5_ / 2;
            break;
         case 1:
            _loc3_ = _fY - _loc5_;
            break;
         case 2:
            _loc3_ = _fY + _fHeight;
            break;
         default:
            _loc3_ = _fY + _fHeight / 2;
            _loc3_ -= _loc5_ / 2;
      }
      this.SetPos(_loc2_,_loc3_);
   }
   function SetInfoPopupMainSmall(_fX, _fY, _fWidth, _fHeight, _strHotkey, _strName)
   {
      this.mcInfoPopup._visible = false;
      this.mcInfoPopupEx._visible = false;
      this.mcInfoPopupEx2._visible = false;
      this.mcInfoPopupEx3._visible = false;
      this.mcTooltip1._visible = true;
      this.mcTooltip2._visible = false;
      this.tfHotkey1.text = _strHotkey;
      this.tfInfo1.text = _strName;
      var _loc5_ = this.mcTooltip1._width;
      var _loc4_ = this.mcTooltip1._height;
      var _loc3_ = _fX + _fWidth / 2;
      var _loc2_ = _fY + _fHeight / 2;
      _loc3_ -= _loc5_ / 2;
      if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      else if(_loc3_ + _loc5_ > this.GetWindowWidth())
      {
         _loc3_ = this.GetWindowWidth() - _loc5_;
      }
      if(_loc2_ > this.GetWindowHeight() / 2)
      {
         _loc2_ = _fY - _loc4_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
      }
      else
      {
         _loc2_ = _fY + _fHeight;
         if(_loc2_ + _loc4_ > this.GetWindowHeight())
         {
            _loc2_ = this.GetWindowHeight() - _loc4_;
         }
      }
      this.SetPos(_loc3_,_loc2_);
   }
   function SetInfoPopupMainLarge(_fX, _fY, _fWidth, _fHeight, _strHotkey, _strName)
   {
      this.mcInfoPopup._visible = false;
      this.mcInfoPopupEx._visible = false;
      this.mcInfoPopupEx2._visible = false;
      this.mcInfoPopupEx3._visible = false;
      this.mcTooltip1._visible = false;
      this.mcTooltip2._visible = true;
      this.tfHotkey2.text = _strHotkey;
      this.tfInfo2.text = _strName;
      var _loc5_ = this.mcTooltip2._width;
      var _loc4_ = this.mcTooltip2._height;
      var _loc3_ = _fX + _fWidth / 2;
      var _loc2_ = _fY + _fHeight / 2;
      _loc3_ -= _loc5_ / 2;
      if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      else if(_loc3_ + _loc5_ > this.GetWindowWidth())
      {
         _loc3_ = this.GetWindowWidth() - _loc5_;
      }
      if(_loc2_ > this.GetWindowHeight() / 2)
      {
         _loc2_ = _fY - _loc4_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
      }
      else
      {
         _loc2_ = _fY + _fHeight;
         if(_loc2_ + _loc4_ > this.GetWindowHeight())
         {
            _loc2_ = this.GetWindowHeight() - _loc4_;
         }
      }
      this.SetPos(_loc3_,_loc2_);
   }
   function SetInfoPopupEx(_strName)
   {
      this.mcInfoPopupEx._visible = true;
      this.taInfoEx.htmlText = _strName;
      var _loc3_ = Math.ceil(this.taInfoEx._width);
      var _loc5_ = Math.ceil(this.taInfoEx._height);
      this.taInfoEx._width = _loc3_;
      this.taInfoEx._height = _loc5_;
      this.taInfoEx.width = _loc3_;
      this.taInfoEx.height = _loc5_;
      this.mcBgEx._width = this.taInfoEx._width + 6;
      this.mcBg2Ex._width = this.taInfoEx._width + 6;
      if(this.taInfoEx._height + 8 < this.mcBg._height)
      {
         this.mcBgEx._height = this.mcBg._height;
         this.mcBg2Ex._height = this.mcBg._height;
      }
      else
      {
         this.mcBgEx._height = this.taInfoEx._height + 8;
         this.mcBg2Ex._height = this.taInfoEx._height + 8;
      }
      var _loc6_ = this.mcBgEx._width + this.mcBg._width;
      var _loc7_;
      if(this.mcBg._height < this.mcBgEx._height)
      {
         _loc7_ = this.mcBgEx._height;
      }
      else
      {
         _loc7_ = this.mcBg._height;
      }
      this.mcInfoPopupEx._x = this.mcBg._width - 2;
      var _loc2_ = this.m_mcMovie._x;
      var _loc4_ = this.m_mcMovie._y;
      if(_loc2_ + _loc6_ > this.GetWindowWidth())
      {
         _loc2_ = this.GetWindowWidth() - _loc6_;
      }
      if(this.m_mcMovie._y + this.mcInfoPopupEx._height > this.GetWindowHeight())
      {
         _loc4_ = this.GetWindowHeight() - this.mcInfoPopupEx._height;
      }
      this.SetPos(_loc2_,_loc4_);
   }
   function SetInfoPopupEx2(_fX, _fY, _fWidth, _fHeight, _strName)
   {
      this.mcInfoPopupEx2._visible = true;
      this.taInfoEx2.htmlText = _strName;
      var _loc7_ = Math.ceil(this.taInfoEx2._width);
      var _loc8_ = Math.ceil(this.taInfoEx2._height);
      this.taInfoEx2._width = _loc7_;
      this.taInfoEx2._height = _loc8_;
      this.taInfoEx2.width = _loc7_;
      this.taInfoEx2.height = _loc8_;
      this.mcBgEx2._height = this.taInfoEx2._height + 6;
      this.mcBg2Ex2._height = this.taInfoEx2._height + 8;
      this.mcBgEx2._width = this.taInfoEx2._width + 6;
      this.mcBg2Ex2._width = this.taInfoEx2._width + 8;
      var _loc5_ = this.mcBgEx2._width + this.mcBg._width;
      var _loc3_;
      if(this.mcInfoPopupEx._visible == true)
      {
         _loc5_ += this.mcBgEx._width;
      }
      if(this.mcInfoPopupEx3._visible == true)
      {
         _loc5_ += this.mcBgEx3._width;
      }
      if(this.mcBg._height < this.mcBgEx2._height)
      {
         _loc3_ = this.mcBgEx2._height;
      }
      else
      {
         _loc3_ = this.mcBg._height;
      }
      var _loc4_ = _fX + _fWidth * 0.5;
      var _loc2_ = _fY + _fHeight * 0.5;
      if(this.mcInfoPopupEx3._visible == true)
      {
         this.mcInfoPopupEx2._x = this.mcBg._x - this.mcBgEx2._width - this.mcBgEx3._width;
      }
      else
      {
         this.mcInfoPopupEx2._x = this.mcBg._x - this.mcBgEx2._width;
      }
      this.mcInfoPopupEx2._y = this.mcBg._y;
      _loc4_ -= this.mcInfoPopup._width / 2;
      _loc2_ = this.m_mcMovie._y;
      var _loc6_ = _fX + _fWidth * 0.5 - this.mcBg._width / 2 - this.mcBgEx2._width;
      if(this.mcInfoPopupEx3._visible == true)
      {
         _loc6_ = _fX + _fWidth * 0.5 - this.mcBg._width / 2 - this.mcBgEx2._width - this.mcBgEx3._width;
      }
      if(_loc6_ < 0)
      {
         _loc4_ = this.mcBgEx2._width;
      }
      else if(_loc6_ + _loc5_ > this.GetWindowWidth())
      {
         _loc4_ = this.GetWindowWidth() - _loc5_;
      }
      if(_loc2_ > this.GetWindowHeight() * 0.5)
      {
         _loc2_ = _fY - _loc3_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
      }
      else
      {
         _loc2_ = _fY + _fHeight;
         if(_loc2_ + _loc3_ > this.GetWindowHeight())
         {
            _loc2_ = this.GetWindowHeight() - _loc3_;
         }
      }
      this.SetPos(_loc4_,_loc2_);
   }
   function SetInfoPopupEx3(_strName)
   {
      this.mcInfoPopupEx3._visible = false;
      this.m_bCompareItemSetOption = true;
      this.taInfoEx3.htmlText = _strName;
      var _loc2_ = Math.ceil(this.taInfoEx3._width);
      var _loc3_ = Math.ceil(this.taInfoEx3._height);
      this.taInfoEx3._width = _loc2_;
      this.taInfoEx3._height = _loc3_;
      this.taInfoEx3.width = _loc2_;
      this.taInfoEx3.height = _loc3_;
      this.mcBgEx3._height = this.taInfoEx3._height + 6;
      this.mcBg2Ex3._height = this.taInfoEx3._height + 8;
      this.mcBgEx3._width = this.taInfoEx3._width + 6;
      this.mcBg2Ex3._width = this.taInfoEx3._width + 8;
   }
   function SetInfoPopupNotLeavingWindow(_fX, _fY, _fWidth, _fHeight, _strName)
   {
      this.mcInfoPopup._visible = true;
      this.mcInfoPopupEx._visible = false;
      this.mcInfoPopupEx2._visible = false;
      this.mcInfoPopupEx3._visible = false;
      this.mcTooltip1._visible = false;
      this.mcTooltip2._visible = false;
      this.ClearInfoPopupBuffTime();
      this.taInfo.htmlText = _strName;
      var _loc4_ = Math.ceil(this.taInfo._width);
      var _loc6_ = Math.ceil(this.taInfo._height);
      this.taInfo._width = _loc4_;
      this.taInfo._height = _loc6_;
      this.taInfo.width = _loc4_;
      this.taInfo.height = _loc6_;
      this.mcInfoPopup.tfTime._width = _loc4_;
      this.mcInfoPopup.tfTime.width = _loc4_;
      this.mcBg._width = this.taInfo._width + 6;
      this.mcBg._height = this.taInfo._height + 8;
      this.mcBg2._width = this.taInfo._width + 6;
      this.mcBg2._height = this.taInfo._height + 8;
      var _loc7_ = this.mcInfoPopup._width;
      var _loc5_ = this.mcInfoPopup._height;
      var _loc2_ = _fX + _fWidth;
      var _loc3_ = _fY;
      if(_loc3_ + _loc5_ > this.GetWindowHeight())
      {
         _loc3_ -= _loc3_ + _loc5_ - this.GetWindowHeight();
      }
      else if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      if(_loc2_ + _loc7_ > this.GetWindowWidth())
      {
         _loc2_ = _loc2_ - _fWidth - _loc7_;
      }
      else if(_loc2_ < 0)
      {
         _loc2_ = 0;
      }
      this.SetPos(_loc2_,_loc3_);
   }
   function SetInfoPopupBuffTimer(infos)
   {
      if(this.mcInfoPopup._visible == false)
      {
         return undefined;
      }
      var _loc6_;
      var _loc5_;
      if(this.taInfo._width < Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN)
      {
         this.mcInfoPopup.tfTime._width = Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN;
         this.mcInfoPopup.tfTime.width = Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN;
         this.taInfo._x = Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN / 2 - this.taInfo._width / 2;
         this.mcBg._width = Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN + 6;
         this.mcBg2._width = Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN + 6;
         _loc6_ = this.m_mcMovie._x + (this.taInfo._width - Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN) * 0.5;
         _loc5_ = this.m_mcMovie._y;
         this.SetPos(_loc6_,_loc5_);
      }
      else
      {
         this.mcInfoPopup.tfTime._width = this.taInfo._width;
         this.mcInfoPopup.tfTime.width = this.taInfo._width;
      }
      this.mcInfoPopup.tfTime._y = this.taInfo._y + this.taInfo._height;
      this.mcInfoPopup.tfTime._visible = true;
      this.mcBg._height = this.taInfo._height + this.mcInfoPopup.tfTime._height + 8;
      this.mcBg2._height = this.taInfo._height + this.mcInfoPopup.tfTime._height + 8;
      this.m_strHead = infos.strHead;
      this.m_strD = infos.strDays;
      this.m_strH = infos.strHours;
      this.m_strM = infos.strMinutes;
      this.m_strLessThanM = infos.strLessThanMinutes;
      this.m_iBuffTime = infos.dmTime;
      this.m_iStarTime = getTimer();
      var _loc4_ = this.devText;
      var _loc3_;
      if(_loc4_ != undefined)
      {
         _loc3_ = "dmTime : " + this.m_iBuffTime;
         trace("남은시간: " + _loc3_);
         _loc4_.text = _loc3_;
      }
      if(this.ChangeTime() == true)
      {
         this.m_iBuffTimerID = setInterval(this,"onCallbackTimer",20000);
      }
   }
   function ClearInfoPopupBuffTime()
   {
      this.mcInfoPopup.tfTime._y = this.taInfo._y;
      this.mcInfoPopup.tfTime._visible = false;
      this.mcInfoPopup.tfTime.text = "";
      this.m_strHead = "";
      this.m_strD = "";
      this.m_strH = "";
      this.m_strM = "";
      this.m_strLessThanM = "";
      this.m_iBuffTime = 0;
      this.m_iStarTime = 0;
      if(this.taInfo._width < Common.Global.MUDefines.INFOPOPUP_BUFFTIME_WIDTH_SIZE_MIN)
      {
         this.taInfo._x = this.mcInfoPopup.tfTime._x;
      }
      clearInterval(this.m_iBuffTimerID);
   }
   function onCallbackTimer()
   {
      if(this.ChangeTime() == false)
      {
         clearInterval(this.m_iBuffTimerID);
      }
   }
   function ChangeTime()
   {
      var _loc6_ = this.m_iBuffTime + (this.m_iStarTime - getTimer()) * 0.001;
      var _loc4_ = int(_loc6_ / 86400);
      var _loc3_ = int((_loc6_ - _loc4_ * 86400) / 3600);
      var _loc5_ = int((_loc6_ - (_loc3_ * 3600 + _loc4_ * 86400)) / 60);
      var _loc7_ = false;
      var _loc2_ = "";
      if(_loc4_ == 0 && _loc3_ == 0 && _loc5_ == 0)
      {
         _loc2_ = this.m_strLessThanM;
         _loc7_ = false;
      }
      else
      {
         if(_loc4_ > 0)
         {
            _loc2_ += String(_loc4_) + this.m_strD + " ";
            _loc2_ += String(_loc3_) + this.m_strH + " ";
            _loc2_ += String(_loc5_) + this.m_strM;
         }
         else if(_loc3_ > 0)
         {
            _loc2_ += String(_loc3_) + this.m_strH + " ";
            _loc2_ += String(_loc5_) + this.m_strM;
         }
         else
         {
            _loc2_ += String(_loc5_) + this.m_strM;
         }
         _loc7_ = true;
      }
      if(this.m_strHead.length > 0)
      {
         this.mcInfoPopup.tfTime.text = this.m_strHead.split("%s").join(_loc2_);
      }
      else
      {
         this.mcInfoPopup.tfTime.text = _loc2_;
      }
      return _loc7_;
   }
   function SetInfoPopupClose()
   {
      this.mcInfoPopup._visible = false;
      this.mcInfoPopupEx._visible = false;
      this.mcInfoPopupEx2._visible = false;
      this.mcTooltip1._visible = false;
      this.mcTooltip2._visible = false;
      this.ClearInfoPopupBuffTime();
      this.mcInfoPopup._x = 0;
      this.m_bCompareItemSetOption = false;
   }
   function SetEquippedInfoPopup(_fX, _fY, _fWidth, _fHeight, _strName)
   {
      this.mcInfoPopupEx2._visible = true;
      this.taInfoEx2.htmlText = _strName;
      var _loc4_ = Math.ceil(this.taInfoEx2._width);
      var _loc6_ = Math.ceil(this.taInfoEx2._height);
      this.taInfoEx2._width = _loc4_;
      this.taInfoEx2._height = _loc6_;
      this.taInfoEx2.width = _loc4_;
      this.taInfoEx2.height = _loc6_;
      this.mcBgEx2._height = this.taInfoEx2._height + 6;
      this.mcBg2Ex2._height = this.taInfoEx2._height + 8;
      this.mcBgEx2._width = this.taInfoEx2._width + 6;
      this.mcBg2Ex2._width = this.taInfoEx2._width + 8;
      var _loc2_ = _fX + _fWidth * 0.5;
      var _loc5_ = _fY + _fHeight * 0.5;
      this.mcInfoPopupEx2._y = this.mcBg._y;
      _loc2_ -= this.mcInfoPopup._width / 2;
      _loc5_ = this.m_mcMovie._y;
      var _loc3_;
      if(this.mcInfoPopupEx._visible == true)
      {
         _loc3_ = this.mcBgEx._width;
      }
      else
      {
         _loc3_ = 0;
      }
      if(_fX - _fWidth * 0.5 + this.mcBg._width + _loc3_ + this.mcBgEx2._width + this.INFO_BACKGROUND_INTERVAL > this.GetWindowWidth())
      {
         _loc2_ = this.m_mcMovie._x - this.mcBgEx2._width - this.INFO_BACKGROUND_INTERVAL;
         this.SetPos(_loc2_,_loc5_);
         this.mcInfoPopupEx2._x = 0;
         this.mcInfoPopup._x = this.mcBgEx2._x + this.mcBgEx2._width + this.INFO_BACKGROUND_INTERVAL;
         this.mcInfoPopupEx._x = this.mcInfoPopup._x + this.mcBg._width - 2;
      }
      else
      {
         this.mcInfoPopup._x = 0;
         this.mcInfoPopupEx._x = this.mcBg._width - 2;
         this.mcInfoPopupEx2._x = this.mcInfoPopupEx._x + _loc3_ + this.INFO_BACKGROUND_INTERVAL;
      }
   }
   function SetInfoPopupCompareItem(_strName)
   {
      this.mcInfoPopupEx2._visible = false;
      this.mcInfoPopupEx3._visible = false;
      this.taInfoEx2.htmlText = _strName;
      var _loc4_ = Math.ceil(this.taInfoEx2._width);
      var _loc5_ = Math.ceil(this.taInfoEx2._height);
      this.taInfoEx2._width = _loc4_;
      this.taInfoEx2._height = _loc5_;
      this.taInfoEx2.width = _loc4_;
      this.taInfoEx2.height = _loc5_;
      this.mcBgEx2._height = this.taInfoEx2._height + 6;
      this.mcBg2Ex2._height = this.taInfoEx2._height + 8;
      this.mcBgEx2._width = this.taInfoEx2._width + 6;
      this.mcBg2Ex2._width = this.taInfoEx2._width + 8;
      if(this.taInfoEx3._height + 8 < this.mcBgEx2._height)
      {
         this.mcBgEx3._height = this.mcBgEx2._height;
         this.mcBg2Ex3._height = this.mcBgEx2._height;
      }
      else
      {
         this.mcBgEx3._height = this.taInfoEx3._height + 8;
         this.mcBg2Ex3._height = this.taInfoEx3._height + 8;
      }
      var _loc6_;
      var _loc7_;
      this.mcInfoPopupEx2._y = this.mcBg._y;
      _loc7_ = this.m_mcMovie._y;
      var _loc3_;
      var _loc2_;
      if(this.mcInfoPopupEx._visible == true)
      {
         _loc3_ = this.mcBgEx._width;
      }
      else
      {
         _loc3_ = 0;
      }
      if(this.m_bCompareItemSetOption == true)
      {
         _loc2_ = this.mcBgEx3._width;
      }
      else
      {
         _loc2_ = 0;
      }
      if(this.m_mcMovie._x + this.mcBg._width + _loc3_ + this.mcBgEx2._width + _loc2_ + this.INFO_BACKGROUND_INTERVAL > this.GetWindowWidth())
      {
         _loc6_ = this.m_mcMovie._x - this.mcBgEx2._width - (_loc2_ + 2) - this.INFO_BACKGROUND_INTERVAL;
         this.SetPos(_loc6_,_loc7_);
         this.mcInfoPopupEx2._x = 0;
         this.mcInfoPopupEx3._x = this.mcBgEx2._width - 2;
         this.mcInfoPopup._x = this.mcBgEx2._x + this.mcBgEx2._width + _loc2_ + this.INFO_BACKGROUND_INTERVAL;
         this.mcInfoPopupEx._x = this.mcInfoPopup._x + this.mcBg._width - 2;
      }
      else
      {
         this.mcInfoPopup._x = 0;
         this.mcInfoPopupEx._x = this.mcBg._width - 2;
         this.mcInfoPopupEx2._x = this.mcInfoPopupEx._x + _loc3_ + this.INFO_BACKGROUND_INTERVAL;
         this.mcInfoPopupEx3._x = this.mcInfoPopupEx2._x + this.mcBgEx2._width - 2;
      }
   }
   function SetCompareItemPress(_bVisible)
   {
      var _loc2_;
      if(this.m_mcMovie._visible == true && this.m_bSetEquippedItemInfo == true && _bVisible == true)
      {
         this.mcInfoPopupEx2._visible = true;
         if(this.m_mcMovie._x < 0)
         {
            if(this.mcInfoPopupEx._visible == true)
            {
               _loc2_ = this.mcBgEx._width;
            }
            else
            {
               _loc2_ = 0;
            }
            this.mcInfoPopup._x = 0;
            this.mcInfoPopupEx._x = this.mcBg._width - 2;
            this.mcInfoPopupEx2._x = this.mcInfoPopupEx._x + this.mcBgEx._width + this.INFO_BACKGROUND_INTERVAL;
            this.mcInfoPopupEx3._x = this.mcInfoPopupEx2._x + this.mcBgEx2._width - 2;
         }
         if(this.m_bCompareItemSetOption == true)
         {
            this.mcInfoPopupEx3._visible = true;
         }
         else
         {
            this.mcInfoPopupEx3._visible = false;
         }
      }
      else
      {
         this.mcInfoPopupEx2._visible = false;
         this.mcInfoPopupEx3._visible = false;
      }
   }
   function SetCompareItemCondition(_bSettingCondition)
   {
      this.m_bSetEquippedItemInfo = _bSettingCondition;
   }
}
