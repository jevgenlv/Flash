class Frame.TopMenuMC.SpecificServerMenu extends MovieClip
{
   var _btNormal;
   var _btPcRoom;
   var _normal;
   var _pcRoom;
   var _pcRoomDis;
   function SpecificServerMenu()
   {
      super();
   }
   function devFunTest(devFunTest)
   {
      devFunTest.setUIName("특성화서버 시간게이지");
      devFunTest.addFunInfo("setTimeProgress",{normal:1000,normalMax:3000,pcroom:1000,pcroomMax:1200});
      devFunTest.addFunInfo("setPcRoom",true);
   }
   function onLoad()
   {
      this._normal.hitTestDisable = true;
      this._pcRoom.hitTestDisable = true;
      this._pcRoomDis.hitTestDisable = true;
      this._btNormal.data = "normal";
      this._btPcRoom.data = "pcroom";
      this._btNormal.addEventListener("rollOver",this,"onTooltip");
      this._btPcRoom.addEventListener("rollOver",this,"onTooltip");
   }
   function onTooltip(e)
   {
      if(e.comp.data == undefined)
      {
         return undefined;
      }
      var _loc1_ = String(e.comp.data);
      flash.external.ExternalInterface.call("topmenu","SServerTooltip",_loc1_);
   }
   function setTimeProgress(info)
   {
      this._normal.setValue(Number(info.normal),Number(info.normalMax));
      if(this._pcRoom._visible == true)
      {
         this._pcRoom.setValue(Number(info.pcroom),Number(info.pcroomMax));
      }
      if(this._pcRoomDis._visible == true)
      {
         this._pcRoomDis.setValue(Number(info.pcroom),Number(info.pcroomMax));
      }
   }
   function setPcRoom(b)
   {
      this._pcRoom._visible = b;
      this._pcRoomDis._visible = !b;
   }
   function setTooltipText(info)
   {
      if(info.text == undefined || info.target == undefined)
      {
         return undefined;
      }
      if(info.target == "normal")
      {
         gSystem.Tooltip.SetText(info.text,this._btNormal,"CB");
         return undefined;
      }
      if(info.target == "pcroom")
      {
         gSystem.Tooltip.SetText(info.text,this._btPcRoom,"CB");
         return undefined;
      }
   }
}
