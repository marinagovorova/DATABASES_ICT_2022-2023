var taskInput = document.getElementById("new-task"); //new-task
var addButton = document.getElementsByTagName("button")[0]; //first button
var incompleteTasksHolder = document.getElementById("incomplete-tasks"); //incomplete-tasks
var completedTasksHolder = document.getElementById("completed-tasks"); //completed-tasks

//New Task List Item
var createNewTaskElement = function (taskString) {

    var listItem = document.createElement("li");

    var checkBox = document.createElement("input"); 
    var label = document.createElement("label");
    var deleteButton = document.createElement("button");

    checkBox.type = "checkbox";

    deleteButton.innerText = "Delete";
    deleteButton.className = "delete";

    label.innerText = taskString;

    listItem.appendChild(checkBox);
    listItem.appendChild(label);
    listItem.appendChild(deleteButton);

    return listItem;
}

//Add a new task
var addTask = function () {
    console.log("Add task...");
    //Create a new list item with the text from #new-task:
    var listItem = createNewTaskElement(taskInput.value);

    if (taskInput.value == "") {
        alert("please type input");
    }
    else {
        //Append listItem to incompleteTasksHolder
        incompleteTasksHolder.appendChild(listItem);
        bindTaskEvents(listItem, taskCompleted);

        // Send a POST request to add.php to add the new task to the database
        fetch('app/add.php', {
            method: 'POST',
            body: new URLSearchParams({
                'title': taskInput.value
            })
        })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error('Error adding task');
                }
            }).then(() => {
                window.location.reload();
            })
            
            .catch(error => {
                console.error(error);
            });
        taskInput.value = "";
    }
}

//Delete an existing task
var deleteTask = function () {
    console.log("Delete task...");
    var listItem = this.parentNode;
    var ul = listItem.parentNode;
    //var title = listItem.querySelector('label').innerText;
    var id = listItem.id;

    // Send a POST request to delete.php to delete the task from the database
    fetch('app/remove.php', {
        method: 'POST',
        body: new URLSearchParams({
            'id': id
        })
    })
        .then(response => {
            if (response.ok) {
                console.log("deleteeee");
                return response.text();
            }
            else {
                throw new Error('Error removing task');
            }
        })
        .then(data => {
            if (data == 1) {
                //Remove the parent list item from the ul
                ul.removeChild(listItem);
            }
        })
        .catch(error => {
            console.error(error);
        });
}

//Mark a task as complete
var taskCompleted = function () {
    console.log("Task complete...");
    //Append the task list item to the #completed-tasks
    var listItem = this.parentNode;
    var ul = listItem.parentNode;
    completedTasksHolder.appendChild(listItem);
    bindTaskEvents(listItem, taskIncomplete);
    var title = listItem.querySelector('label').innerText;
    var id = listItem.id;

    fetch('app/check.php', {
        method: 'POST',
        body: new URLSearchParams({
            'id': id
        })
    })
        .then(response => {
            if (response.ok) {
                console.log("check");
                return response.text();
            }
            else {
                throw new Error('Error removing task');
            }
        })
        .then(data => {
            if (data == 1) {
                //Remove the parent list item from the ul
                ul.removeChild(listItem);
            }
        })
        .catch(error => {
            console.error(error);
        });
}

//Mark a task as incomplete
var taskIncomplete = function () {
    console.log("Task incomplete...");
    //Append the task list item to the #incomplete-tasks
    var listItem = this.parentNode;
    var ul = listItem.parentNode;
    incompleteTasksHolder.appendChild(listItem);
    bindTaskEvents(listItem, taskCompleted);
    //var title = listItem.querySelector('label').innerText;
    var id = listItem.id;

    fetch('app/check.php', {
        method: 'POST',
        body: new URLSearchParams({
            'id': id
        })
    })
        .then(response => {
            if (response.ok) {
                console.log("check");
                return response.text();
            }
            else {
                throw new Error('Error removing task');
            }
        })
        .then(data => {
            if (data == 1) {
                //Remove the parent list item from the ul
                ul.removeChild(listItem);
            }
        })
        .catch(error => {
            console.error(error);
        });
}

var bindTaskEvents = function (taskListItem, checkBoxEventHandler) {
    console.log("Bind list item events");
    //select taskListItem's children
    var checkBox = taskListItem.querySelector("input[type=checkbox]");
    var deleteButton = taskListItem.querySelector("button.delete");

    //bind deleteTask to delete button
    deleteButton.onclick = deleteTask;

    //bind checkBoxEventHandler to checkbox
    checkBox.onchange = checkBoxEventHandler;
}

//Set the click handler to the addTask function
addButton.addEventListener("click", addTask);
//addButton.addEventListener("click", ajaxRequest);

//cycle over incompleteTasksHolder ul list items
for (var i = 0; i < incompleteTasksHolder.children.length; i++) {
    //bind events to list item's children (taskCompleted)
    bindTaskEvents(incompleteTasksHolder.children[i], taskCompleted);
}

//cycle over completedTasksHolder ul list items
for (var i = 0; i < completedTasksHolder.children.length; i++) {
    //bind events to list item's children (taskIncomplete)
    bindTaskEvents(completedTasksHolder.children[i], taskIncomplete);
}