class Frame.Main extends core.KeyMovieClip
{
   var EventCall;
   var _AGbar;
   var _HPbar;
   var _MPbar;
   var _QuestAlarm;
   var _SDbar;
   var _Stamina;
   var _bg;
   var _btCharacterInfo;
   var _btCommunity;
   var _btIngameShop;
   var _btInventory;
   var _btQuest;
   var _btSystem;
   var _initData;
   var _keyName;
   var _tooltipMainButton;
   var _width;
   var _x;
   var _xscale;
   var _y;
   var _yscale;
   function Main()
   {
      super();
      this._keyName = "main";
   }
   function devFunTest(devFunTest)
   {
      devFunTest.setUIName("하단 프레임");
      devFunTest.addFunInfo("setQuestAlarm",true);
      devFunTest.addFunInfo("setHPMP",{isToxic:false,hp:80,maxHp:100,mp:800,maxMp:1000,Shield:100,ShieldMax:200,SkillMana:500,SkillManaMax:1000});
      devFunTest.addFunInfo("setExp",{isMasterLevel:false,page:0,rate:50,curExp:"0",maxExp:"1"});
      devFunTest.addFunInfo("setExpTooltip",{text:"ttttttt",rate:50});
      devFunTest.addFunInfo("setStamina",{show:true,rate:50});
   }
   function onResize()
   {
      if(Stage.height < gStandard.ResizeStageHeight)
      {
         this._xscale = 95;
         this._yscale = 95;
      }
      else
      {
         this._xscale = 100;
         this._yscale = 100;
      }
      this._x = Math.floor((Stage.width - this._width) / 2);
      this._y = Math.floor(Stage.height - this._bg._height * this._yscale / 100);
   }
   function onLoad()
   {
      Stage.addListener(this);
      this._tooltipMainButton._visible = false;
      this._btIngameShop.addEventListener("rollOver",this,"onTooltipMainMenu");
      this._btIngameShop.addEventListener("rollOut",this,"onTooltipMainMenu");
      this._btIngameShop.addEventListener("releaseOutside",this,"onTooltipMainMenu");
      this._btCharacterInfo.addEventListener("rollOver",this,"onTooltipMainMenu");
      this._btCharacterInfo.addEventListener("rollOut",this,"onTooltipMainMenu");
      this._btCharacterInfo.addEventListener("releaseOutside",this,"onTooltipMainMenu");
      this._btInventory.addEventListener("rollOver",this,"onTooltipMainMenu");
      this._btInventory.addEventListener("rollOut",this,"onTooltipMainMenu");
      this._btInventory.addEventListener("releaseOutside",this,"onTooltipMainMenu");
      this._btQuest.addEventListener("rollOver",this,"onTooltipMainMenu");
      this._btQuest.addEventListener("rollOut",this,"onTooltipMainMenu");
      this._btQuest.addEventListener("releaseOutside",this,"onTooltipMainMenu");
      this._btCommunity.addEventListener("rollOver",this,"onTooltipMainMenu");
      this._btCommunity.addEventListener("rollOut",this,"onTooltipMainMenu");
      this._btCommunity.addEventListener("releaseOutside",this,"onTooltipMainMenu");
      this._btSystem.addEventListener("rollOver",this,"onTooltipMainMenu");
      this._btSystem.addEventListener("rollOut",this,"onTooltipMainMenu");
      this._btSystem.addEventListener("releaseOutside",this,"onTooltipMainMenu");
      this._HPbar.setBitmapName("guege_hp-nopack");
      this._MPbar.setBitmapName("guege_mp-nopack");
      this._HPbar.hitTestDisable = true;
      this._MPbar.hitTestDisable = true;
      this._SDbar.hitTestDisable = true;
      this._AGbar.hitTestDisable = true;
      this._QuestAlarm.hitTestDisable = true;
      this._QuestAlarm._visible = false;
      this._Stamina._visible = false;
      this.onResize();
      if(_root.isClient != true)
      {
         this.InitTextTestPram();
      }
   }
   function onTooltipMainMenu(e)
   {
      if(e.type != "rollOver")
      {
         this._tooltipMainButton.visible = false;
         return undefined;
      }
      this._tooltipMainButton.setKeyTooltip(e.comp.data.key,e.comp.data.label);
      this._tooltipMainButton._x = e.comp._x + e.comp._width / 2 - this._tooltipMainButton._width / 2;
      this._tooltipMainButton.visible = true;
   }
   function setStamina(info)
   {
      if(info.show != this._Stamina._visible)
      {
         this._Stamina._visible = info.show;
      }
      if(info.show == true)
      {
         this._Stamina.setValue(info.rate,100);
      }
   }
   function setHPMP(info)
   {
      if(info.isToxic == true)
      {
         this._HPbar.setBitmapName("guege_hp_green-nopack");
      }
      else
      {
         this._HPbar.setBitmapName("guege_hp-nopack");
      }
      this._HPbar.setValue(info.hp,info.maxHp);
      this._MPbar.setValue(info.mp,info.maxMp);
      this._SDbar.setValue(info.Shield,info.ShieldMax);
      this._AGbar.setValue(info.SkillMana,info.SkillManaMax);
   }
   function setQuestAlarm(b)
   {
      this._QuestAlarm._visible = b;
      this._QuestAlarm.noAdvance = !b;
   }
   function InitTextTestPram()
   {
      var _loc2_ = new Array();
      _loc2_.push({keyCode:27,key:"ESC",label:"시스템"});
      _loc2_.push({keyCode:112,key:"F1",label:"가이드"});
      _loc2_.push({keyCode:75,key:"K",label:"그래모리캐이스"});
      var _loc4_ = {label:"인벤토리",subMenu:_loc2_};
      var _loc9_ = {label:"커뮤",subMenu:_loc2_};
      var _loc5_ = {label:"씨스템",subMenu:_loc2_};
      var _loc3_ = {IngameShop:{keyCode:88,key:"X",label:"인게임샵"},CharacterInfo:{keyCode:67,key:"C",label:"캐릭터정보"},Inventory:_loc4_,Quest:{keyCode:84,key:"T",label:"퀘스트창"},Community:_loc9_,System:_loc5_};
      this.InitMenuInfo(_loc3_);
   }
   function InitMenuInfo(info)
   {
      this._btIngameShop.removeEventListener("click",this,"onClickMainMenu");
      this._btCharacterInfo.removeEventListener("click",this,"onClickMainMenu");
      this._btQuest.removeEventListener("click",this,"onClickMainMenu");
      this._btInventory.removeEventListener("change",this,"onChangeSubMenu");
      this._btCommunity.removeEventListener("change",this,"onChangeSubMenu");
      this._btSystem.removeEventListener("change",this,"onChangeSubMenu");
      this._initData = info;
      this._btIngameShop.data = info.IngameShop;
      this._btCharacterInfo.data = info.CharacterInfo;
      this._btQuest.data = info.Quest;
      this._btInventory.data = info.Inventory;
      this._btCommunity.data = info.Community;
      this._btSystem.data = info.System;
      this._btInventory.rowCount = info.Inventory.subMenu.length;
      this._btCommunity.rowCount = info.Community.subMenu.length;
      this._btSystem.rowCount = info.System.subMenu.length;
      this._btInventory.dataProvider = info.Inventory.subMenu;
      this._btCommunity.dataProvider = info.Community.subMenu;
      this._btSystem.dataProvider = info.System.subMenu;
      this._btIngameShop.addEventListener("click",this,"onClickMainMenu");
      this._btCharacterInfo.addEventListener("click",this,"onClickMainMenu");
      this._btQuest.addEventListener("click",this,"onClickMainMenu");
      this._btInventory.addEventListener("change",this,"onChangeSubMenu");
      this._btCommunity.addEventListener("change",this,"onChangeSubMenu");
      this._btSystem.addEventListener("change",this,"onChangeSubMenu");
   }
   function onClickMainMenu(e)
   {
      this.onHotKey(e.comp.data);
   }
   function onChangeSubMenu(e)
   {
      this.onHotKey(e.data);
   }
   function onHotKey(data)
   {
      this.EventCall("onHotKey",data);
      util.TraceAllObjectInfo(data);
   }
   function IsPressHotKey(data, keyCode)
   {
      if(data.keyCode == keyCode)
      {
         this.onHotKey(data);
         return true;
      }
      var _loc4_;
      var _loc5_;
      var _loc2_;
      var _loc3_;
      if(data.subMenu != undefined)
      {
         _loc4_ = data.subMenu;
         _loc5_ = _loc4_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc3_ = _loc4_[_loc2_];
            if(_loc3_.keyCode == keyCode)
            {
               this.onHotKey(_loc3_);
               return true;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      return false;
   }
   function onKeyUp()
   {
      if(gfx.controls.TextInput.IsFocus == true)
      {
         return undefined;
      }
      var _loc2_ = Key.getCode();
      if(this.IsPressHotKey(this._initData.IngameShop,_loc2_) == true)
      {
         return undefined;
      }
      if(this.IsPressHotKey(this._initData.CharacterInfo,_loc2_) == true)
      {
         return undefined;
      }
      if(this.IsPressHotKey(this._initData.Quest,_loc2_) == true)
      {
         return undefined;
      }
      if(this.IsPressHotKey(this._initData.Inventory,_loc2_) == true)
      {
         return undefined;
      }
      if(this.IsPressHotKey(this._initData.Community,_loc2_) == true)
      {
         return undefined;
      }
      if(this.IsPressHotKey(this._initData.System,_loc2_) == true)
      {
         return undefined;
      }
   }
}
