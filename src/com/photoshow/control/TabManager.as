
package com.photoshow.control
{
	import com.photoshow.view.ImagesPanel;
	import com.photoshow.view.Welcome;
	import com.photoshow.model.Images;
	
	import mx.containers.TabNavigator;
	import mx.core.Container;
	import mx.events.ChildExistenceChangedEvent;
	
	public class TabManager
	{
		private static var tabNav:TabNavigator;
		
		private static var uniqueTabs:Object = new Object();

		public static function set tabNavigator(tabNavigator:TabNavigator):void
		{
			tabNav = tabNavigator;
			tabNav.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE,
				function (event:ChildExistenceChangedEvent):void
				{
					for (var uniqueId:String in uniqueTabs)
					{
						if (uniqueTabs[uniqueId] == event.relatedObject)
						{
							uniqueTabs[uniqueId] = null;
							return;
						}
					}
				});
		}
		
		public static function openTab(tabClass:Class, uniqueId:String=null):Container
		{
			if (uniqueId && uniqueTabs[uniqueId])
			{
				tabNav.selectedChild = uniqueTabs[uniqueId];
				return uniqueTabs[uniqueId];
			}

			var tab:Container = new tabClass();

			if (uniqueId)
			{
				uniqueTabs[uniqueId] = tab;
			}
			
			tabNav.addChild(tab);
			
			tabNav.selectedChild = tab;

			return tab;
		}
		
		public static function setUniqueTab(uniqueId:String, tab:Container):void
		{
			uniqueTabs[uniqueId] = tab;		
		}
		
		public static function openWelcome():Welcome
		{
			return openTab(Welcome, "WELCOME") as Welcome;
		}

		public static function openImages(images:Images):ImagesPanel
		{
			var tab:ImagesPanel = TabManager.openTab(ImagesPanel, "IMAGES") as ImagesPanel;
			tab.images = images;
			return tab;
		}
		
		public static function removeTab(tab:Container):void
		{	
			tabNav.removeChild(tab);
		}
		
		public static function getUniqueTab(uniqueId:String):Container
		{
			return uniqueTabs[uniqueId];
		}

	}
}