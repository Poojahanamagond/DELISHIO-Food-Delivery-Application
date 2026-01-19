package com.delishio.daoimpl;

import com.delishio.dao.UserDAO;
import com.delishio.models.User;
import com.delishio.util.MyConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    private static final String INSERT_USER =
        "INSERT INTO users(username, email, password, phone, address) VALUES(?,?,?,?,?)";

    private static final String LOGIN_USER =
        "SELECT * FROM users WHERE email=? AND password=?";

    private static final String GET_USER_BY_ID =
        "SELECT * FROM users WHERE user_id=?";

    private static final String GET_USER_BY_EMAIL =
        "SELECT * FROM users WHERE email=?";

    private static final String UPDATE_USER =
        "UPDATE users SET name=?, email=?, phone=?, address=? WHERE user_id=?";

    private static final String DELETE_USER =
        "DELETE FROM users WHERE user_id=?";

    private static final String GET_ALL_USERS =
        "SELECT * FROM users";

    @Override
    public boolean registerUser(User user) {

        String sql = "INSERT INTO users (username, email, password, phone, address, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace(); // 🔴 MUST PRINT
        }
        return false;
    }


    @Override
    public User loginUser(String email, String password) {
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(LOGIN_USER)) {

            ps.setString(1, email.trim());
            ps.setString(2, password.trim());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractUser(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @Override
    public User getUserById(int userId) {
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(GET_USER_BY_ID)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractUser(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getUserByEmail(String email) {
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(GET_USER_BY_EMAIL)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractUser(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateUser(User user) {
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_USER)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteUser(int userId) {
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_USER)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(GET_ALL_USERS)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                users.add(extractUser(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    private User extractUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username")); // ✅ FIXED
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role")); // ✅ VERY IMPORTANT
        return user;
    }


    @Override
    public boolean isPhoneExists(String phone) {
        String sql = "SELECT user_id FROM users WHERE phone = ?";
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void updatePasswordByPhone(String phone, String password) {
        String sql = "UPDATE users SET password=? WHERE phone=?";
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, password);
            ps.setString(2, phone);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<User> getAllUsers1() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role = 'customer'";
        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

}
