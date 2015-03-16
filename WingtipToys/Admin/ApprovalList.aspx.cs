using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Logic;
using WingtipToys.Models;

namespace WingtipToys.Admin
{
    public partial class ApprovalList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                List<CartItem> carItemsNotApproved = CartItemsBLL.GetNotApprovedCarItems();
                CartList.DataSource = carItemsNotApproved;
                CartList.DataBind();
            }
        }

        public List<CartItem> UpdateCartItems()
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                ShoppingCartActions.ShoppingCartUpdates[] cartUpdates = new ShoppingCartActions.ShoppingCartUpdates[CartList.Rows.Count];
                for (int i = 0; i < CartList.Rows.Count; i++)
                {
                    IOrderedDictionary rowValues = new OrderedDictionary();
                    rowValues = Utility.GetValues(CartList.Rows[i]);
                    cartUpdates[i].ProductId = Convert.ToInt32(rowValues["ProductID"]);

                    DropDownList ddlStatus = new DropDownList();
                    ddlStatus = (DropDownList)CartList.Rows[i].FindControl("StatusDDL");
                    cartUpdates[i].Status = ddlStatus.SelectedValue;

                    cartUpdates[i].PurchaseQuantity = Convert.ToInt32(rowValues["Quantity"]);
                }
                usersShoppingCart.UpdateShoppingCartDatabase(String.Empty, cartUpdates);
                CartList.DataSource = CartItemsBLL.GetNotApprovedCarItems();
                CartList.DataBind();
                lblTotal.Text = String.Format("{0:c}", usersShoppingCart.GetTotal());
                return usersShoppingCart.GetCartItems();
            }
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            UpdateCartItems();
        }
    }
}