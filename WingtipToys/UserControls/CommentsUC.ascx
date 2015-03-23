<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommentsUC.ascx.cs" Inherits="WingtipToys.UserControls.CommentsUC" %>

<h1>Comments</h1>

<asp:TextBox runat="server" ID="TextBoxComment" TextMode="MultiLine" Rows="4" Columns="100"></asp:TextBox>
<asp:RequiredFieldValidator runat="server" ID="requiredComment" ControlToValidate="TextBoxComment" ErrorMessage="Comment is req."></asp:RequiredFieldValidator>
<asp:Button runat="server" ID="ButtonSend" OnClick="ButtonSend_Click" Text="Send"/>

<asp:Repeater runat="server" ID="CommentsRepeater">
    <ItemTemplate>
        <div style="border:1px solid green">
            <b><%# Eval("UserLoginName") %></b>:</br>&nbsp;
            <%# Eval("CommentMSG") %>
        </div>
    </ItemTemplate>
</asp:Repeater>