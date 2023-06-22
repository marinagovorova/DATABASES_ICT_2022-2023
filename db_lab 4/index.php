<?php
$dbuser = 'postgres';
$dbpass = '315510';
$host = 'localhost';
$dbname='postgres';
$dbconnect = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$query = "SELECT * FROM vendors2;";
$result = pg_query($dbconnect, $query);
$vendors = pg_fetch_all($result); 
array_multisort($vendors);

echo "<h2>Список поставщиков:</h2>";
echo "<ul>";
foreach ($vendors as &$vendor) {
    $vendorId = $vendor['id'];
    $vendorName = $vendor['name'];
    echo "<li>$vendorId - $vendorName</li>";
}
echo "</ul>";

echo "<h2>Добавление поставщика:</h2>";
$formCode = 
'<form action="add.php" method="POST">
    <span>Имя поставщика:</span>
    <input type="text" name="vendorName">
    <button type="submit">Добавить</button>
</form>';
echo $formCode;

echo "<h2>Удаление поставщика:</h2>";
$formCode = 
'<form action="delete.php" method="POST">
    <div>
        <span>ID поставщика:</span>
        <input type="text" name="vendorId">
    </div>
    <div>
        <span>Имя поставщика:</span>
        <input type="text" name="vendorName">
    </div>
    <button type="submit">Удалить</button>
</form>';
echo $formCode;

echo "<h2>Обновление поставщика:</h2>";
$formCode = 
'<form action="update.php" method="POST">
    <div>
        <span>ID поставщика:</span>
        <input type="text" name="vendorId">
    </div>
    <div>
        <span>Новое имя поставщика:</span>
        <input type="text" name="vendorName">
    </div>
    <button type="submit">Обновить</button>
</form>';
echo $formCode;

//$message = $_GET['message'];
//if ($message != '') {
//    echo '<script language="javascript">';
//    echo "alert(\"$message\")";
//    echo '</script>';
//}
?>