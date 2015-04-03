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

        <asp:GridView runat="server" ID="CommentsGridView" OnItemDataBound="CommentsRepeater_ItemDataBound"
            OnItemCommand="CommentsRepeater_ItemCommand" AutoGenerateColumns="false">
			<Columns>
				<asp:TemplateField>
					<ItemTemplate>
						<b><a href='/Account/Profile.aspx?UserName=<%# Eval("UserLoginName") %>'>
                        <%# Eval("UserLoginName") %></a></b>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:Label runat="server" ID="UserNameLabel" Text='<%# Eval("UserLoginName") %>'>
						</asp:Label>
					</EditItemTemplate>
				</asp:TemplateField>
				<asp:TemplateField>
					<ItemTemplate>
						<%# Eval("CommentMSG") %>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:TextBox runat="server" ID="commentTB" TextMode="MultiLine" Rows="4" Columns="10" Text='<%# Bind("CommentMSG") %>'>
						</asp:TextBox>
					</EditItemTemplate>
				</asp:TemplateField>
				<asp:TemplateField>
					<ItemTemplate>
					<asp:LinkButton runat="server" CausesValidation="false" ID="TorlesButton" Text="Delete"
                            CommandArgument='<%# Eval("CommentID") %>' CommandName="Torles"></asp:LinkButton> 
					</ItemTemplate>
				</asp:TemplateField>
			</Columns>
        </asp:GridView>
        <asp:ObjectDataSource runat="server" ID="ODS" TypeName="WingtipToys.Models.Comment" SelectMethod="GetComments" UpdateMethod="SetComment"></asp:ObjectDataSource>
    </ContentTemplate>
</asp:UpdatePanel>