using Microsoft.EntityFrameworkCore;

namespace SakuraSushi.Model
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions options) 
            : base(options)
        {
        }

        public DbSet<Category> Categories { get; set; }
        public DbSet<Item> Items { get; set; }
        public DbSet<Transaction> Transactions { get; set; }
        public DbSet<CartItem> CartItems { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrderItems { get; set; }
        public DbSet<Table> Tables { get; set; }
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuring relationships if necessary
            modelBuilder.Entity<Category>()
                .HasMany(c => c.Items)
                .WithOne(i => i.Category)
                .HasForeignKey(i => i.CategoryId);

            modelBuilder.Entity<Item>()
                .HasMany(i => i.CartItems)
                .WithOne(ci => ci.Item)
                .HasForeignKey(ci => ci.ItemId);

            modelBuilder.Entity<Item>()
                .HasMany(i => i.OrderItems)
                .WithOne(oi => oi.Item)
                .HasForeignKey(oi => oi.ItemId);

            modelBuilder.Entity<Transaction>()
                .HasMany(t => t.CartItems)
                .WithOne(ci => ci.Transaction)
                .HasForeignKey(ci => ci.TransactionId);

            modelBuilder.Entity<Transaction>()
                .HasMany(t => t.Orders)
                .WithOne(o => o.Transaction)
                .HasForeignKey(o => o.TransactionId);

            modelBuilder.Entity<Order>()
                .HasMany(o => o.OrderItems)
                .WithOne(oi => oi.Order)
                .HasForeignKey(oi => oi.OrderId);

            modelBuilder.Entity<Table>()
                .HasMany(t => t.Transactions)
                .WithOne(tr => tr.Table)
                .HasForeignKey(tr => tr.TableId);

            modelBuilder.Entity<User>()
                .HasMany(u => u.Transactions)
                .WithOne(tr => tr.Cashier)
                .HasForeignKey(tr => tr.CashierId);
        }
    }
}
