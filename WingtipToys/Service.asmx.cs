using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using WingtipToys.Logic;
using WingtipToys.Models;

namespace WingtipToys
{
    /// <summary>
    /// Summary description for Service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Service : System.Web.Services.WebService
    {

        public Service()
        {

            //Uncomment the following line if using designed components
            //InitializeComponent();
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string[] GetProducts(string prefix)
        {
            List<string> productsResult = new List<string>();
            List<Product> products = ProductBLL.GetProductsFilterByName(prefix);
            foreach (Product item in products)
            {
                productsResult.Add(string.Format("{0}-{1}", item.ProductName, item.ProductID.ToString()));
            }
            return productsResult.ToArray();
        }

    }
}