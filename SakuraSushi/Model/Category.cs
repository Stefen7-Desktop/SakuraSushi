namespace SakuraSushi.Model
{
    public class Category
    {
        public Guid Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }

        public ICollection<Item> Items { get; set; } = new List<Item>();
    }
}
