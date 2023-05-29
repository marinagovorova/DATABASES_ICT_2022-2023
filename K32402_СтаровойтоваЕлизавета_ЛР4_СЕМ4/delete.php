<?php
$dbuser = 'postgres';
$dbpass = 'Listar17102003';
$host = 'localhost';
$dbname = 'students';
$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);

if (isset($_POST['enter'])) {
    $studentID = $_POST['student_id'];
    $firstName = $_POST['first_name'];
    $lastName = $_POST['last_name'];

    // Check if the student exists
    $selectQuery = "SELECT COUNT(*) FROM students.students WHERE student_id = :student_id";
    $stmt = $pdo->prepare($selectQuery);
    $stmt->bindValue(':student_id', $studentID);
    $stmt->execute();
    $count = $stmt->fetchColumn();

    if ($count > 0) {
        $selectQuery = "SELECT student_id, first_name, last_name FROM students.students WHERE student_id = :student_id";
        $stmt = $pdo->prepare($selectQuery);
        $stmt->bindValue(':student_id', $studentID);
        $stmt->execute();
        $student = $stmt->fetch(PDO::FETCH_ASSOC);

        echo "
            student_id: {$student['student_id']}
            <br>
            first_name: {$student['first_name']}
            <br>
            last_name: {$student['last_name']}
            <br>
            <br>
        ";

        $deleteQuery = "DELETE FROM students.students WHERE student_id = :student_id";
        $stmt = $pdo->prepare($deleteQuery);
        $stmt->bindValue(':student_id', $studentID);
        $stmt->execute();

        echo "<b>Student {$student['first_name']} {$student['last_name']} was deleted!</b><br>";
    } else {
        echo "<b>Error:</b> Student with ID $studentID does not exist.";
    }
}
?>