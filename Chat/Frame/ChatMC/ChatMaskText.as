class Frame.ChatMC.ChatMaskText extends MovieClip
{
   var _mask;
   var _maskText;
   var _text;
   var _init = false;
   function ChatMaskText()
   {
      super();
      this._maskText.textAutoSize = "none";
      this._maskText.html = true;
      this._maskText.autoSize = true;
      this._maskText.htmlText = "";
   }
   function onLoad()
   {
      this.updateText();
      this._init = true;
   }
   function updateText(textField)
   {
      if(textField == undefined)
      {
         return false;
      }
      if(this._text == textField.htmlText)
      {
         return false;
      }
      this._text = textField.htmlText;
      this._maskText.htmlText = "";
      this._maskText._xscale = textField._xscale;
      this._maskText._yscale = textField._yscale;
      this._mask._xscale = textField._xscale;
      this._mask._yscale = textField._yscale;
      this._mask._x = 0;
      this._mask._width = textField._width;
      this._mask._height = textField._height;
      this._maskText._x = 0;
      this._maskText._y = 0;
      this._maskText._width = 10;
      this._maskText.htmlText = textField.htmlText;
      return true;
   }
   function closeMaskText()
   {
      if(caurina.transitions.Tweener.isTweening(this._maskText) == true)
      {
         caurina.transitions.Tweener.removeTweens(this._maskText);
      }
      this._visible = false;
   }
   function openMaskText(textField)
   {
      var _loc6_ = this.updateText(textField);
      var _loc2_ = this._maskText._width > textField._width + 1;
      if(_loc2_ == false)
      {
         if(this._visible == true)
         {
            this.closeMaskText();
         }
         return false;
      }
      if(_loc2_ == true && this._visible == true && _loc6_ == false)
      {
         return true;
      }
      this._visible = true;
      if(caurina.transitions.Tweener.isTweening(this._maskText) == true)
      {
         caurina.transitions.Tweener.removeTweens(this._maskText);
      }
      this._maskText._x = 0;
      var _loc3_ = this._maskText._width - textField._width;
      var _loc5_ = 0.08 * _loc3_;
      caurina.transitions.Tweener.addTween(this._maskText,{_x:- _loc3_,time:_loc5_,transition:"linear"});
      return true;
   }
}
