class Frame.mainAssets.SkillHotKeyPage extends MovieClip
{
   var _arrSlots;
   var _page1;
   var _page2;
   var _selectSlot;
   function SkillHotKeyPage()
   {
      super();
   }
   function onLoad()
   {
      this._arrSlots = new Array();
      this._arrSlots[0] = this._page1._slot0;
      this._arrSlots[1] = this._page1._slot1;
      this._arrSlots[2] = this._page1._slot2;
      this._arrSlots[3] = this._page1._slot3;
      this._arrSlots[4] = this._page1._slot4;
      this._arrSlots[5] = this._page2._slot5;
      this._arrSlots[6] = this._page2._slot6;
      this._arrSlots[7] = this._page2._slot7;
      this._arrSlots[8] = this._page2._slot8;
      this._arrSlots[9] = this._page2._slot9;
      var _loc4_ = this._arrSlots.length;
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < _loc4_)
      {
         _loc2_ = this._arrSlots[_loc3_];
         _loc2_.setSlotIdx(_loc3_);
         _loc2_.addEventListener("rollOut",this,"offSkillTooltip");
         _loc2_.addEventListener("releaseOutside",this,"offSkillTooltip");
         _loc2_.addEventListener("rollOver",this,"onSkillTooltip");
         _loc2_.addEventListener("click",this,"onSelectSkill");
         _loc3_ = _loc3_ + 1;
      }
      this._selectSlot.setSlotIdx(-1);
      this._selectSlot.addEventListener("rollOut",this,"offSkillTooltip");
      this._selectSlot.addEventListener("releaseOutside",this,"offSkillTooltip");
      this._selectSlot.addEventListener("rollOver",this,"onSkillTooltip");
      this._selectSlot.addEventListener("click",this,"onOpenSkillWindow");
      var _loc6_ = this._page1._btPageChange;
      var _loc5_ = this._page2._btPageChange;
      _loc6_.data = 2;
      _loc5_.data = 1;
      _loc6_.addEventListener("click",this,"onPageChange");
      _loc5_.addEventListener("click",this,"onPageChange");
      this.onSelectPage(1);
      Key.addListener(this);
      flash.external.ExternalInterface.call("main","onLoadSkillSlot","SkillSlotPage");
   }
   function onPageChange(e)
   {
      var _loc2_ = Number(e.comp.data);
      this.onSelectPage(_loc2_);
   }
   function onSelectPage(viewPage)
   {
      this._page1._visible = viewPage == 1;
      this._page2._visible = viewPage == 2;
   }
   function onKeyDown()
   {
      if(gfx.controls.TextInput.IsFocus == true)
      {
         return undefined;
      }
      var _loc3_ = Key.getCode();
      var _loc2_;
      switch(_loc3_)
      {
         case 49:
         case 50:
         case 51:
         case 52:
         case 53:
         case 54:
         case 55:
         case 56:
         case 57:
            _loc2_ = _loc3_ - 49;
            break;
         case 48:
            _loc2_ = 9;
            break;
         default:
            return undefined;
      }
      if(this._arrSlots[_loc2_] == undefined)
      {
         trace("skillpage keyDown : " + _loc3_);
         return undefined;
      }
      this.onSelectSkill({comp:this._arrSlots[_loc2_]});
   }
   function onOpenSkillWindow(e)
   {
      flash.external.ExternalInterface.call("main","onOpenSkillWindow","SkillSlotPage");
   }
   function onSelectSkill(e)
   {
      if(e.comp == undefined)
      {
         return undefined;
      }
      var _loc1_ = e.comp;
      var _loc3_ = _loc1_.getSlotIdx();
      var _loc2_ = _loc1_.getSkillIdx();
      flash.external.ExternalInterface.call("main","onSelectSkill",{slot:_loc3_,skill:_loc2_});
   }
   function offSkillTooltip(e)
   {
      var _loc1_ = e.comp;
      var _loc3_ = _loc1_.getSlotIdx();
      var _loc2_ = _loc1_.getSkillIdx();
      flash.external.ExternalInterface.call("main","offSkillTooltip",{slot:_loc3_,skill:_loc2_});
   }
   function onSkillTooltip(e)
   {
      var _loc1_ = e.comp;
      if(_loc1_.getSkillIdx() == undefined)
      {
         return undefined;
      }
      var _loc4_ = _loc1_.getSlotIdx();
      var _loc3_ = _loc1_.getSkillIdx();
      var _loc2_ = {x:0,y:0};
      _loc1_.localToGlobal(_loc2_);
      flash.external.ExternalInterface.call("main","onSkillTooltip",{slot:_loc4_,skill:_loc3_,x:_loc2_.x,y:_loc2_.y,w:_loc1_.width,h:_loc1_._height});
   }
   function devFunTest(devFunTest)
   {
      devFunTest.setUIName("스킬 단축키");
      var _loc2_ = new Object();
      _loc2_.Elemental = 0;
      devFunTest.addFunInfo("AddTestSkillData","Client가 넘길 table값 세팅");
      devFunTest.addFunInfo("setSelectSkill",{slot:0,skill:1});
      devFunTest.addFunInfo("onUseSkillDelay",{skill:1,delaytime:4000});
   }
   function setSelectSkill(data)
   {
      var _loc4_ = data.slot;
      var _loc5_ = this._arrSlots.length;
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < _loc5_)
      {
         _loc2_ = this._arrSlots[_loc3_];
         if(_loc3_ == _loc4_)
         {
            _loc2_.setSelect(true);
            if(this._selectSlot.getSkillIdx() != _loc2_.getSkillIdx())
            {
               this._selectSlot.setSkillIdx(_loc2_.getSkillIdx());
               this._selectSlot.setSelect(true);
               this._selectSlot.setEnableElemental(_loc2_.getEnableElemental());
            }
            this._selectSlot.setUseSkill(_loc2_.getUseSkill());
            this._selectSlot.setSkillDelayInfo(_loc2_.getSkillDelayInfo());
         }
         else
         {
            _loc2_.setSelect(false);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function AddTestSkillData(info)
   {
      var _loc3_ = 1;
      var _loc2_;
      while(_loc3_ < 20)
      {
         _loc2_ = new struct.SkillInfo();
         _loc2_.Index = _loc3_;
         _loc2_.Magic_Icon = _loc3_ * 2;
         _loc2_.Name = "TEST_SKILL_" + _loc3_;
         _loc2_.MasteryType = _loc3_ % 5;
         gSystem.DataMan.skill.insert(_loc2_);
         _loc3_ = _loc3_ + 1;
      }
      var _loc8_ = new Object();
      _loc8_.Elemental = 1;
      _loc8_.SelectSlot = 0;
      var _loc7_ = new Array();
      _loc3_ = 0;
      while(_loc3_ < 10)
      {
         _loc7_.push({slot:_loc3_,skill:_loc3_,isUse:_loc3_ % 2 == 0});
         _loc3_ = _loc3_ + 1;
      }
      _loc8_.arrSlots = _loc7_;
      this.SetSkillSlot(_loc8_);
   }
   function onUseSkillDelay(info)
   {
      var _loc4_ = info.skill;
      var _loc5_ = info.delaytime / 1000;
      var _loc6_ = this._arrSlots.length;
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < _loc6_)
      {
         _loc3_ = this._arrSlots[_loc2_];
         if(_loc3_.getSkillIdx() == _loc4_)
         {
            _loc3_.setSkillDelay(_loc5_);
         }
         _loc2_ = _loc2_ + 1;
      }
      if(this._selectSlot.getSkillIdx() == _loc4_)
      {
         this._selectSlot.setSkillDelay(_loc5_);
      }
   }
   function SetSkillSlot(data)
   {
      var _loc6_ = data.Elemental;
      var _loc5_ = data.SelectSlot;
      var _loc10_ = data.SelectSkill;
      var _loc11_ = data.SelectUseSkill;
      var _loc12_ = data.SelectSkill_damageType;
      this._selectSlot.setSkillIdx(_loc10_);
      this._selectSlot.setUseSkill(_loc11_);
      this._selectSlot.setUserElemental(_loc6_);
      this._selectSlot.setSelect(true);
      this._selectSlot.setDamageType(_loc12_);
      var _loc7_ = data.arrSlots;
      var _loc8_ = this._arrSlots.length;
      var _loc3_ = 0;
      var _loc2_;
      var _loc4_;
      while(_loc3_ < _loc8_)
      {
         _loc2_ = this._arrSlots[_loc3_];
         _loc4_ = _loc7_[_loc3_];
         if(_loc4_ != undefined)
         {
            _loc2_.setSkillIdx(_loc4_.skill);
            _loc2_.setUseSkill(_loc4_.isUse);
            _loc2_.setUserElemental(_loc6_);
            _loc2_.setDamageType(_loc4_.damageType);
            _loc2_.setSelect(_loc3_ == _loc5_);
            if(_loc3_ == _loc5_)
            {
               this._selectSlot.setSkillDelayInfo(_loc2_.getSkillDelayInfo());
            }
         }
         else
         {
            _loc2_.setSkillIdx(0);
         }
         _loc3_ = _loc3_ + 1;
      }
      if(this._selectSlot.getUseSkill() == false)
      {
         this.onSelectPage(1);
         return undefined;
      }
      if(_loc5_ < 5)
      {
         this.onSelectPage(1);
      }
      else
      {
         this.onSelectPage(2);
      }
   }
}
