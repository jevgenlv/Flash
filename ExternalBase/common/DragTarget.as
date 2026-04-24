class common.DragTarget extends MovieClip
{
   var _controlWindow;
   var onMouseUp;
   var onPress;
   var m_bDragStart = false;
   function DragTarget()
   {
      super();
   }
   function onLoad()
   {
      this.tabEnabled = this.focusEnabled = false;
      this._controlWindow = this._parent;
      if(this._controlWindow != undefined)
      {
         this.onPress = function()
         {
            this.handleDragStart();
         };
         this.onMouseUp = function()
         {
            this.handleDragStop();
         };
      }
      this.m_bDragStart = false;
   }
   function IsDragStarted()
   {
      return this.m_bDragStart;
   }
   function handleDragStart()
   {
      this.m_bDragStart = true;
      if(this._controlWindow.getDragheight == undefined)
      {
         this._controlWindow.startDrag(false,0,0,Stage.width - this._controlWindow._width,Stage.height - this._controlWindow._height);
         return undefined;
      }
      this._controlWindow.startDrag(false,0,0,Stage.width - this._controlWindow._width,Stage.height - this._controlWindow.getDragheight());
      return undefined;
   }
   function handleDragStop()
   {
      this._controlWindow.stopDrag();
      this.m_bDragStart = false;
   }
}
