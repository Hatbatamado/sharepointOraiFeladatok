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

<%--<asp:UpdatePanel runat="server" ID="MainUpdatePanel">
    <ContentTemplate>--%>
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

        <asp:GridView runat="server" ID="CommentsGridView"
            OnRowCommand="CommentsGridView_RowCommand"
            OnItemCommand="CommentsRepeater_ItemCommand" AutoGenerateColumns="false" DataSourceID="ODS"
            AllowPaging="true" PageSize="3" PagerSettings-Mode="NumericFirstLast">
			<Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button runat="server" ID="EditButton" Text="Edit" CommandName="Edit" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button runat="server" ID="SaveButton" Text="Update" CommandName="Update" />
                        <asp:Button runat="server" ID="CancelButton" Text="Cancel" CommandName="Cancel" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button runat="server" ID="MyEditButton" Text="MyEdit"
                            CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="MyEdit" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button runat="server" ID="MySaveButton" Text="MyUpdate" CommandName="MyUpdate" />
                        <asp:Button runat="server" ID="MyCancelButton" Text="MyCancel" CommandName="MyCancel" />
                    </EditItemTemplate>
                </asp:TemplateField>
				<asp:TemplateField>
					<ItemTemplate>
						<b><a href='/Account/Profile.aspx?UserName=<%# Eval("UserLoginName") %>'>
                        <%# Eval("UserLoginName") %></a></b>
					</ItemTemplate>
					<EditItemTemplate>
						<asp:Label runat="server" ID="UserNameLabel" Text='<%# Eval("UserLoginName") %>'>
						</asp:Label>
                        <asp:HiddenField runat="server" ID="HiddenField1" Value='<%# Bind("CommentID") %>' />
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
        <asp:ObjectDataSource runat="server" ID="ODS" TypeName="WingtipToys.UserControls.CommentsUC" SelectMethod="GetComments" UpdateMethod="SetComment" OnObjectCreating="ODS_ObjectCreating" OnObjectDisposing="ODS_ObjectDisposing" ></asp:ObjectDataSource>
<%--    </ContentTemplate>
</asp:UpdatePanel>--%>