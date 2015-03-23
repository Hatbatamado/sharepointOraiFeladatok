<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommentsUC.ascx.cs" Inherits="WingtipToys.UserControls.CommentsUC" %>
<h1>Comments</h1>

    <asp:TextBox runat="server" ID="TextBoxComment" TextMode="MultiLine" Rows="4" Columns="50"></asp:TextBox>
    <%--<asp:RequiredFieldValidator runat="server" ID="requiredComment" ControlToValidate="TextBoxComment" ErrorMessage="Comment is req."></asp:RequiredFieldValidator>--%>

<script>

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);

    function BeginRequestHandler() {

    }

    function saveCommentToHF() {

        var comment = tinyMCE.activeEditor.getContent();
        $("#<%=HiddenFieldComment.ClientID %>").val(comment);
    }

    //AJAX nem mindig hatja végre a javascripteket, ezért itt meg kell hívni őket
    function EndRequestHandler() {

        try {

        }
        catch (err) {

        }
    }

    </script>

<asp:UpdatePanel runat="server" ID="MainUpdatePanel">
    <ContentTemplate>
        <asp:HiddenField runat="server" ID="HiddenFieldComment" />
        <div runat="server" id="commentDiv">

            <asp:Button runat="server" ID="Button1" Text="Send" OnClientClick="saveCommentToHF();" OnClick="ButtonSend_Click" />
            <br />
            <br />
        </div>
        <div runat="server" id="loginDiv">
            Kommenteléshez jelentkezz be <a href="/Account/Login">itt</a>!!
            <br /><br />
        </div>

        <asp:Repeater runat="server" ID="CommentsRepeater" OnItemDataBound="CommentsRepeater_ItemDataBound"
            OnItemCommand="CommentsRepeater_ItemCommand">
            <ItemTemplate>
                <div style="border: 1px solid green">
                    <b><%# Eval("UserLoginName") %></b>:<br />
                    &nbsp;
            <%# Eval("CommentMSG") %>
                    <div style="float: right">
                        <asp:LinkButton runat="server" CausesValidation="false" ID="TorlesButton" Text="Delete"
                            CommandArgument='<%# Eval("CommentID") %>' CommandName="Torles"></asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </ContentTemplate>
</asp:UpdatePanel>