class struct.FreeChannelListInfo extends Object
{
   var ServerName;
   var ServerNum;
   var Tooltip;
   var bIsCurrentChannel;
   var bIsDisable;
   var bIsGoldServer;
   var bIsNonPkServer;
   function FreeChannelListInfo()
   {
      super();
   }
   function InitServerList(Info)
   {
      this.ServerName = Info.server_name;
      this.ServerNum = Info.server_number;
      this.bIsGoldServer = Info.is_gold_server;
      this.bIsNonPkServer = Info.is_pk_server;
      this.bIsDisable = Info.disable;
      this.bIsCurrentChannel = Info.CurrentChannel;
      this.Tooltip = Info.tooltip_msg;
      return this.MakeShowValue();
   }
   function MakeShowValue()
   {
      var _loc2_ = "";
      if(true == this.bIsNonPkServer)
      {
         _loc2_ += "[Non-PvP";
      }
      else
      {
         _loc2_ += "[PvP";
      }
      if(true == this.bIsGoldServer)
      {
         _loc2_ += " Gold]";
      }
      else
      {
         _loc2_ += "]";
      }
      return _loc2_;
   }
   function ChangeCurrentChannelValue(bCurChannel)
   {
      this.bIsCurrentChannel = bCurChannel;
   }
   function IsCurrentChannel()
   {
      return this.bIsCurrentChannel;
   }
   function IsDisableListInfo()
   {
      return this.bIsDisable;
   }
   function GetTooltip()
   {
      return this.Tooltip;
   }
   function IsNonPkServer()
   {
      return this.bIsNonPkServer;
   }
}
