class Frame.mainAssets.RodGauges extends MovieClip
{
   var _data;
   var _dataMax;
   var _dataStep;
   var _maxValue;
   var _value;
   var mcValue;
   var startLeft;
   var txtValue;
   var _TweenTime = 0.2;
   function RodGauges()
   {
      super();
      this._dataStep = this.mcValue._width / 100;
      this._dataMax = this.mcValue._width;
      this._data = -1;
      this._value = 0;
      this._maxValue = 1;
   }
   function onLoad()
   {
      this.mcValue._width = 0;
   }
   function setValue(value, maxValue)
   {
      this._value = Number(value);
      this._maxValue = Number(maxValue);
      if(this._value < 0)
      {
         this._value = 0;
      }
      if(this._value > this._maxValue)
      {
         this._value = this._maxValue;
      }
      if(this._maxValue < 1)
      {
         this._maxValue = 1;
      }
      this.txtValue.text = this._value + " / " + this._maxValue;
      var _loc2_ = 100 / this._maxValue * this._value;
      this.setData(_loc2_);
   }
   function setData(per)
   {
      if(this._data == per)
      {
         return undefined;
      }
      if(per < 0)
      {
         per = 0;
      }
      else if(per > 100)
      {
         per = 100;
      }
      this._data = per;
      if(caurina.transitions.Tweener.isTweening(this.mcValue) == true)
      {
         caurina.transitions.Tweener.removeTweens(this.mcValue);
      }
      var _loc3_ = this._data * this._dataStep;
      var _loc4_;
      if(this.startLeft == true)
      {
         caurina.transitions.Tweener.addTween(this.mcValue,{time:this._TweenTime,_width:_loc3_});
      }
      else
      {
         _loc4_ = this._dataMax - _loc3_;
         caurina.transitions.Tweener.addTween(this.mcValue,{time:this._TweenTime,_x:_loc4_,_width:_loc3_});
      }
   }
}
