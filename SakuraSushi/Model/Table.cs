namespace SakuraSushi.Model
{
    public class Table
    {
        public Guid Id { get; set; }
        public string? TableNumber { get; set; }
        public int Capacity { get; set; }

        public ICollection<Transaction>? Transactions { get; set; }
    }
}
