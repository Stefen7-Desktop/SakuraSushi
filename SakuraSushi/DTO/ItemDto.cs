namespace SakuraSushi.DTO
{
    public class ItemDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = string.Empty; 
        public string Description { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public bool Available { get; set; }
    }
}
