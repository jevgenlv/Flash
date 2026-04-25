class Frame.ChatMC.ChatViewScroll extends gfx.controls.ScrollBar
{
   var __height;
   var __width;
   var _disabled;
   var _position;
   var _scrollTarget;
   var constraints;
   var direction;
   var downArrow;
   var initialized;
   var invalidate;
   var maxPosition;
   var minPosition;
   var offsetBottom;
   var offsetTop;
   var pageSize;
   var setScrollProperties;
   var thumb;
   var track;
   var upArrow;
   function ChatViewScroll()
   {
      super();
   }
   function draw()
   {
      if(this.direction == "horizontal")
      {
         this.constraints.update(this.__height,this.__width);
      }
      else
      {
         this.constraints.update(this.__width,this.__height);
      }
      this.track.validateNow();
      if(this._scrollTarget instanceof TextField)
      {
         this.setScrollProperties(this._scrollTarget.bottomScroll - this._scrollTarget.scroll,1,this._scrollTarget.maxscroll);
      }
      else
      {
         this.updateThumb();
      }
   }
   function updateThumb()
   {
      if(!this.initialized)
      {
         this.invalidate();
         return undefined;
      }
      if(this._disabled)
      {
         return undefined;
      }
      var _loc5_ = Math.max(1,this.maxPosition - this.minPosition + this.pageSize);
      var _loc4_ = this.track.height + this.offsetTop + this.offsetBottom;
      var _loc6_ = _loc4_;
      this.thumb.height = Math.max(10,Math.min(_loc4_,this.pageSize / _loc5_ * _loc6_));
      this.thumb.validateNow();
      var _loc2_ = (this._position - this.minPosition) / (this.maxPosition - this.minPosition);
      var _loc3_ = this.track._y - this.offsetTop;
      var _loc7_ = _loc2_ * this.availableHeight + _loc3_;
      this.thumb._y = Math.max(_loc3_,Math.min(this.track._y + this.track.height - this.thumb.height + this.offsetBottom,_loc7_));
      this.thumb.visible = !(isNaN(_loc2_) || this.maxPosition <= 0 || this.maxPosition == Infinity);
      if(this.thumb.visible)
      {
         this.track.disabled = false;
         if(this.upArrow)
         {
            if(this._position == this.minPosition)
            {
               this.upArrow.disabled = true;
            }
            else
            {
               this.upArrow.disabled = false;
            }
         }
         if(this.downArrow)
         {
            if(this._position == this.maxPosition)
            {
               this.downArrow.disabled = true;
            }
            else
            {
               this.downArrow.disabled = false;
            }
         }
      }
      else
      {
         if(this.upArrow)
         {
            this.upArrow.disabled = true;
         }
         if(this.downArrow)
         {
            this.downArrow.disabled = true;
         }
         this.track.disabled = true;
      }
   }
}
