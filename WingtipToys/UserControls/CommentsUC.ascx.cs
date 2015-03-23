using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Logic;

namespace WingtipToys.UserControls
{
    public partial class CommentsUC : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                commentDiv.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
                loginDiv.Visible = !commentDiv.Visible;
                LoadComments();

                //script ellen védekezés:
                //string s = Server.HtmlEncode("<script>alert('asda');</script>");
            }
        }

        private void LoadComments()
        {
            CommentsRepeater.DataSource = CommentBLL.GetCommentsByProduct(ProductId);
            CommentsRepeater.DataBind();
        }

        protected void ButtonSend_Click(object sender, EventArgs e)
        {
            CommentBLL.AddComment(TextBoxComment.Text, ProductId);
            LoadComments();
        }

        public int ProductId { get; set; }

        protected void CommentsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //onrowcommand gridviewban
            if (e.CommandName == "Torles")
            {
                int commentId = Convert.ToInt32(e.CommandArgument);
                CommentBLL.DeleteComment(commentId);
                LoadComments();
            }
        }
    }
}