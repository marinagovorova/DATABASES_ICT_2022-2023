<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
    </head>
    <body>
        <div class="ui container" style="padding-top: 10px;">
        <p>Студенты, которые сейчас проходят курс:</p>

        <table class="ui celled table">
            <thead>
                <th>№</th>
                <th>Студенты</th>
                <th>Редактировать/Удалить</th>
            </thead>
            <tbody>
            <a href="http://localhost:8081/new">
                            <button class="ui icon button">
                              <i class="plus icon"></i>
                            </button>
                        </a>
                %for row in rows:
                  <tr>
                  %for col in row:
                    <td>
                        <a href="http://localhost:8081/item{{row[0]}}" >
                            {{col}}
                        </a>
                    </td>
                  %end
                    <td>
                        <a href="http://localhost:8081/edit/{{row[0]}}">
                            <button class="ui icon button">
                              <i class="edit icon"></i>
                            </button>
                        </a>
						<a href="http://localhost:8081/delete/{{row[0]}}">
                            <button class="ui icon button">
                              <i class="delete icon"></i>
                            </button>
                        </a>
                    </td>
                  </td>
				  %end
            </tbody>
        </table>
        </div>
        </form>
        </div>
        <br>
        <br>
        <div class="ui container" style="padding-bottom: 10px;">
            <a href="http://localhost:8081/help">
                <button class="ui icon button">
                  <i class="help icon"></i>
                </button>
            </a>
       </div>
    </body>
</html>