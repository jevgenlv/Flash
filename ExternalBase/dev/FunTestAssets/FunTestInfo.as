class dev.FunTestAssets.FunTestInfo extends Object
{
   var _arrPram;
   var _callFunName;
   function FunTestInfo(funName, defaultPram)
   {
      super();
      this._callFunName = funName;
      this._arrPram = new Array();
      var _loc4_;
      switch(typeof defaultPram)
      {
         case "object":
            _loc4_ = 0;
            for(var _loc5_ in defaultPram)
            {
               this._arrPram.push({index:_loc4_,member:_loc5_,value:defaultPram[_loc5_]});
            }
            return;
         case "string":
         case "number":
         case "boolean":
            this._arrPram.push({index:0,member:typeof defaultPram,value:defaultPram});
            return;
         default:
            return;
      }
   }
}
