class Frame.mainAssets.ItemHotKeyPage extends MovieClip
{
   var _TestButton1;
   var _TestButton2;
   var _TestButton3;
   var _arrItemSlots;
   var _empty;
   var _imgCount;
   var _itemSlotE;
   var _itemSlotQ;
   var _itemSlotR;
   var _itemSlotW;
   var _text;
   function ItemHotKeyPage()
   {
      super();
   }
   function ItemSlots()
   {
   }
   function devFunTest(devFunTest)
   {
      devFunTest.setUIName("아이템 단축키");
      var _loc1_ = new struct.ItemHotkeyInfo();
      devFunTest.addFunInfo("setItemHotKey",_loc1_);
      devFunTest.addFunInfo("setTestNumber",0);
   }
   function setTestNumber(n)
   {
      this._imgCount.setData(n);
   }
   function onLoad()
   {
      this._arrItemSlots = new Array();
      this._arrItemSlots[0] = this._itemSlotQ;
      this._arrItemSlots[1] = this._itemSlotW;
      this._arrItemSlots[2] = this._itemSlotE;
      this._arrItemSlots[3] = this._itemSlotR;
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < 4)
      {
         _loc2_ = this._arrItemSlots[_loc3_];
         _loc2_.setSlotIndex(_loc3_);
         _loc2_.addEventListener("click",this,"onClickItemSlot");
         _loc2_.addEventListener("rollOver",this,"onOverItemSlot");
         _loc2_.addEventListener("rollOut",this,"onOutItemSlot");
         _loc2_.addEventListener("releaseOutside",this,"onOutItemSlot");
         _loc3_ = _loc3_ + 1;
      }
      if(this._TestButton1 != undefined)
      {
         this._TestButton1.addEventListener("click",this,"onTestBitmap1");
         this._TestButton2.addEventListener("click",this,"onTestBitmap2");
         this._TestButton3.addEventListener("click",this,"onTestBitmap3");
      }
   }
   function onClickItemSlot(e)
   {
      if(e.comp == undefined)
      {
         return undefined;
      }
      var _loc3_ = e.comp;
      switch(e.button)
      {
         case 0:
            this.EventCall("registItemHotKey",{slot:_loc3_.getSlotIndex(),info:_loc3_.getItemInfo()});
            break;
         case 1:
            this.EventCall("useItemHotKey",{slot:_loc3_.getSlotIndex(),info:_loc3_.getItemInfo()});
         default:
            return;
      }
   }
   function onOutItemSlot(e)
   {
      var _loc2_ = e.comp;
      this.EventCall("offItemTooltip",{slot:_loc2_.getSlotIndex()});
   }
   function onOverItemSlot(e)
   {
      if(e.comp == undefined)
      {
         return undefined;
      }
      var _loc3_ = e.comp;
      if(_loc3_.isTooltip() == true)
      {
         gSystem.Tooltip.SetText(_loc3_.getTootipText(),_loc3_);
      }
      var _loc2_ = {x:0,y:0};
      _loc3_.localToGlobal(_loc2_);
      this.EventCall("onItemTooltip",{slot:_loc3_.getSlotIndex(),x:_loc2_.x,y:_loc2_.y,w:_loc3_._icon._width,h:_loc3_._icon._height});
   }
   function setItemHotKeyAll(arrItemInfo)
   {
      var _loc5_ = arrItemInfo.length;
      var _loc2_ = 0;
      var _loc4_;
      var _loc3_;
      while(_loc2_ < _loc5_)
      {
         _loc4_ = this._arrItemSlots[_loc2_];
         _loc3_ = arrItemInfo[_loc2_];
         _loc4_.setItemInfo(_loc3_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function setItemHotKey(info)
   {
      var _loc2_ = this._arrItemSlots[info.slot];
      _loc2_.setItemInfo(info);
   }
   function EventCall(cmd, pram)
   {
      flash.external.ExternalInterface.call("main",cmd,pram);
   }
   function handleDragStart()
   {
      if(this._empty != undefined)
      {
         this._empty.startDrag(false);
      }
   }
   function handleDragStop()
   {
      if(this._empty != undefined)
      {
         this._empty.stopDrag();
      }
   }
   function onTestBitmap3(e)
   {
      if(this._empty != undefined)
      {
         this._empty.removeMovieClip();
         this._empty = null;
      }
      this._empty = this.createEmptyMovieClip("mc" + this.getNextHighestDepth(),this.getNextHighestDepth());
      this._empty.onPress = function()
      {
         this._parent.handleDragStart();
      };
      this._empty.onMouseUp = function()
      {
         this._parent.handleDragStop();
      };
      this._empty._y = 40;
      var bt = gSystem.Image.getRootBitmap(0);
      this._text.text = "w:" + bt.width + ", h:" + bt.height;
      var x = 0;
      var y = 0;
      var w = bt.width;
      var h = bt.height;
      var mat = new flash.geom.Matrix();
      mat.identity();
      mat.scale(1,-1);
      with(this._empty)
      {
         _x = - x;
         _y = - y;
         beginBitmapFill(bt,mat);
         moveTo(x,y);
         lineTo(x,y + h);
         lineTo(x + w,y + h);
         lineTo(x + w,y);
         lineTo(x,y);
         endFill();
      }
   }
   function onTestBitmap1(e)
   {
      if(this._empty != undefined)
      {
         this._empty.removeMovieClip();
         this._empty = null;
      }
      this._empty = this.createEmptyMovieClip("mc" + this.getNextHighestDepth(),this.getNextHighestDepth());
      this._empty.onPress = function()
      {
         this._parent.handleDragStart();
      };
      this._empty.onMouseUp = function()
      {
         this._parent.handleDragStop();
      };
      this._empty._y = 40;
      var bt = gSystem.Image.getRootBitmap(0);
      this._text.text = "w:" + bt.width + ", h:" + bt.height;
      var x = 0;
      var y = 0;
      var w = 100;
      var h = 100;
      var mat = new flash.geom.Matrix();
      mat.identity();
      mat.scale(1,-1);
      with(this._empty)
      {
         _x = - x;
         _y = - y;
         beginBitmapFill(bt,mat,true,true);
         moveTo(x,y);
         lineTo(x,y + h);
         lineTo(x + w,y + h);
         lineTo(x + w,y);
         lineTo(x,y);
         endFill();
      }
   }
   function onTestBitmap2(e)
   {
      this._text.text = "";
      if(this._empty != undefined)
      {
         this._empty.removeMovieClip();
         this._empty = null;
      }
   }
}
