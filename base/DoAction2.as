function getBitmapName(exportName)
{
   var _loc1_ = flash.display.BitmapData.loadBitmap(exportName);
   if(_loc1_ == undefined)
   {
      trace("잘못된 이미지를 호출하려 합니다 : " + exportName);
      return undefined;
   }
   return _loc1_;
}
function getBitmap(imageNum)
{
   return getBitmapName("image" + imageNum);
}
