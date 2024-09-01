namespace SakuraSushi.DTO
{
    public class CategoryDto
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public List<ItemDto> Items { get; set; }
    }
}
