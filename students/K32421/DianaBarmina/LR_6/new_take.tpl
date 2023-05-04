<p>Add a new reader to the Taking list:</p>
<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>
<form action="/newtake" method="GET">
  <input type="text" size="100" maxlength="100" name="reader_id">
  <input type="text" size="100" maxlength="100" name="book_id">
  <input type="text" size="100" maxlength="100" name="date">
  <input type="submit" name="save" value="save">
</form>
<th colspan="7">
    <a href="/take" class="ui small button">Return to the Taking</a>
</th>