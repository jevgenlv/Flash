class Frame.ChatMC.ChatScrollingList extends gfx.controls.ScrollingList
{
   var renderers;
   function ChatScrollingList()
   {
      super();
   }
   function CheckMouseOver()
   {
      var _loc5_ = this.renderers.length;
      var _loc4_ = 0;
      var _loc3_;
      while(_loc4_ < _loc5_)
      {
         _loc3_ = this.renderers[_loc4_];
         if(_loc3_.hitTest(_root._xmouse,_root._ymouse) == true)
         {
            _loc3_.onMouseOver();
         }
         else
         {
            _loc3_.onMouseOut();
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function CheckMouseOut()
   {
      var _loc4_ = this.renderers.length;
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.renderers[_loc2_];
         _loc3_.onMouseOut();
         _loc2_ = _loc2_ + 1;
      }
   }
}
