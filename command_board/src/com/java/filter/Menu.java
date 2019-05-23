package com.java.filter;

public class Menu implements Comparable{
	private String url;
	private String menu;
	private int count;		
	
	public Menu() {}
	public Menu(String url, String menu, int count) {
		super();
		this.url = url;
		this.menu = menu;
		this.count = count;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	@Override
	public int compareTo(Object obj) {
		if(obj instanceof Menu) {
			Menu outer=(Menu)obj;
			return outer.getCount()-this.count;
		}			
		return -1;
	}
	@Override
	public int hashCode() {		
		return this.menu.hashCode();
	}
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof Menu) {
			Menu outer = (Menu)obj;
			return this.menu.equals(outer.getMenu());
		}
		return false;
	}
	@Override
	public String toString() {
		return "Menu [url=" + url + ", menu=" + menu + ", count=" + count + "]";
	}
	
		
}
