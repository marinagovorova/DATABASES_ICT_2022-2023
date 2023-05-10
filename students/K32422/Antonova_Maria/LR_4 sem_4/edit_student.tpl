%#template for editing a student
%#the template expects to receive a value for "no" as well a "old", the text of the selected student
<p>Edit the student with ID = {{no}}</p>
<form action="/edit/{{no}}" method="get">
  <input type="text" name="student" value="{{old[0]}}" size="100" maxlength="100">
  <select name="status">
    <option>currently studying</option>
    <option>finished studying</option>
  </select>
  <br>
  <input type="submit" name="save" value="save">
</form>