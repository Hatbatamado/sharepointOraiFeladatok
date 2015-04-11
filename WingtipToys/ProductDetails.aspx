<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="WingtipToys.ProductDetails" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
    <script>

        tinymce.init({
            selector: "textarea"
        });
        $.getJSON("http://localhost:55055/SecretService.svc/GetClientSecretCode", {},
            function (data) {
                $("#jsdiv").html("JS WCF " + data.key + " " + data.value);
            });
    </script>
    <asp:Label runat="server" ID="SecretCodeLabel"></asp:Label>
    <div id="jsdiv"></div>
    <asp:FormView ID="productDetail" runat="server" ItemType="WingtipToys.Models.Product" SelectMethod="GetProduct" RenderOuterTable="false">
        <ItemTemplate>
            <div>
                <h1><%#:Item.ProductName %></h1>
            </div>
            <br />
            <table>
                <tr>
                    <td>
                        <img src="/Catalog/Images/<%#:Item.ImagePath %>" style="border: solid; height: 300px" alt="<%#:Item.ProductName %>" />
                    </td>
                    <td>
                        <video id="video" controls width="400" height="300" src="/Catalog/Videos/<%#:Item.VideoPath %>"></video>
                        <object type="application/x-shockwave-flash" data="http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf" width="640" height="360" class="hide" id="objectVideo">
                            <param name="movie" value="http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf" />
                            <param name="allowFullScreen" value="true" />
                            <param name="wmode" value="transparent" />
                            <param name="flashVars" value="config={'playlist':['http%3A%2F%2Fsandbox.thewikies.com%2Fvfe-generator%2Fimages%2Fbig-buck-bunny_poster.jpg',{'url':'http%3A%2F%2Fclips.vorwaerts-gmbh.de%2Fbig_buck_bunny.mp4','autoPlay':false}]}" />
                            <img alt="Big Buck Bunny" src="http://sandbox.thewikies.com/vfe-generator/images/big-buck-bunny_poster.jpg" width="640" height="360" title="No video playback capabilities, please download the video below" />
                        </object>
                    </td>
                    <td style="vertical-align: top; text-align: left;">
                        <b>Description:</b><br />
                        <%#:Item.Description %>
                        <br />
                        <span><b>Price:</b>&nbsp;<%#: String.Format("{0:c}", Item.UnitPrice) %></span>
                        <br />
                        <span><b>Product Number:</b>&nbsp;<%#:Item.ProductID %></span>
                        <br />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:PlaceHolder runat="server" ID="CommentsPlaceHolder"></asp:PlaceHolder>
    <script>
        if (Modernizr.video) {

        }
        else {
            $("#objectVideo").removeClass("hide");
        }
    </script>
</asp:Content>
