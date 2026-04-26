class asData.ImageLoader extends MovieClip
{
   var _Images;
   var IconSkill = 0;
   var IconSkillNon = 1;
   var IconSkillMaster = 2;
   var IconSkillMasterNon = 3;
   function ImageLoader()
   {
      super();
   }
   function onLoad()
   {
      this._Images = new Array();
      this._Images[0] = this.getBitmap("Icon_Skill-nopack");
      this._Images[1] = this.getBitmap("Icon_Skill_non-nopack");
      this._Images[2] = this.getBitmap("Icon_MasterSkill-nopack");
      this._Images[3] = this.getBitmap("Icon_MasterSkill_non-nopack");
      gSystem.Image = this;
      if(_root.isClient != true)
      {
      }
   }
   function onUnload()
   {
      this._Images.splice(0);
      this._Images = undefined;
   }
   function DrawIcon_Buff(targetMC, buffIndex)
   {
      var _loc2_ = this.getBitmap("icon_" + buffIndex);
      return this.AttachImg(targetMC,_loc2_);
   }
   function DrawIcon_Skill(targetMC, info, bNon)
   {
      var _loc2_;
      if(info.SkillUseType == 0 || info.SkillUseType == 1)
      {
         if(bNon == true)
         {
            _loc2_ = this._Images[this.IconSkillNon];
         }
         else
         {
            _loc2_ = this._Images[this.IconSkill];
         }
      }
      else if(bNon == true)
      {
         _loc2_ = this._Images[this.IconSkillMasterNon];
      }
      else
      {
         _loc2_ = this._Images[this.IconSkillMaster];
      }
      if(_loc2_ == undefined)
      {
         return false;
      }
      var _loc5_ = 20;
      var _loc4_ = 28;
      var _loc7_ = Math.floor(info.Magic_Icon % 25) * _loc5_;
      var _loc6_ = Math.floor(info.Magic_Icon / 25) * _loc4_;
      if(info.SkillUseType == 0 || info.SkillUseType == 1)
      {
         this.DrawImg(targetMC,_loc2_,_loc7_,_loc6_,_loc5_,_loc4_);
      }
      else
      {
         this.DrawImg(targetMC,_loc2_,_loc7_,_loc6_,_loc5_,_loc4_);
      }
      return true;
   }
   function AttachImg(targetMC, img)
   {
      if(img == undefined)
      {
         return false;
      }
      var _loc1_;
      if(targetMC.mcDrawImg != undefined)
      {
         _loc1_ = targetMC.mcDrawImg;
         _loc1_.clear();
      }
      else
      {
         _loc1_ = targetMC.createEmptyMovieClip("mcDrawImg",targetMC.getNextHighestDepth());
      }
      _loc1_.attachBitmap(img,1,"auto",true);
      return true;
   }
   function DrawImg(targetMC, img, x, y, w, h)
   {
      if(img == undefined)
      {
         return undefined;
      }
      var mcDrawImg;
      if(targetMC.mcDrawImg != undefined)
      {
         mcDrawImg = targetMC.mcDrawImg;
         mcDrawImg.clear();
      }
      else
      {
         mcDrawImg = targetMC.createEmptyMovieClip("mcDrawImg",targetMC.getNextHighestDepth());
      }
      with(mcDrawImg)
      {
         _x = - x;
         _y = - y;
         beginBitmapFill(img,null,true,true);
         moveTo(x,y);
         lineTo(x,y + h);
         lineTo(x + w,y + h);
         lineTo(x + w,y);
         lineTo(x,y);
         endFill();
      }
   }
   function getBitmap(exportName)
   {
      return this._parent.getBitmap(exportName);
   }
   function getRootBitmap(idx)
   {
      return _root.getBitmap(idx);
   }
   function DrawRootImg(targetMC, imgIndex, x, y, w, h)
   {
      var img = this.getRootBitmap(imgIndex);
      if(img == undefined)
      {
         return undefined;
      }
      var mcDrawImg;
      if(targetMC.mcDrawImg != undefined)
      {
         mcDrawImg = targetMC.mcDrawImg;
         mcDrawImg.clear();
      }
      else
      {
         mcDrawImg = targetMC.createEmptyMovieClip("mcDrawImg",targetMC.getNextHighestDepth());
      }
      var mat = new flash.geom.Matrix();
      mat.identity();
      mat.scale(1,-1);
      with(mcDrawImg)
      {
         _x = - x;
         _y = - y;
         beginBitmapFill(img,mat,true,true);
         moveTo(x,y);
         lineTo(x,y + h);
         lineTo(x + w,y + h);
         lineTo(x + w,y);
         lineTo(x,y);
         endFill();
      }
   }
}
