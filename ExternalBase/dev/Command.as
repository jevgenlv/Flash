class dev.Command extends core.KeyMovieClip
{
   var _LoaderName;
   var _keyName;
   var _loader;
   var _parent;
   var _visible;
   var _x;
   var _y;
   var arrDatas;
   var mcCmd;
   var mcSubCmd;
   var noAdvance;
   function Command()
   {
      super();
      this._keyName = "devCmd";
   }
   function get LoaderName()
   {
      return this._LoaderName;
   }
   function set LoaderName(value)
   {
      this._LoaderName = value;
      this.setLoaderMC(this._LoaderName);
   }
   function setLoaderMC(value)
   {
      if(value != "" && this._parent[value] != undefined)
      {
         this._loader = this._parent[value];
         debug.Log(" cmd loader : " + this._loader);
      }
   }
   function onLoad()
   {
      if(_root.isClient != true)
      {
         trace("UI 테스트 환경입니다.  Client:" + _root.isClient);
      }
      debug.Log("create SystemCmd  : " + this + " loader : " + this._LoaderName);
      this.arrDatas = new Array();
      this.arrDatas.push("사용자 명령어");
      this.arrDatas.push("INI 명령어");
      this.arrDatas.push("SWF 읽기");
      this.arrDatas.push("AS 전역 변수");
      this.arrDatas.push("폰트");
      this.mcCmd.setTextInput(false);
      this.mcCmd.setTitle("Tools Menu");
      this.mcCmd.setList("main",this.arrDatas);
      this.mcCmd.addEventListener("click",this,"onMainCmd");
      this.mcSubCmd.Open(false);
      this.mcSubCmd.addEventListener("click",this,"onSubCmd");
      this._visible = false;
      this.onResize();
      if(_root.isClient != true)
      {
         this.useGlobalSystem(true);
      }
      super.onFileLoad();
   }
   function onMainCmd(e)
   {
      debug.Log("-- onMainCmd -- " + e.msg);
      var _loc4_;
      switch(e.msg)
      {
         case "SWF 읽기":
         case "INI 명령어":
            if(_root.isClient == true)
            {
               this.EventCall(e.cmd,e.msg);
            }
            else
            {
               _loc4_ = new Array();
               _loc4_.push("packLoad1");
               _loc4_.push("packLoad2");
               _loc4_.push("test value2");
               _loc4_.push("test value3");
               _loc4_.push("box");
               _loc4_.push("box1");
               _loc4_.push("FontConfig");
               e.datas = _loc4_;
               e.cmd = e.msg;
               this.OpenSubCmd(e);
            }
            return;
         case "사용자 명령어":
            this.mcCmd.setTextInput(!this.mcCmd.getTextInput());
            this.mcSubCmd.Open(false);
            return;
         case "AS 전역 변수":
            this.mcSubCmd.Open(false);
            return;
         case "폰트":
            _loc4_ = new Array();
            _loc4_.push("Korean");
            _loc4_.push("English");
            _loc4_.push("Japan");
            _loc4_.push("China");
            _loc4_.push("Taiwan");
            e.datas = _loc4_;
            e.cmd = e.msg;
            this.OpenSubCmd(e);
            return;
         default:
            this.EventCall(e.cmd,e.msg);
            return undefined;
      }
   }
   function onSubCmd(e)
   {
      debug.Log("-- onSubCmd --  " + e.cmd + " : " + e.msg);
      switch(e.cmd)
      {
         case "SWF 읽기":
            if(this._loader == undefined)
            {
               debug.Log("Command 에서 파일로더가 없습니다");
            }
            if(e.msg == undefined)
            {
               return undefined;
            }
            if(this._loader.getMC(e.msg) == undefined)
            {
               this._loader.Load(e.msg);
            }
            else
            {
               this._loader.Unload(e.msg);
            }
            return;
            break;
         case "폰트":
            trace(e.cmd + " : " + e.msg);
            fscommand("GFxApplyLanguage",e.msg);
            _global.gfxLanguage = e.msg;
            return;
         default:
            this.EventCall(e.cmd,e.msg);
            return;
      }
   }
   function OpenSubCmd(info)
   {
      trace("OpenSubCmd : " + info.cmd + "-" + this.mcSubCmd.getType());
      if(info.cmd == undefined)
      {
         return undefined;
      }
      if(this.mcSubCmd.getType() == info.cmd)
      {
         this.mcSubCmd.Open(!this.mcSubCmd.isOpen());
         return undefined;
      }
      this.mcSubCmd.setTitle(info.cmd);
      this.mcSubCmd.setList(info.cmd,info.datas);
      this.mcSubCmd.Open(true);
   }
   function onUnloadFile(e)
   {
      debug.Log(e.type + ", " + e.keyName);
   }
   function onLoadFile(e)
   {
      debug.Log(e.type + ", " + e.keyName);
   }
   function onLoadError(e)
   {
      debug.Log(e.keyName + " : LoadError " + e.errorCode);
   }
   function useGlobalSystem(b)
   {
      gSystem.useDebugLog = b;
      if(b == true)
      {
         this.noAdvance = false;
         Stage.addListener(this);
         Key.addListener(this);
         this.onResize();
         return undefined;
      }
      this._visible = false;
      this.noAdvance = true;
      Stage.removeListener(this);
      Key.removeListener(this);
   }
   function onResize()
   {
      this._x = Stage.width - this.mcCmd._width;
      this._y = Stage.height - this.mcCmd._height - 100;
   }
   function onKeyDown()
   {
      if(gfx.controls.TextInput.IsFocus == true)
      {
         return undefined;
      }
      var _loc2_ = Key.getCode();
      if(_loc2_ == 192)
      {
         this._visible = !this._visible;
      }
   }
}
