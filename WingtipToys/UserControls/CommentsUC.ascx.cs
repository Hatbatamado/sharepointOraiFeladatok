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
                LoadComments();
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
    }
}