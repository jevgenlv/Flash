class Frame.TopMenuMC.FreeChannelList_ItemRenderer extends gfx.controls.ListItemRenderer
{
   var IsDisable;
   var Label1;
   var Label2;
   var _selected;
   var disabled;
   var gotoAndPlay;
   var selected;
   var visible;
   function FreeChannelList_ItemRenderer()
   {
      super();
      this.Label1.textField.text = "";
      this.Label2.textField.text = "";
   }
   function setDisable()
   {
      this.gotoAndPlay("disabled");
      this.Label1.textField.textColor = 8421245;
   }
   function setCurrent()
   {
      if(true == this._selected)
      {
         this.gotoAndPlay("selected_disabled");
      }
   }
   function setData(data)
   {
      super();
      this.disabled = false;
      if(undefined == data.Label1 || undefined == data.Label2 || undefined == data.IsDisable || undefined == data.mclist || undefined == data.ChannelNum)
      {
         this.visible = false;
         this.Label1.textField.text = undefined;
         this.Label2.textField.text = undefined;
         this.IsDisable = true;
         return undefined;
      }
      this.visible = true;
      this.Label1.textField.text = data.Label1;
      this.Label2.textField.text = data.Label2;
      this.IsDisable = data.IsDisable;
      this.gotoAndPlay("up");
      if(data.mclist.IsNonPkServer())
      {
         this.Label1.textField.textColor = 45056;
      }
      else
      {
         this.Label1.textField.textColor = 11534336;
      }
      if(true == data.mclist.IsCurrentChannel())
      {
         this.selected = true;
         this.setCurrent();
      }
      else if(data.mclist.IsDisableListInfo())
      {
         this.selected = false;
         this.setDisable();
      }
   }
}
