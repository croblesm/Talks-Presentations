using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backend.Models;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegionsController : ControllerBase
    {
        private readonly DemoContext _context;

        public RegionsController(DemoContext context)
        {
            _context = context;
        }

        // GET: api/Regions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Regions>>> GetRegions()
        {
            return await _context.Regions.ToListAsync();
        }

        // GET: api/Regions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Regions>> GetRegions(int id)
        {
            var regions = await _context.Regions.FindAsync(id);

            if (regions == null)
            {
                return NotFound();
            }

            return regions;
        }

        // PUT: api/Regions/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRegions(int id, Regions regions)
        {
            if (id != regions.region_id)
            {
                return BadRequest();
            }

            _context.Entry(regions).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RegionsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Regions
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Regions>> PostRegions(Regions regions)
        {
            _context.Regions.Add(regions);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRegions", new { id = regions.region_id }, regions);
        }

        // DELETE: api/Regions/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Regions>> DeleteRegions(int id)
        {
            var regions = await _context.Regions.FindAsync(id);
            if (regions == null)
            {
                return NotFound();
            }

            _context.Regions.Remove(regions);
            await _context.SaveChangesAsync();

            return regions;
        }

        private bool RegionsExists(int id)
        {
            return _context.Regions.Any(e => e.region_id == id);
        }
    }
}
