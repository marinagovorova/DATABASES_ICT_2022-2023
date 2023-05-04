<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>
<h1>Do you sure you want to DELETE take with ID = {{no}}?</h1>
<form action="/deletetake/{{no}}" method="get">
  <select name="delete">
    <option>yes</option>
    <option>no</option>
  </select>
  <br>
  <input type="submit" name="save" value="save">
</form>
<th colspan="7">
    <a href="/take" class="ui small button">Return to the Takings</a>
</th>