namespace SakuraSushi.Model
{
    public class Order
    {
        public Guid Id { get; set; }
        public Guid TransactionId { get; set; }
        public DateTimeOffset OrderedAt { get; set; }
        public decimal Amount { get; set; }

        public Transaction? Transaction { get; set; }
        public ICollection<OrderItem>? OrderItems { get; set; }

   
    }
}
