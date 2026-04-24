class Frame.TopMenuMC.FreeChannelList extends core.KeyWindow
{
   var CurrentButton;
   var Data;
   var FixedTextInfo;
   var GreenBtn;
   var ListInfo;
   var RedBtn;
   var ServerList;
   var _parent;
   var iListCount;
   var list;
   function FreeChannelList()
   {
      super();
      this.ServerList = this.list.ServerList;
      this.list._visible = false;
      this.FixedTextInfo = {channelName:String("")};
   }
   function onLoad()
   {
      super.onLoad();
      this.Init();
   }
   function Init()
   {
      if(undefined != this.ServerList)
      {
         this.ServerList.addEventListener("itemClick",this,"OnListEvent");
         this.ServerList.addEventListener("itemRollOver",this,"OnListEvent");
         this.ServerList.addEventListener("itemRollOut",this,"OnListEvent");
      }
      this.RedBtn.addEventListener("click",this,"OnClickUpdateButton");
      this.GreenBtn.addEventListener("click",this,"OnClickUpdateButton");
   }
   function InitFixedData(info)
   {
      this.FixedTextInfo.channelName = info.channelName;
   }
   function InitServerList(DataInfo)
   {
      if(null == DataInfo || DataInfo.length <= 0)
      {
         this.iListCount = 0;
         this.SetButtonValue(undefined);
         this.ClearList();
         return undefined;
      }
      this.ClearList();
      this.iListCount = DataInfo.length;
      this.ListInfo = new Array(this.iListCount);
      var _loc3_ = 0;
      var _loc2_;
      var _loc4_;
      var _loc5_;
      while(_loc3_ < this.iListCount)
      {
         _loc2_ = new struct.FreeChannelListInfo();
         _loc4_ = _loc2_.InitServerList(DataInfo[_loc3_]);
         _loc5_ = {Label1:String(this.FixedTextInfo.channelName + " " + _loc2_.ServerNum),Label2:String(_loc4_),IsDisable:Boolean(_loc2_.bIsDisable),ChannelNum:Object(_loc2_.ServerNum),mclist:struct.FreeChannelListInfo(_loc2_)};
         this.Data.push(_loc5_);
         if(_loc2_.bIsCurrentChannel)
         {
            this.SetButtonValue(_loc2_);
         }
         this.ListInfo[_loc3_] = _loc2_;
         _loc3_ = _loc3_ + 1;
      }
      this.ServerList.dataProvider = this.Data;
      this.ServerList.invalidate();
      this._parent.UpdateIsOpenChannelList();
   }
   function ClearList()
   {
      this.Data = new gfx.data.DataProvider();
      this.ServerList.dataProvider = this.Data;
      this.ServerList.invalidate();
   }
   function SetButtonValue(info)
   {
      if(undefined == info)
      {
         this.GreenBtn.disabled = true;
         this.GreenBtn.visible = false;
         this.RedBtn.disabled = true;
         this.RedBtn.visible = false;
         if(undefined != this.CurrentButton)
         {
            this.CurrentButton.disabled = true;
            this.CurrentButton.visible = false;
         }
         return undefined;
      }
      var _loc2_;
      if(true == info.IsNonPkServer())
      {
         this.GreenBtn.disabled = false;
         this.GreenBtn.visible = true;
         this.RedBtn.disabled = true;
         this.RedBtn.visible = false;
         this.CurrentButton = this.GreenBtn;
         _loc2_ = 40192;
      }
      else
      {
         this.GreenBtn.disabled = true;
         this.GreenBtn.visible = false;
         this.RedBtn.disabled = false;
         this.RedBtn.visible = true;
         this.CurrentButton = this.RedBtn;
         _loc2_ = 10289152;
      }
      var _loc3_;
      if(undefined != this.CurrentButton)
      {
         _loc3_ = this.CurrentButton.Title;
         _loc3_.textField.text = this.FixedTextInfo.channelName + " " + info.ServerNum;
         _loc3_.textField.textColor = _loc2_;
         this.CurrentButton.gotoAndPlay("disabled");
      }
   }
   function OnClickList(event)
   {
      if(this.ServerList.selectedIndex >= this.iListCount)
      {
         return undefined;
      }
      if(this.ServerList.selectedIndex < 0)
      {
         return undefined;
      }
      this.list._visible = false;
      var _loc2_;
      if(false == this.OnDisableFunction(event,event.index))
      {
         _loc2_ = new Object();
         _loc2_.select_index = this.ServerList.selectedIndex;
         this._parent.OnClickList(_loc2_);
      }
   }
   function OnClickUpdateButton(event)
   {
      this.list._visible != true ? (this.list._visible = true) : (this.list._visible = false);
      this._parent.OnClickUpdateButton();
   }
   function OnDisableFunction(event, index)
   {
      var _loc2_ = event.target.getRendererAt(index);
      if(this.ListInfo[index].IsCurrentChannel())
      {
         if(true == _loc2_._visible)
         {
            Frame.TopMenuMC.FreeChannelList_ItemRenderer(_loc2_).setCurrent();
            return true;
         }
      }
      else if(true == this.ListInfo[index].IsDisableListInfo())
      {
         if(true == _loc2_._visible)
         {
            Frame.TopMenuMC.FreeChannelList_ItemRenderer(_loc2_).setDisable();
            return true;
         }
      }
      return false;
   }
   function OnListEvent(event)
   {
      var _loc3_ = event.index;
      if(_loc3_ >= this.iListCount)
      {
         return undefined;
      }
      if(_loc3_ < 0)
      {
         return undefined;
      }
      var _loc6_ = this.ListInfo[_loc3_].GetTooltip();
      this.OnDisableFunction(event,_loc3_);
      var _loc4_;
      var _loc5_;
      switch(event.type)
      {
         case "itemRollOver":
            _loc4_ = event.target.getRendererAt(_loc3_);
            _loc5_ = new Object();
            _loc5_.x = event.target._parent._parent._x + event.target._x + _loc4_._x;
            _loc5_.y = event.target._parent._parent._y + event.target._y + _loc4_._y;
            _loc5_.w = event.target._parent._parent._width + event.target._width + _loc4_._width;
            _loc5_.tooltip = _loc6_;
            this._parent.OnMouseOverList(_loc5_);
            break;
         case "itemRollOut":
            this._parent.OnMouseOutList();
            break;
         case "itemClick":
            this.list._visible = false;
            _loc5_ = new Object();
            _loc5_.select_index = this.ServerList.selectedIndex;
            this._parent.OnClickList(_loc5_);
         default:
            return;
      }
   }
   function DisableBtn_whileMovingChannel()
   {
      if(undefined == this.CurrentButton)
      {
         return undefined;
      }
      this.list._visible = false;
      this.CurrentButton.gotoAndPlay("disabled_15sec");
   }
   function DisableBtn_ForTheMoment()
   {
      if(undefined == this.CurrentButton)
      {
         return undefined;
      }
      this.list._visible = false;
      this.CurrentButton.gotoAndPlay("disabled");
   }
   function CallUpdateClient()
   {
      this._parent.CallUpdateClient();
   }
   function onClose()
   {
      this.list._visible = false;
      if(undefined == this.CurrentButton)
      {
         return undefined;
      }
      this.CurrentButton.gotoAndPlay("disabled");
      this._parent.UpdateIsOpenChannelList();
   }
   function Test()
   {
      var _loc4_ = random(50);
      trace(_loc4_);
      if(_loc4_ <= 0)
      {
         _loc4_ = 1;
      }
      var _loc5_ = new Array(_loc4_);
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < _loc4_)
      {
         _loc2_ = new Object();
         _loc2_.server_name = "가이온";
         _loc2_.server_number = _loc3_;
         _loc2_.is_gold_server = false;
         if(_loc3_ == 23)
         {
            _loc2_.CurrentChannel = true;
         }
         if(_loc3_ % 2 == 0)
         {
            _loc2_.is_pk_server = 0;
         }
         else
         {
            _loc2_.is_pk_server = 1;
         }
         if(_loc3_ == 9 || _loc3_ == 5 || _loc3_ == 28)
         {
            _loc2_.disable = true;
         }
         else
         {
            _loc2_.disable = false;
         }
         _loc2_.tooltip_msg = _loc2_.server_name + _loc2_.server_number;
         _loc5_[_loc3_] = _loc2_;
         _loc3_ = _loc3_ + 1;
      }
      this.InitServerList(_loc5_);
   }
}
