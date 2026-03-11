//================================================================================
// TeleportLoadingWnd.
//================================================================================

class TeleportLoadingWnd extends UICommonAPI;

var WindowHandle Me;
var TextureHandle t_BG;
const DELAY_FADE= 3000;
const DELAY_HIDE= 200;
const TIMER_HIDE= 8001;
const TIMER_FADE= 8000;
const H_SIZE= 1080;
const W_SIZE= 1920;

function OnLoad ()
{
	RegisterEvent( EV_SystemMessage );
  RegisterEvent(2900);
  RegisterEvent(99981);
  Me = GetHandle("TeleportLoadingWnd");
 // t_BG = TextureHandle(GetHandle("TeleportLoadingWnd.ReviewTex"));
  CheckResolution();
  Me.SetAlpha(0);
}

function OnEvent (int EventID, string a_Param)
{
	local int SystemMsgIndex;
  switch (EventID)
  {
    case EV_SystemMessage:
	
		ParseInt ( a_Param, "Index", SystemMsgIndex );
	
        if (SystemMsgIndex == 2154) // Compara directamente el parametro con el ID del mensaje
        {
			
			
			
             HandleShowLoading(a_Param);

		
		}
	
    
    break;
    case 2900:
    CheckResolution();
    break;
    default:
  }
}

function OnTimer (int TimerID)
{
  switch (TimerID)
  {
    case 8000:
    Me.KillTimer(8000);
    Me.SetAlpha(0,0.2);
    Me.SetTimer(8001,200);
    break;
    case 8001:
    Me.KillTimer(8001);
    Me.HideWindow();
    break;
    default:
  }
}

function HandleShowLoading (string a_Param)
{
  local string t_TextureBG;

  ParseString(a_Param,"texture",t_TextureBG);
  Me.SetAlpha(255,0.2);
  Me.ShowWindow();
  Me.SetFocus();
  Me.SetTimer(8000,3000);
  
}



function CheckResolution ()
{
  local int CurrentMaxWidth;
  local int CurrentMaxHeight;

  GetCurrentResolution(CurrentMaxWidth,CurrentMaxHeight);
  SetTextureSize(CurrentMaxWidth,CurrentMaxHeight);
}

function SetTextureSize (int textureWidth, int textureHeight)
{
  local float screenAspectRatio;
  local float videoAspectRatio;
  local int CurrentMaxWidth;
  local int CurrentMaxHeight;

  GetCurrentResolution(CurrentMaxWidth,CurrentMaxHeight);
  t_BG.SetAnchor("TeleportLoadingWnd","CenterCenter","CenterCenter",0,0);
  screenAspectRatio = (CurrentMaxWidth / CurrentMaxHeight);
  videoAspectRatio = (1920 / 1080);
if (GetAbs(videoAspectRatio - screenAspectRatio) > 0)
  {
    if ( screenAspectRatio > videoAspectRatio )
    {
      textureWidth = CurrentMaxWidth;
      textureHeight = int((textureWidth / videoAspectRatio));
    } else {
      textureHeight = CurrentMaxHeight;
      textureWidth = int((textureHeight * videoAspectRatio));
    }
  } else {
    textureWidth = CurrentMaxWidth;
    textureHeight = CurrentMaxHeight;
  }
  t_BG.SetWindowSize(textureWidth,textureHeight);
}

function float GetAbs(float Num)
{
    if (Num < 0)
    {
        return -Num;
    }
    return Num;
}


