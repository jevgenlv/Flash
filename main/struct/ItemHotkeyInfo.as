class struct.ItemHotkeyInfo extends Object
{
   var InventoryIndex;
   var TooltipText;
   var itemCount;
   var itemLevel;
   var itemType;
   var renderH;
   var renderW;
   var renderX;
   var renderY;
   var selectGroup;
   var slot;
   function ItemHotkeyInfo()
   {
      super();
      this.TooltipText = "";
      this.slot = 0;
      this.selectGroup = 0;
      this.itemCount = 0;
      this.itemType = 0;
      this.itemLevel = 0;
      this.InventoryIndex = 0;
      this.renderX = 0;
      this.renderY = 0;
      this.renderW = 0;
      this.renderH = 0;
   }
}
