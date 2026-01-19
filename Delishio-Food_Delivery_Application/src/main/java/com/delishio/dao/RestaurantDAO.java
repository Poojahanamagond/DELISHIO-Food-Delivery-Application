package com.delishio.dao;

import com.delishio.models.Restaurant;
import java.util.List;

public interface RestaurantDAO {
    Restaurant addRestaurant(Restaurant restaurant);
    Restaurant getRestaurantById(int restaurantId);
    List<Restaurant> getAllRestaurants();
    List<Restaurant> getActiveRestaurants();
    boolean updateRestaurant(Restaurant restaurant);
    boolean deleteRestaurant(int restaurantId);
    List<Restaurant> searchRestaurants(String keyword);
}
