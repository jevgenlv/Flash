function onLoad()
{
   trace("onLoad base swf");
   var _loc2_ = new Object();
   _loc2_.onResize = function()
   {
      trace("Stage onResize : " + Stage.width + " / " + Stage.height);
   };
   Stage.addListener(_loc2_);
   invalidationIntervalID = setInterval(this,"onLoadInterval",1);
}
function onLoadInterval()
{
   LoadBaseMovie("ExternalBase.swf",_root);
   flash.external.ExternalInterface.call("base","onLoad");
   clearInterval(invalidationIntervalID);
   delete invalidationIntervalID;
}
function LoadBaseMovie(url, container)
{
   trace("LoadBaseMovie " + url);
   var _loc2_ = new Object();
   _loc2_.onLoadError = function(target, errorCode, htpSaus)
   {
      trace("ERROR LoadBaseMovie" + target._name + " " + errorCode);
   };
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc2_);
   var _loc1_ = container.createEmptyMovieClip("base",container.getNextHighestDepth());
   _loc3_.loadClip(url,_loc1_);
   return _loc1_;
}
function ClearFocus()
{
   _root.base.setButtonFocus();
}
_global.gfxExtensions = true;
Stage.align = "TL";
Stage.scaleMode = "noScale";
Selection.disableFocusKeys = true;
var invalidationIntervalID;
