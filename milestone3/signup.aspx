<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="milestone3.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <title></title>
<script>
    function signup() {
        var userType = document.getElementById('usertype').value;
        var email = document.getElementById('Textemail').value;
        var firstName = document.getElementById('Textfname').value;
        var lastName = document.getElementById('Textlname').value;
        var password = document.getElementById('Textpass').value;
        var day = document.getElementById('ddlDay').value;
        var month = document.getElementById('ddlMonth').value;
        var year = document.getElementById('ddlYear').value;
        var birthDate = year + '-' + month + '-' + day;

        // Generate a unique identifier (GUID)
        var usersId = generateUniqueId();

        // Make AJAX call to server-side code
        $.ajax({
            type: 'POST',
            url: 'signup.aspx/UserRegister',
            data: JSON.stringify({
                usersId: usersId,
                userType: userType, // Pass user type as a string
                email: email,
                firstName: firstName,
                lastName: lastName,
                password: password,
                birthDate: birthDate
            }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (result) {
                var response = result.d;

                if (response.Success) {
                    alert('Signup successful!');
                    window.location.href = 'profile.aspx?userId=' + response.UserId;
                } else {
                    alert('Error during signup: ' + response.ErrorMessage);
                    console.log(response.ErrorMessage);
                }
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                alert('Error during signup. Check the console for more details.');
            }
        });
    }


    // Function to generate a unique identifier (GUID)
    function generateUniqueId() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0,
                v = c === 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }


</script>
     <style>
        .bodyy{
             display: flex;
            flex-direction:column;
            align-items: center;
            justify-content: center;
            background-image: url('images/50-Beautiful-and-Minimalist-Presentation-Backgrounds-019.jpg');
            
        }
         .registerbody{
             display:flex;
             flex-direction:column;
             align-content:flex-start ;
             border:2px solid #808080 ;
             border-radius:3%;
             width:20%;
             padding:2%;
             margin-top:10%;

         }
        .titlee {
         font-size:175%;
         margin-top:2%;
         
        }  
         .lablee{
        align-content :flex-start ;
      margin-bottom:2%;
         margin-top:2%;
         }
         .type{
             width:40%;
         }
         #Text{
              width:40%;
         }
         .signupbut{
             margin-top:4%;
             width : 20%;
             color :#ffffff ;
             background-color :#000000 ;
             border-radius:4%;
             border :none ;
            
         }
         .signbut{
              display:flex;
              align-items:center;
              justify-content:center;
         }
    </style>
    
</head>
     
<body class ="bodyy">

    <header class="titlee"> Signup page</header>
        <div class ="registerbody">
            <lable class="lablee">User type</lable>
         <select id="usertype" class="usertype">
    <option value="admin">Admin</option>
    <option value="user">User</option>
</select>


            <lable class="lablee">Email</lable> 
 <input id="Textemail" type="Email"  placeholder="Enter your email"/>
             <lable class="lablee">First name</lable> 
 <input id="Textfname" type="Text"  placeholder="Enter your First name"/>
                         <lable class="lablee">Last name</lable> 
 <input id="Textlname" type="Text"  placeholder="Enter your Last name"/>
                         <lable class="lablee">Password</lable> 
 <input id="Textpass" type="Text"  placeholder="Enter your Password"/>
            <label class="lablee">Birthdate</label>
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
            <div class ="signbut">
             
<button type="button" class="signupbut" onclick="signup()" ClientIDMode="Static">Signup</button>
        </div>
            </div>
    
</body>
        
</html>