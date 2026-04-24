class Frame.mainAssets.LRSubMenu extends gfx.controls.ListItemRenderer
{
   var _label;
   var constraints;
   var data;
   var dispatchEvent;
   var height;
   var initialized;
   var state;
   var textField;
   var txtKey;
   var validateNow;
   var width;
   function LRSubMenu()
   {
      super();
   }
   function setData(data)
   {
      super.setData(data);
      this.updateData();
   }
   function updateData()
   {
      this.textField.textAutoSize = "shrink";
      this.txtKey.textAutoSize = "shrink";
      this.textField.verticalAlign = "center";
      this.txtKey.verticalAlign = "center";
      this.txtKey.text = this.data.key;
      this.textField.text = this.data.label;
   }
   function updateAfterStateChange()
   {
      if(!this.initialized)
      {
         return undefined;
      }
      if(this.textField != null && this._label != null)
      {
         this.updateData();
      }
      this.validateNow();
      if(this.constraints != null)
      {
         this.constraints.update(this.width,this.height);
      }
      this.dispatchEvent({type:"stateChange",state:this.state});
   }
}
