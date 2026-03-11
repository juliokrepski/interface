class UICommonAPI extends UIScript;

// Dialog API
enum EDialogType
{
	DIALOG_OKCancel,
	DIALOG_OK,
	DIALOG_OKCancelInput,
	DIALOG_OKInput,
	DIALOG_Warning,
	DIALOG_Notice,
	DIALOG_NumberPad,
	DIALOG_Progress,
};

enum DialogDefaultAction
{
	EDefaultNone,
	EDefaultOK,
	EDefaultCancel,
};
enum HeaderPosition
{
	Header_Head,
	Header_MidBody,
	Header_LowBody
};

struct infoautobuff
{
	var int Id;
	var string Name;
	var bool answermatha;
	var int quequierestuax2;
};

// 다이얼로그를 보여준다. strMessage : 함께 보여줄 스트링( 예를들어 "개수를 입력해 주세요" )
// 무척 간단한 다이얼로그가 아닌 이상 DialogSetID() 같이 불러줘야 한다.
function DialogShow( EDialogType dialogType, string strMessage )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.ShowDialog( dialogType, strMessage, string(Self) );
}

// 다이얼로그를 감춘다. 다이얼로그가 떠 있는 상황에서 다른 다이얼로그를 보여주려면 DialogHide() 를 먼저 호출해야한다.
function DialogHide()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.HideDialog();
}

// 엔터 키를 눌렀을 경우 다이얼로그가 어떤 동작을 취할지를 세팅하는 함수이다.
// 이 함수를 부르지 않으면 엔터키가 들어오면 Cancel 버튼을 누른 것과 같은 동작을 한다.
// 한번 사용되고나면 초기화 되므로 디폴트 액션을 OK로 하고싶으면 매번 다이얼로그 띄울 때 마다 불러줘야한다.
function DialogSetDefaultOK()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetDefaultAction( EDefaultOK );
}

// EV_DialogOK 등의 다이얼로그 이벤트가 왔을 때, 이 다이얼로그가 자신이 띄운 다이얼로그 인지를 판별할 때 쓰인다. 남이 띄운 다이얼로그라면 신경쓸 필요가 없다~
function bool DialogIsMine()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	if( script.GetTarget() == string(Self) )
		return true;
	return false;
}

// 한개의 uc에서 다이얼로그를 한번만 띄운다면 쓸 필요가 없겠지만, 다이얼로그를 여러 상황에서 쓴다면, 예를 들어 혈맹.uc에서  혈원아이디를 묻는데도 쓰고
// 혈원 호칭을 입력 받는 데도 사용한다면, 다이얼로그 이벤트가 왔을때 자신이 어떤 다이얼로그를 띄웠는지를 알 필요가 있다.
// 이럴 경우 다이얼로그를 띄울 때 적절하게 아무 숫자나 DialogSetID() 해 주고 이벤트 처리 부분에서 DialogGetID()를 해서 그에 맞게 코드를 짜면된다.
function DialogSetID( int id )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetID( id );
}

// 다이어로그의 에디트 박스의 입력 타입을 지정해 줄 수 있다. 일반 문자열, 숫자, 패스워드 등, XML 프로토콜 문서 참조.
function DialogSetEditType( string strType )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetEditType( strType );
}


function float calculeflo(int i, int x)
{
	return float(i) / float(x);

}

function bool calculebol(int i, int o)
{
	return i == o;

}

function bool calculemixmax(int i, int o)
{
	return i > o;

}


function AddItemNumTex(ItemInfo item, out ItemInfo Info)
{
    Info.ForeTexture = "";
    // End:0x95
    if(item.ItemNum > 1)
    {
        // End:0x5C
        if(item.ItemNum > 99)
        {
            Info.ForeTexture = "L2UI_CH3.ItemCount.texCount99+";            
        }
        else
        {
            Info.ForeTexture = "L2UI_CH3.ItemCount.texCount" $ string(item.ItemNum);
        }        
    }
    else
    {
        // End:0x101
        if(((Info.Enchanted <= 50) && Info.Enchanted > 0) && Info.SlotBitType > 0)
        {
            Info.ForeTexture = "L2UI_CH3.ItemEnchant.enchant" $ string(Info.Enchanted);
        }
    }
 
}




function string getclassx(int classIndex)
{
    switch(classIndex)
    {
        // End:0x15
        case 1:
            return "Warrior";
        // End:0x26
        case 2:
            return "Gladiator";
        // End:0x35
        case 88:
            return "Duelist";
        // End:0x44
        case 3:
            return "Warlord";
        // End:0x57
        case 89:
            return "Dreadnought";
        // End:0x6B
        case 0:
            return "Human Fighter";
        // End:0x7F
        case 4:
            return "Human Knight";
        // End:0x8E
        case 5:
            return "Paladin";
        // End:0xA4
        case 90:
            return "Phoenix Knight";
        // End:0xB8
        case 6:
            return "Dark Avenger";
        // End:0xCB
        case 91:
            return "Hell Knight";
        // End:0xDE
        case 7:
            return "Human Rogue";
        // End:0xF5
        case 8:
            return "Treasure Hunter";
        // End:0x107
        case 93:
            return "Adventurer";
        // End:0x116
        case 9:
            return "Hawkeye";
        // End:0x129
        case 92:
            return "Sagittarius";
        // End:0x139
        case 12:
            return "Sorcerer";
        // End:0x14A
        case 94:
            return "Archmage ";
        // End:0x15E
        case 11:
            return "Human Wizard";
        // End:0x171
        case 13:
            return "Necromancer";
        // End:0x182
        case 95:
            return "Soultaker";
        // End:0x196
        case 10:
            return "Human Mystic";
        // End:0x1A5
        case 14:
            return "Warlock";
        // End:0x1B8
        case 96:
            return "Arcana Lord";
        // End:0x1C6
        case 15:
            return "Cleric";
        // End:0x1D4
        case 16:
            return "Bishop";
        // End:0x1E4
        case 97:
            return "Cardinal";
        // End:0x1F3
        case 17:
            return "Prophet";
        // End:0x205
        case 98:
            return "Hierophant";
        // End:0x21A
        case 20:
            return "Temple Knight";
        // End:0x22F
        case 99:
            return "Eva's Templar";
        // End:0x241
        case 19:
            return "Elf Knight";
        // End:0x254
        case 21:
            return "Swordsinger";
        // End:0x266
        case 100:
            return "Sword Muse";
        // End:0x279
        case 18:
            return "Elf Fighter";
        // End:0x28A
        case 22:
            return "Elf Scout";
        // End:0x29E
        case 23:
            return "Plainswalker";
        // End:0x2B0
        case 101:
            return "Wind Rider";
        // End:0x2C6
        case 24:
            return "Silver Ranger ";
        // End:0x2E0
        case 102:
            return "Moonlight Sentinel";
        // End:0x2F4
        case 26:
            return "Elven Wizard";
        // End:0x307
        case 27:
            return "Spellsinger";
        // End:0x31B
        case 103:
            return "Mystic Muse ";
        // End:0x32F
        case 25:
            return "Elven Mystic";
        // End:0x345
        case 28:
            return "Elem. Summoner";
        // End:0x35E
        case 104:
            return "Elemental Master ";
        // End:0x36C
        case 29:
            return "Oracle";
        // End:0x37F
        case 30:
            return "Elven Elder";
        // End:0x392
        case 105:
            return "Eva's Saint";
        // End:0x3A9
        case 33:
            return "Shillien Knight";
        // End:0x3C1
        case 106:
            return "Shillien Templar";
        // End:0x3D5
        case 32:
            return "Palus Knight";
        // End:0x3E8
        case 34:
            return "Bladedancer";
        // End:0x3FF
        case 107:
            return "Spectral Dancer";
        // End:0x419
        case 31:
            return "Dark Elven Fighter";
        // End:0x429
        case 35:
            return "Assassin";
        // End:0x43D
        case 36:
            return "Abyss Walker";
        // End:0x451
        case 108:
            return "Ghost Hunter";
        // End:0x467
        case 37:
            return "Phantom Ranger";
        // End:0x47D
        case 109:
            return "Ghost Sentinel";
        // End:0x496
        case 39:
            return "Dark Elven Wizard";
        // End:0x4A9
        case 40:
            return "Spellhowler";
        // End:0x4BF
        case 110:
            return "Storm Screamer";
        // End:0x4D8
        case 38:
            return "Dark Elven Mystic";
        // End:0x4F0
        case 41:
            return "Phantom Summoner";
        // End:0x507
        case 111:
            return "Spectral Master";
        // End:0x51E
        case 42:
            return "Shillien Oracle";
        // End:0x534
        case 43:
            return "Shillien Elder";
        // End:0x54A
        case 112:
            return "Shillien Saint";
        // End:0x558
        case 45:
            return "Raider";
        // End:0x569
        case 46:
            return "Destroyer";
        // End:0x576
        case 113:
            return "Titan";
        // End:0x589
        case 44:
            return "Orc Fighter";
        // End:0x595
        case 47:
            return "Monk";
        // End:0x5A3
        case 48:
            return "Tyrant";
        // End:0x5B6
        case 114:
            return "G.Khavatari";
        // End:0x5C6
        case 51:
            return "Overlord";
        // End:0x5D7
        case 115:
            return "Dominator";
        // End:0x5E9
        case 49:
            return "Orc Mystic";
        // End:0x5F7
        case 50:
            return "Shaman";
        // End:0x607
        case 52:
            return "Warcryer";
        // End:0x618
        case 116:
            return "Doomcryer";
        // End:0x627
        case 56:
            return "Artisan";
        // End:0x637
        case 57:
            return "Warsmith";
        // End:0x646
        case 118:
            return "Maestro";
        // End:0x65D
        case 53:
            return "Dwarven Fighter";
        // End:0x66E
        case 54:
            return "Scavenger";
        // End:0x683
        case 55:
            return "Bounty Hunter";
        // End:0x699
        case 117:
            return "Fortune Seeker";
        // End:0xFFFF
        default:
            return "";
            break;
    }

}




function calculemenosmenosa(out int i)
{
	i--;
	return;
}

function bool calculesame(string i, string o)
{
	return i == o;

}

function bool calculemulti(bool i, bool o)
{
	return i || o;

}

function int calculeresta(int i, int o)
{
	return i - o;

}


function int calculesuma(int i, int o)
{
	return i + o;

}


function bool calculemenor(int i, int o)
{
	return i < o;

}

function caculemasmas(out int i)
{
	i++;
	return;
}


function bool calculeand2(bool i, bool o)
{
	return i && o;

}

function bool calculedesigual(bool i)
{
	return !i;

}

function EditBoxHandle EditBoxHandle (string WindowName)
{
	local EditBoxHandle Handle;

	Handle = EditBoxHandle(GetHandle(WindowName));
	return Handle;
}



function calculetamax3ia(out int i)
{
	++i;
	return;
}
function string calculeburgatugar(string i, string o)
{
	return i$o;

}

function bool calculemayorigual(int i, int o)
{
	return i >= o;

}

function bool calculemenorigual(int i, int o)
{
	return i <= o;

}

function int findMatchString(string targetStr, string a_Param)
{
    local array<string> modifiedParamArr;
    local int i;
    local string delim, modifiedString;
    local int _inStr;
    local string strTemp1, strTemp2;

    modifiedString = targetStr;
    delim = " ";
    _inStr = InStr(a_Param, delim);
    J0x26:

    // End:0x88 [Loop If]
    if(_inStr > -1)
    {
        modifiedParamArr.Insert(modifiedParamArr.Length, 1);
        modifiedParamArr[modifiedParamArr.Length - 1] = Left(a_Param, _inStr);
        a_Param = Mid(a_Param, _inStr + 1);
        _inStr = InStr(a_Param, delim);
        // [Loop Continue]
        goto J0x26;
    }
    modifiedParamArr.Insert(modifiedParamArr.Length, 1);
    modifiedParamArr[modifiedParamArr.Length - 1] = a_Param;
    i = 0;
    J0xB1:

    // End:0x11C [Loop If]
    if(i < modifiedParamArr.Length)
    {
        strTemp1 = Caps(modifiedString);
        strTemp2 = Caps(modifiedParamArr[i]);
        // End:0x112
        if((InStr(strTemp1, strTemp2) == -1) && modifiedParamArr[i] != " ")
        {
            return -1;
        }
        i++;
        // [Loop Continue]
        goto J0xB1;
    }
    return 1;

}



function string makeShortStringByPixel(string targetString, int maxPixel, string dotString)
{
    local string fixedText, tempStr;
    local int textWidth, textHeight, dotWidth, dotHeight, i;

    GetTextSize(dotString, dotWidth, dotHeight);
    GetTextSize(targetString, textWidth, textHeight);
    // End:0x47
    if(textWidth <= maxPixel)
    {
        fixedText = targetString;        
    }
    else
    {
        fixedText = targetString;
        i = 0;
        J0x59:

        // End:0xC7 [Loop If]
        if(i < Len(targetString))
        {
            tempStr = Mid(targetString, 0, i);
            GetTextSize(tempStr, textWidth, textHeight);
            // End:0xBD
            if(maxPixel < (textWidth + dotWidth))
            {
                fixedText = tempStr $ dotString;
                // [Explicit Break]
                goto J0xC7;
            }
            i++;
            // [Loop Continue]
            goto J0x59;
        }
    }
    J0xC7:

    return fixedText;

}

function string GetItemGradeTextureName(int item)
{
    // End:0x29
    if(item > 0)
    {
        return "L2ui_ch3.grade_" $ string(item);        
    }
    else
    {
        return "";
    }

}

function string GetItemNameAll(ItemInfo Info)
{
    local string FullName, addStr;

    // End:0x27
    if(Info.Enchanted > 0)
    {
        FullName = "+" $ string(Info.Enchanted);
    }
    // End:0x53
    if(Len(FullName) > 0)
    {
        FullName = (FullName $ " ") $ Info.Name;        
    }
    else
    {
        FullName = Info.Name;
    }
    // End:0x91
    if(Len(Info.AdditionalName) > 0)
    {
        addStr = (addStr $ " ") $ Info.AdditionalName;
    }
    FullName = FullName $ addStr;
    return FullName;
 
}




// 다이얼로그의 에디트박스에 입력된 스트링을 받아온다
function string DialogGetString()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	return script.GetEditMessage();
}

// 다이얼로그의 에디트박스에 스트링을 입력한다
function DialogSetString(string strInput)
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetEditMessage(strInput);
}

function int DialogGetID()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	return script.GetID();
}

// ParamInt는 다이얼로그의 동작과 관련된 상수들을 지정해 주는데 쓰인다. Progress의 timeup 시간, NumberPad에서 max값 등.
function DialogSetParamInt( int param )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetParamInt( param );
}

// ReservedXXX 값들은 다이얼로그에 넣어놨다가 다시 꺼내 볼 수 있다는 점에서 ParamXXX와는 다르다.
function DialogSetReservedInt( int value )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetReservedInt( value );
}

function DialogSetReservedInt2( int value )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetReservedInt2( value );
}

function DialogSetReservedInt3( int value )
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetReservedInt3( value );
}

function int DialogGetReservedInt()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	return script.GetReservedInt();
}

function int DialogGetReservedInt2()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	return script.GetReservedInt2();
}

function int DialogGetReservedInt3()
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	return script.GetReservedInt3();
}

function DialogSetEditBoxMaxLength(int maxLength)
{
	local DialogBox	script;
	script = DialogBox(GetScript("DialogBox"));
	script.SetEditBoxMaxLength(maxLength);
}

function int Split( string strInput, string delim, out array<string> arrToken )
{
	local int arrSize;
	
	while ( InStr(strInput, delim)>0 )
	{
		arrToken.Insert(arrToken.Length, 1);
		arrToken[arrToken.Length-1] = Left(strInput, InStr(strInput, delim));
		strInput = Mid(strInput, InStr(strInput, delim)+1);
		arrSize = arrSize + 1;
	}
	arrToken.Insert(arrToken.Length, 1);
	arrToken[arrToken.Length-1] = strInput;
	arrSize = arrSize + 1;
	
	return arrSize;
}

function ShowWindow( string a_ControlID )
{
	class'UIAPI_WINDOW'.static.ShowWindow( a_ControlID );
}

function ShowWindowWithFocus( string a_ControlID )
{
	class'UIAPI_WINDOW'.static.ShowWindow( a_ControlID );
	class'UIAPI_WINDOW'.static.SetFocus( a_ControlID );
}


function HideWindow( string a_ControlID )
{
	class'UIAPI_WINDOW'.static.HideWindow( a_ControlID );
}



function TextureHandle GetTextureHandle(string WindowName)
{
	local TextureHandle Handle;

	Handle = TextureHandle(GetHandle(WindowName));
	return Handle;
}

function TextBoxHandle GetTextBoxHandle(string WindowName)
{
	local TextBoxHandle Handle;

	Handle = TextBoxHandle(GetHandle(WindowName));
	return Handle;
}

function AnimTextureHandle GetAnimTextureHandle(string WindowName)
{
	local AnimTextureHandle Handle;

	Handle = AnimTextureHandle(GetHandle(WindowName));
	return Handle;
}

function float xxfloat(int zzsada, int zzwdasd)
{
	return float(zzsada) / float(zzwdasd);

}


function BarHandle GetBarHandle(string WindowName)
{
	local private BarHandle Handle;

	Handle = BarHandle(GetHandle(WindowName));
	return Handle;
 
}
function string setItemDecWidth(string strIndex, int intIndex)
{
	local int i;
	local string lineJump, outStr, compareStr;
	local array< string> writeStr;

	if( InStr(strIndex, "\\n") > -1 )
	{
		return strIndex;
	}
	outStr = "";
	compareStr = "";
	intIndex -= 6;
	lineJump = "";
	writeStr = getStringItems(strIndex, " ");
	i = 0;
J0x59:
	if( i < writeStr.Length )
	{
		if( ((GetTextWidth(compareStr)) + (GetTextWidth(writeStr[i]))) <= intIndex )
		{
			if( i == writeStr.Length )
			{
				compareStr = compareStr$writeStr[i];
			}
			else
			{
				compareStr = (compareStr$writeStr[i])$" ";
			}
			goto J0x10B;
		}
		outStr = (outStr$compareStr)$lineJump;
		compareStr = writeStr[i]$" ";
	J0x10B:
		i++;
		goto J0x59;
	}
	outStr = outStr$compareStr;
	return outStr;
}

function int GetTextWidth(string val)
{
	local int ent1;
	local int ent2;

	GetTextSize(val, ent1, ent2);
	return ent1;
}

function array<string> getStringItems(string strIndex, string strBlank)
{
	local string percStr;
	local array< string> strSize;
	local int i;

	percStr = strIndex;
J0x0B:
	if( percStr != "" )
	{
		i = InStr(percStr, strBlank);
		if( i == -1 )
		{
			strSize[strSize.Length] = percStr;
			percStr = "";
		}
		else
		{
			strSize[strSize.Length] = Left(percStr, i);
			percStr = Mid(percStr, i + Len(strBlank));
		}
		goto J0x0B;
	}
	return strSize;
}



function ButtonHandle GetButtonHandle(string WindowName)
{
	local ButtonHandle Handle;

	Handle = ButtonHandle(GetHandle(WindowName));
	return Handle;
}

function ItemWindowHandle GetItemWindowHandle(string WindowName)
{
	local ItemWindowHandle Handle;

	Handle = ItemWindowHandle(GetHandle(WindowName));
	return Handle;
}



function WindowHandle GetWindowHandle(string WindowName)
{
	local WindowHandle Handle;

	Handle = GetHandle(WindowName);
	return Handle;
}




function ParamToItemInfo (string index, out ItemInfo Info)
{
	local int tmpInt;
	local EItemType eItemType;
	eItemType = EItemType(info.ItemType);

	ParseInt(index,"classID",Info.ClassID);
	ParseInt(index,"level",Info.Level);
	ParseString(index,"name",Info.Name);
	ParseString(index,"additionalName",Info.AdditionalName);
	ParseString(index,"iconName",Info.IconName);
	ParseString(index,"description",Info.Description);
	ParseInt(index,"itemType",Info.ItemType);
	ParseInt(index,"serverID",Info.ServerID);
	ParseInt(index,"itemNum",Info.ItemNum);
	ParseInt(index,"slotBitType",Info.SlotBitType);
	ParseInt(index,"enchanted",Info.Enchanted);
	ParseInt(index,"blessed",Info.Blessed);
	ParseInt(index,"damaged",Info.Damaged);
	if ( ParseInt(index,"equipped",tmpInt) )
	{
		Info.bEquipped = bool(tmpInt);
	}
	ParseInt(index,"price",Info.Price);
	ParseInt(index,"reserved",Info.Reserved);
	ParseInt(index,"defaultPrice",Info.DefaultPrice);
	ParseInt(index,"refineryOp1",Info.RefineryOp1);
	ParseInt(index,"refineryOp2",Info.RefineryOp2);
	ParseInt(index,"currentDurability",Info.CurrentDurability);
	ParseInt(index,"weight",Info.Weight);
	ParseInt(index,"materialType",Info.MaterialType);
	ParseInt(index,"weaponType",Info.WeaponType);
	ParseInt(index,"physicalDamage",Info.PhysicalDamage);
	ParseInt(index,"magicalDamage",Info.MagicalDamage);
	ParseInt(index,"shieldDefense",Info.ShieldDefense);
	ParseInt(index,"shieldDefenseRate",Info.ShieldDefenseRate);
	ParseInt(index,"durability",Info.Durability);
	ParseInt(index,"crystalType",Info.CrystalType);
	ParseInt(index,"randomDamage",Info.RandomDamage);
	ParseInt(index,"critical",Info.Critical);
	ParseInt(index,"hitModify",Info.HitModify);
	ParseInt(index,"attackSpeed",Info.AttackSpeed);
	ParseInt(index,"mpConsume",Info.MpConsume);
	ParseInt(index,"avoidModify",Info.AvoidModify);
	ParseInt(index,"soulshotCount",Info.SoulshotCount);
	ParseInt(index,"spiritshotCount",Info.SpiritshotCount);
	ParseInt(index,"armorType",Info.ArmorType);
	ParseInt(index,"physicalDefense",Info.PhysicalDefense);
	ParseInt(index,"magicalDefense",Info.MagicalDefense);
	ParseInt(index,"mpBonus",Info.MpBonus);
	ParseInt(index,"consumeType",Info.ConsumeType);
	ParseInt(index,"ItemSubType",Info.ItemSubType);
	ParseString(index,"iconNameEx1",Info.IconNameEx1);
	ParseString(index,"iconNameEx2",Info.IconNameEx2);
	ParseString(index,"iconNameEx3",Info.IconNameEx3);
	ParseString(index,"iconNameEx4",Info.IconNameEx4);
	if ( ParseInt(index,"arrow",tmpInt) )
	{
		Info.bArrow = bool(tmpInt);
	}
	if ( ParseInt(index,"recipe",tmpInt) )
	{
		Info.bRecipe = bool(tmpInt);
	}
	if ( (eItemType == ITEM_WEAPON || eItemType == ITEM_ARMOR || eItemType == ITEM_ACCESSARY) && (Info.Enchanted <= 50 && Info.Enchanted > 0) )
	{
		Info.ForeTexture = "L2UI_CH3.ENCHANT"$Info.Enchanted$"";
	}

	if ( Info.ItemNum > 1 )
	{
		if ( Info.ItemNum > 99 )
		{
			Info.ForeTexture = "L2UI_CH3.ItemCount.texCount99+";
		}
		else
		{
			Info.ForeTexture = "L2UI_CH3.ItemCount.texCount"$string(Info.ItemNum);
		}
	}


}






function  getlevel()
{
RequestBypassToServer("getlevel");
}

function int GetShotSlot(int shotID)
{
    switch(shotID)
    {
        // End:0x0F
        case 1835:
        // End:0x17
        case 1463:
        // End:0x1F
        case 1464:
        // End:0x27
        case 1465:
        // End:0x2F
        case 1466:
        // End:0x3C
        case 1467:
            return 1;
            // End:0xC9
            break;
        // End:0x44
        case 3947:
        // End:0x4C
        case 3948:
        // End:0x54
        case 3949:
        // End:0x5C
        case 3950:
        // End:0x64
        case 3951:
        // End:0x6C
        case 3952:
        // End:0x74
        case 2509:
        // End:0x7C
        case 2510:
        // End:0x84
        case 2511:
        // End:0x8C
        case 2512:
        // End:0x94
        case 2513:
        // End:0xA2
        case 2514:
            return 2;
            // End:0xC9
            break;
        // End:0xB0
        case 6645:
            return 3;
            // End:0xC9
            break;
        // End:0xB8
        case 6646:
        // End:0xC6
        case 6647:
            return 4;
            // End:0xC9
            break;
        // End:0xFFFF
        default:
            break;
    }

}


function ItemInfoToParam(ItemInfo Info, out string param)
{
    ParamAdd(param, "ClassID", string(Info.ClassID));
    ParamAdd(param, "ServerID", string(Info.ServerID));
    ParamAdd(param, "level", string(Info.Level));
    ParamAdd(param, "name", Info.Name);
    ParamAdd(param, "additionalName", Info.AdditionalName);
    ParamAdd(param, "iconName", Info.IconName);
    ParamAdd(param, "description", Info.Description);
    ParamAdd(param, "itemType", string(Info.ItemType));
    ParamAdd(param, "itemNum", string(Info.ItemNum));
    ParamAdd(param, "slotBitType", string(Info.SlotBitType));
    ParamAdd(param, "enchanted", string(Info.Enchanted));
    ParamAdd(param, "blessed", string(Info.Blessed));
    ParamAdd(param, "damaged", string(Info.Damaged));
    ParamAdd(param, "equipped", string(Info.bEquipped));
    ParamAdd(param, "price", string(Info.Price));
    ParamAdd(param, "reserved", string(Info.Reserved));
    ParamAdd(param, "defaultPrice", string(Info.DefaultPrice));
    ParamAdd(param, "refineryOp1", string(Info.RefineryOp1));
    ParamAdd(param, "refineryOp2", string(Info.RefineryOp2));
    ParamAdd(param, "currentDurability", string(Info.CurrentDurability));
    ParamAdd(param, "weight", string(Info.Weight));
    ParamAdd(param, "materialType", string(Info.MaterialType));
    ParamAdd(param, "weaponType", string(Info.WeaponType));
    ParamAdd(param, "physicalDamage", string(Info.PhysicalDamage));
    ParamAdd(param, "magicalDamage", string(Info.MagicalDamage));
    ParamAdd(param, "shieldDefense", string(Info.ShieldDefense));
    ParamAdd(param, "shieldDefenseRate", string(Info.ShieldDefenseRate));
    ParamAdd(param, "durability", string(Info.Durability));
    ParamAdd(param, "crystalType", string(Info.CrystalType));
    ParamAdd(param, "randomDamage", string(Info.RandomDamage));
    ParamAdd(param, "critical", string(Info.Critical));
    ParamAdd(param, "hitModify", string(Info.HitModify));
    ParamAdd(param, "attackSpeed", string(Info.AttackSpeed));
    ParamAdd(param, "mpConsume", string(Info.MpConsume));
    ParamAdd(param, "avoidModify", string(Info.AvoidModify));
    ParamAdd(param, "soulshotCount", string(Info.SoulshotCount));
    ParamAdd(param, "spiritshotCount", string(Info.SpiritshotCount));
    ParamAdd(param, "armorType", string(Info.ArmorType));
    ParamAdd(param, "physicalDefense", string(Info.PhysicalDefense));
    ParamAdd(param, "magicalDefense", string(Info.MagicalDefense));
    ParamAdd(param, "mpBonus", string(Info.MpBonus));
    ParamAdd(param, "consumeType", string(Info.ConsumeType));
    ParamAdd(param, "ItemSubType", string(Info.ItemSubType));
    ParamAdd(param, "iconNameEx1", Info.IconNameEx1);
    ParamAdd(param, "iconNameEx2", Info.IconNameEx2);
    ParamAdd(param, "iconNameEx3", Info.IconNameEx3);
    ParamAdd(param, "iconNameEx4", Info.IconNameEx4);
    ParamAdd(param, "arrow", string(Info.bArrow));
    ParamAdd(param, "recipe", string(Info.bRecipe));
    return;
}

function bool isalgo(string v, out ItemInfo info)
{
	local ItemWindowHandle me;

	me = GetItemWindowHandle("InventoryWnd.InventoryItem");
    // End:0x42
	if( function200(me, v, info) )
	{
		return True;
	}
	me = GetItemWindowHandle("InventoryWnd.QuestItem");
    // End:0x8D
	if( function200(me, v, info) )
	{
		info.bShowCount = True;
		return True;
	}
	return False;

}

function bool function200(ItemWindowHandle me, string saaa, out ItemInfo info)
{
	local int i, j;

	i = me.GetItemNum();
	j = 0;
J0x1C:

    // End:0x67 [Loop If]
	if( j <= i )
	{
        // End:0x5D
		if( me.GetItem(j, info) )
		{
            // End:0x5D
			if( info.Name == saaa )
			{
				return True;
			}
		}
		j++;
        // [Loop Continue]
		goto J0x1C;
	}
	return False;

}

function bool finditemconid(int valonmano, out ItemInfo info)
{
	local int supradurpa, conchapu;
	local ItemWindowHandle Mex;
	local InventoryWnd scripts;

	Mex = GetItemWindowHandle("InventoryWnd.InventoryItem");
	conchapu = tucarronax22(Mex, valonmano);
    // End:0x11F
	if( conchapu <= -1 )
	{
		Mex = GetItemWindowHandle("InventoryWnd.QuestItem");
		conchapu = tucarronax22(Mex, valonmano);
        // End:0x11F
		if( conchapu <= -1 )
		{
			scripts = InventoryWnd(GetScript("InventoryWnd"));
			supradurpa = 0;
		J0xBC:

            // End:0x11F [Loop If]
			if( supradurpa < 15 )
			{
				conchapu = tucarronax22(scripts.m_equipItem[supradurpa], valonmano);
                // End:0x115
				if( conchapu >= 0 )
				{
					Mex = scripts.m_equipItem[supradurpa];
                    // [Explicit Break]
					goto J0x11F;
				}
				supradurpa++;
                // [Loop Continue]
				goto J0xBC;
			}
		}
	}
J0x11F:

    // End:0x13D
	if( Mex.GetItem(conchapu, info) )
	{
		return True;
	}
	return False;

}

function int tucarronax22(ItemWindowHandle mondak, int i)
{
	local int colagusano;

    // End:0x2C
	if( i < 100000000 )
	{
		colagusano = mondak.FindItemWithClassID(i);
	}
	else
	{
		colagusano = mondak.FindItemWithServerID(i);
	}
	return colagusano;

}

function Color getcottt(string j)
{
	local Color getc;

	getc.A = byte(255);
	switch(j)
	{
        // End:0x4D
		case "Goldlite":
			getc.R = 230;
			getc.G = 213;
			getc.B = 164;
            // End:0x418
			break;
        // End:0x80
		case "Grey":
			getc.R = 180;
			getc.G = 180;
			getc.B = 180;
            // End:0x418
			break;
        // End:0xB8
		case "GreyLight":
			getc.R = 220;
			getc.G = 220;
			getc.B = 220;
            // End:0x418
			break;
        // End:0xEF
		case "GreyDark":
			getc.R = 100;
			getc.G = 100;
			getc.B = 100;
            // End:0x418
			break;
        // End:0x128
		case "Yellow":
			getc.R = byte(255);
			getc.G = byte(255);
			getc.B = 0;
            // End:0x418
			break;
        // End:0x15C
		case "Red":
			getc.R = byte(255);
			getc.G = 0;
			getc.B = 0;
            // End:0x418
			break;
        // End:0x191
		case "Blue":
			getc.R = 0;
			getc.G = 0;
			getc.B = byte(255);
            // End:0x418
			break;
        // End:0x1C7
		case "Green":
			getc.R = 0;
			getc.G = byte(255);
			getc.B = 0;
            // End:0x418
			break;
        // End:0x1FC
		case "Orange":
			getc.R = 230;
			getc.G = 153;
			getc.B = 77;
            // End:0x418
			break;
        // End:0x231
		case "System":
			getc.R = 176;
			getc.G = 155;
			getc.B = 121;
            // End:0x418
			break;
        // End:0x265
		case "Amber":
			getc.R = 218;
			getc.G = 165;
			getc.B = 32;
            // End:0x418
			break;
        // End:0x29F
		case "White":
			getc.R = byte(255);
			getc.G = byte(255);
			getc.B = byte(255);
            // End:0x418
			break;
        // End:0x2D1
		case "Dim":
			getc.R = 177;
			getc.G = 173;
			getc.B = 172;
            // End:0x418
			break;
        // End:0x30B
		case "Magenta":
			getc.R = byte(255);
			getc.G = 0;
			getc.B = byte(255);
            // End:0x418
			break;
        // End:0x33F
		case "Brown":
			getc.R = 176;
			getc.G = 155;
			getc.B = 121;
            // End:0x418
			break;
        // End:0x373
		case "Black":
			getc.R = 0;
			getc.G = 0;
			getc.B = 0;
            // End:0x418
			break;
        // End:0x3AB
		case "LightPink":
			getc.R = 191;
			getc.G = 168;
			getc.B = 211;
            // End:0x418
			break;
        // End:0x3E5
		case "LightBlue":
			getc.R = 128;
			getc.G = 153;
			getc.B = byte(255);
            // End:0x418
			break;
        // End:0xFFFF
		default:
			getc.R = byte(255);
			getc.G = byte(255);
			getc.B = byte(255);
            // End:0x418
			break;
			break;
	}
	return getc;
}

function array<string> xxlista23(string val, string val2)
{
	local array<string> listastring;
	local int startPos;

	local string remaining;

	listastring.Length = 0;
	remaining = val;

	while ( remaining != "" )
	{

		startPos = InStr(remaining, val2);

		if ( startPos == -1 )
		{

			listastring[listastring.Length] = remaining;
			remaining = "";
		}
		else
		{

			listastring[listastring.Length] = Left(remaining, startPos);

			remaining = Mid(remaining, startPos + Len(val2));
		}
	}

	return listastring;
}


function int GetSoulShotID(int WeaponGrade)
{
    local ItemInfo weaponItemInfo;

    switch(WeaponGrade)
    {
        // End:0x4B
        case 0:
            // End:0x48
            if(GetItemWindowHandle("InventoryWnd.EquipItem_RHand").GetItem(0, weaponItemInfo))
            {
                return 1835;
            }
            // End:0x93
            break;
        // End:0x58
        case 1:
            return 1463;
            // End:0x93
            break;
        // End:0x66
        case 2:
            return 1464;
            // End:0x93
            break;
        // End:0x74
        case 3:
            return 1465;
            // End:0x93
            break;
        // End:0x82
        case 4:
            return 1466;
            // End:0x93
            break;
        // End:0x90
        case 5:
            return 1467;
            // End:0x93
            break;
        // End:0xFFFF
        default:
            break;
    }

}

function int GetSpiritShotID(int WeaponGrade)
{
    local ItemInfo weaponItemInfo;

    switch(WeaponGrade)
    {
        // End:0x4B
        case 0:
            // End:0x48
            if(GetItemWindowHandle("InventoryWnd.EquipItem_RHand").GetItem(0, weaponItemInfo))
            {
                return 2509;
            }
            // End:0x93
            break;
        // End:0x58
        case 1:
            return 2510;
            // End:0x93
            break;
        // End:0x66
        case 2:
            return 2511;
            // End:0x93
            break;
        // End:0x74
        case 3:
            return 2512;
            // End:0x93
            break;
        // End:0x82
        case 4:
            return 2513;
            // End:0x93
            break;
        // End:0x90
        case 5:
            return 2514;
            // End:0x93
            break;
        // End:0xFFFF
        default:
            break;
    }

}

function int GetBlessedSpiritShotID(int WeaponGrade)
{
    local ItemInfo weaponItemInfo;

    switch(WeaponGrade)
    {
        // End:0x4B
        case 0:
            // End:0x48
            if(GetItemWindowHandle("InventoryWnd.EquipItem_RHand").GetItem(0, weaponItemInfo))
            {
                return 3947;
            }
            // End:0x93
            break;
        // End:0x58
        case 1:
            return 3948;
            // End:0x93
            break;
        // End:0x66
        case 2:
            return 3949;
            // End:0x93
            break;
        // End:0x74
        case 3:
            return 3950;
            // End:0x93
            break;
        // End:0x82
        case 4:
            return 3951;
            // End:0x93
            break;
        // End:0x90
        case 5:
            return 3952;
            // End:0x93
            break;
        // End:0xFFFF
        default:
            break;
    }

}





function bool IsShowWindow( string a_ControlID )
{
	return class'UIAPI_WINDOW'.static.IsShowWindow( a_ControlID );
}

function ComboBoxHandle GetComboBoxHandle( string WindowName )
{
	local ComboBoxHandle Handle;

	Handle = ComboBoxHandle(GetHandle(WindowName));
	return Handle;
}

function SetEnchantTex(out ItemInfo a_ItemInfo)
{
    // End:0x5A
    if((a_ItemInfo.Enchanted <= 50) && a_ItemInfo.Enchanted > 0)
    {
        a_ItemInfo.ForeTexture = "L2UI_CH3.ItemEnchant.enchant" $ string(a_ItemInfo.Enchanted);
    }
    return;
}
function bool IsSongDance(int SkillID)
{
    switch(SkillID)
    {
        // End:0x0F
        case 529:
        // End:0x17
        case 764:
        // End:0x1F
        case 264:
        // End:0x27
        case 265:
        // End:0x2F
        case 266:
        // End:0x37
        case 267:
        // End:0x3F
        case 268:
        // End:0x47
        case 269:
        // End:0x4F
        case 270:
        // End:0x57
        case 304:
        // End:0x5F
        case 305:
        // End:0x67
        case 306:
        // End:0x6F
        case 308:
        // End:0x77
        case 349:
        // End:0x7F
        case 363:
        // End:0x87
        case 364:
        // End:0x8F
        case 271:
        // End:0x97
        case 272:
        // End:0x9F
        case 273:
        // End:0xA7
        case 274:
        // End:0xAF
        case 275:
        // End:0xB7
        case 276:
        // End:0xBF
        case 277:
        // End:0xC7
        case 307:
        // End:0xCF
        case 309:
        // End:0xD7
        case 310:
        // End:0xDF
        case 311:
        // End:0xE7
        case 365:
        // End:0xEF
        case 366:
        // End:0xF7
        case 530:
        // End:0x104
        case 765:
            return true;
            // End:0x10C
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }    

}
function bool xxIsValidItemID(ItemInfo Id)
{
    // End:0x24
	if( (Id.ClassID < 1) && Id.ServerID < 1 )
	{
		return False;
	}
	return True;

}
function bool xxIsUseAutoEquipSoulShot()
{
	return false;
}


function L2Util xxgetInstanceL2Util()
{
	local L2Util utilbar;
	utilbar = L2Util(GetScript("L2Util"));
	return utilbar;
}




function ParamToRecord( string param, out LVDataRecord record )
{
	local int idx;
	local int MaxColumn;
	
	ParseString( param, "szReserved", record.szReserved );
	ParseInt( param, "nReserved1", record.nReserved1 );
	ParseInt( param, "nReserved2", record.nReserved2 );
	ParseInt( param, "nReserved3", record.nReserved3 );

	ParseInt( param, "MaxColumn", MaxColumn );
	record.LVDataList.Length = MaxColumn;
	for (idx=0; idx<MaxColumn; idx++)
	{
		ParseString( param, "szData_" $ idx, record.LVDataList[idx].szData );
		ParseString( param, "szReserved_" $ idx, record.LVDataList[idx].szReserved );
		ParseInt( param, "nReserved1_" $ idx, record.LVDataList[idx].nReserved1 );
		ParseInt( param, "nReserved2_" $ idx, record.LVDataList[idx].nReserved2 );
		ParseInt( param, "nReserved3_" $ idx, record.LVDataList[idx].nReserved3 );
	}
}





function StxXml(string TreeName, string NodeName, string ItemName, optional int offsetX, optional int offsetY, optional int E, optional bool OneLine, optional bool bLineBreak)
{
    local XMLTreeNodeItemInfo infNodeItem;

    // Asegurate de que el nombre del nodo sea unico
    infNodeItem.eType = XTNITEM_TEXT;
    infNodeItem.t_strText = ItemName;
    infNodeItem.t_bDrawOneLine = OneLine;
    infNodeItem.bLineBreak = bLineBreak;
    infNodeItem.nOffSetX = offsetX;
    infNodeItem.nOffSetY = offsetY;
    infNodeItem = Virtual(E, infNodeItem);
    Class'UIAPI_TREECTRL'.static.InsertNodeItem(TreeName, NodeName, infNodeItem);
}

function bool IsNotShowGauge(int m_skillID)
{
    local bool showGauge;

    showGauge = false;
    switch(m_skillID)
    {
        // End:0x17
        case 2039:
        // End:0x1F
        case 2150:
        // End:0x27
        case 2151:
        // End:0x2F
        case 2152:
        // End:0x37
        case 2153:
        // End:0x3F
        case 2154:
        // End:0x47
        case 2047:
        // End:0x4F
        case 2155:
        // End:0x57
        case 2156:
        // End:0x5F
        case 2157:
        // End:0x67
        case 2158:
        // End:0x6F
        case 2159:
        // End:0x77
        case 2061:
        // End:0x7F
        case 2160:
        // End:0x87
        case 2161:
        // End:0x8F
        case 2162:
        // End:0x97
        case 2163:
        // End:0x9F
        case 2164:
        // End:0xA7
        case 26060:
        // End:0xAF
        case 26061:
        // End:0xB7
        case 26062:
        // End:0xBF
        case 26063:
        // End:0xC7
        case 26064:
        // End:0xCF
        case 22036:
        // End:0xD7
        case 22037:
        // End:0xDF
        case 22038:
        // End:0xE7
        case 2033:
        // End:0xEF
        case 2008:
        // End:0xF7
        case 2009:
        // End:0xFF
        case 26050:
        // End:0x107
        case 26051:
        // End:0x10F
        case 26052:
        // End:0x117
        case 26053:
        // End:0x11F
        case 26054:
        // End:0x127
        case 26055:
        // End:0x12F
        case 26056:
        // End:0x137
        case 26057:
        // End:0x13F
        case 26058:
        // End:0x147
        case 26059:
        // End:0x14F
        case 22369:
        // End:0x157
        case 2499:
        // End:0x15F
        case 2166:
        // End:0x167
        case 2005:
        // End:0x16F
        case 2037:
        // End:0x182
        case 2038:
            showGauge = true;
            // End:0x185
            break;
        // End:0xFFFF
        default:
            break;
    }
    return showGauge;
   
}


function TreeInsertRootNode(string TreeName, string NodeName, string ParentName, optional int offsetX, optional int offsetY)
{
	local XMLTreeNodeInfo infNode;

    // Aseg첬rate de que el nombre del nodo sea 첬nico
	infNode.strName = NodeName;
	infNode.nOffSetX = offsetX;
	infNode.nOffSetY = offsetY;
	class'UIAPI_TREECTRL'.static.InsertNode(TreeName, ParentName, infNode);
}


function xxstx2k23( string zzTreeName, string zzNodeName, string zzTextureName, int zzTextureWidth, int zzTextureHeight, optional int zzoffsetX, optional int zzoffsetY, optional bool zzOneLine, optional bool zzbLineBreak, optional int zzVAL, optional int zzVAL2, optional string VALSTR)
{
	local XMLTreeNodeItemInfo zzinfNode;

	zzinfNode.eType = XTNITEM_TEXTURE;
	zzinfNode.t_bDrawOneLine = zzOneLine;
	zzinfNode.bLineBreak = zzbLineBreak;
	zzinfNode.nOffSetX = zzoffsetX;
	zzinfNode.nOffSetY = zzoffsetY;
	zzinfNode.u_nTextureWidth = zzTextureWidth;
	zzinfNode.u_nTextureHeight = zzTextureHeight;

	zzinfNode.u_nTextureUWidth = zzVAL;
	zzinfNode.u_nTextureUHeight = zzVAL2;
	zzinfNode.u_strTexture = zzTextureName;


	getinsertnodeitem(zzTreeName,zzNodeName,zzinfNode);
}

function ListCtrlHandle ListCtrlHandle (string WindowName)
{
	local ListCtrlHandle Handle;

	Handle = ListCtrlHandle(GetHandle(WindowName));
	return Handle;
}

function texCountNoStack (out ItemInfo Info)
{
	local int ItemNum;

	ItemNum = FindNoStackableItem(Info.ClassID);
	if ( (ItemNum > 1) )
	{
		if ( (ItemNum > 99) )
		{
			Info.ForeTexture = "L2UI_CH3.ItemCount.texCount99+";
		} 


		else 
	  
		{
			Info.ForeTexture = ("L2UI_CH3.ItemCount.texCount"$string(ItemNum));
		}
	}
}
function Color GetRefineColor(int Quality)
{
    local Color tmp;

    switch(Quality)
    {
        // End:0x35
        case 1:
            tmp.R = 187;
            tmp.G = 181;
            tmp.B = 138;
            // End:0xEF
            break;
        // End:0x64
        case 2:
            tmp.R = 132;
            tmp.G = 174;
            tmp.B = 216;
            // End:0xEF
            break;
        // End:0x93
        case 3:
            tmp.R = 193;
            tmp.G = 112;
            tmp.B = 202;
            // End:0xEF
            break;
        // End:0xC2
        case 4:
            tmp.R = 225;
            tmp.G = 109;
            tmp.B = 109;
            // End:0xEF
            break;
        // End:0xFFFF
        default:
            tmp.R = 187;
            tmp.G = 181;
            tmp.B = 138;
            // End:0xEF
            break;
            break;
    }
    return tmp;
 
}
function Color GetColorXA(int R, int G, int B, int A)
{
    local Color tColor;

    tColor.R = byte(R);
    tColor.G = byte(G);
    tColor.B = byte(B);
    tColor.A = byte(A);
    return tColor;

}



function Color GetItemNameWithoutTag (out string iName)
{
	local Color tmp;
	local int Color;


	if ( Mid(iName, Len(iName) - 3, 1) == "[" && Mid(iName, Len(iName) - 1, 1) == "]" )

	{
		Color = int(Mid(iName, Len(iName) - 2, 1));

		switch (Color)
		{
			case 1:
				tmp.R = 255;
				tmp.G = 0;
				tmp.B = 255;
				tmp.A = 255;
				break;
			case 2:
				tmp.R = 152;
				tmp.G = 83;
				tmp.B = 179;
				tmp.A = 230;
				break;
			case 3:
				tmp.R = 33;
				tmp.G = 164;
				tmp.B = 255;
				tmp.A = 255;
				break;
			case 4:
				tmp.R = 138;
				tmp.G = 255;
				tmp.B = 0;
				tmp.A = 255;
				break;
			case 5:
				tmp.R = 255;
				tmp.G = 251;
				tmp.B = 4;
				tmp.A = 255;
				break;
			case 6:
				tmp.R = 240;
				tmp.G = 68;
				tmp.B = 68;
				tmp.A = 255;
				break;
			default:
		}
		iName = Left(iName, Len(iName) - 3);

	}
	return tmp;
}

function bool FindItemByServerID (int ServerID, out ItemInfo item)
{
	local int i;
	local int pos;
	local ItemWindowHandle InvWnd;
	local InventoryWnd script;

	script = InventoryWnd(GetScript("InventoryWnd"));
	pos = script.m_invenItem.FindItemWithServerID(ServerID);
	if ( pos > -1 )
	{
		InvWnd = script.m_invenItem;
	}
	if ( pos < 0 )
	{
		i = 0;
		if ( i < 15 )
		{
			pos = script.m_equipItem[i].FindItemWithServerID(ServerID);
			if ( pos > -1 )
			{
				InvWnd = script.m_equipItem[i];
			} 
	  
	
			else 
	    
			{
				i++;

			}
		}
	}
	if ( InvWnd.GetItem(pos,item) )
	{
		return True;
	}
	return False;
}


function string Replace (string Text, string Replace, string With)
{
	local int i;
	local string Input;

	Input = Text;
	Text = "";
	i = InStr(Input,Replace);
	if ( i != -1 )
	{
		Text = (Text$Left(Input,i)$With);
		Input = Mid(Input, Len(Input) + i);
		i = InStr(Input,Replace);

	}
	return Text$Input;
}



function int FindNoStackableItem (int ClassID)
{
	local int i;
	local int itemCount;
	local int invenLimit;
	local ItemInfo item;
	local ItemWindowHandle InvWnd;

	InvWnd = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
	invenLimit = InvWnd.GetItemNum();
	itemCount = 0;
	i = 0;
	if ( i < invenLimit )
	{
		InvWnd.GetItem(i,item);
		if ( item.ClassID == ClassID )
		{
			itemCount++;
		}
		i++;

	}
	return itemCount;
}

function xxStxXml(string zzTreeName, string zzNodeName, string zzItemName, optional int zzoffsetX, optional int zzoffsetY, optional int E, optional bool zzOneLine, optional bool zzbLineBreak)
{
	local XMLTreeNodeItemInfo zzinfNodeItem;

    // Aseg첬rate de que el nombre del nodo sea 첬nico
	zzinfNodeItem.eType = XTNITEM_TEXT;
	zzinfNodeItem.t_strText = zzItemName;
	zzinfNodeItem.t_bDrawOneLine = zzOneLine;
	zzinfNodeItem.bLineBreak = zzbLineBreak;
	zzinfNodeItem.nOffSetX = zzoffsetX;
	zzinfNodeItem.nOffSetY = zzoffsetY;
	zzinfNodeItem = Virtual(E, zzinfNodeItem);
	class'UIAPI_TREECTRL'.static.InsertNodeItem(zzTreeName, zzNodeName, zzinfNodeItem);
}


function string TreeInsertItemTooltipSimpleNode (string TreeName, string NodeName, string ParentName, int nTexExpandedOffSetX, int nTexExpandedOffSetY, int nTexExpandedHeight, int nTexExpandedRightWidth, int nTexExpandedLeftUWidth, int nTexExpandedLeftUHeight, optional string TooltipSimpleText, optional string strTexExpandedLeft, optional int offsetX, optional int offsetY)
{
	local XMLTreeNodeInfo infNode;

	if ( TooltipSimpleText != "" )
	{
		infNode.ToolTip = xxMakeTooltipSimpleText(TooltipSimpleText);
	}
	if ( strTexExpandedLeft == "" )
	{
		strTexExpandedLeft = "L2UI_CH3.etc.IconSelect2";
	}
	infNode.strName = NodeName;
	infNode.nOffSetX = offsetX;
	infNode.nOffSetY = offsetY;
	infNode.bFollowCursor = True;
	infNode.nTexExpandedOffSetX = nTexExpandedOffSetX;
	infNode.nTexExpandedOffSetY = nTexExpandedOffSetY;
	infNode.nTexExpandedHeight = nTexExpandedHeight;
	infNode.nTexExpandedRightWidth = nTexExpandedRightWidth;
	infNode.nTexExpandedLeftUWidth = nTexExpandedLeftUWidth;
	infNode.nTexExpandedLeftUHeight = nTexExpandedLeftUHeight;
	infNode.strTexExpandedLeft = strTexExpandedLeft;
	return Class'UIAPI_TREECTRL'.static.InsertNode(TreeName,ParentName,infNode);
}
function stx2k23 ( string TreeName,  string NodeName,  string TextureName,  int TextureWidth,  int TextureHeight, optional  int offsetX, optional  int offsetY, optional  bool OneLine, optional  bool bLineBreak, optional  int VAL, optional  int VAL2, optional  string VALSTR)
{
  local  XMLTreeNodeItemInfo infNode;

infNode.eType = XTNITEM_TEXTURE;
infNode.t_bDrawOneLine = OneLine;
infNode.bLineBreak = bLineBreak;
infNode.nOffSetX = offsetX;
infNode.nOffSetY = offsetY;
infNode.u_nTextureWidth = TextureWidth;
infNode.u_nTextureHeight = TextureHeight;

infNode.u_nTextureUWidth = VAL;
infNode.u_nTextureUHeight = VAL2;
infNode.u_strTexture = TextureName;

  
  getinsertnodeitem(TreeName,NodeName,infNode);
}



function XMLTreeNodeItemInfo Virtual (int E, XMLTreeNodeItemInfo infNodeItem)
{
  switch (E)
  {
    case 0:
    infNodeItem.t_color.R = 255;
    infNodeItem.t_color.G = 255;
    infNodeItem.t_color.B = 255;
    infNodeItem.t_color.A = 255;
    break;
    case 1:
    infNodeItem.t_color.R = 163;
    infNodeItem.t_color.G = 163;
    infNodeItem.t_color.B = 163;
    infNodeItem.t_color.A = 255;
    break;
    case 2:
    infNodeItem.t_color.R = 176;
    infNodeItem.t_color.G = 155;
    infNodeItem.t_color.B = 121;
    infNodeItem.t_color.A = 255;
    break;
    case 3:
    infNodeItem.t_color.R = 250;
    infNodeItem.t_color.G = 50;
    infNodeItem.t_color.B = 0;
    infNodeItem.t_color.A = 255;
    break;
    case 4:
    infNodeItem.t_color.R = 240;
    infNodeItem.t_color.G = 214;
    infNodeItem.t_color.B = 54;
    infNodeItem.t_color.A = 255;
    break;
    case 5:
    infNodeItem.t_color.R = 175;
    infNodeItem.t_color.G = 185;
    infNodeItem.t_color.B = 205;
    infNodeItem.t_color.A = 255;
    break;
    case 6:
    infNodeItem.t_color.R = 102;
    infNodeItem.t_color.G = 150;
    infNodeItem.t_color.B = 253;
    infNodeItem.t_color.A = 255;
    break;
    case 7:
    infNodeItem.t_color.R = 85;
    infNodeItem.t_color.G = 170;
    infNodeItem.t_color.B = 255;
    infNodeItem.t_color.A = 255;
    break;
    case 8:
    infNodeItem.t_color.R = 211;
    infNodeItem.t_color.G = 192;
    infNodeItem.t_color.B = 82;
    infNodeItem.t_color.A = 255;
    break;
    case 9:
    infNodeItem.t_color.R = 170;
    infNodeItem.t_color.G = 152;
    infNodeItem.t_color.B = 120;
    infNodeItem.t_color.A = 255;
    break;
    case 10:
    infNodeItem.t_color.R = 168;
    infNodeItem.t_color.G = 103;
    infNodeItem.t_color.B = 53;
    infNodeItem.t_color.A = 255;
    break;
    case 11:
    infNodeItem.t_color.R = 175;
    infNodeItem.t_color.G = 42;
    infNodeItem.t_color.B = 39;
    infNodeItem.t_color.A = 255;
    break;
    case 12:
    infNodeItem.t_color.R = 255;
    infNodeItem.t_color.G = 204;
    infNodeItem.t_color.B = 0;
    infNodeItem.t_color.A = 255;
    break;
    case 13:
    infNodeItem.t_color.R = 170;
    infNodeItem.t_color.G = 110;
    infNodeItem.t_color.B = 230;
    infNodeItem.t_color.A = 255;
    break;
    default:
  }
  return infNodeItem;
}






function Color GetColortool (int R, int G, int B, int A)
{
  local Color tColor;

  tColor.R = R;
  tColor.G = G;
  tColor.B = B;
  tColor.A = A;
  return tColor;
}


function L2Util getInstanceL2Util()
{
  local L2Util utilbar;
  utilbar = L2Util(GetScript("L2Util"));
  return utilbar; 
}


function string getxml ( string val,  string val2,  XMLTreeNodeInfo xml)
{
  return Class'UIAPI_TREECTRL'.static.InsertNode(val,val2,xml);
}





function getinsetnode ( string val,  string val2,  XMLTreeNodeInfo val3 )
{
   Class'UIAPI_TREECTRL'.static.InsertNode(val,val2,val3);
}

function getinsertnodeitem ( string val,  string val2 ,  XMLTreeNodeItemInfo val3 )
{
  Class'UIAPI_TREECTRL'.static.InsertNodeItem(val,val2,val3);
}

function array<string> lista2(string val, string val2)
{
    local array<string> listastring;
    local int startPos;
    local int endPos;
    local string remaining;

    listastring.Length = 0;
    remaining = val;

    while (remaining != "")
    {
        startPos = InStr(remaining, val2);

        if (startPos == -1)
        {
            // Si no se encuentra mas separadores, se agrega el elemento restante
            listastring[listastring.Length] = remaining;
            remaining = "";
        }
        else
        {
            endPos = startPos + Len(val2);
            // Se agrega el elemento encontrado a la lista
            listastring[listastring.Length] = Left(remaining, startPos - 1);
            // Se actualiza la cadena restante eliminando el elemento y el separador
            remaining = Mid(remaining, endPos);
        }
    }

    return listastring;
}



function DrawItemInfo DrawTex (string Tex, int Width, int Height, int UWidth, int UHeight, int nOffSetX, int nOffSetY, bool bDrawOneLine, bool bLineBreak)
{
  local DrawItemInfo Info;

  Info.eType = DIT_TEXTURE;
  Info.t_bDrawOneLine = bDrawOneLine;
  Info.bLineBreak = bLineBreak;
  Info.u_nTextureWidth = Width;
  Info.u_nTextureHeight = Height;
  Info.u_nTextureUWidth = UWidth;
  Info.u_nTextureUHeight = UHeight;
  Info.nOffSetX = nOffSetX;
  Info.nOffSetY = nOffSetY;
  Info.u_strTexture = Tex;
  return Info;
}



function DrawItemInfo DrawText (string Text, Color c_Color, bool bDrawOneLine, bool bLineBreak, int nOffSetX, int nOffSetY)
{
  local DrawItemInfo Info;

  Info.eType = DIT_TEXT;
  Info.t_color = c_Color;
  Info.t_bDrawOneLine = bDrawOneLine;
  Info.bLineBreak = bLineBreak;
  Info.nOffSetX = nOffSetX;
  Info.nOffSetY = nOffSetY;
  Info.t_strText = Text;
  return Info;
}
function DrawItemInfo DrawBlank (int Height)
{
  local DrawItemInfo Info;

  Info.eType = DIT_BLANK;
  Info.b_nHeight = Height;
  return Info;
}

function TreeClear (string Str)
{
  Class'UIAPI_TREECTRL'.static.Clear(Str);
}




function DisableWindow (string Window)
{
	class'UIAPI_WINDOW'.static.DisableWindow(Window);
}

function EnableWindow (string Window)
{
	class'UIAPI_WINDOW'.static.EnableWindow(Window);
}

function SysDebug (string Str, optional bool Clear)
{
	local TextListBoxHandle Debug;

	Debug = TextListBoxHandle(GetHandle("ConsoleDebug.debug"));
	if ( !(IsShowWindow("ConsoleDebug")) )
	{
		ShowWindow("ConsoleDebug");
	}
	if ( Clear )
	{
		Debug.Clear();
	}
	Debug.AddString(Str,xxgetInstanceL2Util().Red);
}


function Color GetNumColor(string strCommaAdena)
{
	local Color ResultColor;
	local int L;

    // Inicializa los componentes de ResultColor con valores predeterminados.
	ResultColor.R = 220;
	ResultColor.G = 220;
	ResultColor.B = 220;
	ResultColor.A = 255;

    // Obtiene la longitud de la cadena strCommaAdena.
	L = Len(strCommaAdena);

    // Si la cadena contiene una coma, realiza una accion desconocida y almacena el resultado en comma_num.
	if ( InStr(strCommaAdena, ",") != -1 )
	{
        // Realiza una accion desconocida para obtener el valor de comma_num.
        // UnknownFunction163(comma_num);
	}

    // Si la longitud de la cadena es 5, devuelve ResultColor sin hacer mas calculos.
	if ( L == 5 )
	{
		return ResultColor;
	}

    // Ajusta la longitud a 5 para que se pueda utilizar en el siguiente switch.
	L = Clamp(L, 0, 5);

    // Asigna diferentes valores de color a ResultColor segun el valor de L.
	switch (L)
	{
		case 0:
			ResultColor.R = 105;
			ResultColor.G = 255;
			ResultColor.B = 255;
			break;

		case 1:
			ResultColor.R = 255;
			ResultColor.G = 128;
			ResultColor.B = 255;
			break;

		case 2:
			ResultColor.R = 255;
			ResultColor.G = 255;
			ResultColor.B = 0;
			break;

		case 3:
			ResultColor.R = 0;
			ResultColor.G = 255;
			ResultColor.B = 0;
			break;

		case 4:
			ResultColor.R = 255;
			ResultColor.G = 140;
			ResultColor.B = 0;
			break;

		case 5:
			ResultColor.R = 0;
			ResultColor.G = 110;
			ResultColor.B = 255;
			break;

		default:
            // Manejar otros casos, si es necesario.
			break;
	}

    // Devuelve ResultColor con los componentes actualizados.
	return ResultColor;
}
function bool xxisConsumable(int Id)
{
	local bool isCons;

	switch(Id)
	{
        // End:0x0F
		case 1835:
        // End:0x17
		case 1463:
        // End:0x1F
		case 1464:
        // End:0x27
		case 1465:
        // End:0x2F
		case 1466:
        // End:0x37
		case 1467:
        // End:0x3F
		case 3947:
        // End:0x47
		case 3948:
        // End:0x4F
		case 3949:
        // End:0x57
		case 3950:
        // End:0x5F
		case 3951:
        // End:0x67
		case 3952:
        // End:0x6F
		case 2509:
        // End:0x77
		case 2510:
        // End:0x7F
		case 2511:
        // End:0x87
		case 2512:
        // End:0x8F
		case 2513:
        // End:0x97
		case 2514:
        // End:0x9F
		case 6645:
        // End:0xA7
		case 6646:
        // End:0xBA
		case 6647:
			isCons = True;
            // End:0xBD
			break;
        // End:0xFFFF
		default:
			break;
	}
	return isCons;

}

function bool GetPlayerActor(out Actor actor)
{
	actor = xxgetInstanceL2Util().GetActor();
    // End:0x23
	if( actor != None )
	{
		return True;
	}
	return False;

}


function CalculateHeaderPosition(UserInfo Info, HeaderPosition HeaderPos,optional out float OutX,optional out float OutY)
{
	local vector CameraLocation;
	local rotator CameraRotation;
	local vector CameraDirection, CameraRight, CameraUp;
	local int ScreenWidth, ScreenHeight;
	local float FOV, Near, Far, Aspect, Top, Bottom, Right, Left;
	local Matrix ProjMat, ViewMat, MVP;
	local Plane PosHomog, PosMvp;
	local Actor TargetActor;
	local Pawn TargetPawn;
	local LineagePlayerController TargetController;
	local vector TargetLocation;
	local float ManualOffset, ScreenX, ScreenY, PercentX, PercentY, Calibrate;

    // End:0x12
	if ( !GetPlayerActor(TargetActor) )
	{
		return;
	}
    // End:0x24
	if ( !GetPlayerController(TargetController) )
	{
		return;
	}
    // End:0x3D
	if ( Info.bNpc )
	{
		ManualOffset = -0.7;
	}
	TargetController.PlayerCalcView(TargetActor, CameraLocation, CameraRotation);
	GetCurrentResolution(ScreenWidth, ScreenHeight);
	GetAxes(CameraRotation, CameraDirection, CameraRight, CameraUp);
    // End:0x223
	foreach TargetActor.CollidingActors(class'Pawn', TargetPawn, 50, Info.Loc)
	{
        // End:0x222
		if ( Info.nID == TargetPawn.CreatureID )
		{
			TargetLocation = Info.Loc;
			ManualOffset = ManualOffset + TargetPawn.NameOffset;
			TargetLocation.Z = (TargetLocation.Z + TargetPawn.CollisionHeight) + ManualOffset;
		}
	}
	FOV = 60.0;
	Near = 0.1;
	Far = 1000.0;
	Aspect = ScreenWidth / ScreenHeight;
	Top = Tan(FOV * 0.5) * Near;
	Bottom = -Top;
	Right = Top * Aspect;
	Left = -Right;
	ProjMat.XPlane = GetPlane(2.0 * Near / (Right - Left), 0, 0, 0);
	ProjMat.YPlane = GetPlane(0, 2.0 * Near / (Top - Bottom), 0, 0);
	ProjMat.ZPlane = GetPlane((Right + Left) / (Right - Left), (Top + Bottom) / (Top - Bottom), (-2.0 * Far * Near) / (Far - Near), -1);
	ProjMat.WPlane = GetPlane(0, 0, (-Far - Near) / (Far - Near), 0);
	ViewMat.XPlane = GetPlane(CameraRight.X, CameraUp.X, -CameraDirection.X, 0);
	ViewMat.YPlane = GetPlane(CameraRight.Y, CameraUp.Y, -CameraDirection.Y, 0);
	ViewMat.ZPlane = GetPlane(CameraRight.Z, CameraUp.Z, -CameraDirection.Z, 0);
	ViewMat.WPlane = GetPlane(- Dot (CameraRight, CameraLocation), - Dot (CameraUp, CameraLocation), Dot (CameraDirection, CameraLocation), 1);
	MVP = multiplyMatrices(ProjMat, ViewMat);
	PosHomog = GetPlane(TargetLocation.X, TargetLocation.Y, TargetLocation.Z, 1);
	PosMvp = multiplyMatrixVector(MVP, PosHomog);
	PosMvp.X = PosMvp.X / (PosMvp.W / 1000);
	PosMvp.Y = PosMvp.Y / (PosMvp.W / 1000);
	PosMvp.Z = PosMvp.Z / (PosMvp.W / 1000);
	Calibrate = 27.5 * (ScreenWidth / ScreenHeight) / 1000;
	PercentX = (((PosMvp.X * 0.5) * ScreenWidth) + (ScreenWidth / Calibrate)) / ((ScreenWidth / Calibrate) * 0.5);
	PercentY = (((PosMvp.Y * 0.5) * ScreenHeight) + (ScreenHeight / Calibrate)) / ((ScreenHeight / Calibrate) * 0.5);
	ScreenX = (100 - PercentX) * ScreenWidth / 100;
	ScreenY = PercentY * ScreenHeight / 100;
    // End:0x4FA
	if ( (Dot ((TargetLocation - CameraLocation), CameraDirection) < 0) || (ScreenX < -100) || (ScreenX > ScreenWidth + 100) || (ScreenY < -100) || (ScreenY > ScreenHeight + 100) )
	{
		OutX = -100;
		OutY = -100;
		return;
	}
	OutX = ScreenX;
	OutY = ScreenY;
}

function float Dot(Vector v1, Vector v2)
{
	return v1 Dot v2;

}

function Plane nak(float f1, float f2, float f3, float f4)
{
	local Plane P;

	P.X = f1;
	P.Y = f2;
	P.Z = f3;
	P.W = f4;
	return P;

}

function Matrix ComputeProjectionMatrix(float FOV, float near, float far, float aspect)
{
	local float top, bottom, Right, Left;
	local Matrix projMat;

	top = Tan(FOV / float(2)) * near;
	bottom = -top;
	Right = top * aspect;
	Left = -Right;
	projMat.XPlane = nak((2 * near) / (Right - Left), 0, 0, 0);
	projMat.YPlane = nak(0, (2 * near) / (top - bottom), 0, 0);
	projMat.ZPlane = nak((Right + Left) / (Right - Left), (top + bottom) / (top - bottom), ((-1 * far) - near) / (far - near), -1);
	projMat.WPlane = nak(0, 0, ((-2 * far) * near) / (far - near), 0);
	return projMat;

}

function Matrix ComputeViewMatrix(Vector CameraLocation, Vector cameraDirection, Vector cameraRight, Vector cameraUp)
{
	local Matrix viewMat;

	viewMat.XPlane = nak(cameraRight.X, cameraUp.X, -cameraDirection.X, 0);
	viewMat.YPlane = nak(cameraRight.Y, cameraUp.Y, -cameraDirection.Y, 0);
	viewMat.ZPlane = nak(cameraRight.Z, cameraUp.Z, -cameraDirection.Z, 0);
	viewMat.WPlane = nak(-1 * (cameraRight Dot CameraLocation), -1 * (cameraUp Dot CameraLocation), cameraDirection Dot CameraLocation, 1);
	return viewMat;

}













function Matrix multiplyMatrices(Matrix A, Matrix B)
{
	local Matrix C;

	C.XPlane.X = (((A.XPlane.X * B.XPlane.X) + (A.YPlane.X * B.XPlane.Y)) + (A.ZPlane.X * B.XPlane.Z)) + (A.WPlane.X * B.XPlane.W);
	C.XPlane.Y = (((A.XPlane.Y * B.XPlane.X) + (A.YPlane.Y * B.XPlane.Y)) + (A.ZPlane.Y * B.XPlane.Z)) + (A.WPlane.Y * B.XPlane.W);
	C.XPlane.Z = (((A.XPlane.Z * B.XPlane.X) + (A.YPlane.Z * B.XPlane.Y)) + (A.ZPlane.Z * B.XPlane.Z)) + (A.WPlane.Z * B.XPlane.W);
	C.XPlane.W = (((A.XPlane.W * B.XPlane.X) + (A.YPlane.W * B.XPlane.Y)) + (A.ZPlane.W * B.XPlane.Z)) + (A.WPlane.W * B.XPlane.W);
	C.YPlane.X = (((A.XPlane.X * B.YPlane.X) + (A.YPlane.X * B.YPlane.Y)) + (A.ZPlane.X * B.YPlane.Z)) + (A.WPlane.X * B.YPlane.W);
	C.YPlane.Y = (((A.XPlane.Y * B.YPlane.X) + (A.YPlane.Y * B.YPlane.Y)) + (A.ZPlane.Y * B.YPlane.Z)) + (A.WPlane.Y * B.YPlane.W);
	C.YPlane.Z = (((A.XPlane.Z * B.YPlane.X) + (A.YPlane.Z * B.YPlane.Y)) + (A.ZPlane.Z * B.YPlane.Z)) + (A.WPlane.Z * B.YPlane.W);
	C.YPlane.W = (((A.XPlane.W * B.YPlane.X) + (A.YPlane.W * B.YPlane.Y)) + (A.ZPlane.W * B.YPlane.Z)) + (A.WPlane.W * B.YPlane.W);
	C.ZPlane.X = (((A.XPlane.X * B.ZPlane.X) + (A.YPlane.X * B.ZPlane.Y)) + (A.ZPlane.X * B.ZPlane.Z)) + (A.WPlane.X * B.ZPlane.W);
	C.ZPlane.Y = (((A.XPlane.Y * B.ZPlane.X) + (A.YPlane.Y * B.ZPlane.Y)) + (A.ZPlane.Y * B.ZPlane.Z)) + (A.WPlane.Y * B.ZPlane.W);
	C.ZPlane.Z = (((A.XPlane.Z * B.ZPlane.X) + (A.YPlane.Z * B.ZPlane.Y)) + (A.ZPlane.Z * B.ZPlane.Z)) + (A.WPlane.Z * B.ZPlane.W);
	C.ZPlane.W = (((A.XPlane.W * B.ZPlane.X) + (A.YPlane.W * B.ZPlane.Y)) + (A.ZPlane.W * B.ZPlane.Z)) + (A.WPlane.W * B.ZPlane.W);
	C.WPlane.X = (((A.XPlane.X * B.WPlane.X) + (A.YPlane.X * B.WPlane.Y)) + (A.ZPlane.X * B.WPlane.Z)) + (A.WPlane.X * B.WPlane.W);
	C.WPlane.Y = (((A.XPlane.Y * B.WPlane.X) + (A.YPlane.Y * B.WPlane.Y)) + (A.ZPlane.Y * B.WPlane.Z)) + (A.WPlane.Y * B.WPlane.W);
	C.WPlane.Z = (((A.XPlane.Z * B.WPlane.X) + (A.YPlane.Z * B.WPlane.Y)) + (A.ZPlane.Z * B.WPlane.Z)) + (A.WPlane.Z * B.WPlane.W);
	C.WPlane.W = (((A.XPlane.W * B.WPlane.X) + (A.YPlane.W * B.WPlane.Y)) + (A.ZPlane.W * B.WPlane.Z)) + (A.WPlane.W * B.WPlane.W);
	return C;

}

function Plane multiplyMatrixVector(Matrix Matrix, Plane Vector)
{
	local Plane Result;

	Result.X = (((Matrix.XPlane.X * Vector.X) + (Matrix.YPlane.X * Vector.Y)) + (Matrix.ZPlane.X * Vector.Z)) + (Matrix.WPlane.X * Vector.W);
	Result.Y = (((Matrix.XPlane.Y * Vector.X) + (Matrix.YPlane.Y * Vector.Y)) + (Matrix.ZPlane.Y * Vector.Z)) + (Matrix.WPlane.Y * Vector.W);
	Result.Z = (((Matrix.XPlane.Z * Vector.X) + (Matrix.YPlane.Z * Vector.Y)) + (Matrix.ZPlane.Z * Vector.Z)) + (Matrix.WPlane.Z * Vector.W);
	Result.W = (((Matrix.XPlane.W * Vector.X) + (Matrix.YPlane.W * Vector.Y)) + (Matrix.ZPlane.W * Vector.Z)) + (Matrix.WPlane.W * Vector.W);
	return Result;

}

function Plane GetPlane(float f1, float f2, float f3, float f4)
{
	local Plane P;

	P.X = f1;
	P.Y = f2;
	P.Z = f3;
	P.W = f4;
	return P;

}

function bool GetPlayerController(out LineagePlayerController controller)
{
	controller = xxgetInstanceL2Util().GetController();
    // End:0x23
	if( controller != None )
	{
		return True;
	}
	return False;

}

function OMG(string Msg)
{
	local ChatWindowHandle NormalChat;
	local Color iColor;

	NormalChat = ChatWindowHandle(GetHandle("ChatWnd.NormalChat"));
	iColor.R = 255;
	iColor.G = 0;
	iColor.B = 255;
	iColor.A = 255;
	NormalChat.AddString(("LotusInfo: "$Msg),iColor);
}


function SetItemTextLink (ItemInfo a_ID)
{
	local ChatWnd scriptChat;
	local string param;

	scriptChat = ChatWnd(GetScript("ChatWnd"));
	param = a_ID.Name;
	if ( (a_ID.Enchanted > 0) )
	{
		param = (((" +"$string(a_ID.Enchanted))$" ")$a_ID.Name);
	}
	if ( (a_ID.ItemNum > 1) )
	{
		param = (((a_ID.Name$"[")$string(a_ID.ItemNum))$"]");
	}
	scriptChat.HandleTextLinkLButtonClick(param);
}


function ShowOnScreenMessage(string MessageText)
{
    local string out_Param;

    ParamAdd(out_Param, "MsgType", string(1));
    ParamAdd(out_Param, "MsgNo", string(0));
    ParamAdd(out_Param, "WindowType", string(2));
    ParamAdd(out_Param, "FontSize", "20");
    ParamAdd(out_Param, "FontType", string(0));
    ParamAdd(out_Param, "MsgColor", "1");
    ParamAdd(out_Param, "MsgColorR", string(255));
    ParamAdd(out_Param, "MsgColorG", string(255));
    ParamAdd(out_Param, "MsgColorB", string(255));
    ParamAdd(out_Param, "ShadowType", "0");
    ParamAdd(out_Param, "BackgroundType", "0");
    ParamAdd(out_Param, "LifeTime", string(1000));
    ParamAdd(out_Param, "AnimationType", "1");
    ParamAdd(out_Param, "Msg", MessageText);
    ExecuteEvent(140, out_Param);

}

function string GetDetailedClassIconName (int ClassID, int iconType)
{
	local string iconSize;

	iconSize = "";
	if ( (iconType == 1) )
	{
		iconSize = "_Big";
	}
	if ( (iconType == 2) )
	{
		iconSize = "_Small";
	}
	switch (ClassID)
	{
		case 0:
		case 10:
			return ("L2UI_CH3.ClassMark.PlayerStatusWnd_ClassMark_human"$iconSize);
			break;
		case 18:
		case 25:
			return ("L2UI_CH3.ClassMark.PlayerStatusWnd_ClassMark_elf"$iconSize);
			break;
		case 31:
		case 38:
			return ("L2UI_CH3.ClassMark.PlayerStatusWnd_ClassMark_darkelf"$iconSize);
			break;
		case 44:
		case 49:
			return ("L2UI_CH3.ClassMark.PlayerStatusWnd_ClassMark_orc"$iconSize);
			break;
		case 53:
			return ("L2UI_CH3.ClassMark.PlayerStatusWnd_ClassMark_dwarf"$iconSize);
			break;
		default:
			return (("L2UI_CH3.ClassMark.PlayerStatusWnd_ClassMark_"$string(ClassID))$iconSize);
			break;
	}
}



function CustomTooltip xxMakeTooltipSimpleText(string Text)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;

	ToolTip.DrawList.Length = 1;
	Info.eType = DIT_TEXT;
	Info.t_bDrawOneLine = True;
	Info.t_strText = Text;
	ToolTip.DrawList[0] = Info;
	return ToolTip;
}



function CustomTooltip MakeTooltipSimpleText(string Text)
{
	local CustomTooltip Tooltip;
	local DrawItemInfo info;
	
	Tooltip.DrawList.Length = 1;
	info.eType = DIT_TEXT;
	info.t_bDrawOneLine = true;
	info.t_strText = Text;
	Tooltip.DrawList[0] = info;

	return Tooltip;
}
defaultproperties
{
}
