class Common.Controls.MULabel extends gfx.controls.Label
{
   var hitTest;
   var textField;
   function MULabel()
   {
      super();
   }
   function onLoad()
   {
      super.onLoad();
   }
   function onUnload()
   {
      super.onUnload();
   }
   function onEnterFrame()
   {
      if(this.hitTest(_root._xmouse,_root._ymouse,false) == true)
      {
         if(this.textField.textWidth > this.textField._width)
         {
            this.textField.hscroll += 1;
         }
      }
      else
      {
         this.textField.hscroll = 0;
      }
   }
   function handleInput(details, pathToFocus)
   {
      if(details.code == 9 && Key.isDown(9))
      {
         return true;
      }
      super.handleInput(details,pathToFocus);
      return true;
   }
}
