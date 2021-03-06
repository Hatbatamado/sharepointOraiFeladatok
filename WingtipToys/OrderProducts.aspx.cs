﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Logic;

namespace WingtipToys
{
    public partial class OrderProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<WingtipToys.Models.CartItem> CartList_GetData()
        {
            string status = ViewsDDL.SelectedValue;
            if (status == "All")
                status = string.Empty;
            return CartItemsBLL.GetOrderedCarItems(HttpContext.Current.User.Identity.Name, status);
        }

        protected void ViewsDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            CartList.DataBind();
        }
    }
}