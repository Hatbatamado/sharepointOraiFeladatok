<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommentsUC.ascx.cs" Inherits="WingtipToys.UserControls.CommentsUC" %>
<h1>Comments</h1>
<div runat="server" id="commentDiv">
    <asp:TextBox runat="server" ID="TextBoxComment" TextMode="MultiLine" Rows="4" Columns="100"></asp:TextBox>
    <%--<asp:RequiredFieldValidator runat="server" ID="requiredComment" ControlToValidate="TextBoxComment" ErrorMessage="Comment is req."></asp:RequiredFieldValidator>--%>
    <asp:Button runat="server" ID="ButtonSend" OnClick="ButtonSend_Click" Text="Send" OnClientClick="saveCommentTOHF();" />
</div>

<script>

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);

    function BeginRequestHandler() {
        var comment = $('#<%= TextBoxComment.ClientID %>').val();
        $('#<%= HiddenFieldComment.ClientID %>').val(comment);
    }

    function saveCommentToHF()
    {
        <%--var comment = $('#<%= TextBoxComment.ClientID %>').val();--%>
        var comment = tinyMCE.activeEditor.getContent();
        $('#<%= HiddenFieldComment.ClientID %>').val(comment);
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

<div runat="server" id="loginDiv">
    Kommenteléshez jelentkezz be <a href="../Account/Login.aspx">itt!</a>
</div>
<asp:Repeater runat="server" ID="CommentsRepeater" OnItemCommand="CommentsRepeater_ItemCommand" OnItemDataBound="CommentsRepeater_ItemDataBound">
    <ItemTemplate>
        <div style="border: 1px solid green">
            <b><%# Eval("UserLoginName") %></b>:</br>&nbsp;
            <%# Eval("CommentMSG") %>
            <div style="float:right">
                <asp:LinkButton runat="server" ID="TorlesButton" Text="Törlés" CausesValidation="false"
                    CommandArgument='<%# Eval("CommentID") %>' CommandName="Torles"></asp:LinkButton>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
    </ContentTemplate>
</asp:UpdatePanel>