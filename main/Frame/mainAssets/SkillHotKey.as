class Frame.mainAssets.SkillHotKey extends gfx.controls.Button
{
   var _damageType;
   var _delayMovieSize;
   var _delayStartTime;
   var _delayValueTime;
   var _devText;
   var _disabled;
   var _isUseSkill;
   var _mcDelay;
   var _mcIcon;
   var _mcIconDisabled;
   var _select;
   var _skillIndex;
   var _skillInfo;
   var _slotIndex;
   var _stamp;
   function SkillHotKey()
   {
      super();
   }
   function configUI()
   {
      super.configUI();
      this._mcDelay.hitTestDisable = true;
      this._delayMovieSize = this._mcDelay._height;
      this._mcDelay._height = 0;
      this._select.hitTestDisable = true;
      this._stamp.hitTestDisable = true;
      this._damageType.hitTestDisable = true;
      this._mcIcon.hitTestDisable = true;
      this._mcIconDisabled.hitTestDisable = true;
      this.UpdateSkillInfo();
   }
   function setSkillDelay(delay)
   {
      if(caurina.transitions.Tweener.isTweening(this._mcDelay) == true)
      {
         caurina.transitions.Tweener.removeTweens(this._mcDelay);
      }
      if(delay <= 0)
      {
         this._mcDelay._height = 0;
         return undefined;
      }
      this._delayValueTime = delay * 1000;
      this._delayStartTime = getTimer();
      this._mcDelay._height = this._delayMovieSize;
      caurina.transitions.Tweener.addTween(this._mcDelay,{_height:0,time:delay,transition:"linear"});
   }
   function setSkillDelayInfo(info)
   {
      if(info == undefined)
      {
         if(caurina.transitions.Tweener.isTweening(this._mcDelay) == true)
         {
            this._mcDelay._height = 0;
            caurina.transitions.Tweener.removeTweens(this._mcDelay);
         }
         return undefined;
      }
      if(caurina.transitions.Tweener.isTweening(this._mcDelay) == true)
      {
         caurina.transitions.Tweener.removeTweens(this._mcDelay);
      }
      util.TraceAllObjectInfo(info);
      this._delayValueTime = info._delayValueTime;
      this._delayStartTime = info._delayStartTime;
      this._mcDelay._height = info.value;
      caurina.transitions.Tweener.addTween(this._mcDelay,{_height:0,time:Number(info.remainTime / 1000),transition:"linear"});
   }
   function getSkillDelayInfo()
   {
      if(caurina.transitions.Tweener.isTweening(this._mcDelay) == false)
      {
         return undefined;
      }
      var _loc4_ = this._delayValueTime - (getTimer() - this._delayStartTime);
      if(_loc4_ <= 0)
      {
         return undefined;
      }
      var _loc2_ = {remainTime:_loc4_,value:this._mcDelay._height,_delayValueTime:this._delayValueTime,_delayStartTime:this._delayStartTime};
      return _loc2_;
   }
   function getDevText()
   {
      return this._devText;
   }
   function setSlotIdx(idx)
   {
      this._slotIndex = idx;
   }
   function getSlotIdx()
   {
      return this._slotIndex;
   }
   function getEnableElemental()
   {
      return this._stamp._visible;
   }
   function setEnableElemental(b)
   {
      this._stamp._visible = b;
   }
   function setUserElemental(n)
   {
      if(this._skillInfo.MasteryType != 0 && this._skillIndex != 0 && this._skillIndex != -1 && this._isUseSkill != false)
      {
         this._stamp.gotoAndStop(n + 1);
         this._stamp._visible = true;
      }
      else
      {
         this._stamp._visible = false;
      }
   }
   function setDamageType(n)
   {
      this._damageType.gotoAndStop(n + 1);
   }
   function getUseSkill()
   {
      return this._isUseSkill;
   }
   function setUseSkill(b)
   {
      if(this._skillInfo != undefined)
      {
         this._isUseSkill = b;
         this._mcIcon._visible = b;
         this._mcIconDisabled._visible = !b;
      }
   }
   function setSelect(b)
   {
      if(b != true)
      {
         this._select._visible = false;
         return undefined;
      }
      this._select._alpha = 0;
      this._select._visible = true;
      if(caurina.transitions.Tweener.isTweening(this._select) == true)
      {
         caurina.transitions.Tweener.removeTweens(this._select);
      }
      caurina.transitions.Tweener.addTween(this._select,{_alpha:100,time:0.8});
   }
   function getSkillIdx()
   {
      return this._skillInfo.Index;
   }
   function setSkillIdx(idx)
   {
      if(this._skillIndex == idx)
      {
         return undefined;
      }
      this._skillIndex = idx;
      this._devText = "slot: " + this._slotIndex + ", idx:" + this._skillIndex + "\n";
      this.UpdateSkillInfo();
   }
   function UpdateSkillInfo()
   {
      var _loc2_ = gSystem.DataMan.skill.getData(this._skillIndex);
      this._skillInfo = _loc2_;
      if(this._skillInfo == undefined)
      {
         this._skillIndex = -1;
         this._devText += "스킬 찾지 못함";
         if(gSystem.DataMan == undefined)
         {
            this._devText += "DataMan: undefined";
         }
         else
         {
            this._devText += "SkillCount : " + gSystem.DataMan.skill.getCount();
         }
         this._stamp._visible = false;
         this._select._visible = false;
         this._mcIcon._visible = false;
         this._mcIconDisabled._visible = false;
         return undefined;
      }
      this._devText += util.TextAllObjectInfo(this._skillInfo);
      this._devText += "disable:" + this._disabled;
      this._stamp.gotoAndStop(this._skillInfo.MasteryType + 1);
      this.setUseSkill(this._isUseSkill);
      gSystem.Image.DrawIcon_Skill(this._mcIcon,this._skillInfo,false);
      gSystem.Image.DrawIcon_Skill(this._mcIconDisabled,this._skillInfo,true);
   }
}
