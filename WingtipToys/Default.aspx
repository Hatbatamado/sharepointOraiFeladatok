<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WingtipToys._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">  
    <h1><%: Title %></h1>

    <style type="text/css">
        .progress {
            position: fixed;
            top: 30%;
            left: 40%; /*width: 200px;*/
            z-index: 200;
            background-color: gray;
            padding: 15px;
            text-align: center;
            border: 1px solid black;
            color: white;
            height: 220px;
        }

        .blur {
            width: 100%;
            background-color: black;
            moz-opacity: 0.5;
            khtml-opacity: .5;
            opacity: .5;
            filter: alpha(opacity=50);
            z-index: 120;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
        }
    </style>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            hami
        </ContentTemplate>
    </asp:UpdatePanel> 
Wingtip Toys can help you find the perfect gift. 
<p>We're all about transportation toys. You can order class any of our toys today. Each toy listing has detailed information to help you choose the right toy.</p> 
　     <style>
        .ui-autocomplete-loading {
            background: white url("Catalog/Images/loading.gif") right center no-repeat;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=txtSearch.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("/Service.asmx/GetProducts") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0],
                                    val: item.split('-')[1]
                                }
                            }))
                        },
                        error: function (response) {
                            $("#ErrorMsg").html(response.responseText);
                        },
                        failure: function (response) {
                            $("#ErrorMsg").html(response.responseText);
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=hfCustomerId.ClientID %>").val(i.item.val);
                    window.location = "/ProductDetails.aspx?id=" + i.item.val;
                },
                minLength: 1
            });
        });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);

            function BeginRequestHandler() {

            }

            //AJAX nem mindig hatja végre a javascripteket, ezért itt meg kell hívni őket
            function EndRequestHandler() {

                try {
                    $('#<%= texts.ClientID %>').removeAttr('disabled');
            }
            catch (err) {

            }
        }


        function textChanged() {

            $('#<%= texts.ClientID %>').prop('disabled', false);
                __doPostBack('<%= MainUpdatePanel.ClientID %>', 'UpdateProductResults');



            }
    </script>
    <table>
        <tr>
            <td valign="top">
                <h1>Autocomplete with jquery</h1>
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                <input id="texts" type="text" runat="server" onkeyup="textChanged();" />
                <asp:HiddenField ID="hfCustomerId" runat="server" />
                <br />
                <div id="ErrorMsg"></div>
            </td>
            <td valign="top">
                <h1>Search with UpdatePanel</h1>
                <asp:UpdatePanel runat="server" ID="MainUpdatePanel" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:TextBox runat="server" ID="SearchTextBox"></asp:TextBox>
                        <asp:Button runat="server" ID="SearchButton" Text="Search" OnClick="SearchButton_Click" />
                        <asp:Label runat="server" ID="LabelDate"></asp:Label>

                        <h1>Results</h1>
                        <asp:ListView ID="productList" runat="server"
                            DataKeyNames="ProductID" GroupItemCount="4"
                            ItemType="WingtipToys.Models.Product">


                            <EmptyDataTemplate><table>


                                    <tr>


                                        <td>No data was returned.</td>


                                    </tr>


                                </table>


                            </EmptyDataTemplate>


                            <EmptyItemTemplate>


                                <td />


                            </EmptyItemTemplate>


                            <GroupTemplate>


                                <tr id="itemPlaceholderContainer" runat="server">


                                    <td id="itemPlaceholder" runat="server"></td>


                                </tr>


                            </GroupTemplate>


                            <ItemTemplate>


                                <td runat="server">


                                    <table>


                                        <tr>


                                            <td>


                                                <a href="<%#: GetRouteUrl("ProductByNameRoute", new {productName = Item.ProductName}) %>">


                                                    <image src='/Catalog/Images/Thumbs/<%#:Item.ImagePath%>'
                                                        width="100" height="75" border="1" />


                                                </a>


                                            </td>


                                        </tr>


                                        <tr>


                                            <td>


                                                <a href="<%#: GetRouteUrl("ProductByNameRoute", new {productName = Item.ProductName}) %>">


                                                    <%#:Item.ProductName%> 


                                                </a>


                                                <br />


                                                <span>


                                                    <b>Price: </b><%#:String.Format("{0:c}", Item.UnitPrice)%> 


                                                </span>


                                                <br />


                                                <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>">


                                                    <span class="ProductListItem">


                                                        <b>Add To Cart<b> 


                                                    </span>


                                                </a>


                                            </td>


                                        </tr>


                                        <tr>


                                            <td>&nbsp;</td>


                                        </tr>


                                    </table>


                                    </p> 


                                </td>


                            </ItemTemplate>


                            <LayoutTemplate>


                                <table style="width: 100%;">


                                    <tbody>


                                        <tr>


                                            <td>


                                                <table id="groupPlaceholderContainer" runat="server" style="width: 100%">


                                                    <tr id="groupPlaceholder"></tr>


                                                </table>


                                            </td>


                                        </tr>


                                        <tr>


                                            <td></td>


                                        </tr>


                                        <tr></tr>


                                    </tbody>


                                </table>


                            </LayoutTemplate>


                        </asp:ListView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress DisplayAfter="0" ID="UpdateProgressMain" runat="server" AssociatedUpdatePanelID="MainUpdatePanel"
                    DynamicLayout="true">
                    <ProgressTemplate>
                        <div class="blur"></div>
                        <div class="progress">
                            <img src="Images/loading.gif" height="150px">
                            <br>

                            <h3 style="color: white">Folyamatban...</h3>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>

</asp:Content>
