using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WingtipToys.Models;

namespace WingtipToys.Logic
{
    public class ProductBLL
    {
        public static List<Product> GetProductsFilterByName(string name)
        {
            using (ProductContext db = new WingtipToys.Models.ProductContext())
            {
                return (from p in db.Products
                        where p.ProductName.Contains(name)
                        select p).ToList();

                //return db.Products.Where(p => p.ProductName.Contains(name)).ToList();
            }
        }
    }
}