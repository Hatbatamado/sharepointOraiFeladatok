<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderProducts.aspx.cs" Inherits="WingtipToys.OrderProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="ApprovalListTitle" runat="server" class="ContentHead"><h1>Ordered Products</h1></div>
    <asp:DropDownList runat="server" ID="ViewsDDL" AutoPostBack="true" OnSelectedIndexChanged="ViewsDDL_SelectedIndexChanged">
        <asp:ListItem Text="Active" Value="Approved"></asp:ListItem>
        <asp:ListItem Text="Shipped" Value="Shipped"></asp:ListItem>
        <asp:ListItem Text="All" Value="All"></asp:ListItem>
    </asp:DropDownList>
    <asp:GridView ID="CartList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
        ItemType="WingtipToys.Models.CartItem" SelectMethod="CartList_GetData"
        CssClass="table table-striped table-bordered" >   
        <Columns>
        <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" />        
        <asp:BoundField DataField="Product.ProductName" HeaderText="Name" />        
        <asp:BoundField DataField="Product.UnitPrice" HeaderText="Price (each)" DataFormatString="{0:c}"/>     
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" /> 
            <asp:BoundField DataField="Status" HeaderText="Status" /> 
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
</asp:Content>
