using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SakuraSushi.DTO;
using SakuraSushi.Model;

namespace SakuraSushi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransactionController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TransactionController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("{uniqueCode}/Cart")]
        public async Task<IActionResult> GetCartItems(string uniqueCode)
        {
            var cartItems = await (from t in _context.Transactions
                                   where t.UniqueCode == uniqueCode && t.ClosedAt == null
                                   from ci in t.CartItems!
                                   join item in _context.Items on ci.ItemId equals item.Id
                                   orderby ci.AddedAt
                                   select new
                                   {
                                       quantity = ci.Quantity,
                                       totalPrice = ci.TotalPrice,
                                       addedAt = ci.AddedAt,
                                       item = new
                                       {
                                           id = item.Id,
                                           name = item.Name,
                                           description = item.Description,
                                           price = item.Price,
                                           available = item.Available
                                       }
                                   }).ToListAsync();

            if (!cartItems.Any())
            {
                return NotFound(new { Message = "Transaction not found" });
            }

            return Ok(cartItems);
        }


        [HttpPost("{uniqueCode}/Cart")]
        public async Task<IActionResult> AddItemToCart(string uniqueCode, [FromBody] CartItemDto newItem)
        {
            if (newItem == null || newItem.ItemId == Guid.Empty || newItem.Quantity <= 0)
            {
                return BadRequest("Invalid cart item.");
            }

            var transaction = await _context.Transactions
                                            .Include(t => t.CartItems)
                                            .FirstOrDefaultAsync(t => t.UniqueCode == uniqueCode && t.ClosedAt == null);
            if (transaction == null)
            {
                return NotFound("Transaction not found.");
            }

            var item = await _context.Items.FindAsync(newItem.ItemId);
            if (item == null)
            {
                return NotFound("Item not found.");
            }

            var cartItem = new CartItem
            {
                Id = Guid.NewGuid(),
                TransactionId = transaction.Id,
                ItemId = newItem.ItemId,
                Quantity = newItem.Quantity,
                Price = item.Price,
                TotalPrice = item.Price * newItem.Quantity,
                AddedAt = DateTimeOffset.UtcNow
            };

            _context.CartItems.Add(cartItem);

            await _context.SaveChangesAsync();

            var response = new
            {
                Quantity = cartItem.Quantity,
                TotalPrice = cartItem.TotalPrice,
                AddedAt = cartItem.AddedAt,
                Item = new
                {
                    Id = item.Id,
                    Name = item.Name,
                    Description = item.Description,
                    Price = item.Price,
                    Available = item.Available
                }
            };

            return CreatedAtAction(nameof(AddItemToCart), new { id = cartItem.Id }, response);
        }

        [HttpDelete("{uniqueCode}/Cart/{itemId}")]
        public async Task<IActionResult> RemoveItemFromCart([FromRoute] string uniqueCode, [FromRoute] Guid itemId)
        {
            var transaction = await _context.Transactions
                .Include(t => t.CartItems!)
                .ThenInclude(ci => ci.Item)
                .FirstOrDefaultAsync(t => t.UniqueCode == uniqueCode && t.ClosedAt == null);

            if (transaction == null)
            {
                return NotFound(new { Message = "Transaction not found" });
            }

            var cartItem = transaction.CartItems!
                .FirstOrDefault(ci => ci.ItemId == itemId);

            if (cartItem == null)
            {
                return NotFound(new { Message = "Item not found in cart" });
            }

            if (cartItem.Item == null)
            {
                return NotFound(new { Message = "Associated item not found" });
            }

            var itemResponse = new
            {
                quantity = cartItem.Quantity,
                totalPrice = cartItem.TotalPrice,
                addedAt = cartItem.AddedAt,
                item = new
                {
                    id = cartItem.Item.Id,
                    name = cartItem.Item.Name,
                    description = cartItem.Item.Description,
                    price = cartItem.Item.Price,
                    available = cartItem.Item.Available
                }
            };

            _context.CartItems.Remove(cartItem);
            await _context.SaveChangesAsync();

            return Ok(itemResponse);
        }
        [HttpPost("{uniqueCode}/Cart/Order")]
        public async Task<IActionResult> AddItemToCartOrder([FromRoute] string uniqueCode)
        {
            var transaction = await _context.Transactions
                                             .Include(t => t.CartItems!)
                                             .ThenInclude(ci => ci.Item)
                                             .FirstOrDefaultAsync(t => t.UniqueCode == uniqueCode && t.ClosedAt == null);

            if (transaction == null)
            {
                return NotFound(new { Message = "Transaction not found." });
            }

            if (transaction.CartItems == null || !transaction.CartItems.Any())
            {
                return BadRequest(new { Message = "No items in the cart to order." });
            }

            var order = new Order
            {
                Id = Guid.NewGuid(),
                TransactionId = transaction.Id,
                OrderedAt = DateTime.UtcNow,
                Amount = transaction.CartItems.Sum(ci => ci.Quantity * ci.Item!.Price)
            };

            var orderItems = transaction.CartItems.Select(ci => new OrderItem
            {
                Id = Guid.NewGuid(),
                OrderId = order.Id,
                ItemId = ci.ItemId,
                Quantity = ci.Quantity,
                Price = ci.Item!.Price,
                Status = "Pending"
            }).ToList();

            _context.Orders.Add(order);
            _context.OrderItems.AddRange(orderItems);

            _context.CartItems.RemoveRange(transaction.CartItems);
            await _context.SaveChangesAsync();

            var response = new
            {
                id = order.Id,
                orderedAt = order.OrderedAt,
                amount = order.Amount,
                orderItems = orderItems.Select(oi => new
                {
                    quantity = oi.Quantity,
                    status = oi.Status,
                    item = new
                    {
                        id = oi.ItemId,
                        name = oi.Item!.Name,
                        description = oi.Item.Description,
                        price = oi.Price,
                        available = oi.Item.Available
                    }
                }).ToList()
            };

            return CreatedAtAction(nameof(AddItemToCartOrder), new { id = order.Id }, response);
        }

      

    }
}
