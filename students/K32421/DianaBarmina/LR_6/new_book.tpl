<p>Add a new take to the ToDo list:</p>
<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>
<form action="/newbook" method="GET">
  <input type="text" size="100" maxlength="100" name="name">
  <input type="text" size="100" maxlength="100" name="author_name">
  <input type="submit" name="save" value="save">
</form>
<th colspan="7">
    <a href="/books" class="ui small button">Return to the Books</a>
</th>