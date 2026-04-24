class core.KeyWindow extends core.KeyMovieClip
{
   var _height;
   var _isCloseLock;
   var _isOpenWindow;
   var _keyName;
   var _visible;
   var _width;
   var _x;
   var _xscale;
   var _y;
   var _yscale;
   var btClose;
   var devText;
   var onEnterFrame;
   var onMouseDown;
   var txTitle;
   var _isDepthSwap = true;
   var _align = "center";
   function KeyWindow()
   {
      super();
      this._keyName = "keyWin";
      this._isCloseLock = false;
   }
   function updateDevText()
   {
      var _loc2_ = "win " + this._keyName + "\n";
      _loc2_ += "pos:" + this._x + ", " + this._y + "\n";
      _loc2_ += "size: " + this._width + ", " + this._height + "\n";
      _loc2_ += "align: " + this._align + " \n";
      this.devText.text = _loc2_;
   }
   function setCloseLock(isCloseLock)
   {
      this._isCloseLock = isCloseLock;
   }
   function get isCloseLock()
   {
      return this._isCloseLock;
   }
   function get isKeyWindow()
   {
      return true;
   }
   function onFileLoad()
   {
      super.onFileLoad();
      if(this.txTitle != undefined)
      {
         this.txTitle.textAutoSize = "shrink";
         this.txTitle.verticalAlign = "center";
      }
      if(this._isDepthSwap == true)
      {
         this.onMouseDown = function()
         {
            this.handleTopWindow();
         };
      }
      if(this.devText != undefined)
      {
         this.onEnterFrame = this.updateDevText;
      }
      if(this.btClose != undefined)
      {
         this.btClose.addEventListener("click",this,"closeWindow");
      }
      this.onResize();
      this.initPosition();
      Stage.addListener(this);
      this.onLoadEvents();
   }
   function onLoadEvents()
   {
      this.closeWindow();
      if(gSystem.isClient == false)
      {
         this.setDevMode();
      }
   }
   function setDevMode()
   {
   }
   function onUnload()
   {
      gSystem.WinMan.delKeyWindow(this._keyName);
      super.onUnload();
   }
   function initPosition()
   {
      this._y = Math.floor((Stage.height - this._height) / 3);
      switch(this._align)
      {
         case "left":
            this._x = 0;
            return;
         case "right":
            this._x = Math.floor(Stage.width - this._width);
            return;
         default:
            this._x = Math.floor((Stage.width - this._width) / 2);
            return;
      }
   }
   function onResize()
   {
      if(Stage.height < gStandard.ResizeStageHeight)
      {
         this._xscale = 83;
         this._yscale = 83;
      }
      else
      {
         this._xscale = 100;
         this._yscale = 100;
      }
   }
   function openWindow()
   {
      if(this._isOpenWindow == true)
      {
         return undefined;
      }
      this._isOpenWindow = true;
      this._visible = true;
      this.EventCall("onOpenWindow",this._isOpenWindow);
   }
   function closeWindow()
   {
      if(this._isOpenWindow == false)
      {
         return undefined;
      }
      this._isOpenWindow = false;
      this._visible = false;
      this.EventCall("onOpenWindow",this._isOpenWindow);
   }
   function handleTopWindow()
   {
      var _loc4_ = false;
      var _loc3_ = Mouse.getTopMostEntity(false);
      while(_loc3_ != null && _loc3_ != _root)
      {
         if(_loc3_ == this)
         {
            _loc4_ = true;
            break;
         }
         _loc3_ = _loc3_._parent;
      }
      if(_loc4_ == false)
      {
         return undefined;
      }
      gSystem.WinMan.setTopDepth(this.getKeyName());
   }
}
