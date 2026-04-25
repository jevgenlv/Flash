class Frame.ChatMC.ChatInputBox extends core.EventMovieClip
{
   var _arrChatHistory;
   var _arrUserIdHistory;
   var _historyIndex;
   var _isKeyEnable;
   var _itTextBox;
   var _itWhisper;
   var _userIdIndex;
   var FocusedNon = 0;
   var FocusedText = 1;
   var FocusedWhisper = 2;
   function ChatInputBox()
   {
      super();
      this._arrChatHistory = new Array();
      this._arrUserIdHistory = new Array();
      this._historyIndex = -1;
      this._userIdIndex = -1;
   }
   function onLoad()
   {
      this._isKeyEnable = true;
      Key.addListener(this);
      var _loc2_;
      if(gSystem.isClient == false)
      {
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            this._arrChatHistory.push("UpDownTest " + _loc2_);
            _loc2_ = _loc2_ + 1;
         }
         this._historyIndex = this._arrChatHistory.length;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            this._arrUserIdHistory.push("Name " + _loc2_);
            _loc2_ = _loc2_ + 1;
         }
         this._userIdIndex = this._arrUserIdHistory.length;
      }
   }
   function getDevText()
   {
      var _loc2_ = "ChatInputBox ChatHistoryCount:" + this._arrChatHistory.length + "\n";
      _loc2_ += util.TextAllObjectInfo(this._arrChatHistory);
      return _loc2_;
   }
   function InitData(info)
   {
      this._itTextBox.maxChars = Number(info.MaxInputSize);
      this._itWhisper.maxChars = Number(info.MaxUsetNameSize);
   }
   function setKeyInput(b)
   {
      this._isKeyEnable = b;
   }
   function SetWhisper(name)
   {
      this._itWhisper.text = name;
      this.setEditState(this.FocusedText);
   }
   function onMouseUp()
   {
      var _loc4_ = this._itTextBox.hitTest(_root._xmouse,_root._ymouse);
      if(_loc4_)
      {
         flash.external.ExternalInterface.call("chat","SetInputTextReady",0);
         return undefined;
      }
      var _loc3_ = this._itWhisper.hitTest(_root._xmouse,_root._ymouse);
      if(_loc3_)
      {
         this._itWhisper.text = "";
         flash.external.ExternalInterface.call("chat","SetInputWhisperReady",0);
         return undefined;
      }
   }
   function onPushText(_pos, str)
   {
      if(_pos == 0)
      {
         this._itTextBox.text = str;
         return undefined;
      }
      if(_pos == 1)
      {
         this._itWhisper.text = str;
         return undefined;
      }
   }
   function onKeyDownForcedEnter()
   {
      if(gSystem.isClient == true && gSystem.isMainScene != true)
      {
         return undefined;
      }
      if(this._isKeyEnable == false)
      {
         return undefined;
      }
      var _loc2_ = 13;
      var _loc3_ = this.getEditStat();
      var _loc0_;
      switch(_loc3_)
      {
         case this.FocusedNon:
            if(gfx.controls.TextInput.IsTextFieldFocus != true && _loc2_ == 13)
            {
               this.setEditState(this.FocusedText);
               return undefined;
            }
            break;
         case this.FocusedText:
            if((_loc0_ = _loc2_) === 13)
            {
               this.callInputText();
               return undefined;
            }
            break;
         case this.FocusedWhisper:
            if((_loc0_ = _loc2_) === 13)
            {
               this.callInputText();
               return undefined;
            }
         default:
            return;
      }
   }
   function onKeyDown()
   {
      if(gSystem.isClient == true && gSystem.isMainScene != true)
      {
         return undefined;
      }
      if(this._isKeyEnable == false)
      {
         return undefined;
      }
      var _loc2_ = Key.getCode();
      var _loc3_ = this.getEditStat();
      switch(_loc3_)
      {
         case this.FocusedNon:
            if(gfx.controls.TextInput.IsTextFieldFocus != true && _loc2_ == 13)
            {
               this.setEditState(this.FocusedText);
               return undefined;
            }
            break;
         case this.FocusedText:
            switch(_loc2_)
            {
               case 13:
                  this.callInputText();
                  return undefined;
               case 38:
                  this.onTextUpDown(true);
                  return undefined;
               case 40:
                  this.onTextUpDown(false);
                  return undefined;
               case 9:
                  this.setEditState(this.FocusedWhisper);
                  return undefined;
            }
            break;
         case this.FocusedWhisper:
            switch(_loc2_)
            {
               case 9:
                  this.setEditState(this.FocusedText);
                  return undefined;
               case 13:
                  this.callInputText();
                  return undefined;
               case 38:
                  this.onTextUpDown(true);
                  return undefined;
               case 40:
                  this.onTextUpDown(false);
                  return undefined;
            }
         default:
            return;
      }
   }
   function onTextUpDown(isUp)
   {
      if(this._itTextBox.focused != 0)
      {
         if(this._arrChatHistory.length == 0)
         {
            return undefined;
         }
         if(isUp == true)
         {
            this._historyIndex = this._historyIndex - 1;
            if(this._historyIndex < 0 || this._historyIndex >= this._arrChatHistory.length)
            {
               this._historyIndex = this._arrChatHistory.length - 1;
            }
         }
         else
         {
            this._historyIndex = this._historyIndex + 1;
            if(this._historyIndex < 0 || this._historyIndex >= this._arrChatHistory.length)
            {
               this._historyIndex = 0;
            }
         }
         this._itTextBox.text = this._arrChatHistory[this._historyIndex];
         return undefined;
      }
      if(this._itWhisper.focused != 0)
      {
         if(this._arrUserIdHistory.length == 0)
         {
            return undefined;
         }
         if(isUp == true)
         {
            this._userIdIndex = this._userIdIndex - 1;
            if(this._userIdIndex < 0 || this._userIdIndex >= this._arrUserIdHistory.length)
            {
               this._userIdIndex = this._arrUserIdHistory.length - 1;
            }
         }
         else
         {
            this._userIdIndex = this._userIdIndex + 1;
            if(this._userIdIndex < 0 || this._userIdIndex >= this._arrUserIdHistory.length)
            {
               this._userIdIndex = 0;
            }
         }
         this._itWhisper.text = this._arrUserIdHistory[this._userIdIndex];
         return undefined;
      }
   }
   function callInputText()
   {
      if(this._itTextBox.text == "")
      {
         this.setEditState(this.FocusedNon);
         return undefined;
      }
      var _loc2_ = this._itTextBox.text;
      this._historyIndex = this.addHistoryText(this._arrChatHistory,_loc2_,12);
      if(this._itWhisper.text != "")
      {
         this._userIdIndex = this.addHistoryText(this._arrUserIdHistory,this._itWhisper.text,5);
      }
      this.onEvent({type:"inputText",wisper:this._itWhisper.text,text:_loc2_});
      this._itTextBox.text = "";
      this.setEditState(this.FocusedNon);
   }
   function ClearAllChatHistory()
   {
      this._itTextBox.text = "";
      this._itWhisper.text = "";
   }
   function addHistoryText(arr, text, maxCount)
   {
      if(arr.length == 0)
      {
         arr.push(text);
         return arr.length;
      }
      var _loc2_ = arr[arr.length - 1];
      if(_loc2_ != text)
      {
         arr.push(text);
      }
      if(arr.length > maxCount)
      {
         arr.splice(0,1);
      }
      return arr.length;
   }
   function onEditText(isTextEdit)
   {
      gSystem.clearFocus();
      if(isTextEdit == true)
      {
         this._itTextBox.focused = 1;
      }
      else
      {
         this._itTextBox.text = "";
      }
   }
   function setEditState(focuseState)
   {
      var _loc2_ = this.getEditStat();
      if(_loc2_ == this.FocusedNon && focuseState != this.FocusedNon)
      {
         this.onEvent({type:"focused",focused:true});
         return undefined;
      }
      if(_loc2_ != this.FocusedNon && focuseState == this.FocusedNon)
      {
         this.onEvent({type:"focused",focused:false});
         return undefined;
      }
      gSystem.clearFocus();
      switch(focuseState)
      {
         case this.FocusedText:
            this._itTextBox.focused = 1;
            break;
         case this.FocusedWhisper:
            this._itWhisper.focused = 1;
         default:
            return;
      }
   }
   function getEditStat()
   {
      if(this._itTextBox.focused == 1)
      {
         return this.FocusedText;
      }
      if(this._itWhisper.focused == 1)
      {
         return this.FocusedWhisper;
      }
      return this.FocusedNon;
   }
}
