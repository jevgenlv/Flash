class Frame.ChatMC.ChatListItemRenderer extends gfx.controls.ListItemRenderer
{
   var __height;
   var __width;
   var _label;
   var _maskText;
   var autoSize;
   var constraints;
   var data;
   var dispatchEvent;
   var height;
   var initialized;
   var sizeIsInvalid;
   var state;
   var textField;
   var validateNow;
   var width;
   function ChatListItemRenderer()
   {
      super();
      this._maskText._visible = false;
   }
   function set label(value)
   {
      this._label = value;
      if(this.initialized)
      {
         if(this.textField != null)
         {
            this.updateData();
         }
         if(this.autoSize != "none")
         {
            this.sizeIsInvalid = true;
         }
         this.updateAfterStateChange();
      }
   }
   function setSize(width, height)
   {
      super.setSize(width,height);
   }
   function setData(data)
   {
      super.setData(data);
      this.updateData();
   }
   function updateData()
   {
      this.textField.textAutoSize = "none";
      this.textField.html = true;
      if(this.data == undefined)
      {
         this.textField.htmlText = "";
         return undefined;
      }
      this.textField.htmlText = this.data.label;
      if(this.constraints != null)
      {
         this.constraints.update(this.__width,this.__height);
      }
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
      if(this._maskText._init != true)
      {
         return undefined;
      }
      switch(this.state)
      {
         case "over":
         case "down":
         case "release":
            this.onMouseOver();
            return;
         default:
            this.onMouseOut();
            return;
      }
   }
   function onMouseOver()
   {
      if(this._maskText.openMaskText(this.textField) == true)
      {
         this.textField._visible = false;
         return undefined;
      }
      this.textField._visible = true;
   }
   function onMouseOut()
   {
      this.textField._visible = true;
      this._maskText.closeMaskText();
   }
}
