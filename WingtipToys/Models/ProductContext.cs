using System.Data.Entity;

namespace WingtipToys.Models
{

    public class ProductContext : DbContext
    {
        public ProductContext()
            : base("WingtipToys")
        {
        }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<CartItem> ShoppingCartItems { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<MyUserInfo> MyUserInfos { get; set; }
    }
}