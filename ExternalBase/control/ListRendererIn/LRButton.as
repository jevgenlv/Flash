class control.ListRendererIn.LRButton extends gfx.controls.Button
{
   var _parent;
   var addEventListener;
   function LRButton()
   {
      super();
   }
   function configUI()
   {
      super.configUI();
      this.addEventListener("click",this._parent,"handleMouseRelease");
      this.addEventListener("press",this._parent,"handleMousePress");
      this.addEventListener("rollOver",this._parent,"handleMouseRollOver");
      this.addEventListener("rollOut",this._parent,"handleMouseRollOut");
   }
}
