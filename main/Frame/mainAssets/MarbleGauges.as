class Frame.mainAssets.MarbleGauges extends MovieClip
{
   var TextFieldName;
   var _BitmapSizeH;
   var _BitmapSizeW;
   var _Gauges;
   var _ValueHeight;
   var _bitmapName;
   var _maxValue;
   var _text;
   var _value;
   function MarbleGauges()
   {
      super();
      this._value = 0;
      this._ValueHeight = 0;
      this._maxValue = 100;
   }
   function onLoad()
   {
      this._BitmapSizeW = this._Gauges._width;
      this._BitmapSizeH = this._Gauges._height;
      if(this._parent[this.TextFieldName] != undefined)
      {
         this._text = this._parent[this.TextFieldName];
      }
   }
   function setBitmapName(bitName)
   {
      if(bitName == this._bitmapName)
      {
         return undefined;
      }
      this._bitmapName = bitName;
      var _loc2_ = this._value;
      this._value = -1;
      this._ValueHeight = -1;
      this.setValue(_loc2_,this._maxValue);
   }
   function setValue(value, maxValue)
   {
      if(this._value == value && this._maxValue == maxValue)
      {
         return undefined;
      }
      if(maxValue != undefined)
      {
         this._maxValue = maxValue;
      }
      this._value = value;
      if(this._text != undefined)
      {
         this._text.text = this._value + "/" + this._maxValue;
      }
      var bt = flash.display.BitmapData.loadBitmap(this._bitmapName);
      if(bt == undefined)
      {
         return undefined;
      }
      var step = bt.height / this._maxValue;
      var value = Math.floor(step * this._value);
      if(this._ValueHeight == value)
      {
         return undefined;
      }
      this._ValueHeight = value;
      if(this._ValueHeight == 0)
      {
         this._Gauges.clear();
         return undefined;
      }
      trace(this._name + " : " + bt.width + "," + bt.height + " == " + value);
      value = bt.height - value;
      if(value < 0)
      {
         value = 0;
      }
      with(this._Gauges)
      {
         clear();
         beginBitmapFill(bt);
         moveTo(0,value);
         lineTo(0,bt.height);
         lineTo(bt.width,bt.height);
         lineTo(bt.width,value);
         lineTo(0,value);
         endFill();
      }
   }
}
