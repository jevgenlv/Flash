class control.ListRendererIn.LRbase extends gfx.controls.ListItemRenderer
{
   var _autoSize;
   var _disableConstraints;
   var _focused;
   var constraints;
   var focusIndicator;
   var focusTarget;
   var owner;
   var sizeIsInvalid;
   var textField;
   var updateAfterStateChange;
   function LRbase()
   {
      super();
   }
   function UpdateChildData()
   {
      trace("LRbase 상속받은 클래스는 이 함수를 재정의 해야 합니다.");
   }
   function configUI()
   {
      this.constraints = new gfx.utils.Constraints(this,true);
      if(!this._disableConstraints)
      {
         this.constraints.addElement(this.textField,gfx.utils.Constraints.ALL);
      }
      if(this._autoSize != "none")
      {
         this.sizeIsInvalid = true;
      }
      if(this.focusIndicator != null && !this._focused && this.focusIndicator._totalFrames == 1)
      {
         this.focusIndicator._visible = false;
      }
      this.updateAfterStateChange();
      this.focusTarget = this.owner;
   }
}
