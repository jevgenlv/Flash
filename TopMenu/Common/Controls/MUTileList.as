class Common.Controls.MUTileList extends Common.Controls.MUCoreList
{
   var __height;
   var __width;
   var _columnCount;
   var _columnWidth;
   var _dataProvider;
   var _disabled;
   var _focused;
   var _height;
   var _name;
   var _parent;
   var _rowCount;
   var _rowHeight;
   var _scrollBar;
   var _width;
   var _xscale;
   var _yscale;
   var container;
   var focusEnabled;
   var gotoAndPlay;
   var initialized;
   var inspectableScrollBar;
   var invalidate;
   var renderers;
   var setSize;
   var sizeIsInvalid;
   var tabEnabled;
   var wrapping = "normal";
   var autoRowCount = false;
   var _direction = "horizontal";
   var _scrollPosition = 0;
   var totalRows = 0;
   var totalColumns = 0;
   var autoScrollBar = false;
   var externalColumnCount = 0;
   var margin = 1;
   var spaceX = 0;
   var spaceY = 0;
   function MUTileList()
   {
      super();
   }
   function get scrollBar()
   {
      return this._scrollBar;
   }
   function set scrollBar(value)
   {
      if(!this.initialized)
      {
         this.inspectableScrollBar = value;
         return;
      }
      if(this._scrollBar != null)
      {
         this._scrollBar.removeEventListener("scroll",this,"handleScroll");
         this._scrollBar.removeEventListener("change",this,"handleScroll");
         this._scrollBar.focusTarget = null;
         if(this.autoScrollBar)
         {
            this._scrollBar.removeMovieClip();
         }
      }
      this.autoScrollBar = false;
      if(typeof value == "string")
      {
         this._scrollBar = MovieClip(this._parent[value.toString()]);
         if(this._scrollBar == null)
         {
            this._scrollBar = this.container.attachMovie(value.toString(),"_scrollBar",1000);
            if(this._scrollBar != null)
            {
               this.autoScrollBar = true;
            }
         }
      }
      else
      {
         this._scrollBar = MovieClip(value);
      }
      this.invalidate();
      if(this._scrollBar == null)
      {
         return;
      }
      if(this._scrollBar.setScrollProperties != null)
      {
         this._scrollBar.addEventListener("scroll",this,"handleScroll");
      }
      else
      {
         this._scrollBar.addEventListener("change",this,"handleScroll");
      }
      this._scrollBar.focusTarget = this;
      this._scrollBar.tabEnabled = false;
      this.drawScrollBar();
      this.updateScrollBar();
   }
   function get rowHeight()
   {
      return this._rowHeight;
   }
   function set rowHeight(value)
   {
      if(value == 0)
      {
         value = null;
         return;
      }
      this._rowHeight = value;
      this.invalidate();
   }
   function get columnWidth()
   {
      return this._columnWidth;
   }
   function set columnWidth(value)
   {
      if(value == 0)
      {
         value = null;
         return;
      }
      this._columnWidth = value;
      this.invalidate();
   }
   function get rowCount()
   {
      return this.totalRows;
   }
   function set rowCount(value)
   {
      this._rowCount = !this.autoRowCount ? value : Math.ceil(value / this.totalColumns);
      var _loc2_ = this._rowHeight;
      var _loc4_;
      if(_loc2_ == null)
      {
         _loc4_ = this.renderers[0];
         _loc2_ = _loc4_.height;
      }
      var _loc3_ = this.spaceY * (this._rowCount - 1);
      if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      this.setSize(this.__width,_loc2_ * this._rowCount + this.margin * 2 + _loc3_);
   }
   function get columnCount()
   {
      return this.totalColumns;
   }
   function set columnCount(value)
   {
      this._columnCount = value;
      var _loc3_ = this._columnWidth;
      var _loc4_;
      if(_loc3_ == null)
      {
         _loc4_ = this.renderers[0];
         _loc3_ = _loc4_.width;
      }
      var _loc2_ = this.spaceX * (this._columnCount - 1);
      if(_loc2_ < 0)
      {
         _loc2_ = 0;
      }
      this.setSize(_loc3_ * this._columnCount + this.margin * 2 + _loc2_,this.__height);
   }
   function get direction()
   {
      return this._direction;
   }
   function set direction(value)
   {
      if(value == this._direction)
      {
         return;
      }
      this._direction = value;
      this.invalidate();
   }
   function get disabled()
   {
      return this._disabled;
   }
   function set disabled(value)
   {
      super.disabled = value;
      if(this.initialized)
      {
         this.setState();
      }
   }
   function get selectedIndex()
   {
      return this._selectedIndex;
   }
   function set selectedIndex(value)
   {
      var _loc3_ = this.getRendererAt(this._selectedIndex);
      if(_loc3_ != null)
      {
         _loc3_.selected = false;
      }
      super.selectedIndex = value;
      _loc3_ = this.getRendererAt(this._selectedIndex);
      if(this.totalRows * this.totalColumns == 0)
      {
         return;
      }
      if(_loc3_ != null)
      {
         _loc3_.selected = true;
      }
      else
      {
         this.scrollToIndex(this._selectedIndex);
         this.getRendererAt(this._selectedIndex).displayFocus = true;
      }
   }
   function scrollToIndex(index)
   {
      var _loc2_ = this._direction != "horizontal" ? this.totalColumns : this.totalRows;
      var _loc3_ = this._scrollPosition * _loc2_;
      if(_loc2_ == 0)
      {
         return undefined;
      }
      if(index >= _loc3_ && index < _loc3_ + this.totalRows * this.totalColumns)
      {
         return undefined;
      }
      if(index < _loc3_)
      {
         this.scrollPosition = index / _loc2_ >> 0;
      }
      else
      {
         this.scrollPosition = Math.floor(index / _loc2_) - (this._direction != "horizontal" ? this.totalRows : this.totalColumns) + 1;
      }
   }
   function get scrollPosition()
   {
      return this._scrollPosition;
   }
   function set scrollPosition(value)
   {
      var _loc3_ = Math.ceil((this._dataProvider.length - this.totalRows * this.totalColumns) / (this._direction != "horizontal" ? this.totalColumns : this.totalRows));
      value = Math.max(0,Math.min(_loc3_,Math.round(value)));
      if(this._scrollPosition == value)
      {
         return;
      }
      this._scrollPosition = value;
      this.invalidateData();
      this.updateScrollBar();
   }
   function invalidateData()
   {
      var _loc3_ = this._direction != "horizontal" ? this.totalColumns : this.totalRows;
      var _loc4_ = Math.ceil(this._dataProvider.length / _loc3_);
      var _loc5_ = _loc4_ - (this._direction != "horizontal" ? this.totalRows : this.totalColumns);
      this._scrollPosition = Math.max(0,Math.min(_loc5_,this._scrollPosition));
      var _loc2_ = this._scrollPosition * _loc3_;
      var _loc6_ = _loc2_ + this.totalColumns * this.totalRows - 1;
      this._dataProvider.requestItemRange(_loc2_,_loc6_,this,"populateData");
   }
   function get availableWidth()
   {
      return (!(this.autoScrollBar && this._direction == "vertical") ? this.__width : this.__width - this._scrollBar._width) - this.margin * 2;
   }
   function get availableHeight()
   {
      return (!(this.autoScrollBar && this._direction == "horizontal") ? this.__height : this.__height - this._scrollBar._height) - this.margin * 2;
   }
   function setRendererList(value, newColumnCount)
   {
      if(newColumnCount != null)
      {
         this.externalColumnCount = newColumnCount;
      }
      super.setRendererList(value);
   }
   function handleInput(details, pathToFocus)
   {
      if(details.code == 9 && Key.isDown(9))
      {
         return true;
      }
      if(pathToFocus == null)
      {
         pathToFocus = [];
      }
      var _loc3_ = this.getRendererAt(this._selectedIndex);
      var _loc7_;
      if(_loc3_ != null && _loc3_.handleInput != null)
      {
         _loc7_ = _loc3_.handleInput(details,pathToFocus.slice(1));
         if(_loc7_)
         {
            return true;
         }
      }
      var _loc8_ = details.value == "keyDown" || details.value == "keyHold";
      var _loc5_ = details.navEquivalent;
      var _loc2_;
      if(this._direction == "horizontal")
      {
         switch(_loc5_)
         {
            case gfx.ui.NavigationCode.RIGHT:
               _loc2_ = this._selectedIndex + this.totalRows;
               break;
            case gfx.ui.NavigationCode.LEFT:
               _loc2_ = this._selectedIndex - this.totalRows;
               break;
            case gfx.ui.NavigationCode.UP:
               _loc2_ = this._selectedIndex - 1;
               break;
            case gfx.ui.NavigationCode.DOWN:
               _loc2_ = this._selectedIndex + 1;
         }
      }
      else
      {
         switch(_loc5_)
         {
            case gfx.ui.NavigationCode.DOWN:
               _loc2_ = this._selectedIndex + this.totalColumns;
               break;
            case gfx.ui.NavigationCode.UP:
               _loc2_ = this._selectedIndex - this.totalColumns;
               break;
            case gfx.ui.NavigationCode.LEFT:
               _loc2_ = this._selectedIndex - 1;
               break;
            case gfx.ui.NavigationCode.RIGHT:
               _loc2_ = this._selectedIndex + 1;
         }
      }
      switch(_loc5_)
      {
         case gfx.ui.NavigationCode.HOME:
            _loc2_ = 0;
            break;
         case gfx.ui.NavigationCode.END:
            _loc2_ = this._dataProvider.length - 1;
            break;
         case gfx.ui.NavigationCode.PAGE_DOWN:
            _loc2_ = Math.min(this._dataProvider.length - 1,this._selectedIndex + this.totalColumns * this.totalRows);
            break;
         case gfx.ui.NavigationCode.PAGE_UP:
            _loc2_ = Math.max(0,this._selectedIndex - this.totalColumns * this.totalRows);
      }
      if(_loc2_ != null)
      {
         if(!_loc8_)
         {
            return true;
         }
         if(_loc2_ >= 0 && _loc2_ < this.dataProvider.length)
         {
            this.selectedIndex = Math.max(0,Math.min(this._dataProvider.length - 1,_loc2_));
            return true;
         }
         if(this.wrapping == "stick")
         {
            _loc2_ = Math.max(0,Math.min(this._dataProvider.length - 1,_loc2_));
            if(this.selectedIndex != _loc2_)
            {
               this.selectedIndex = _loc2_;
            }
            return true;
         }
         if(this.wrapping == "wrap")
         {
            this.selectedIndex = _loc2_ >= 0 ? (this.selectedIndex >= this._dataProvider.length - 1 ? 0 : this._dataProvider.length - 1) : this._dataProvider.length - 1;
            return true;
         }
      }
      return false;
   }
   function toString()
   {
      return "[Scaleform TileList " + this._name + "]";
   }
   function configUI()
   {
      super.configUI();
      if(this.inspectableScrollBar != "" && this.inspectableScrollBar != null)
      {
         this.scrollBar = this.inspectableScrollBar;
         this.inspectableScrollBar = null;
      }
   }
   function draw()
   {
      if(this.sizeIsInvalid)
      {
         this._width = this.__width;
         this._height = this.__height;
      }
      var _loc4_;
      var _loc3_;
      var _loc5_;
      var _loc6_;
      if(this.externalRenderers)
      {
         this.totalColumns = this.externalColumnCount != 0 ? this.externalColumnCount : 1;
         this.totalRows = Math.ceil(this.renderers.length / this.totalColumns);
      }
      else
      {
         this.container._xscale = 10000 / this._xscale;
         this.container._yscale = 10000 / this._yscale;
         _loc4_ = this._columnWidth;
         _loc3_ = this._rowHeight;
         if(_loc3_ == null || _loc4_ == null)
         {
            _loc5_ = this.createItemRenderer(99);
            _loc5_.enableInitCallback = false;
            if(_loc4_ == null)
            {
               _loc4_ = _loc5_._width;
            }
            if(_loc3_ == null)
            {
               _loc3_ = _loc5_._height;
            }
            _loc5_.removeMovieClip();
         }
         this.totalRows = (this.availableHeight + this.spaceY) / (_loc3_ + this.spaceY) >> 0;
         this.totalColumns = (this.availableWidth + this.spaceX) / (_loc4_ + this.spaceX) >> 0;
         _loc6_ = this.totalRows * this.totalColumns;
         this.drawRenderers(_loc6_);
         this.drawLayout(_loc4_,_loc3_);
         this.updateScrollBar();
         this.drawScrollBar();
      }
      this.updateScrollBar();
      this.invalidateData();
      this.setState();
      super.draw();
   }
   function drawLayout(rendererWidth, rendererHeight)
   {
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < this.renderers.length)
      {
         _loc3_ = this.renderers[_loc2_];
         if(this.direction == "horizontal")
         {
            _loc3_._x = (_loc2_ / this.totalRows >> 0) * rendererWidth + this.margin + this.spaceX * (_loc2_ / this.totalRows >> 0);
            _loc3_._y = _loc2_ % this.totalRows * rendererHeight + this.margin + this.spaceY * (_loc2_ % this.totalRows);
         }
         else if(this.direction == "horizontal_flip")
         {
            _loc3_._x = this.__width - this.margin - rendererWidth - (rendererWidth + this.spaceX) * (_loc2_ / this.totalRows >> 0);
            _loc3_._y = _loc2_ % this.totalRows * rendererHeight + this.margin + this.spaceY * (_loc2_ % this.totalRows);
         }
         else if(this.direction == "vertical")
         {
            _loc3_._x = _loc2_ % this.totalColumns * rendererWidth + this.margin + this.spaceX * (_loc2_ % this.totalColumns);
            _loc3_._y = (_loc2_ / this.totalColumns >> 0) * rendererHeight + this.margin + this.spaceY * (_loc2_ / this.totalColumns >> 0);
         }
         else if(this.direction == "vertical_flip")
         {
            _loc3_._x = this.__width - this.margin - rendererWidth - (rendererWidth + this.spaceX) * (_loc2_ % this.totalColumns);
            _loc3_._y = (_loc2_ / this.totalColumns >> 0) * rendererHeight + this.margin + this.spaceY * (_loc2_ / this.totalColumns >> 0);
         }
         this.renderers[_loc2_].setSize(rendererWidth,rendererHeight);
         _loc2_ = _loc2_ + 1;
      }
      this.drawScrollBar();
   }
   function changeFocus()
   {
      super.changeFocus();
      this.setState();
      var _loc3_ = this.getRendererAt(this._selectedIndex);
      if(_loc3_ != null)
      {
         _loc3_.displayFocus = this._focused;
      }
   }
   function populateData(data)
   {
      var _loc2_ = 0;
      var _loc4_;
      var _loc3_;
      while(_loc2_ < this.totalColumns * this.totalRows)
      {
         _loc4_ = this.renderers[_loc2_];
         _loc3_ = this._scrollPosition * (this._direction != "horizontal" ? this.totalColumns : this.totalRows) + _loc2_;
         this.renderers[_loc2_].setListData(_loc3_,this.itemToLabel(data[_loc2_]),this._selectedIndex == _loc3_);
         _loc4_.setData(data[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function getRendererAt(index)
   {
      var _loc2_ = index - this._scrollPosition * (this._direction != "horizontal" ? this.totalColumns : this.totalRows);
      if(_loc2_ > this._dataProvider.length - 1)
      {
         return null;
      }
      return this.renderers[_loc2_];
   }
   function handleScroll(event)
   {
      var _loc2_ = event.target.position;
      if(isNaN(_loc2_))
      {
         return undefined;
      }
      this.scrollPosition = _loc2_;
   }
   function drawScrollBar()
   {
      if(!this.autoScrollBar)
      {
         return undefined;
      }
      this._scrollBar.direction = this._direction;
      if(this._direction == "vertical")
      {
         this._scrollBar._rotation = 0;
         this._scrollBar._x = this.__width - this._scrollBar._width + this.margin;
         this._scrollBar._y = this.margin;
         this._scrollBar.height = this.__height - this.margin * 2;
      }
      else
      {
         this._scrollBar._rotation = -90;
         this._scrollBar._x = this.margin;
         this._scrollBar._y = this.__height - this.margin;
         this._scrollBar.width = this.__width - this.margin * 2;
      }
   }
   function updateScrollBar()
   {
      var _loc2_;
      if(this.direction == "horizontal")
      {
         _loc2_ = Math.ceil(this._dataProvider.length / this.totalRows) - this.totalColumns;
      }
      else
      {
         _loc2_ = Math.ceil(this._dataProvider.length / this.totalColumns) - this.totalRows;
      }
      if(this._scrollBar.setScrollProperties != null)
      {
         this._scrollBar.setScrollProperties(this._direction != "horizontal" ? this.totalRows : this.totalColumns,0,_loc2_);
      }
      else
      {
         this._scrollBar.minimum = 0;
         this._scrollBar.maximum = _loc2_;
      }
      this._scrollBar.position = this._scrollPosition;
      this._scrollBar.trackScrollPageSize = Math.max(1,this._direction != "horizontal" ? this.totalRows : this.totalColumns);
   }
   function scrollWheel(delta)
   {
      if(this._disabled)
      {
         return undefined;
      }
      this.scrollPosition = this._scrollPosition - delta;
   }
   function setState()
   {
      this.tabEnabled = this.focusEnabled = !this._disabled;
      this.gotoAndPlay(!this._disabled ? (!this._focused ? "default" : "focused") : "disabled");
      if(this._scrollBar)
      {
         this._scrollBar.disabled = this._disabled;
         this._scrollBar.tabEnabled = false;
      }
      var _loc2_ = 0;
      while(_loc2_ < this.renderers.length)
      {
         this.renderers[_loc2_].disabled = this._disabled;
         this.renderers[_loc2_].tabEnabled = false;
         _loc2_ = _loc2_ + 1;
      }
   }
}
