using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WingtipToys.Models
{
    public class MyUserInfo
    {
        [Key]
        public string UserName { get; set; }
        public DateTime Birthday { get; set; }
        public string Manager { get; set; }
        public string ProfilePictureUrl { get; set; }
    }
}