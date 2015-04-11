<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AngulasJSTest.aspx.cs" Inherits="WingtipToys.AngulasJSTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div ng-app="myApp">
        <div ng-controller="myAppController as todoList">
            <label>Name:</label>
            <input type="text" ng-model="todoList.yourName" placeholder="Enter a name here">
            <hr>
            <h1>Hello {{todoList.yourName}}!</h1>
            <h2>Kocsik a db-ben: {{todoList.ProductLength}}</h2>
        </div>
    </div>

    <script type="text/javascript">
        angular.module('myApp', [])
  .controller('myAppController', function () {
      var todoList = this;

      todoList.yourName = "Béla";

      $.ajax({
          url: '<%=ResolveUrl("/Service.asmx/GetProducts") %>',
          data: "{ 'prefix': 'car'}",
          dataType: "json",
          type: "POST",
          contentType: "application/json; charset=utf-8",
          success: function (data) {
              todoList.ProductLength = data.d.lenght;
          },
          error: function (response) {
              $("#ErrorMsg").html(response.responseText);
          },
          failure: function (response) {
              $("#ErrorMsg").html(response.responseText);
          }
      });

      function Ujertek(i) {
          alert(i);
          todoList.ProductLength = i;
      }

      todoList.todos = [
        { text: 'learn angular', done: true },
        { text: 'build an angular app', done: false }];

      todoList.addTodo = function () {
          todoList.todos.push({ text: todoList.todoText, done: false });
          todoList.todoText = '';
      };

      todoList.remaining = function () {
          var count = 0;
          angular.forEach(todoList.todos, function (todo) {
              count += todo.done ? 0 : 1;
          });
          return count;
      };

      todoList.archive = function () {
          var oldTodos = todoList.todos;
          todoList.todos = [];
          angular.forEach(oldTodos, function (todo) {
              if (!todo.done) todoList.todos.push(todo);
          });
      };
  });
    </script>
</asp:Content>
