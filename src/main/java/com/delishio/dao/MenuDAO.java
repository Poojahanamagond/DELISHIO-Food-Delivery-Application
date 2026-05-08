package com.delishio.dao;

import com.delishio.models.MenuItem;
import java.util.List;

public interface MenuDAO {
    MenuItem addMenuItem(MenuItem menuItem);
    MenuItem getMenuItemById(int menuId);
    List<MenuItem> getMenuByRestaurantId(int restaurantId);
    List<MenuItem> getAllMenuItems();
    boolean updateMenuItem(MenuItem menuItem);
    boolean deleteMenuItem(int menuId);
    List<MenuItem> getAvailableMenuItems(int restaurantId);
	List<MenuItem> getSnacks();
	List<MenuItem> getFoodByMood(String mood);
}