class ManorSeedInfoSettingWnd extends UICommonAPI;

var int m_ManorID;
var int m_SumOfDefaultPrice;


const SEED_NAME=0;
const TODAY_VOLUME_OF_SALES=1;
const TODAY_PRICE=2;
const TOMORROW_VOLUME_OF_SALES=3;
const TOMORROW_PRICE=4;

const MINIMUM_CROP_PRICE=5;
const MAXIMUM_CROP_PRICE=6;
const SEED_LEVEL=7;
const REWARD_TYPE_1=8;
const REWARD_TYPE_2=9;

const COLUMN_CNT=10;

const DIALOG_ID_STOP=555;
const DIALOG_ID_SETTODAY=666;


function OnLoad()
{
	RegisterEvent( EV_ManorSeedInfoSettingWndShow );
	RegisterEvent( EV_ManorSeedInfoSettingWndAddItem );
	RegisterEvent( EV_ManorSeedInfoSettingWndAddItemEnd );

	RegisterEvent( EV_ManorSeedInfoSettingWndChangeValue );

	RegisterEvent( EV_DialogOK );


	m_ManorID=-1;
	m_SumOfDefaultPrice=0;
}

function OnEvent( int Event_ID, string a_Param)
{
	switch( Event_ID )
	{
	case EV_ManorSeedInfoSettingWndShow :
		HandleShow(a_Param);
		break;

	case EV_ManorSeedInfoSettingWndAddItem :
		HandleAddItem(a_Param);
		break;
	case EV_ManorSeedInfoSettingWndAddItemEnd :
		CalculateSumOfDefaultPrice();
		ShowWindowWithFocus("ManorSeedInfoSettingWnd");
		break;
	case EV_ManorSeedInfoSettingWndChangeValue :
		HandleChangeValue(a_Param);
		break;
	case EV_DialogOK :
		HandleDialogOk();
		break;
	}
}

function HandleDialogOk()
{
	local int DialogID;

	if(!DialogIsMine())
		return;

	DialogID=DialogGetID();

	switch(DialogID)
	{
	case DIALOG_ID_STOP :
		HandleStop();
		break;
	case DIALOG_ID_SETTODAY :
		HandleSetToday();
		break;
	}
}

function HandleStop()
{
	local int i;
	local int RecordCnt;
	local LVDataRecord record;
	local LVDataRecord recordClear;

	RecordCnt=class'UIAPI_LISTCTRL'.static.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");


	debug("카운트:"$RecordCnt);
	for(i=0; i<RecordCnt; ++i)
	{
		record = recordClear;		// 이렇게 삭제해주지 않으면 자꾸 늘어난다.
		record=class'UIAPI_LISTCTRL'.static.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", i);
//		debug("레코드인덱스:"$i$", 레코드길이(모두 10이어야 정상):"$record.LvDataList.Length);

		record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData="0";
		record.LVDataList[TOMORROW_PRICE].szData="0";

		class'UIAPI_LISTCTRL'.static.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", i, record);
	}

	CalculateSumOfDefaultPrice();
}

function HandleSetToday()
{
	local int i;
	local int RecordCnt;
	local LVDataRecord record;
	local LVDataRecord recordClear;

	RecordCnt=class'UIAPI_LISTCTRL'.static.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	for(i=0; i<RecordCnt; ++i)
	{
		record = recordClear;
		record=class'UIAPI_LISTCTRL'.static.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", i);

		record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData=record.LVDataList[TODAY_VOLUME_OF_SALES].szData;
		record.LVDataList[TOMORROW_PRICE].szData=record.LVDataList[TODAY_PRICE].szData;

		class'UIAPI_LISTCTRL'.static.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", i, record);
	}

	CalculateSumOfDefaultPrice();
}





function HandleShow(string a_Param)
{
	local int ManorID;
	local string ManorName;

	ParseInt(a_Param, "ManorID", ManorID);
	ParseString(a_Param, "ManorName", ManorName);

	m_ManorID=ManorID;

	class'UIAPI_TEXTBOX'.static.SetText("ManorSeedInfoSettingWnd.txtManorName", ManorName);

	DeleteAll();
}

function HandleChangeValue(string a_Param)
{
	local int TomorrowSalesVolume;
	local int TomorrowPrice;

	local LVDataRecord record;
	local int SelectedIndex;

	ParseInt(a_Param, "TomorrowSalesVolume", TomorrowSalesVolume);
	ParseInt(a_Param, "TomorrowPrice", TomorrowPrice);

	SelectedIndex=class'UIAPI_LISTCTRL'.static.GetSelectedIndex("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	record=class'UIAPI_LISTCTRL'.static.GetSelectedRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

//	debug("수정된레코드의인덱스:"$SelectedIndex$", 길이:"$record.LVDataList.Length);
	
	record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData=string(TomorrowSalesVolume);
	record.LVDataList[TOMORROW_PRICE].szData=string(TomorrowPrice);

	class'UIAPI_LISTCTRL'.static.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", SelectedIndex, record);

	CalculateSumOfDefaultPrice();
}



function DeleteAll()
{
	class'UIAPI_LISTCTRL'.static.DeleteAllItem("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
}

function OnDBClickListCtrlRecord( String strID )
{
	switch(strID)
	{
	case "ManorSeedInfoSettingListCtrl" :
		OnChangeBtn();
		break;
	}
}

function OnClickButton(string strID)
{
	debug(" "$strID);

	switch(strID)
	{
	case "btnChangeSell" :
		OnChangeBtn();
		break;
	case "btnSetToday" :
		DialogSetID(DIALOG_ID_SETTODAY);
		DialogShow( DIALOG_Warning, GetSystemMessage(1601));
		break;
	case "btnStop" :
		DialogSetID(DIALOG_ID_STOP);
		DialogShow( DIALOG_Warning, GetSystemMessage(1600));
		break;
	case "btnOk" :
		OnOk();
		break;
	case "btnCancel" :
		HideWindow("ManorSeedInfoSettingWnd");
		break;
	}
}

function OnOk()
{
	local int RecordCount;
	local LVDataRecord record;
	local LVDataRecord recordClear;

	local int i;

	local string param;


	RecordCount=class'UIAPI_LISTCTRL'.static.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	ParamAdd(param, "ManorID", string(m_ManorID));
	ParamAdd(param, "SeedCnt", string(RecordCount));

	// 레코드 수만큼 돌면서 검색해서 넣는다
	for(i=0; i<RecordCount; ++i)
	{
		record=recordClear;
		record=class'UIAPI_LISTCTRL'.static.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", i);
	
		ParamAdd(param, "SeedID"$i, string(record.nReserved1));
		ParamAdd(param, "TomorrowSalesVolume"$i, record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData);
		ParamAdd(param, "TomorrowPrice"$i,record.LVDataList[TOMORROW_PRICE].szData);
	}

	RequestSetSeed(param);

	HideWindow("ManorSeedInfoSettingWnd");
}

function OnChangeBtn()
{
	local LVDataRecord record;
	local string param;

	record=class'UIAPI_LISTCTRL'.static.GetSelectedRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	ParamAdd(param, "SeedName", record.LVDataList[SEED_NAME].szData);								// 씨앗이름
	ParamAdd(param, "TomorrowVolumeOfSales", record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData);	// 내일 판매량
	ParamAdd(param, "TomorrowLimit", string(record.nReserved2));									// 내일 발매한도
	ParamAdd(param, "TomorrowPrice", record.LVDataList[TOMORROW_PRICE].szData);						// 내일 가격

	ParamAdd(param, "MinCropPrice", record.LVDataList[MINIMUM_CROP_PRICE].szData);					// 최소작물가격
	ParamAdd(param, "MaxCropPrice", record.LVDataList[MAXIMUM_CROP_PRICE].szData);					// 최대작물가격

	ExecuteEvent(EV_ManorSeedInfoChangeWndShow, param);
}



function HandleAddItem(string a_Param)
{
	local LVDataRecord record;

	local int SeedID;
	local string SeedName;
	local int TodaySeedTotalCnt;
	local int TodaySeedPrice;
	local int NextSeedTotalCnt;
	local int NextSeedPrice;
	local int MinCropPrice;
	local int MaxCropPrice;
	local int SeedLevel;
	local string RewardType1;
	local string RewardType2;
	local int MaxSeedTotalCnt;
	local int DefaultSeedPrice;

	ParseInt(a_Param, "SeedID", SeedID);
	ParseString(a_Param, "SeedName", SeedName);
	ParseInt(a_Param, "TodaySeedTotalCnt", TodaySeedTotalCnt);
	ParseInt(a_Param, "TodaySeedPrice", TodaySeedPrice);
	ParseInt(a_Param, "TodayNextSeedTotalCnt", NextSeedTotalCnt);
	ParseInt(a_Param, "NextSeedPrice", NextSeedPrice);
	ParseInt(a_Param, "MinCropPrice", MinCropPrice);
	ParseInt(a_Param, "MaxCropPrice", MaxCropPrice);
	ParseInt(a_Param, "SeedLevel", SeedLevel);
	ParseString(a_Param, "RewardType1", RewardType1);
	ParseString(a_Param, "RewardType2", RewardType2);
	ParseInt(a_Param, "MaxSeedTotalCnt", MaxSeedTotalCnt);
	ParseInt(a_Param, "DefaultSeedPrice", DefaultSeedPrice);


	record.LVDataList.Length=COLUMN_CNT;

	record.LVDataList[SEED_NAME].szData=SeedName;										// 씨앗이름
	record.LVDataList[TODAY_VOLUME_OF_SALES].szData=string(TodaySeedTotalCnt);			// 오늘 판매량
	record.LVDataList[TODAY_PRICE].szData=string(TodaySeedPrice);						// 오늘 가격
	record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData=string(NextSeedTotalCnt);		// 내일 판매량
	record.LVDataList[TOMORROW_PRICE].szData=string(NextSeedPrice);						// 내일 가격

	record.LVDataList[MINIMUM_CROP_PRICE].szData=string(MinCropPrice);					
	record.LVDataList[MAXIMUM_CROP_PRICE].szData=string(MaxCropPrice);
	record.LVDataList[SEED_LEVEL].szData=string(SeedLevel);
	record.LVDataList[REWARD_TYPE_1].szData=RewardType1;
	record.LVDataList[REWARD_TYPE_2].szData=RewardType2;

	record.nReserved1=SeedID;
	record.nReserved2=MaxSeedTotalCnt;
	record.nReserved3=DefaultSeedPrice;

	class'UIAPI_LISTCTRL'.static.InsertRecord( "ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", record );
}


function CalculateSumOfDefaultPrice()
{
	local LVDataRecord record;
	local LVDataRecord recordClear;
	local int ItemCnt;
	local int i;
	local int tmpMulti;

	local string AdenaString;

	m_SumOfDefaultPrice=0;

	ItemCnt=class'UIAPI_LISTCTRL'.static.GetRecordCount( "ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	for(i=0; i<ItemCnt; ++i)
	{
		record=recordClear;
		record=class'UIAPI_LISTCTRL'.static.GetRecord( "ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", i);	

		tmpMulti=record.nReserved3*int(record.LVDataList[TOMORROW_VOLUME_OF_SALES].szData);
		m_SumOfDefaultPrice+=tmpMulti;
	}

	AdenaString=MakeCostString(string(m_SumOfDefaultPrice));
	class'UIAPI_TEXTBOX'.static.SetText("ManorSeedInfoSettingWnd.txtVarNextTotalExpense", AdenaString);
}




/*

function OnChangeBtn()
{
	local LVDataRecord record;
	local int SelectedIndex;
	local int CropID;
	local string ManorCropSellChangeWndString;

	local string param;
	
	SelectedIndex=class'UIAPI_LISTCTRL'.static.GetSelectedIndex("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	if(SelectedIndex==-1)
		return;

	record=class'UIAPI_LISTCTRL'.static.GetSelectedRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	CropID=record.nReserved2;

	// 서버에 윈도우 열기 요청
	// 원래 문자열 "manor_menu_select?ask=9&state=%d&time=0" <- %d 자리에CropID 가 들어감
	ManorCropSellChangeWndString="manor_menu_select?ask=9&state="$string(CropID)$"&time=0";
	RequestBypassToServer(ManorCropSellChangeWndString);

	// 작물판매량 변경 윈도우에 정보를 보내준다
	ParamAdd(param, "CropName", record.LVDataList[CROP_NAME].szData);
	ParamAdd(param, "RewardType1", record.LVDataList[REWARD_TYPE_1].szData);
	ParamAdd(param, "RewardType2", record.LVDataList[REWARD_TYPE_2].szData);

	ExecuteEvent(EV_ManorCropSellChangeWndSetCropNameAndRewardType, param);
}


function HandleSetCropSell(string a_Param)
{
	local string SellCntString;
	local int ManorID;
	local string ManorName; 
	local string CropRemainCntString;
	local string CropPriceString;
	local string ProcureTypeString;
	local int SelectedIndex;

	local LVDataRecord record;

	ParseString(a_Param, "SellCntString", SellCntString);
	ParseInt(a_Param, "ManorID", ManorID);
	ParseString(a_Param, "ManorName", ManorName);
	ParseString(a_Param, "CropRemainCntString", CropRemainCntString);
	ParseString(a_Param, "CropPriceString", CropPriceString);
	ParseString(a_Param, "ProcureTypeString", ProcureTypeString);

	record=class'UIAPI_LISTCTRL'.static.GetSelectedRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	record.LVDataList[MANOR_NAME].szData=ManorName;
	record.LVDataList[CROP_REMAIN_CNT].szData=CropRemainCntString;
	record.LVDataList[CROP_PRICE].szData=CropPriceString;
	record.LVDataList[PROCURE_TYPE].szData=ProcureTypeString;
	record.LVDataList[SELL_CNT].szData=SellCntString;
	record.nReserved1=ManorID;

	SelectedIndex=class'UIAPI_LISTCTRL'.static.GetSelectedIndex("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");

	class'UIAPI_LISTCTRL'.static.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl", SelectedIndex, record);
}
*/
defaultproperties
{
}
