class common.KeyManager extends core.EventMovieClip
{
   var _arrKeyState;
   var onEvent;
   var KEY_STATE_UP = 0;
   var KEY_STATE_PRESS = 1;
   function KeyManager()
   {
      super();
   }
   function onLoad()
   {
      this._arrKeyState = new Array();
      Key.addListener(this);
   }
   function onKeyDown()
   {
      var _loc2_ = Key.getCode();
      if(this._arrKeyState[_loc2_] != this.KEY_STATE_PRESS)
      {
         this._arrKeyState[_loc2_] = this.KEY_STATE_PRESS;
         this.onEvent({type:"keyDownOne",code:_loc2_});
      }
   }
   function onKeyUp()
   {
      var _loc2_ = Key.getCode();
      this._arrKeyState[_loc2_] = this.KEY_STATE_UP;
      this.onEvent({type:"keyUp",code:_loc2_});
   }
}
