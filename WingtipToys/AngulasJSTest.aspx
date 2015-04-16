<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AngulasJSTest.aspx.cs" Inherits="WingtipToys.AngulasJSTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div ng-app="myApp">
        <div ng-controller="myAppController as todoList">
            <label>Name:</label>
            <input type="text" ng-model="todoList.yourName" placeholder="Enter a name here">
            <hr>
            <h1>Hello {{todoList.yourName}}!</h1>
            <h2>Kocsik a db-ben: {{todoList.ProductLength}}</h2>
            <input class="btn-primary" type="submit" ng-click="setLength" value="setLength">
        </div>
    </div>

    <script type="text/javascript">
        var App = angular.module('myApp', []);

        App.controller('myAppController', function ($scope, $http) {
            var todoList = this;
            var ProductLength = 20;
            $.ajax({
                url: '<%=ResolveUrl("/Service.asmx/GetProducts") %>',
                data: "{ 'prefix': 'car'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $scope.$apply(function () {
                        $scope.ProductLength = data.d.length;
                        $scope.todoList.setLength(data.d.length);
                    });
                },
                error: function (response) {
                    $("#ErrorMsg").html(response.responseText);
                },
                failure: function (response) {
                    $("#ErrorMsg").html(response.responseText);
                }
            });
        });

        angular.module('myApp2', [])
  .controller('MyAppController2', function () {
      var todoList = this;

      todoList.yourName = "Béla";
      todoList.ProductLength = 10;
      $.ajax({
          url: '<%=ResolveUrl("/Service.asmx/GetProducts") %>',
              data: "{ 'prefix': 'car'}",
              dataType: "json",
              type: "POST",
              contentType: "application/json; charset=utf-8",
              success: function (data) {
                  todoList.ProductLength = data.d.length;
                  todoList.setLength();
              },
              error: function (response) {
                  $("#ErrorMsg").html(response.responseText);
              },
              failure: function (response) {
                  $("#ErrorMsg").html(response.responseText);
              }
          });
          todoList.setLength = function () {
              //todoList.ProductLength = 15;
              return false;
          };

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
