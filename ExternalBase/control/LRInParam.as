class control.LRInParam extends control.ListRendererIn.LRbase
{
   var _button;
   var _visible;
   var cbPram;
   var data;
   var txtMember;
   var txtPram;
   function LRInParam()
   {
      super();
   }
   function configUI()
   {
      super.configUI();
      this.txtPram.addEventListener("textChange",this,"onPramTextChange");
      this.cbPram.addEventListener("select",this,"onParamBooleanChange");
   }
   function onPramTextChange(e)
   {
      this.data.value = this.txtPram.text;
   }
   function onParamBooleanChange(e)
   {
      this.data.value = this.cbPram.selected;
   }
   function setData(data)
   {
      super.setData(data);
      this.UpdateChildData();
   }
   function UpdateChildData()
   {
      if(this.data == undefined)
      {
         this._visible = false;
         return undefined;
      }
      this._visible = true;
      if(this.data.text != undefined)
      {
         this._button.label = this.data.text;
      }
      this.txtMember.text = this.data.member;
      var _loc2_ = typeof this.data.value;
      switch(_loc2_)
      {
         case "boolean":
            this.txtPram._visible = false;
            this.cbPram._visible = true;
            this.cbPram.selected = this.data.value;
            return;
         case "number":
            this.txtPram._visible = true;
            this.cbPram._visible = false;
            this.txtPram.text = this.data.value;
            return;
         case "string":
         default:
            this.txtPram._visible = true;
            this.cbPram._visible = false;
            this.txtPram.text = this.data.value;
            return;
      }
   }
}
