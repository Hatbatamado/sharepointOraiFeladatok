using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Models;

namespace WingtipToys.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using(ProductContext db = new ProductContext())
                {
                    string Username= Request.QueryString["UserName"];
                    MyUserInfo minfo =
                        db.MyUserInfos.Where(u => u.UserName ==
                            Username).SingleOrDefault();
                    if (minfo != null)
                    {
                        ProfilePictureImg.ImageUrl = minfo.ProfilePictureUrl;
                        ProfilePictureImg.Width = 300;
                        ManagerLabel.Text = minfo.Manager;
                        BirthdayLabel.Text = minfo.Birthday.ToString();
                        UserNameLabel.Text = minfo.UserName;
                    }
                }
            }
        }
    }
}