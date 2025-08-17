<!DOCTYPE html>
<html>
<head>
<title>Chilli Hub</title>
<style>
  body {
    background-color: #212121;
    color: #bdbdbd;
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }
  .container {
    display: flex;
    height: 100vh;
    width: 100vw;
  }
  .sidebar {
    width: 200px;
    background-color: #333333;
    display: flex;
    flex-direction: column;
    padding: 20px 0;
  }
  .header {
    font-size: 24px;
    font-weight: bold;
    padding: 10px 20px;
    border-bottom: 2px solid #555555;
  }
  .menu-item {
    font-size: 18px;
    padding: 15px 20px;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  .menu-item:hover {
    background-color: #555555;
  }
  .main-content {
    flex-grow: 1;
    background-color: #2b2b2b;
  }
</style>
</head>
<body>

<div class="container">
  <div class="sidebar">
    <div class="header">Chilli Hub</div>
    <div class="menu-item">Main</div>
    <div class="menu-item">Stealer</div>
    <div class="menu-item">Helper</div>
    <div class="menu-item">Player</div>
    <div class="menu-item">Finder</div>
    <div class="menu-item">Server</div>
    <div class="menu-item">Discord!</div>
  </div>
  <div class="main-content"></div>
</div>

</body>
</html>
