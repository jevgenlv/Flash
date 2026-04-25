class Frame.ChatMC.ChatMenu extends core.EventMovieClip
{
   var _btAlpha;
   var _btBackImage;
   var _btBlockedUser;
   var _btConfig;
   var _btFilterGens;
   var _btFilterGuild;
   var _btFilterNormal;
   var _btFilterParty;
   var _btFilterSystem;
   var _btFilterWhisper;
   var _btResize;
   var _btTypeGens;
   var _btTypeGuild;
   var _btTypeNormal;
   var _btTypeParty;
   var _selectChatType;
   var _visible;
   function ChatMenu()
   {
      super();
   }
   function InitTextTable(info)
   {
      this._btTypeNormal.label = info.strNormal;
      this._btTypeParty.label = info.strParty;
      this._btTypeGuild.label = info.strGuild;
      this._btTypeGens.label = info.strGens;
      this._btFilterWhisper.label = info.strWhisper;
      this._btFilterSystem.label = info.strSystem;
      this._btBlockedUser.label = info.strBlock;
   }
   function onHideMenu()
   {
      var _loc2_ = !this._btTypeNormal._visible;
      this._btTypeNormal._visible = _loc2_;
      this._btTypeParty._visible = _loc2_;
      this._btTypeGuild._visible = _loc2_;
      this._btTypeGens._visible = _loc2_;
      this._btFilterWhisper._visible = _loc2_;
      this._btFilterSystem._visible = _loc2_;
      this._btBlockedUser._visible = _loc2_;
      this._btBackImage._visible = _loc2_;
      this._btResize._visible = _loc2_;
      this._btAlpha._visible = _loc2_;
   }
   function onLoad()
   {
      this._btBackImage.data = "viewMode";
      this._btResize.data = "resize";
      this._btAlpha.data = "alpha";
      this._btConfig.addEventListener("click",this,"onHideMenu");
      this._btTypeNormal.data = "normal";
      this._btTypeParty.data = "party";
      this._btTypeGuild.data = "guild";
      this._btTypeGens.data = "gens";
      this.setInputType(Frame.ChatMC.ChatView.ChatTypeNormal);
      this._btTypeNormal.addEventListener("click",this,"onInputType");
      this._btTypeParty.addEventListener("click",this,"onInputType");
      this._btTypeGuild.addEventListener("click",this,"onInputType");
      this._btTypeGens.addEventListener("click",this,"onInputType");
      this._btFilterWhisper.addEventListener("click",this,"onFilter");
      this._btFilterSystem.addEventListener("click",this,"onFilter");
      this._btFilterNormal._visible = false;
      this._btFilterParty._visible = false;
      this._btFilterGuild._visible = false;
      this._btFilterGens._visible = false;
      this._btBackImage.addEventListener("click",this,"onViewOption");
      this._btResize.addEventListener("click",this,"onViewOption");
      this._btAlpha.addEventListener("click",this,"onViewOption");
      this._btBlockedUser.addEventListener("click",this,"onBlocked");
      Key.addListener(this);
   }
   function onKeyDown()
   {
      var _loc2_ = Key.getCode();
      switch(_loc2_)
      {
         case 113:
            this._btBlockedUser.selected = !this._btBlockedUser.selected;
            this.onBlocked();
            break;
         case 116:
            this.onButtonEvent(this._btBackImage);
            break;
         case 120:
            this._btFilterGens.selected = !this._btFilterGens.selected;
            this.setFilter(this._btFilterGens);
            break;
         case 121:
            this._btFilterNormal.selected = !this._btFilterNormal.selected;
            this.setFilter(this._btFilterNormal);
            break;
         case 122:
            this._btFilterParty.selected = !this._btFilterParty.selected;
            this.setFilter(this._btFilterParty);
            break;
         case 123:
            this._btFilterGuild.selected = !this._btFilterGuild.selected;
            this.setFilter(this._btFilterGuild);
      }
      if(this._visible == false)
      {
         return undefined;
      }
      switch(_loc2_)
      {
         case 114:
            this._btFilterWhisper.selected = !this._btFilterWhisper.selected;
            this.setFilter(this._btFilterWhisper);
            break;
         case 115:
            this.onButtonEvent(this._btResize);
         default:
            return;
      }
   }
   function onBlocked(e)
   {
      trace(" onBlocked ");
      flash.external.ExternalInterface.call("chat","BlockedUser",{open:this._btBlockedUser.selected});
   }
   function setBlocked(b)
   {
      trace(" setBlocked " + b);
      if(this._btBlockedUser.selected == b)
      {
         return undefined;
      }
      this._btBlockedUser.selected = b;
   }
   function setInputType(n)
   {
      this._selectChatType = Number(n);
      this._btTypeNormal.selected = this._selectChatType == Frame.ChatMC.ChatView.ChatTypeNormal;
      this._btTypeParty.selected = this._selectChatType == Frame.ChatMC.ChatView.ChatTypeParty;
      this._btTypeGuild.selected = this._selectChatType == Frame.ChatMC.ChatView.ChatTypeGuild;
      this._btTypeGens.selected = this._selectChatType == Frame.ChatMC.ChatView.ChatTypeGens;
   }
   function getInputType()
   {
      return this._selectChatType;
   }
   function onInputType(e)
   {
      var _loc1_ = -1;
      switch(e.comp.data)
      {
         case "normal":
            _loc1_ = Frame.ChatMC.ChatView.ChatTypeNormal;
            break;
         case "party":
            _loc1_ = Frame.ChatMC.ChatView.ChatTypeParty;
            break;
         case "guild":
            _loc1_ = Frame.ChatMC.ChatView.ChatTypeGuild;
            break;
         case "gens":
            _loc1_ = Frame.ChatMC.ChatView.ChatTypeGens;
            break;
         default:
            return undefined;
      }
      flash.external.ExternalInterface.call("chat","changeChatType",{chatType:_loc1_});
   }
   function onFilter(e)
   {
      this.setFilter(e.comp);
   }
   function setFilter(bt)
   {
      this.onEvent({type:"onFilter",name:bt.data,enable:!bt.selected});
   }
   function onViewOption(e)
   {
      this.onButtonEvent(e.comp);
   }
   function onButtonEvent(bt)
   {
      this.onEvent({type:"onViewOption",data:bt.data});
   }
}
