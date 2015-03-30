using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using WingtipToys.Models;

namespace WingtipToys.Account
{
    public partial class Register : Page
    {
        protected void Page_load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using(ApplicationDbContext db = new ApplicationDbContext())
                {
                    List<ApplicationUser> users = db.Users.ToList();
                    DDLManager.DataSource = users;
                    DDLManager.DataTextField = "UserName";
                    DDLManager.DataValueField = "UserName";
                    DDLManager.DataBind();
                }
            }
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            Boolean fileOK = false;
            String path = Server.MapPath("~/Catalog/Images/");
            if (PictureFileUpload.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(PictureFileUpload.FileName).ToLower();
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
                    PictureFileUpload.PostedFile.SaveAs(path + PictureFileUpload.FileName);
                    // Save to Images/Thumbs folder.
                    PictureFileUpload.PostedFile.SaveAs(path + "Thumbs/" + PictureFileUpload.FileName);
                }
                catch (Exception ex)
                {
                    ErrorMessage.Text = ex.Message;
                }
            }
            else
            {
                ErrorMessage.Text = "Unable to accept file type.";
            }

            var manager = new UserManager();
            var user = new ApplicationUser() { UserName = UserName.Text };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                using(ProductContext db = new ProductContext())
                {
                    MyUserInfo minfo = new MyUserInfo();
                    minfo.UserName = user.UserName;
                    minfo.Birthday = DateTime.Parse(TBBirthDay.Text);
                    if (fileOK)
                        minfo.ProfilePictureUrl = "/Catalog/Images/" + PictureFileUpload.FileName;
                    if (DDLManager.SelectedValue != null)
                        minfo.Manager = DDLManager.SelectedValue;
                    db.MyUserInfos.Add(minfo);

                    db.SaveChanges();
                }
                IdentityHelper.SignIn(manager, user, isPersistent: false);
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}