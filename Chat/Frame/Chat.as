class Frame.Chat extends core.KeyMovieClip
{
   var _configMenu;
   var _devText;
   var _inputBox;
   var _keyName;
   var _view;
   var _x;
   var _xscale;
   var _y;
   var _yscale;
   var _bOrigialVisible_configMenu = false;
   var _bOrigialVisible_inputBox = false;
   function Chat()
   {
      super();
      this._keyName = "chat";
   }
   function onLoad()
   {
      this.onResize();
      Stage.addListener(this);
      this._inputBox.addEventListener("inputText",this,"onEnterText");
      this._inputBox.addEventListener("focused",this,"onFocuseText");
      this._configMenu.addEventListener("onViewOption",this,"onViewOption");
      this._configMenu.addEventListener("onFilter",this,"SetFilter");
      this._view.addEventListener("click",this,"onClickView");
      this.CloseEditText();
      this.updateDevText();
   }
   function onClickView()
   {
      trace("onClickView");
   }
   function onResize()
   {
      if(Stage.height < gStandard.ResizeStageHeight)
      {
         this._xscale = 83;
         this._yscale = 83;
         this._x = 0;
         this._y = Stage.height - 197;
      }
      else
      {
         this._xscale = 100;
         this._yscale = 100;
         this._x = 0;
         this._y = Stage.height - 238;
      }
   }
   function devFunTest(devFunTest)
   {
      devFunTest.setUIName("채팅프레임");
      devFunTest.addFunInfo("testChatType");
      devFunTest.addFunInfo("testChatText",{type:1,name:"UIdev",msg:"text"});
      devFunTest.addFunInfo("ClearAllChatHistory");
      devFunTest.addFunInfo("CloseEditText");
      devFunTest.addFunInfo("OpenEditText");
      devFunTest.addFunInfo("setInputType",1);
   }
   function testChatType()
   {
      this._view.testChatType();
   }
   function testChatText(info)
   {
      this._view.AddChatInfo(info);
   }
   function InitData(info)
   {
      this._view.InitTextTable(info);
      this._configMenu.InitTextTable(info);
      this._inputBox.InitData(info);
   }
   function setSimpleMode(b)
   {
      this._bOrigialVisible_configMenu = this._configMenu._visible;
      this._bOrigialVisible_inputBox = this._inputBox._visible;
      this._configMenu._visible = b;
      this._inputBox._visible = b;
   }
   function setClassicMode()
   {
      this._configMenu._visible = this._bOrigialVisible_configMenu;
      this._inputBox._visible = this._bOrigialVisible_inputBox;
   }
   function setKeyInput(b)
   {
      this._inputBox.setKeyInput(b);
   }
   function setBlocked(b)
   {
      this._configMenu.setBlocked(b);
   }
   function setInputType(n)
   {
      this._configMenu.setInputType(n);
   }
   function SetWhisper(name)
   {
      this._inputBox.SetWhisper(name);
   }
   function SetFilter(info)
   {
      this._view.SetFilter(info);
   }
   function AddChatInfo(info)
   {
      this._view.AddChatInfo(info);
   }
   function ClearAllChatHistory()
   {
      this._view.ClearAllChatHistory();
      this._inputBox.ClearAllChatHistory();
   }
   function SetUIOption(info)
   {
      this._view.SetUIOption(info);
   }
   function onViewOption(e)
   {
      this._view.onViewOption(e);
   }
   function CloseEditText()
   {
      this.setFocusUI(false);
      this._inputBox.onEditText(false);
   }
   function OpenEditText()
   {
      this.setFocusUI(true);
      this._inputBox.onEditText(true);
   }
   function setFocusUI(b)
   {
      this._view.SetEditText(b);
      this._configMenu._visible = b;
      this._inputBox._visible = b;
      this.updateDevText();
   }
   function onFocuseText(e)
   {
      if(gSystem.isClient == false)
      {
         if(e.focused == true)
         {
            this.OpenEditText();
         }
         else
         {
            this.CloseEditText();
         }
         return undefined;
      }
      this.EventCall("onFocuseText",e);
   }
   function onEnterText(e)
   {
      util.TraceAllObjectInfo(e);
      var _loc4_ = e.text;
      if(gSystem.isClient == false)
      {
         this._view.AddChatInfo({type:1,name:"flashDev",msg:_loc4_});
      }
      else
      {
         _loc4_ = _loc4_.split("&lt;").join("<");
         _loc4_ = _loc4_.split("&gt;").join(">");
         this.EventCall("onEnterText",{wisper:e.wisper,text:_loc4_,type:this._configMenu.getInputType()});
         this._view.onScrollDown();
      }
   }
   function onPushText(info)
   {
      this._inputBox.onPushText(info.pos,info.str);
      var _loc3_;
      if(info.pos == 0)
      {
         _loc3_ = {wisper:this.getWhisper(),type:"inputText",target:this._inputBox,text:this.getText()};
         this.onEnterText(_loc3_);
         this._inputBox.onPushText(0,"");
      }
   }
   function getWhisper()
   {
      return this._inputBox._itWhisper.textField.text;
   }
   function getText()
   {
      return this._inputBox._itTextBox.textField.text;
   }
   function updateDevText()
   {
      if(this._devText == undefined)
      {
         return undefined;
      }
      this._devText.text = this._inputBox.getDevText();
   }
}
