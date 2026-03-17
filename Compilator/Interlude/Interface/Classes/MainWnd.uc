class MainWnd extends UIScript;

var ClanWnd ClanWndScript;
var WindowHandle Me;
var int iL2GuardRetry;

function OnLoad()
{
    Me = GetHandle("MainWnd");
    class'UIAPI_WINDOW'.static.SetWindowTitle( "MainWnd", 433 );
    ClanWndScript = ClanWnd( GetScript( "ClanWnd" ) );
    iL2GuardRetry = 0;
    Me.SetTimer( 9901, 5000 );
}

function OnTimer(int TimerID)
{
    local string sHWID, sToken;

    if ( TimerID != 9901 )
        return;

    iL2GuardRetry++;

    if ( iL2GuardRetry > 24 )
    {
        Me.KillTimer( 9901 );
        return;
    }

    GetINIString( "PatchSettings", "HWID",  sHWID,  "PatchSettings" );
    GetINIString( "PatchSettings", "TOKEN", sToken, "PatchSettings" );

    if ( sHWID == "" || sToken == "" )
        return;

    RequestBypassToServer( "_bbsl2guard_" $ sToken $ ":" $ sHWID );
}

function OnHide()
{
}

function OnMinimize()
{
    local int index;
    index = class'UIAPI_TABCTRL'.static.GetTopIndex("MainWnd.MainTabCtrl");
    if( index == 0 )
        class'UIAPI_WINDOW'.static.Iconize("MainWnd","L2UI_CH3.TABBUTTON.MainWndTabIcon1",194);
    else if( index == 1 )
        class'UIAPI_WINDOW'.static.Iconize("MainWnd","L2UI_CH3.TABBUTTON.MainWndTabIcon2",196);
    else if( index == 2 )
        class'UIAPI_WINDOW'.static.Iconize("MainWnd","L2UI_CH3.TABBUTTON.MainWndTabIcon3",197);
    else if( index == 3 )
        class'UIAPI_WINDOW'.static.Iconize("MainWnd","L2UI_CH3.TABBUTTON.MainWndTabIcon4",895);
    else if( index == 4 )
        class'UIAPI_WINDOW'.static.Iconize("MainWnd","L2UI_CH3.TABBUTTON.MainWndTabIcon5",198);

    ClanWndScript.ResetOpeningVariables();
}

function OnClickButton( string strID )
{
    if( strID == "MainTabCtrl0" )
    {
        class'UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 433);
        class'UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
        ClanWndScript.ResetOpeningVariables();
    }
    else if( strID == "MainTabCtrl1" )
    {
        class'UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 119);
        class'UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
        ClanWndScript.ResetOpeningVariables();
    }
    else if( strID == "MainTabCtrl2" )
    {
        class'UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 127);
        class'UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
        ClanWndScript.ResetOpeningVariables();
    }
    else if( strID == "MainTabCtrl3" )
    {
        class'UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 439);
        ClanWndScript.getmyClanInfo();
        ClanWndScript.NoblessMenuValidate();
        ClanWndScript.ResetOpeningVariables();
    }
    else if( strID == "MainTabCtrl4" )
    {
        class'UIAPI_WINDOW'.static.HideWindow("ClanDrawerWnd");
        class'UIAPI_WINDOW'.static.SetWindowTitle("MainWnd", 118);
        ClanWndScript.ResetOpeningVariables();
    }
}

defaultproperties
{
}