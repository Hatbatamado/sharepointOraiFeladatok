using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WingtipToys.Models;
using System.Data.Entity;
using System.Web.UI.WebControls;

namespace WingtipToys.Logic
{
    public class CartItemsBLL
    {
        internal static List<CartItem> GetOrderedCarItems()
        {
            using (ProductContext db = new ProductContext())
            {
                /*return (from ci in db.ShoppingCartItems
                        where ci.Status != CartItemStatus.Approved.ToString()
                        select ci).*/

                string a = CartItemStatus.Approved.ToString();
                List<CartItem> carItems = (db.ShoppingCartItems.
                    Where(ci => !String.IsNullOrEmpty(ci.Status))).
                    Include(p => p.Product).ToList();

                foreach (CartItem item in carItems)
                {
                    item.Statuslist = new List<ListItem>();
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Approved.ToString(), Text = CartItemStatus.Approved.ToString() });
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Declined.ToString(), Text = CartItemStatus.Declined.ToString() });
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Registered.ToString(), Text = CartItemStatus.Registered.ToString() });
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Shipped.ToString(), Text = CartItemStatus.Shipped.ToString() });
                }
                return carItems;
            }
        }
        internal static List<Models.CartItem> GetNotApprovedCarItems()
        {
            using (ProductContext db = new ProductContext())
            {
                /*return (from ci in db.ShoppingCartItems
                        where ci.Status != CartItemStatus.Approved.ToString()
                        select ci).*/

                string a = CartItemStatus.Approved.ToString();
                List<CartItem> carItems = (db.ShoppingCartItems.
                    Where(ci => ci.Status != a && !String.IsNullOrEmpty(ci.Status))).
                    Include(p => p.Product).ToList();

                foreach (CartItem item in carItems)
                {
                    item.Statuslist = new List<ListItem>();
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Approved.ToString(), Text = CartItemStatus.Approved.ToString() });
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Declined.ToString(), Text = CartItemStatus.Declined.ToString() });
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Registered.ToString(), Text = CartItemStatus.Registered.ToString() });
                    item.Statuslist.Add(new ListItem { Value = CartItemStatus.Shipped.ToString(), Text = CartItemStatus.Shipped.ToString() });
                }
                return carItems;
            }
        }
    }
}