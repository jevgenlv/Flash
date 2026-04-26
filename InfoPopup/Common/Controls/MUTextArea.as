class Common.Controls.MUTextArea extends gfx.controls.TextArea
{
   function MUTextArea()
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
