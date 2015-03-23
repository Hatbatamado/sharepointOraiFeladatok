﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WingtipToys.Models;

namespace WingtipToys.Logic
{
    public class CommentBLL
    {
        public static void AddComment(string comment, int productId)
        {
            using(ProductContext db = new ProductContext())
            {
                Comment c = new Comment();
                db.Comments.Add(c);
                c.CommentMSG = comment;
                c.ProductID = productId;
                c.UserLoginName = HttpContext.Current.User.Identity.Name;

                db.SaveChanges();
            }
        }

        internal static List<Comment> GetCommentsByProduct(int ProductId)
        {
            using (var db = new ProductContext())
            {
                return (from c in db.Comments
                        where c.ProductID == ProductId
                        select c).ToList();

                //return (db.Comments.Where(c => c.ProductID == ProductId).ToList());
            }
        }
    }
}