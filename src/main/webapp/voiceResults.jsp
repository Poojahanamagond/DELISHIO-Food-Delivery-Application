<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.MenuItem" %>

<%
    List<MenuItem> menuList = (List<MenuItem>) request.getAttribute("menuList");
    String combo = (String) request.getAttribute("combo");
    String mood = (String) request.getAttribute("mood");
    if(mood == null) mood = "happy";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delishio Results</title>

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #f4f7f6;
}

/* TITLE */
h2 {
    text-align: center;
    padding: 20px;
}

/* MAIN LAYOUT */
.main {
    display: flex;
    gap: 20px;
    padding: 20px;
}

/* LEFT MUSIC PANEL */
.music-panel {
    width: 35%;
    background: white;
    border-radius: 15px;
    padding: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    text-align: center;
}

/* RIGHT FOOD PANEL */
.food-panel {
    width: 65%;
}

/* FOOD GRID */
.grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

/* CARD */
.card {
    background: white;
    padding: 15px;
    width: 220px;
    border-radius: 15px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    text-align: center;
    transition: 0.3s;
}

.card:hover {
    transform: scale(1.08);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}

.card img {
    width: 100%;
    height: 140px;
    border-radius: 10px;
}

/* BUTTON */
.btn {
    margin-top:10px;
    padding:8px 15px;
    background:black;
    color:white;
    border:none;
    border-radius:10px;
    cursor:pointer;
}

/* ANIMATION */
body {
    animation: fadeIn 1s ease-in;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}
</style>
</head>

<body>

<h2>🍽️ Mood Based Results</h2>

<div class="main">

    <!-- 🎧 LEFT: MUSIC -->
    <div class="music-panel">
        <h3>🎧 Music For Your Mood</h3>
        <div id="musicBox"></div>
    </div>

    <!-- 🍔 RIGHT: FOOD -->
    <div class="food-panel">

        <% if(combo != null){ %>
            <h3 style="text-align:center;color:orange;">
                🔥 <%= combo %>
            </h3>
        <% } %>

        <% if(menuList == null || menuList.isEmpty()) { %>

            <p style="text-align:center;">No items found</p>

        <% } else { %>

        <div class="grid">

        <% for(MenuItem m : menuList) { %>

        <div class="card">
            <img src="images/<%= m.getImageUrl() %>">
            <h3><%= m.getItemName() %></h3>
            <p>₹ <%= m.getPrice() %></p>

            <form action="<%= request.getContextPath() %>/cart" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">

                <button type="submit" class="btn">Add to Cart</button>
            </form>
        </div>

        <% } %>

        </div>

        <% } %>

    </div>

</div>

<!-- NAVIGATION -->
<div style="text-align:center;margin-top:30px;">

    <a href="<%= request.getContextPath() %>/cart" style="
        padding:10px 20px;
        background:green;
        color:white;
        border-radius:10px;
        text-decoration:none;">
        Go to Cart 🛒
    </a>

    <a href="home.jsp" style="
        padding:10px 20px;
        background:black;
        color:white;
        border-radius:10px;
        text-decoration:none;">
        Home 🏠
    </a>

</div>

<!-- 🎧 SCRIPT -->
<script>

window.onload = function () {

    let mood = "<%= mood %>";

    if (mood === "tired") {
        speak("You seem tired. Relax and enjoy music with your food.");
        showMusic("tired");
    }
    else if (mood === "happy") {
        speak("You are happy. Enjoy your food and party music.");
        showMusic("happy");
    }
    else if (mood === "sad") {
        speak("You look sad. Have something sweet and calm music.");
        showMusic("sad");
    }
};

function speak(text) {
    let msg = new SpeechSynthesisUtterance(text);
    msg.lang = "en-US";
    window.speechSynthesis.speak(msg);
}

function showMusic(mood) {

    let container = document.getElementById("musicBox");

    if (mood === "tired") {
        container.innerHTML = `
            <h3>🎧 Relax Music</h3>
            <iframe width="100%" height="180"              
            src="https://www.youtube.com/embed/0bapipMS7hg"
            allowfullscreen></iframe>
            <iframe width="100%" height="180"              
            src="https://www.youtube.com/embed/ibdmlv_kItU"
            allowfullscreen></iframe>
            <iframe width="100%" height="180"              
                src="https://www.youtube.com/embed/m70d24MiCPA"
                allowfullscreen></iframe>
                <iframe width="100%" height="180"              
                    src="https://www.youtube.com/embed/ibdmlv_kItU"
                    allowfullscreen></iframe>
                    <iframe width="100%" height="180"              
                        src="https://www.youtube.com/embed/ibdmlv_kItU"
                        allowfullscreen></iframe>
           
        `;
    }

    if (mood === "happy") {
        container.innerHTML = `
            <h3>🎉 Party Music</h3>
            <iframe width="100%" height="180"
            src="https://www.youtube.com/embed/I6LuJQa5jtE"
            allowfullscreen></iframe>
            <iframe width="100%" height="180"
            src="https://www.youtube.com/embed/I6LuJQa5jtE"
                allowfullscreen></iframe>
                <iframe width="100%" height="180"
                src="https://www.youtube.com/embed/I6LuJQa5jtE"
                    allowfullscreen></iframe>  
        `;
    }

    <!-- update -->
    if (mood === "sad") {
        container.innerHTML = `
            <h3>😌 Calm Music</h3>
            <iframe width="100%" height="180"
            src="https://www.youtube.com/embed/lE6RYpe9IT0"
            allowfullscreen></iframe>
        `;
    }
}

</script>

</body>
</html>