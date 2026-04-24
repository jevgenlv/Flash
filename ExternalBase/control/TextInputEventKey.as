class control.TextInputEventKey extends gfx.controls.TextInput
{
   var _arrEventKey;
   var dispatchEventAndSound;
   var focused;
   function TextInputEventKey()
   {
      super();
   }
   function configUI()
   {
      super.configUI();
      Key.addListener(this);
   }
   function onUnload()
   {
      Key.removeListener(this);
      super.onUnload();
   }
   function addEventKey(code)
   {
      if(this._arrEventKey == undefined)
      {
         this._arrEventKey = new Array();
      }
      this._arrEventKey.push(code);
   }
   function removeEventKeyAll()
   {
      if(this._arrEventKey != undefined)
      {
         this._arrEventKey.splice(0);
      }
   }
   function removeEventKey(code)
   {
      var _loc3_ = this._arrEventKey.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._arrEventKey[_loc2_] == code)
         {
            this._arrEventKey.splice(_loc2_,1);
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function onKeyDown()
   {
      if(this.focused == false)
      {
         return undefined;
      }
      if(this._arrEventKey == undefined)
      {
         return undefined;
      }
      if(this._arrEventKey.length == 0)
      {
         return undefined;
      }
      var _loc3_ = Key.getCode();
      var _loc5_ = this._arrEventKey.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         if(this._arrEventKey[_loc2_] == _loc3_)
         {
            this.dispatchEventAndSound({type:"KeyDown",code:_loc3_});
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
