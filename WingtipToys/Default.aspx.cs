using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Logic;
using WingtipToys.Models;
using System.Threading;

namespace WingtipToys
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["__EVENTARGUMENT"] == "UpdateProductResults")
            {
                List<Product> productWithThisName = ProductBLL.GetProductsFilterByName(texts.Value);
                productList.DataSource = productWithThisName;
                productList.DataBind();
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            LabelDate.Text = DateTime.Now.ToString();
            if (!String.IsNullOrEmpty(SearchTextBox.Text))
            {
                List<Product> productWithThisName = ProductBLL.GetProductsFilterByName(SearchTextBox.Text);
                productList.DataSource = productWithThisName;
                productList.DataBind();
                Thread.Sleep(3000);
            }
        }
    }
}