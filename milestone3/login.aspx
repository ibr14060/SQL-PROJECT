<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="milestone3.login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
   <script>
       function login() {
           var email = document.getElementById('Text1').value;
           var password = document.getElementById('Text2').value;

           // Make AJAX call to server-side code
           $.ajax({
               type: 'POST',
               url: 'login.aspx/UserLogin',
               data: JSON.stringify({
                   email: email,
                   password: password
               }),
               contentType: 'application/json; charset=utf-8',
               dataType: 'json',
               // Inside the success block of your AJAX call in login.aspx.cs
               success: function (result) {
                   var response = result.d;

                   if (response.Success) {
                       alert('Login successful!');
                       // Redirect to the profile page with the obtained user ID
                       window.location.href = 'profile.aspx?userId=' + response.UserId;
                   } else {
                       alert('Error during login: ' + response.ErrorMessage);
                       console.log(response.ErrorMessage);
                   }
               },

               error: function (xhr, status, error) {
                   console.error(xhr.responseText);
                   alert('Error during login. Check the console for more details.');
               }
           });
       }
</script>

    <style>
        .bodyy{
             display: flex;
            flex-direction:column;
            align-items: center;
            justify-content: center;
            background-image: url('images/Presentation1.jpg');
             background-size: cover;
        }
        .loginbody {
            border :1px solid #dddddd ;
            display: flex;
            flex-direction:column;
            align-items: flex-start;
            justify-content: center;
           height:100%;  
           width: 20%;
           margin-top :15%;
           border-radius :2px;
           padding:2%;
        }


        .titlee {
         font-size:175%;
         color:#ffffff ;
        }  
    
    .lablee{
        align-content :flex-start ;
        margin-left :3%;
         color:#ffffff ;
    }
           
    #Text1{
         margin-left :3%;
         margin-bottom :2%;
    }
      #Text2{
         margin-left :3%;
         margin-bottom :2%;
    }
    
    .Button1{
        width:20%;
       margin-top :2%;
        height:100%;
        

    }
           .ssdd{
               display:flex;
             align-items: center;
            justify-content: center;
            width:100%;
            flex-direction :column ;
            margin-bottom :3%;
           }
    </style>
</head>
   
<body class="bodyy">
    <header class="titlee">Login page</header>
    <div class="loginbody">
        <label class="lablee">Email</label>
        <input id="Text1" runat="server" type="text" placeholder="Enter your email" />
        <label class="lablee">Password</label>
        <input id="Text2" runat="server" type="Password" placeholder="Enter your password" />
        <div class="ssdd">
            <button type="button" runat="server" class="Button1" onclick="login()">Login</button>
            <a href="signup.aspx">Don't have an account? Signup</a>
        </div>
    </div>
</body>
</html>