<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JSTest.aspx.cs" Inherits="WingtipToys.JSTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .gyerek {
            
            height: 300px;
          
            background: linear-gradient(red, blue); /* Standard syntax */
            color: white;
            font-weight: bold;
            width:25%;
            display:inline-block;
        }
        .gyerek div{
            position:relative;
            top:50%;
            height:50px;
              vertical-align:middle;
        }
            .gyerek:hover {
                background: none;
                background-color: white;
                color: black;
                font-size: 20pt;
            }

        .gyerekclicked {
            border: 2px solid;
            border-radius: 25px;
        }

        #testdiv {
            background-color: blue;
        }

            #testdiv:hover {
                background-color: white;
                color: black;
                font-size: 20pt;
            }

        .piros {
            background-color: red !important;
            color: white;
            height: 200px;
            width: 400px;
            text-align: center;
        }

        .hupilila {
            border: dotted 5px white;
        }
        .navbar-inverse{
z-index:-1;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            // Handler for .ready() called.
            $("#testdiv").hide();
        });

        function ChangeBackgroundColor() {
            /*var i;
            var divem = document.getElementById("testdiv");
            divem.style.backgroundColor = "red";
            divem.style.color = "white";*/

            if ($("#testdiv").attr('class').indexOf("piros") >= 0) {
                $("#testdiv").removeClass("piros");
                $("#testdiv").addClass("hupilila");
            }
            else {
                $("#testdiv").addClass("piros");
                $("#testdiv").removeClass("hupilila");
                //$("#testdiv").html("SZia!");

                $("#testdiv").children().each(function () {
                    $(this).addClass("gyerekclicked");
                }
                    );
            }
        }
    </script>
    <div style="position:absolute; top:0px; left:0px; z-index:1; color:white">
        Szia!
    </div>
    <div onclick="ChangeBackgroundColor();" id="testdiv" class="vmi">
        sdfsdsdsdfsdf
        <div class="gyerek">
            <div>10</div>
        </div>
        <div class="gyerek">
            10
        </div>
        <div class="gyerek">
            10
        </div>
        <div class="gyerek">
            10
        </div>
        <div class="gyerek">
            10
        </div>
    </div>
</asp:Content>
