<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addreminder.aspx.cs" Inherits="milestone3.addreminder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        function addReminder() {
            var taskId = document.getElementById('Text1').value;
            var day = document.getElementById('ddlDay').value;
            var month = document.getElementById('ddlMonth').value;
            var year = document.getElementById('ddlYear').value;
            var reminderDate = year + '-' + month + '-' + day;

            // Make AJAX call to server-side code
            $.ajax({
                type: 'POST',
                url: 'addreminder.aspx/AddReminder',
                data: JSON.stringify({
                    taskId: taskId,
                    reminderDate: reminderDate
                }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (result) {
                    var response = result.d;

                    if (response.Success) {
                        alert('Reminder added successfully!');
                    } else {
                        alert('Error adding reminder: ' + response.ErrorMessage);
                        console.log(response.ErrorMessage);
                    }
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                    alert('Error adding reminder. Check the console for more details.');
                }
            });
        }
    </script>
    <style>
         .body{
             display: flex;
            flex-direction:column;
            align-items: center;
            justify-content: center;
            background-image: url('images/Presentation22.jpg');
            background-size: cover;
        }
        .titlee {
         font-size:175%;
         margin-top:2%; 
        margin-bottom:5%;
        } 
        .reminderbody{
            display:flex;
            align-items:center;
            justify-content:center;
            flex-direction:column;
        }
        .addreminder{
            margin-top:4%;
            background-color:#000000;
            color:#ffffff;
        }
    </style>
</head>
<body class="body">
    <header class="titlee"> Add Reminder </header>
    <div class="reminderbody">
        <label>Enter Task ID</label>
        <input id="Text1" type="text" placeholder="Enter Task ID"/>
        <label> Enter Reminder date </label>
        <div style="display: flex;">
            <select id="ddlDay" class="type">
                <!-- Populate with day options -->
                <% for (int i = 1; i <= 31; i++) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>
            
            <select id="ddlMonth" class="type">
                <!-- Populate with month options -->
                <% string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }; %>
                <% foreach (string month in months) { %>
                    <option value="<%= month %>"><%= month %></option>
                <% } %>
            </select>
            
            <select id="ddlYear" class="type">
                <!-- Populate with year options -->
                <% for (int year = 1990; year <= 2023; year++) { %>
                    <option value="<%= year %>"><%= year %></option>
                <% } %>
            </select>
        </div>
        <button type="button" onclick="addReminder()" class="addreminder">Add Reminder</button>
    </div>
</body>
</html>
