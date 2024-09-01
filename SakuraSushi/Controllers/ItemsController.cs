using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SakuraSushi.Model;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;

namespace SakuraSushi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ItemsController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetItems([FromQuery] string? search)
        {
            var categoriesQuery = from c in _context.Categories
                                  select new
                                  {
                                      name = c.Name,
                                      description = c.Description,
                                      items = from i in c.Items
                                              where string.IsNullOrEmpty(search) ||
                                                    i.Name!.Contains(search) ||
                                                    i.Description!.Contains(search)
                                              orderby i.Name
                                              select new
                                              {
                                                  id = i.Id,
                                                  name = i.Name,
                                                  description = i.Description,
                                                  price = i.Price,
                                                  available = i.Available
                                              }
                                  };

            var result = await categoriesQuery
                            .Where(c => c.items.Any()) 
                            .OrderBy(c => c.name)
                            .ToListAsync();

            return Ok(result);
        }
    }
}
