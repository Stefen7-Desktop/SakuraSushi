namespace SakuraSushi.Model
{
    public class Item
    {
        public Guid Id { get; set; }
        public Guid CategoryId { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public decimal Price { get; set; }
        public string? ImageUrl { get; set; }
        public bool Available { get; set; }

        public Category? Category { get; set; } 
        public ICollection<CartItem>? CartItems { get; set; } = new List<CartItem>(); 
        public ICollection<OrderItem>? OrderItems { get; set; } = new List<OrderItem>();
    }
}
