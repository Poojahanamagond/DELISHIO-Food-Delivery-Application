package com.delishio.dao;


import com.delishio.models.Cart;
import java.util.List;

public interface CartDAO {
    boolean addToCart(Cart cart);
    List<Cart> getCartItems(int userId);
    boolean updateCartQuantity(int cartId, int quantity);
    boolean removeFromCart(int cartId);
    boolean clearCart(int userId);
    double getCartTotal(int userId);
	void incrementQuantity(int cartId);
	void decrementQuantity(int cartId);
	List<Cart> getCartByUserAndRestaurant(Integer userId, int restaurantId);
	void clearCartByUserAndRestaurant(Integer userId, int restaurantId);
}