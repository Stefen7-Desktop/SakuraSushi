namespace SakuraSushi.DTO
{
    public class OrderItemResponse
    {
        public int Quantity { get; set; }
        public string Status { get; set; }
        public ItemResponse Item { get; set; }
    }
}
