<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>
<h1>UPDATE take with ID = {{no}}</h1>
<form action="/updatetake/{{no}}" method="get">
  <input type="text" name="reader_id" value="{{old[0]}}" size="10" maxlength="100">
  <input type="text" name="book_id" value="{{old[1]}}" size="10" maxlength="100">
  <input type="text" name="date" value="{{old[2]}}" size="10" maxlength="100">
  <br>
  <input type="submit" name="save" value="save">
</form>
<th colspan="7">
    <a href="/take" class="ui small button">Return to the Taking</a>
</th>
