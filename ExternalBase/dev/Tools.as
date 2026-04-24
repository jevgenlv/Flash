class dev.Tools extends MovieClip
{
   function Tools()
   {
      super();
   }
   function onLoad()
   {
      if(gSystem.useDevMode == false)
      {
         return undefined;
      }
   }
}
