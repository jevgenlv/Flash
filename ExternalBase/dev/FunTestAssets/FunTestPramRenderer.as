class dev.FunTestAssets.FunTestPramRenderer extends control.ListRendererIn.LRbase
{
   var _visible;
   var checkPram;
   var data;
   var dispatchEventAndSound;
   var txtMember;
   var txtPram;
   function FunTestPramRenderer()
   {
      super();
   }
   function configUI()
   {
      super.configUI();
      this.txtPram.addEventListener("textChange",this,"onPramTextChange");
      this.checkPram.addEventListener("select",this,"onBooleanChange");
   }
   function onPramTextChange(e)
   {
      if(this.data.value == this.txtPram.text)
      {
         return undefined;
      }
      this.data.value = this.txtPram.text;
      this.dispatchEventAndSound({type:"changePram"});
   }
   function onBooleanChange(e)
   {
      if(this.data.value == this.checkPram.selected)
      {
         return undefined;
      }
      this.data.value = this.checkPram.selected;
      this.dispatchEventAndSound({type:"changePram"});
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
      this.txtMember.text = this.data.member;
      switch(typeof this.data.value)
      {
         case "string":
         case "number":
            this.checkPram._visible = false;
            this.txtPram._visible = true;
            this.txtPram.text = this.data.value;
            return;
         case "boolean":
            this.checkPram._visible = true;
            this.txtPram._visible = false;
            this.checkPram.selected = this.data.value;
            return;
         default:
            trace("data : " + typeof this.data.value);
            return;
      }
   }
}
