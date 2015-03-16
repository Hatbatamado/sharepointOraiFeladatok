using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace WingtipToys.Models
{
    public class CartItem
    {
        [Key]
        public String ItemId { get; set; }
        public String CartId { get; set; }
        public int Quantity { get; set; }
        public DateTime DateCreated { get; set; }
        public String Status { get; set; }

        public int ProductId { get; set; }
        public virtual Product Product { get; set; }

        [NotMapped]
        public List<ListItem> Statuslist { get; set; }
    }
}