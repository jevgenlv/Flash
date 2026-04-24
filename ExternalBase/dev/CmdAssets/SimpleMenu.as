class dev.CmdAssets.SimpleMenu extends core.EventMovieClip
{
   var _arrDatas;
   var _cmdType;
   var _isInputText;
   var _isOpen;
   var _lastText;
   var _visible;
   var dispatchEvent;
   var inputLoader;
   var slCommand;
   var sr1;
   var txEnter;
   var txTitle;
   function SimpleMenu()
   {
      super();
      this._isInputText = true;
   }
   function onLoad()
   {
      this._isOpen = this._visible;
      this.txTitle.textAutoSize = "fit";
      this.slCommand.addEventListener("itemClick",this,"onCmd");
      this.inputLoader.addEventKey(13);
      this.inputLoader.addEventKey(38);
      this.inputLoader.addEventListener("KeyDown",this,"onKeyEvent");
   }
   function setTitle(title)
   {
      this.txTitle.text = title;
   }
   function getType()
   {
      return this._cmdType;
   }
   function setList(cmdType, arrList)
   {
      this._cmdType = cmdType;
      this._arrDatas = arrList;
      this.slCommand.dataProvider = this._arrDatas;
   }
   function disabledControls(b)
   {
      this.inputLoader.disabled = b;
      this.slCommand.disabled = b;
      this.sr1.disabled = b;
   }
   function isOpen()
   {
      return this._isOpen;
   }
   function Open(b)
   {
      this._isOpen = b;
      if(caurina.transitions.Tweener.isTweening(this) == true)
      {
         caurina.transitions.Tweener.removeTweens(this);
      }
      this.disabledControls(!b);
      if(this._isOpen == true)
      {
         caurina.transitions.Tweener.addTween(this,{time:1,_alpha:100});
      }
      else
      {
         caurina.transitions.Tweener.addTween(this,{time:1,_alpha:0});
      }
   }
   function getTextInput()
   {
      return this._isInputText;
   }
   function setTextInput(b)
   {
      this._isInputText = b;
      caurina.transitions.Tweener.removeTweens(this.inputLoader);
      caurina.transitions.Tweener.removeTweens(this.txEnter);
      caurina.transitions.Tweener.removeTweens(this.slCommand);
      caurina.transitions.Tweener.removeTweens(this.sr1);
      if(b == true)
      {
         this.inputLoader.disabled = false;
         caurina.transitions.Tweener.addTween(this.inputLoader,{time:1,_alpha:100});
         caurina.transitions.Tweener.addTween(this.txEnter,{time:1,_alpha:100});
         caurina.transitions.Tweener.addTween(this.slCommand,{time:1,_y:64,height:180});
         caurina.transitions.Tweener.addTween(this.sr1,{time:1,_y:64,height:180});
         return undefined;
      }
      this.inputLoader.disabled = true;
      caurina.transitions.Tweener.addTween(this.inputLoader,{time:1,_alpha:0});
      caurina.transitions.Tweener.addTween(this.txEnter,{time:1,_alpha:0});
      caurina.transitions.Tweener.addTween(this.slCommand,{time:1,_y:34,height:210});
      caurina.transitions.Tweener.addTween(this.sr1,{time:1,_y:34,height:210});
   }
   function onKeyEvent(e)
   {
      switch(e.code)
      {
         case 13:
            if(this.inputLoader.text == "")
            {
               return undefined;
            }
            this.onEventCall(this.inputLoader.text);
            this._lastText = this.inputLoader.text;
            this.inputLoader.text = "";
            break;
         case 38:
            this.inputLoader.text = this._lastText;
         default:
            return;
      }
   }
   function onCmd(e)
   {
      debug.Log("sippleMenu onCmd ");
      util.TraceAllObjectInfo(e);
      this.onEventCall(e.item);
   }
   function onEventCall(msg)
   {
      debug.Log("sippleMenu onEventCall - " + this._cmdType + " : " + msg);
      if(msg == "" || msg == undefined)
      {
         return undefined;
      }
      this.dispatchEvent({type:"click",cmd:this._cmdType,msg:msg});
   }
}
