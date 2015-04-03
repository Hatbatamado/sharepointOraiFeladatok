using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Logic;
using WingtipToys.Models;

namespace WingtipToys.Admin
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!HttpContext.Current.User.IsInRole(Settings.AdministratorRoleName))
            {
                throw new UnauthorizedAccessException();
            }
            string productAction = Request.QueryString["ProductAction"];
            if (productAction == "add")
            {
                LabelAddStatus.Text = "Product added!";
            }

            if (productAction == "remove")
            {
                LabelRemoveStatus.Text = "Product removed!";
            }
        }

        protected void AddProductButton_Click(object sender, EventArgs e)
        {
            Boolean fileOK = false;
            String path = Server.MapPath("~/Catalog/Images/");
            if (ProductImage.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage.FileName).ToLower();
                String[] allowedExtensions = { ".gif", ".png", ".jpeg", ".jpg" };
                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        fileOK = true;
                    }
                }
            }

            if (fileOK)
            {
                try
                {
                    // Save to Images folder.
                    ProductImage.PostedFile.SaveAs(path + ProductImage.FileName);
                    // Save to Images/Thumbs folder.
                    ProductImage.PostedFile.SaveAs(path + "Thumbs/" + ProductImage.FileName);
                }
                catch (Exception ex)
                {
                    LabelAddStatus.Text = ex.Message;
                }

                // Add product data to DB.
                AddProducts products = new AddProducts();
                bool addSuccess = products.AddProduct(AddProductName.Text, AddProductDescription.Text,
                    AddProductPrice.Text, DropDownAddCategory.SelectedValue, ProductImage.FileName);
                if (addSuccess)
                {
                    // Reload the page.
                    string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                    Response.Redirect(pageUrl + "?ProductAction=add");
                }
                else
                {
                    LabelAddStatus.Text = "Unable to add new product to database.";
                }
            }
            else
            {
                LabelAddStatus.Text = "Unable to accept file type.";
            }
        }

        public IQueryable GetCategories()
        {
            var _db = new WingtipToys.Models.ProductContext();
            IQueryable query = _db.Categories;
            return query;
        }

        public IQueryable GetProducts()
        {
            var _db = new WingtipToys.Models.ProductContext();
            IQueryable query = _db.Products;
            return query;
        }

        protected void RemoveProductButton_Click(object sender, EventArgs e)
        {
            using (var _db = new WingtipToys.Models.ProductContext())
            {
                int productId = Convert.ToInt16(DropDownRemoveProduct.SelectedValue);
                var myItem = (from c in _db.Products where c.ProductID == productId select c).FirstOrDefault();
                if (myItem != null)
                {
                    _db.Products.Remove(myItem);
                    _db.SaveChanges();

                    // Reload the page.
                    string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                    Response.Redirect(pageUrl + "?ProductAction=remove");
                }
                else
                {
                    LabelRemoveStatus.Text = "Unable to locate product.";
                }
            }
        }

        protected void ExcelReportButton_Click(object sender, EventArgs e)
        {
            byte[] result = null;
            String path = Server.MapPath("~/ReportTemplates/ReportTemplate.xlsx");
			
			using(Stream stream = new FileStream(path, FileMode.Open, FileAccess.Read)
			{
				using(MemoryStream ms = new MemoryStream())
				{
					using(ExcelPackage p = new ExcelPackage(ms, stream))
					{
						using(ProductContext db = new ProductContext())
						{
							ExcelWorksheet ws = p.Workbook.Worksheets[1];
							List<CartItem> cartItems = db.ShoppingCartItems.ToList();
							ws.Cells["A2"].LoadFromCollection(cartItems.Select(
							c => new
							{
								ProductName = c.Product.ProductName,
								UserName = c.UserLoginName,
								DateCreated = c.DateCreated.ToString(),
								Quantity = c.Quantity
							}));
							
							//táblázat sor változtatás
							ws.Tables[0].TableXml.InnerXml =
								ws.Tables[0].TableXml.InnerXml.Replace("ref=\"A1:D2\"",
								String.Format("ref=\"A1:D{0}\"", cartItems.Count+1));

							result = p.GetAsByteArray();
						}
					}
				}
			}
			if (result != null)
            {
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.AddHeader("content-disposition", "attachment;filename=Report"
                    + DateTime.Now.ToString("yyyy_MM_dd_HH_mm_ss") + ".xlsx");
                Response.BinaryWrite(result);
                Response.Flush();
                Response.End();
            }
        }
    }
}