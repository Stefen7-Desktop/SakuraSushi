namespace SakuraSushi.DTO
{
    public class OrderResponse
    {
        public Guid Id { get; set; }
        public DateTimeOffset OrderedAt { get; set; }
        public decimal Amount { get; set; }
        public List<OrderItemResponse> OrderItems { get; set; }
    }
}
