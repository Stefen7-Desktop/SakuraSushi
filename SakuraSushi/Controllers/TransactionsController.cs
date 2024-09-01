using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SakuraSushi.Model;
using System.ComponentModel.DataAnnotations;

namespace SakuraSushi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransactionsController : ControllerBase
    {
        private readonly AppDbContext context;

        public TransactionsController(AppDbContext context)
        {
            this.context = context;
        }

        [HttpPost]
        [Authorize(Roles = "Cashier,Waiter")]
        public async Task<IActionResult> CreateTransaction([FromForm] string tableNumber)
        {
            var table = await context.Tables.FirstOrDefaultAsync(t => t.TableNumber == tableNumber);

            if (table == null)
            {
                return NotFound(new { Message = "Table not found" });
            }

            var existingTransaction = await context.Transactions
                .FirstOrDefaultAsync(t => t.TableId == table.Id && t.ClosedAt == null);

            if (existingTransaction != null)
            {
                return BadRequest(new { Message = "Table already has an open transaction" });
            }

            string uniqueCode;
            do
            {
                uniqueCode = GenerateUniqueCode();
            } while (await context.Transactions.AnyAsync(t => t.UniqueCode == uniqueCode));

            var transaction = new Transaction
            {
                Id = Guid.NewGuid(),
                TableId = table.Id,
                UniqueCode = uniqueCode,
                OpenedAt = DateTimeOffset.UtcNow
            };

            context.Transactions.Add(transaction);
            await context.SaveChangesAsync();

            return Ok(new { UniqueCode = transaction.UniqueCode });
        }

        private string GenerateUniqueCode()
        {
            var random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, 4)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }


        [HttpGet("{uniqueCode}/Orders")]
        public async Task<IActionResult> GetOrdersByTransaction(string uniqueCode)
        {
            var transaction = await context.Transactions
                .Include(t => t.Orders!) 
                .ThenInclude(o => o.OrderItems!) 
                .ThenInclude(oi => oi.Item)
                .FirstOrDefaultAsync(t => t.UniqueCode == uniqueCode);

            if (transaction == null)
            {
                return NotFound(new { Message = "Transaction not found" });
            }

            var orders = transaction.Orders!.Select(o => new
            {
                Id = o.Id,
                OrderedAt = o.OrderedAt,
                Amount = o.Amount,
                OrderItems = o.OrderItems != null ? o.OrderItems.Select(oi => new
                {
                    Quantity = oi.Quantity,
                    Status = oi.Status,
                    Item = oi.Item != null ? new
                    {
                        Id = oi.Item.Id,
                        Name = oi.Item.Name,
                        Description = oi.Item.Description,
                        Price = oi.Item.Price,
                        Available = oi.Item.Available
                    } : null
                }).ToList() : null
            }).ToList();

            return Ok(orders);
        }

        [HttpPost("{uniqueCode}/Pay")]
        [Authorize(Roles = "Cashier")]
        public async Task<IActionResult> MarkTransactionAsPaid(string uniqueCode)
        {
            var transaction = await context.Transactions
                .Include(t => t.Table!) 
                .Include(t => t.Cashier!)
                .Include(t => t.Orders!) 
                .ThenInclude(o => o.OrderItems!) 
                .ThenInclude(oi => oi.Item)
                .FirstOrDefaultAsync(t => t.UniqueCode == uniqueCode);

            if (transaction == null)
            {
                return NotFound(new { Message = "Transaction not found" });
            }

            if (transaction.ClosedAt != null)
            {
                return BadRequest(new { Message = "Transaction is already paid" });
            }

            transaction.ClosedAt = DateTimeOffset.UtcNow;
            await context.SaveChangesAsync();

            var result = new
            {
                Id = transaction.Id,
                TableId = transaction.TableId,
                CashierId = transaction.CashierId,
                UniqueCode = transaction.UniqueCode,
                OpenedAt = transaction.OpenedAt,
                ClosedAt = transaction.ClosedAt,
                TotalAmount = transaction.TotalAmount,
                Table = new
                {
                    Id = transaction.Table!.Id,
                    TableNumber = transaction.Table.TableNumber,
                    Capacity = transaction.Table.Capacity,
                    Transactions = transaction.Table.Transactions!.Select(t => t.Id)
                },
                Cashier = transaction.Cashier != null ? new
                {
                    Username = transaction.Cashier.Username,
                    FullName = transaction.Cashier.FullName,
                    Email = transaction.Cashier.Email,
                    PhoneNumber = transaction.Cashier.PhoneNumber,
                    Role = transaction.Cashier.Role
                } : null, 
                Orders = transaction.Orders!.Select(o => new
                {
                    Id = o.Id,
                    OrderedAt = o.OrderedAt,
                    Amount = o.Amount,
                    OrderItems = o.OrderItems!.Select(oi => new
                    {
                        Quantity = oi.Quantity,
                        Status = oi.Status,
                        Item = oi.Item != null ? new
                        {
                            Id = oi.Item.Id,
                            Name = oi.Item.Name,
                            Description = oi.Item.Description,
                            Price = oi.Item.Price,
                            Available = oi.Item.Available
                        } : null
                    }).ToList()
                }).ToList()
            };

            return Ok(result);
        }

        public enum ItemStatus
        {
            [Display(Name = "--")]
            Default = -1,

            [Display(Name = "Pending")]
            Pending = 0,

            [Display(Name = "InProgress")]
            InProgress = 1,

            [Display(Name = "Completed")]
            Completed = 2,

            [Display(Name = "Cancelled")]
            Cancelled = 3
        }


        [HttpPut("{uniqueCode}/Orders/{orderId}/Items/{itemId}/Status")]
        [Authorize(Roles = "Chef,Waiter")]
        public async Task<IActionResult> UpdateItemStatus(string uniqueCode, Guid orderId, Guid itemId, [FromForm] ItemStatus status)
        {
            var transaction = await context.Transactions
                .Include(t => t.Orders!)
                .ThenInclude(o => o.OrderItems)
                .FirstOrDefaultAsync(t => t.UniqueCode == uniqueCode);

            if (transaction == null)
            {
                return NotFound(new { Message = "Transaction not found" });
            }

            var order = transaction.Orders!.FirstOrDefault(o => o.Id == orderId);

            if (order == null)
            {
                return NotFound(new { Message = "Order not found" });
            }

            var orderItem = order.OrderItems!.FirstOrDefault(oi => oi.ItemId == itemId);

            if (orderItem == null)
            {
                return NotFound(new { Message = "Item not found" });
            }

            orderItem.Status = status.ToString();
            await context.SaveChangesAsync();

            return Ok(new { Message = "Item status updated successfully" });
        }


    }
}
