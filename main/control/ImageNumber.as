class control.ImageNumber extends MovieClip
{
   var _overNumber;
   var arrNumberMC;
   function ImageNumber()
   {
      super();
      this.arrNumberMC = new Array();
      var _loc4_ = "_n1";
      var _loc3_ = this[_loc4_];
      var _loc5_ = 0;
      this._overNumber = 1;
      while(_loc3_ != undefined)
      {
         this.arrNumberMC.push(_loc3_);
         this._overNumber *= 10;
         _loc5_ = _loc5_ + 1;
         _loc4_ += "0";
         _loc3_ = this[_loc4_];
      }
   }
   function onLoad()
   {
      this.clearAll();
   }
   function setData(n)
   {
      if(n == undefined || n == NaN)
      {
         this.clearAll();
         return undefined;
      }
      if(this._overNumber <= n)
      {
         this.setMaxDisplay();
         return undefined;
      }
      var _loc6_ = this.arrNumberMC.length;
      var _loc7_ = 10;
      var _loc4_ = Number(n);
      trace("setData " + n);
      var _loc2_ = 0;
      var _loc3_;
      var _loc5_;
      while(_loc2_ < _loc6_)
      {
         _loc3_ = _loc4_ % _loc7_;
         _loc4_ -= _loc3_;
         _loc4_ /= 10;
         trace("i : " + _loc2_ + "frame" + _loc3_ + "    " + _loc4_);
         _loc5_ = this.arrNumberMC[_loc2_];
         if(_loc3_ == 0 && _loc4_ == 0 && _loc2_ != 0)
         {
            _loc5_._visible = false;
         }
         else
         {
            _loc5_.gotoAndStop(_loc3_ + 1);
            _loc5_._visible = true;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function setMaxDisplay()
   {
      var _loc4_ = this.arrNumberMC.length;
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.arrNumberMC[_loc2_];
         _loc3_.gotoAndStop(11);
         _loc3_._visible = true;
         _loc2_ = _loc2_ + 1;
      }
   }
   function clearAll()
   {
      var _loc4_ = this.arrNumberMC.length;
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.arrNumberMC[_loc2_];
         _loc3_._visible = false;
         _loc2_ = _loc2_ + 1;
      }
   }
}
