package com.delishio.dao;

import com.delishio.models.User;
import java.util.List;

public interface UserDAO {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    User getUserById(int userId);
    User getUserByEmail(String email);
    boolean updateUser(User user);
    boolean deleteUser(int userId);
    List<User> getAllUsers();
    boolean isPhoneExists(String phone);
    void updatePasswordByPhone(String phone, String password);

}