package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.*;
    import flash.geom.Rectangle;
    import flash.net.LocalConnection;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.ui.Keyboard;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import flash.utils.ByteArray;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;
    
    import ninedays.command.QueueEvent;
    import ninedays.data.BinaryXML;
    import ninedays.loading.QueueLoader;
    import ninedays.loading.items.SWFItem;
    import ninedays.utils.AutoTimer;


    [SWF(backgroundColor=0x555555, frameRate="30", width="800", height="760")]
    public class TestCase extends Sprite
    {
		[Embed(source="/assets/items_attire.xml",mimeType="application/octet-stream")]
		private var equipXmlClass:Class;
		
		[Embed(source="/assets/items_attire.bx",mimeType="application/octet-stream")]
		private var equipBxClass:Class;
		
		
		private var _xmlArray:Array = [];
		private var _bxArray:Array = [];
		
        public function TestCase()
        {
			var prev:int = getTimer();
			var equipXML:XML = XML(new equipXmlClass());
			parseItemXMLList(equipXML);
			trace(_xmlArray.length, getTimer() - prev);
			
			prev = getTimer();
			var equipBX:ByteArray = new equipBxClass();
			var bx:BinaryXML = new BinaryXML();
			bx.importByteArray(equipBX);
			parseItemBinaryXMLList(bx);
			trace(_bxArray.length, getTimer() - prev);
        }
		
		private function parseItemBinaryXMLList(itemXML:BinaryXML):void
		{
			var xmllist:Vector.<BinaryXML> = itemXML.descendants("Item");
			for each(var item:BinaryXML in xmllist)
			{
				var info:ItemNorInfo = parseBinaryXMLToNorInfo(item);
				_bxArray.push(info);
//				_dataMap.add(info.id,info);
//				_cacheItemInfoArr.push(info);
			}
		}
		
		private function parseBinaryXMLToNorInfo(xml:BinaryXML):ItemNorInfo
		{
			var info:ItemNorInfo = new ItemNorInfo();
			info.id = parseInt(xml.attributes.ID);
			info.name = xml.attributes.Name;
			info.subType = parseInt(xml.attributes.subType);
			info.summonLv = parseInt(xml.attributes.SummonLV);
			info.summonID = parseInt(xml.attributes.SummonID);
			
			info.qualityLevel = parseInt(xml.attributes.QualityLevel);
			
			info.equipPart = parseInt(xml.attributes.EquipPart);
			info.gfdTradeTax = Number(xml.attributes.GfdTradeTax);
			info.ypTradeTax = Number(xml.attributes.YpTradeTax);
			
			info.viewLevel = xml.attributes.viewLevel;
			
			info.useLv = parseInt(xml.attributes.UseLv);
			
			info.price = int(xml.attributes.Price);
			
			info.repairPrice = int(xml.attributes.RepairPrice);
			
			info.exploitValue = int(xml.attributes.ExploitValue);
			
			info.honorLevel = int(xml.attributes.honorLevel);
			
			info.suitGroup = int(xml.attributes.SuitGroup);
			
			info.gainMethod = int(xml.attributes.GainMethod);
			
			info.sellPrice = int(xml.attributes.SellPrice);
			
			//xml.descript[0]
			var desripts:Vector.<BinaryXML> = xml.elements("descript");
			if(desripts && desripts.length)
			{
				info.descript = desripts[0].simpleContent;
			}
			
			info.rule = xml.attributes.Rule;
			
			info.atk = xml.attributes.Atk;
			info.def = xml.attributes.Def;
			info.duration = int(xml.attributes.Duration);
			info.strength = xml.attributes.Strength;
			info.agility = xml.attributes.Agility;
			info.bodyQuality = int(xml.attributes.BodyQuality);
			info.stamina = xml.attributes.Stamina;
			/**
			 * @Hp
			 */
			info.hpAdtion = xml.attributes.Hp;
			info.mpAdtion = xml.attributes.Mp;
			info.addHp = int(xml.attributes.AddHp);
			info.addPerHp = int(xml.attributes.AddPerHp);
			info.addMp = int(xml.attributes.AddMp);
			info.addPerMp = int(xml.attributes.AddPerMp);
			info.hit = xml.attributes.Hit;
			info.dodge = xml.attributes.Dodge;
			info.crit= xml.attributes.Crit;
			info.useEffect = int(xml.attributes.UseEffect);
			info.url = xml.attributes.url;
			info.lifeTime = int(xml.attributes.LifeTime);
			
			/**
			 * @HP
			 */
			info.hp = int(xml.attributes.HP);
			info.pp = int(xml.attributes.PP);
			info.fun = int(xml.attributes.Fun);
			
			info.isCom = int(xml.attributes.isCom);
			info.disabledDir = int(xml.attributes.disabledDir);
			info.disabledStatus = int(xml.attributes.disabledStatus);
			info.skillID = int(xml.attributes.SkillID);
			info.publicCD = int(xml.attributes.publicCD);
			info.cd = int(xml.attributes.cd);
			info.play = int(xml.attributes.Play);
			info.addPower = int(xml.attributes.AddPower);
			info.addIQ = int(xml.attributes.AddIQ);
			info.useAI = int(xml.attributes.UseAI);
			info.vipOnly = int(xml.attributes.VipOnly);
			info.vipName = xml.attributes.VipName;
			info.isConsume = int(xml.attributes.IsConsume);
			info.useEnergy = int(xml.attributes.UseEnergy);
			info.sound = xml.attributes.sound;
			info.pkFireRange = int(xml.attributes.PkFireRange);
			info.tradable = int(xml.attributes.Tradable);
			info.tradability = int(xml.attributes.Tradability);
			info.vipTradability = int(xml.attributes.VipTradability);
			info.shortcut = int(xml.attributes.Shortcut);
			info.availableMap = xml.attributes.AvailableMap;
			info.decompose = int(xml.attributes.decompose);
			info.dailyId = int(xml.attributes.DailyId);
			info.swapId = int(xml.attributes.swapId);
			info.unDrop = int(xml.attributes.UnDrop);
			info.role = int(xml.attributes.Role);
			info.shop = int(xml.attributes.Shop);
			info.resID = int(xml.attributes.resID);
			info.isCanDestory = int(xml.attributes.isCanDestory);
			info.isCanUse = int(xml.attributes.isCanUse);
			info.scoreExchange = xml.attributes.ScoreExchange;
			info.batchUse = int(xml.attributes.BatchUse);
			info.rideID = int(xml.attributes.RideID);
			info.unStorage = int(xml.attributes.UnStorage);
			
			info.equipRole = int(xml.parentNode.attributes.ID);
			info.catID = uint(xml.parentNode.attributes.ID);
			info.itemMax = uint(xml.parentNode.attributes.Max);
			
			info.batSwapID = int(xml.attributes.BatSwapID);
			info.isTurnBack = uint(xml.attributes.Reincarnated) == 1;
			info.itemSwapID = int(xml.attributes.ItemSwapID);
			info.itemSwapPrice = String(xml.attributes.ItemSwapPrice);
			return info;
		}
		
		private function parseItemXMLList(itemXML:XML):void
		{
			var xmllist:XMLList = itemXML.descendants("Item");
			for each(var item:XML in xmllist)
			{
				var info:ItemNorInfo = parseXmlToNorInfo(item);
				_xmlArray.push(info);
//				_dataMap.add(info.id,info);
//				_cacheItemInfoArr.push(info);
			}
		}
		
		private function parseXmlToNorInfo(xml:XML):ItemNorInfo
		{
			var info:ItemNorInfo = new ItemNorInfo();
			info.id = parseInt(xml.@ID);
			info.name = xml.@Name;
			info.subType = parseInt(xml.@subType);
			info.summonLv = parseInt(xml.@SummonLV);
			info.summonID = parseInt(xml.@SummonID);
			
			info.qualityLevel = parseInt(xml.@QualityLevel);
			
			info.equipPart = parseInt(xml.@EquipPart);
			info.gfdTradeTax = Number(xml.@GfdTradeTax);
			info.ypTradeTax = Number(xml.@YpTradeTax);
			
			info.viewLevel = xml.@viewLevel;
			
			info.useLv = parseInt(xml.@UseLv);
			
			info.price = int(xml.@Price);
			
			info.repairPrice = int(xml.@RepairPrice);
			
			info.exploitValue = int(xml.@ExploitValue);
			
			info.honorLevel = int(xml.@honorLevel);
			
			info.suitGroup = int(xml.@SuitGroup);
			
			info.gainMethod = int(xml.@GainMethod);
			
			info.sellPrice = int(xml.@SellPrice);
			
			//xml.descript[0]
			info.descript = xml.descript[0];
			
			info.rule = xml.@Rule;
			
			info.atk = xml.@Atk;
			info.def = xml.@Def;
			info.duration = int(xml.@Duration);
			info.strength = xml.@Strength;
			info.agility = xml.@Agility;
			info.bodyQuality = int(xml.@BodyQuality);
			info.stamina = xml.@Stamina;
			/**
			 * @Hp
			 */
			info.hpAdtion = xml.@Hp;
			info.mpAdtion = xml.@Mp;
			info.addHp = int(xml.@AddHp);
			info.addPerHp = int(xml.@AddPerHp);
			info.addMp = int(xml.@AddMp);
			info.addPerMp = int(xml.@AddPerMp);
			info.hit = xml.@Hit;
			info.dodge = xml.@Dodge;
			info.crit= xml.@Crit;
			info.useEffect = int(xml.@UseEffect);
			info.url = xml.@url;
			info.lifeTime = int(xml.@LifeTime);
			
			/**
			 * @HP
			 */
			info.hp = int(xml.@HP);
			info.pp = int(xml.@PP);
			info.fun = int(xml.@Fun);
			
			info.isCom = int(xml.@isCom);
			info.disabledDir = int(xml.@disabledDir);
			info.disabledStatus = int(xml.@disabledStatus);
			info.skillID = int(xml.@SkillID);
			info.publicCD = int(xml.@publicCD);
			info.cd = int(xml.@cd);
			info.play = int(xml.@Play);
			info.addPower = int(xml.@AddPower);
			info.addIQ = int(xml.@AddIQ);
			info.useAI = int(xml.@UseAI);
			info.vipOnly = int(xml.@VipOnly);
			info.vipName = xml.@VipName;
			info.isConsume = int(xml.@IsConsume);
			info.useEnergy = int(xml.@UseEnergy);
			info.sound = xml.@sound;
			info.pkFireRange = int(xml.@PkFireRange);
			info.tradable = int(xml.@Tradable);
			info.tradability = int(xml.@Tradability);
			info.vipTradability = int(xml.@VipTradability);
			info.shortcut = int(xml.@Shortcut);
			info.availableMap = xml.@AvailableMap;
			info.decompose = int(xml.@decompose);
			info.dailyId = int(xml.@DailyId);
			info.swapId = int(xml.@swapId);
			info.unDrop = int(xml.@UnDrop);
			info.role = int(xml.@Role);
			info.shop = int(xml.@Shop);
			info.resID = int(xml.@resID);
			info.isCanDestory = int(xml.@isCanDestory);
			info.isCanUse = int(xml.@isCanUse);
			info.scoreExchange = xml.@ScoreExchange;
			info.batchUse = int(xml.@BatchUse);
			info.rideID = int(xml.@RideID);
			info.unStorage = int(xml.@UnStorage);
			
			info.equipRole = int(XML(xml.parent()).@ID);
			info.catID = uint(xml.parent().@ID);
			info.itemMax = uint(xml.parent().@Max);
			
			info.batSwapID = int(xml.@BatSwapID);
			info.isTurnBack = uint(xml.@Reincarnated) == 1;
			info.itemSwapID = int(xml.@ItemSwapID);
			info.itemSwapPrice = String(xml.@ItemSwapPrice);
			return info;
		}
	}
}

class ItemNorInfo
{
	
	
	public var id:int;
	public var name:String;
	/**
	 * 物品等级
	 * (稀有度1白，2绿，3蓝，4紫，5橙，6金，7神圣)
	 */
	public var subType:int;
	
	public var summonID:int;
	/** 孵化出的灵兽等级 **/
	public var summonLv:int;
	
	public var qualityLevel:int;
	
	public var equipPart:int;
	//未使用
	public var viewLevel:String;
	
	public var useLv:int;
	
	public var price:int;
	
	public var repairPrice:int;
	
	public var exploitValue:int;
	
	public var honorLevel:int;
	//未使用
	public var suitGroup:int;
	//未使用
	public var gainMethod:int;
	
	public var sellPrice:int;
	
	//xml.descript[0]
	public var descript:String;
	//未使用
	public var rule:String;
	
	public var atk:String;
	public var def:String;
	public var duration:int;
	public var strength:String;
	public var agility:String;
	public var bodyQuality:int;
	public var stamina:String;
	/**
	 * @Hp
	 */
	public var hpAdtion:String;
	public var mpAdtion:String;
	public var addHp:int;
	public var addPerHp:int;
	public var addMp:int;
	public var addPerMp:int;
	public var hit:String;
	public var dodge:String;
	public var crit:String;
	public var useEffect:int;
	//未使用
	public var url:String;
	public var lifeTime:int;
	
	/**
	 * @HP
	 */
	public var hp:int;
	//未使用
	public var pp:int;
	//未使用
	public var fun:int;
	//未使用
	public var isCom:int;
	//未使用
	public var disabledDir:int;
	//未使用
	public var disabledStatus:int;
	//未使用
	public var skillID:int;
	public var publicCD:int;
	public var cd:int;
	//未使用
	public var play:int;
	public var addPower:int;
	//未使用
	public var addIQ:int;
	//未使用
	public var useAI:int;
	public var vipOnly:int;
	//未使用
	public var vipName:String;
	//未使用
	public var isConsume:int;
	//未使用
	public var useEnergy:int;
	//未使用
	public var sound:String;
	//未使用
	public var pkFireRange:int;
	public var tradable:int;
	public var tradability:int;
	public var vipTradability:int;
	public var shortcut:int;
	public var availableMap:String;
	public var decompose:int;
	public var dailyId:int;
	public var swapId:int;
	public var unDrop:int;
	public var role:int;
	public var shop:int;
	public var resID:int;
	public var isCanDestory:int;
	public var isCanUse:int;
	public var scoreExchange:String;
	public var batchUse:int;
	
	public var rideID:int;
	public var unStorage:int;
	
	public var equipRole:int;
	public var catID:int;
	public var itemMax:int;
	
	public var batSwapID:int;
	public var isTurnBack:Boolean;//是否是转生后的装备
	public var itemSwapID:int;
	public var itemSwapPrice:String;
	
	/**
	 * 功夫豆交易税率 
	 */		
	public var gfdTradeTax:Number;
	/**
	 * 银票的交易税率 
	 */		
	public var ypTradeTax:Number;
	
	public function ItemNorInfo()
	{
		super();
	}
}
