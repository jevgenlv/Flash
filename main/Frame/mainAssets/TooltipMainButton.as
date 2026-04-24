class Frame.mainAssets.TooltipMainButton extends gfx.controls.Label
{
   var text;
   var txtKey;
   function TooltipMainButton()
   {
      super();
      this.txtKey.textAutoSize = "fit";
   }
   function setKeyTooltip(key, value)
   {
      if(key != undefined)
      {
         this.txtKey.text = key;
      }
      else
      {
         this.txtKey.text = "";
      }
      this.text = value;
   }
}
