namespace SakuraSushi.Model
{
    public class CartItem
    {
        public Guid Id { get; set; }
        public Guid TransactionId { get; set; }
        public Guid ItemId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal TotalPrice { get; set; }
        public DateTimeOffset AddedAt { get; set; }
       

        public Transaction? Transaction { get; set; }
        public Item? Item { get; set; }
    }
}
