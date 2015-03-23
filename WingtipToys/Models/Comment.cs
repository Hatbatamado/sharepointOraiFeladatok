using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WingtipToys.Models
{
    public class Comment
    {
        [ScaffoldColumn(false)]
        public int CommentID { get; set; }
        [Required]
        public string CommentMSG { get; set; }
        [Required]
        public string UserLoginName { get; set; }
        [Required]
        public int ProductID { get; set; }

        public virtual Product Product { get; set; }
    }
}