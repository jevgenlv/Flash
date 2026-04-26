class Common.Controls.MUButton extends gfx.controls.Button
{
   var __get__autoSize;
   var __get__disabled;
   var __get__height;
   var __get__width;
   var __set__disabled;
   var __set__selected;
   var _autoSize;
   var _disableConstraints;
   var _disabled;
   var _focused;
   var _label;
   var _name;
   var _selected;
   var addEventListener;
   var autoRepeat;
   var buttonRepeatDelay;
   var buttonRepeatInterval;
   var constraints;
   var dispatchEvent;
   var dispatchEventAndSound;
   var doubleClickDuration;
   var doubleClickEnabled;
   var doubleClickExpired;
   var doubleClickInterval;
   var focusIndicator;
   var getStatePrefixes;
   var gotoAndPlay;
   var handleDragOut;
   var handleDragOver;
   var handleMouseRollOut;
   var handleMouseRollOver;
   var handleReleaseOutside;
   var initialized;
   var m_iDisableIntervalID;
   var onDragOut;
   var onDragOver;
   var onPress;
   var onRelease;
   var onReleaseOutside;
   var onRollOut;
   var onRollOver;
   var pressedByKeyboard;
   var sizeIsInvalid;
   var state;
   var stateMap;
   var textField;
   var toggle;
   var validateNow;
   var m_strTopMostParentUID = "";
   function MUButton()
   {
      super();
      if(this._label == undefined)
      {
         this._label = "";
      }
      this.textField.html = true;
   }
   function onLoad()
   {
      super.onLoad();
   }
   function onUnload()
   {
      super.onUnload();
   }
   function onAddEvent(_strParentName)
   {
      this.m_strTopMostParentUID = _strParentName;
      this.addEventListener("click",this,"onClickBtnEvent");
   }
   function onEnterFrame()
   {
      if(this.state == "over")
      {
         if(this.textField.textWidth > this.textField._width)
         {
            this.textField.hscroll += 1;
         }
      }
      else
      {
         this.textField.hscroll = 0;
      }
   }
   function handleInput(details, pathToFocus)
   {
      if(details.code == 9 && Key.isDown(9))
      {
         return true;
      }
      super.handleInput(details,pathToFocus);
      return true;
   }
   function handleMousePress(controllerIdx, keyboardOrMouse, button)
   {
      if(this._disabled)
      {
         return undefined;
      }
      this.setState("down");
      this.dispatchEventAndSound({type:"press",controllerIdx:controllerIdx,button:button});
      if(this.autoRepeat)
      {
         this.buttonRepeatInterval = setInterval(this,"beginButtonRepeat",this.buttonRepeatDelay,controllerIdx,button);
      }
   }
   function set label(value)
   {
      this._label = value;
      this.textField.html = true;
      this.textField.htmlText = this._label;
      if(this.initialized)
      {
         if(this.textField != null)
         {
            this.textField.htmlText = this._label;
         }
         if(this.autoSize != "none")
         {
            this.sizeIsInvalid = true;
         }
         this.updateAfterStateChange();
      }
   }
   function configUI()
   {
      this.constraints = new gfx.utils.Constraints(this,true);
      if(!this._disableConstraints)
      {
         this.constraints.addElement(this.textField,gfx.utils.Constraints.ALL);
      }
      super.configUI();
      if(this._autoSize != "none")
      {
         this.sizeIsInvalid = true;
      }
      this.onRollOver = this.handleMouseRollOver;
      this.onRollOut = this.handleMouseRollOut;
      this.onPress = this.handleMousePress;
      this.onRelease = this.handleMouseRelease;
      this.onReleaseOutside = this.handleReleaseOutside;
      this.onDragOver = this.handleDragOver;
      this.onDragOut = this.handleDragOut;
      this.textField.html = true;
      this.textField.htmlText = this._label;
      if(this.focusIndicator != null && !this._focused && this.focusIndicator._totalFrames == 1)
      {
         this.focusIndicator._visible = false;
      }
      this.updateAfterStateChange();
   }
   function updateAfterStateChange()
   {
      if(!this.initialized)
      {
         return undefined;
      }
      if(this.textField != null && this._label != null)
      {
         this.textField.htmlText = this._label;
      }
      this.validateNow();
      if(this.constraints != null)
      {
         this.constraints.update(this.width,this.height);
      }
      this.dispatchEvent({type:"stateChange",state:this.state});
   }
   function setState(state)
   {
      this.state = state;
      var _loc5_ = this.getStatePrefixes();
      var _loc3_ = this.stateMap[state];
      if(_loc3_ == null || _loc3_.length == 0)
      {
         return undefined;
      }
      var _loc4_;
      var _loc2_;
      do
      {
         _loc4_ = _loc5_.pop().toString();
         _loc2_ = _loc3_.length - 1;
         while(_loc2_ >= 0)
         {
            this.gotoAndPlay(_loc4_ + _loc3_[_loc2_]);
            _loc2_ = _loc2_ - 1;
         }
      }
      while(_loc5_.length > 0);
      
      this.updateAfterStateChange();
      this.textField.html = true;
      this.textField.htmlText = this._label;
   }
   function handleMouseRelease(controllerIdx, keyboardOrMouse, button)
   {
      if(this._disabled)
      {
         return undefined;
      }
      clearInterval(this.buttonRepeatInterval);
      delete this.buttonRepeatInterval;
      if(this.doubleClickEnabled)
      {
         if(this.doubleClickInterval != null)
         {
            this.doubleClickExpired();
            this.dispatchEventAndSound({type:"doubleClick",controllerIdx:controllerIdx,button:button});
            this.setState("release");
            this.textField.html = true;
            this.textField.htmlText = this._label;
            return undefined;
         }
         this.doubleClickInterval = setInterval(this,"doubleClickExpired",this.doubleClickDuration);
      }
      this.setState("release");
      this.textField.html = true;
      this.textField.htmlText = this._label;
      this.handleClick(controllerIdx,button);
   }
   function handleRelease(controllerIdx)
   {
      if(this._disabled)
      {
         return undefined;
      }
      this.setState(this.focusIndicator != null ? "kb_release" : "release");
      this.handleClick(controllerIdx);
      this.pressedByKeyboard = false;
      this.textField.html = true;
      this.textField.htmlText = this._label;
   }
   function handleClick(controllerIdx, button)
   {
      if(this.toggle)
      {
         this.selected = !this._selected;
      }
      this.dispatchEventAndSound({type:"click",controllerIdx:controllerIdx,button:button});
      this.textField.html = true;
      this.textField.htmlText = this._label;
   }
   function onClickBtnEvent()
   {
      flash.external.ExternalInterface.call("onClick" + this._name,this.m_strTopMostParentUID);
   }
   function onReleaseAux(mouseIdx, keyboardOrMouse, buttonIdx)
   {
      if(this.toggle)
      {
         this.selected = !this._selected;
      }
      if(buttonIdx == 1)
      {
         this.dispatchEventAndSound({type:"clickR",mouseIdx:mouseIdx,buttonIdx:buttonIdx});
      }
      this.textField.html = true;
      this.textField.htmlText = this._label;
   }
   function SetIntervalDisable(iIntervalMS)
   {
      if(this.disabled == true)
      {
         return undefined;
      }
      this.disabled = true;
      this.m_iDisableIntervalID = setInterval(this,"onEnable",iIntervalMS);
   }
   function onEnable()
   {
      this.disabled = false;
      clearInterval(this.m_iDisableIntervalID);
   }
}
