class Frame.mainAssets.RidePage extends MovieClip
{
   var _RideInfo;
   var _RideMain;
   var _RideOut;
   var _RideSub;
   var _delayMovieSize;
   var _delayStartTime;
   var _delayValueTime;
   var _mcRideDelay;
   function RidePage()
   {
      super();
   }
   function onLoad()
   {
      this._RideMain.data = "main";
      this._RideSub.data = "sub";
      this._RideOut.data = "out";
      this._mcRideDelay.hitTestDisable = true;
      this._delayMovieSize = this._mcRideDelay._height;
      this._mcRideDelay._height = 0;
      this._RideMain.addEventListener("click",this,"onRide");
      this._RideSub.addEventListener("click",this,"onRide");
      this._RideOut.addEventListener("click",this,"onRide");
   }
   function onRide(e)
   {
      if(e.comp.data == undefined)
      {
         return undefined;
      }
      var _loc1_ = String(e.comp.data);
      flash.external.ExternalInterface.call("main","ride",_loc1_);
   }
   function setRideInfo(info)
   {
      this._RideInfo = info;
      var _loc5_ = this._RideInfo.PetType;
      var _loc2_ = this._RideInfo.ButtonType;
      var _loc3_ = this._RideInfo.isRide;
      var _loc4_ = this._RideInfo.isDisable;
      if(_loc2_ == "non")
      {
         this._visible = false;
         return undefined;
      }
      this._visible = true;
      this.setDisable(_loc4_);
      if(_loc3_ == true)
      {
         this.setViewButton("out");
         return undefined;
      }
      this.setViewButton(_loc2_);
   }
   function setViewButton(name)
   {
      this._RideMain._visible = name == "main";
      this._RideSub._visible = name == "sub";
      this._RideOut._visible = name == "out";
   }
   function setDisable(b)
   {
      this._RideMain.disabled = b;
      this._RideSub.disabled = b;
      this._RideOut.disabled = b;
   }
   function startDelay(delayTime)
   {
      if(caurina.transitions.Tweener.isTweening(this._mcRideDelay) == true)
      {
         caurina.transitions.Tweener.removeAllTweens(this._mcRideDelay);
      }
      if(delayTime <= 0)
      {
         this._mcRideDelay._height = 0;
         return undefined;
      }
      this._delayValueTime = delayTime * 1000;
      this._delayStartTime = getTimer();
      this._mcRideDelay._height = this._delayMovieSize;
      caurina.transitions.Tweener.addTween(this._mcRideDelay,{_height:0,time:delayTime,transition:"linear"});
   }
   function resetDelay()
   {
      if(caurina.transitions.Tweener.isTweening(this._mcRideDelay) == true)
      {
         caurina.transitions.Tweener.removeAllTweens(this._mcRideDelay);
      }
      this._mcRideDelay._height = 0;
   }
}
