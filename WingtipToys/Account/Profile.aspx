<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WingtipToys.Account.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><asp:Label runat="server" ID="UserNameLabel"></asp:Label></h1>
    <asp:Image runat="server" ID="ProfilePictureImg" />
    Birthday: <asp:Label runat="server" ID="BirthdayLabel"></asp:Label>
    Manager: <asp:Label runat="server" ID="ManagerLabel"></asp:Label>
</asp:Content>
