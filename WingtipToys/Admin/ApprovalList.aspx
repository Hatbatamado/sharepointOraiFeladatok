<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovalList.aspx.cs" Inherits="WingtipToys.Admin.ApprovalList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div id="ApprovalListTitle" runat="server" class="ContentHead"><h1>Cart items approval</h1></div>
    <asp:GridView ID="CartList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
        ItemType="WingtipToys.Models.CartItem" 
        CssClass="table table-striped table-bordered" >   
        <Columns>
        <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" />        
        <asp:BoundField DataField="Product.ProductName" HeaderText="Name" />        
        <asp:BoundField DataField="Product.UnitPrice" HeaderText="Price (each)" DataFormatString="{0:c}"/>     
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" /> 
        <asp:TemplateField   HeaderText="Quantity">            
                <ItemTemplate>
                    <asp:Label ID="PurchaseQuantity" Width="40" runat="server" Text="<%#: Item.Quantity %>"></asp:Label> 
                </ItemTemplate>        
        </asp:TemplateField>    
        <asp:TemplateField HeaderText="Item Total">            
                <ItemTemplate>
                    <%#: String.Format("{0:c}", ((Convert.ToDouble(Item.Quantity)) *  Convert.ToDouble(Item.Product.UnitPrice)))%>
                </ItemTemplate>        
        </asp:TemplateField> 
        <asp:TemplateField HeaderText="Remove Item">            
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="StatusDDL"
                        SelectedValue='<%# Eval("Status") %>'
                        DataSource='<%# Eval("StatusList") %>'
                        DataTextField="Text" DataValueField="Value"></asp:DropDownList>
                </ItemTemplate>        
        </asp:TemplateField>    
        </Columns>    
    </asp:GridView>
    <div>
        <p></p>
        <strong>
            <asp:Label ID="LabelTotalText" runat="server" Text="Order Total: "></asp:Label>
            <asp:Label ID="lblTotal" runat="server" EnableViewState="false"></asp:Label>
        </strong> 
    </div>
    <br />
    <table> 
    <tr>
      <td>
        <asp:Button ID="UpdateBtn" runat="server" Text="Update" OnClick="UpdateBtn_Click" />
      </td>
      <td>
       
      </td>
    </tr>
    </table>
</asp:Content>
