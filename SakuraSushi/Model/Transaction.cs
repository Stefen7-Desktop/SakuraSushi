namespace SakuraSushi.Model
{
    public class Transaction
    {
        public Guid Id { get; set; }
        public string? UniqueCode { get; set; }
        public Guid TableId { get; set; }
        public Guid? CashierId { get; set; }
        public DateTimeOffset OpenedAt { get; set; }
        public DateTimeOffset? ClosedAt { get; set; }
        public decimal TotalAmount { get; set; }

        // Relationship
        public Table? Table { get; set; }
        public ICollection<CartItem>? CartItems { get; set; }
        public ICollection<Order>? Orders { get; set; }
        public User? Cashier { get; set; }
    }
}
