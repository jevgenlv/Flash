class Frame.mainAssets.ItemHotKey extends gfx.controls.Button
{
   var _ItemInfo;
   var _icon;
   var _imgCount;
   var _slotIndex;
   function ItemHotKey()
   {
      super();
      this._imgCount.hitTestDisable = true;
   }
   function getTootipText()
   {
      return this._ItemInfo.TooltipText;
   }
   function isTooltip()
   {
      if(this._ItemInfo.TooltipText != undefined && this._ItemInfo.TooltipText != "")
      {
         return true;
      }
      return false;
   }
   function getSlotIndex()
   {
      return this._slotIndex;
   }
   function setSlotIndex(n)
   {
      this._slotIndex = n;
   }
   function getItemInfo()
   {
      return this._ItemInfo;
   }
   function setItemInfo(info)
   {
      if(info == undefined || info.selectGroup == 0)
      {
         this._icon._visible = false;
         this._imgCount._visible = false;
         this._ItemInfo = undefined;
         return undefined;
      }
      if(info.itemType != this._ItemInfo.itemType || info.itemLevel != this._ItemInfo.itemLevel)
      {
         this.DrawIcon(info);
      }
      if(info.itemCount != this._ItemInfo.itemCount)
      {
         this._imgCount.setData(info.itemCount);
      }
      this._imgCount._visible = true;
      this._icon._visible = true;
      this._ItemInfo = info;
   }
   function DrawIcon(info)
   {
      gSystem.Image.DrawRootImg(this._icon,enum.RootImage.MainFrameItem,info.renderX,info.renderY,info.renderW,info.renderH);
   }
}
