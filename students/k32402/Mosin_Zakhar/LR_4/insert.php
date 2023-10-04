<?php
global $db;
include 'pg.php';
if (isset($_POST['submit'])) {
	$query = "INSERT INTO public.book_info VALUES ('$_POST[book_id]',
	'$_POST[book_name]', '$_POST[book_type]', '$_POST[book_author]')";
	$query = "INSERT INTO public.book_info (book_id, book_name, field_of_knowledge, original_language, book_author, book_type)
VALUES ('$_POST[book_id]', '$_POST[book_name]', '$_POST[field_of_knowledge]', '$_POST[original_language]', '$_POST[book_author]', '$_POST[book_type]')";

	
	$result = pg_query($query);
	pg_close($db);
	if (!$result) {
		echo "Update failed!";
	} else {
		echo "Update successfull!";
	}
}
?>