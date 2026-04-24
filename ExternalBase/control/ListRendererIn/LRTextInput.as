class control.ListRendererIn.LRTextInput extends gfx.controls.TextInput
{
   var _parent;
   function LRTextInput()
   {
      super();
   }
   function configUI()
   {
      super.configUI();
      this._parent.UpdateChildData();
   }
}
