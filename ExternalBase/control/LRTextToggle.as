class control.LRTextToggle extends gfx.controls.ListItemRenderer
{
   var _check;
   var data;
   var label;
   function LRTextToggle()
   {
      super();
   }
   function setData(data)
   {
      super.setData(data);
      this.UpdateData();
   }
   function UpdateData()
   {
      if(this.data == undefined)
      {
         this.label = "";
         this._check._visible = false;
         return undefined;
      }
      if(this.data.text != undefined)
      {
         this.label = this.data.text;
      }
      else
      {
         this.label = this.data.member;
      }
      this._check._visible = this.data.value == true;
   }
}
