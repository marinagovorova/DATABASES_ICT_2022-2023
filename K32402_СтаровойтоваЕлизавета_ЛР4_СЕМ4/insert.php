<?php
$dbuser = 'postgres';
$dbpass = 'Listar17102003';
$host = 'localhost';
$dbname = 'students';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);

if ($_POST['enter']) {
    echo "
        student_id: $_POST[student_id]<br>
        first_name: $_POST[first_name]<br>
        last_name: $_POST[last_name]<br>
        group_number: $_POST[group_number]<br><br>
    ";
}

try {
    $student_id = $_POST['student_id'];
    $pgsql = "INSERT INTO students.students (student_id, first_name, last_name, group_number)
              VALUES (:student_id, :first_name, :last_name, :group_number)";
    $stmt = $pdo->prepare($pgsql);
    $stmt->bindValue(':student_id', $student_id);
    $stmt->bindValue(':first_name', $_POST['first_name']);
    $stmt->bindValue(':last_name', $_POST['last_name']);
    $stmt->bindValue(':group_number', $_POST['group_number']);
    $stmt->execute();
    echo "<b>Student was inserted!</b><br>";
} catch (PDOException $e) {
    if ($e->getCode() == '23505') {
        echo "Error: Duplicate entry for student_id $student_id";
    } else {
        echo 'Ошибка выполнения запроса: ' . $e->getMessage();
    }

}
?>







